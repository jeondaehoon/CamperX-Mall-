package com.CamperX.productView.controller;

import VO.PrdInfoVO;
import com.CamperX.productView.service.ProductViewService;
import com.CamperX.util.SessionUtil;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class ProductViewController {

    @Autowired
    private ProductViewService service;

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("/camperX/productView")
    public String productView(@RequestParam("prdCode") String prdCode, Model model) {
        model.addAttribute("prdCode", prdCode);
        return "productview/productView";
    }

    @RequestMapping("/camperX/productDetailSearch")
    @ResponseBody
    public Map<String, Object> getProductDetailSearch(@RequestParam String prdCode) throws Exception {
        return service.getProductDetail(prdCode);
    }

    @RequestMapping("/camperX/getRelatedProducts")
    @ResponseBody
    public List<PrdInfoVO> getRelatedProducts(@RequestParam String prdCode) throws Exception {
        return service.getRelatedProducts(prdCode);
    }

    @RequestMapping("/camperX/getRecommendedProducts")
    @ResponseBody
    public List<PrdInfoVO> getRecommendedProducts() throws Exception {
        return service.getRecommendedProducts();
    }

    @RequestMapping(value = "/camperX/addToCart", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addToCart(@RequestBody Map<String, Object> requestData) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String userId = (String) requestData.get("userId");
            String prdCode = (String) requestData.get("prdCode");
            Integer quantity = (Integer) requestData.get("quantity");
            
            // CART_ID 생성
            String cartId = "CART_" + UUID.randomUUID().toString().replace("-", "").substring(0, 12);
            
            // INSERT 쿼리 실행
            Map<String, Object> cartInfo = new HashMap<>();
            cartInfo.put("cartId", cartId);
            cartInfo.put("userId", userId);
            cartInfo.put("prdCode", prdCode);
            cartInfo.put("quantity", quantity);
            
            int result = sqlSession.insert("com.CamperX.productView.dao.ProductViewDao.addToCart", cartInfo);
            
            if (result > 0) {
                response.put("success", true);
                response.put("message", "장바구니에 추가되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "장바구니 추가에 실패했습니다.");
            }
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "장바구니 추가 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return response;
    }

    @RequestMapping(value = "/camperX/saveProductToOrder", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> saveProductToOrder(@RequestBody Map<String, Object> requestData, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String prdCode = (String) requestData.get("prdCode");
            Integer quantity = (Integer) requestData.get("quantity");
            
            if (prdCode == null || quantity == null || quantity < 1) {
                response.put("success", false);
                response.put("message", "잘못된 요청입니다.");
                return response;
            }
            
            // 상품 정보를 가져와서 세션에 저장
            Map<String, Object> productData = service.getProductDetail(prdCode);
            if (productData != null && productData.get("info") != null) {
                Map<String, Object> orderItem = new HashMap<>();
                orderItem.put("prdCode", prdCode);
                orderItem.put("quantity", quantity);
                orderItem.put("productInfo", productData.get("info"));
                
                // 세션에 주문 상품 정보 저장
                SessionUtil.set(request, "directOrderItem", orderItem);
                
                response.put("success", true);
                response.put("message", "주문 페이지로 이동합니다.");
            } else {
                response.put("success", false);
                response.put("message", "상품 정보를 찾을 수 없습니다.");
            }
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return response;
    }
}
