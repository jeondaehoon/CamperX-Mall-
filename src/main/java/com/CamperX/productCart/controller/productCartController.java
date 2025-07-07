package com.CamperX.productCart.controller;

import VO.CartInfoVO;
import com.CamperX.productCart.dao.ProductCartDao;
import com.CamperX.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class productCartController {

    @Autowired
    private ProductCartDao productCartDao;

    @RequestMapping("/camperX_cart")
    public String camperX_mainpage() throws Exception {
        return "productCart/productCart";
    }

    // 장바구니 개수 조회
    @RequestMapping("/camperX/getCartCount")
    @ResponseBody
    public Map<String, Object> getCartCount(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 세션에서 사용자 ID 가져오기
            String userId = (String) SessionUtil.getObject(request, "userId");
            
            if (userId == null) {
                response.put("count", 0);
                response.put("success", true);
                return response;
            }
            
            // 장바구니 개수 조회
            int cartCount = productCartDao.getCartCount(userId);
            response.put("count", cartCount);
            response.put("success", true);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("count", 0);
            response.put("success", false);
            response.put("message", "장바구니 개수 조회 중 오류가 발생했습니다.");
        }
        
        return response;
    }

    @RequestMapping("/camperX/getCartItems")
    @ResponseBody
    public List<CartInfoVO> getCartItems(@RequestParam("userId") String userId) {
        return productCartDao.getCartItems(userId);
    }

    @RequestMapping("/camperX/updateCart")
    @ResponseBody
    public Map<String, Object> updateCart(@RequestBody Map<String, Object> requestData) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String cartId = (String) requestData.get("cartId");
            Integer quantity = (Integer) requestData.get("quantity");
            
            if (cartId == null || quantity == null || quantity < 1) {
                response.put("success", false);
                response.put("message", "잘못된 요청입니다.");
                return response;
            }
            
            int result = productCartDao.updateCartQuantity(cartId, quantity);
            
            if (result > 0) {
                response.put("success", true);
                response.put("message", "수량이 업데이트되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "수량 업데이트에 실패했습니다.");
            }
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return response;
    }

    @RequestMapping("/camperX/removeFromCart")
    @ResponseBody
    public Map<String, Object> removeFromCart(@RequestBody Map<String, Object> requestData) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String cartId = (String) requestData.get("cartId");
            
            if (cartId == null) {
                response.put("success", false);
                response.put("message", "잘못된 요청입니다.");
                return response;
            }
            
            int result = productCartDao.removeFromCart(cartId);
            
            if (result > 0) {
                response.put("success", true);
                response.put("message", "상품이 장바구니에서 삭제되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "삭제에 실패했습니다.");
            }
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return response;
    }

    @RequestMapping("/camperX/saveCartToSession")
    @ResponseBody
    public Map<String, Object> saveCartToSession(@RequestBody List<CartInfoVO> cartItems, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 세션에 장바구니 데이터 저장
            SessionUtil.set(request, "orderCartItems", cartItems);
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        
        return response;
    }

    @RequestMapping("/camperX/clearOrderSession")
    @ResponseBody
    public Map<String, Object> clearOrderSession(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 세션에서 주문 관련 데이터 제거
            SessionUtil.remove(request, "orderCartItems");
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        
        return response;
    }
}
