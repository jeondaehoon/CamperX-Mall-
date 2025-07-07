package com.CamperX.productOrder.controller;

import VO.CartInfoVO;
import com.CamperX.productOrder.service.productOrderService;
import com.CamperX.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import VO.ProductOrderInfoVO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
public class productOrderController {

    @Autowired
    private productOrderService service;

    @RequestMapping("/camperX_order")
    public String camperX_order(HttpServletRequest request, Model model) throws Exception {
        // 로그인 상태 확인
        Object userInfo = SessionUtil.getObject(request, "userInfo");
        
        if (userInfo == null) {
            // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            return "redirect:/camperX_loginId?url=/camperX_order";
        }
        
        // 먼저 직접 주문 상품이 있는지 확인
        Map<String, Object> directOrderItem = (Map<String, Object>) SessionUtil.getObject(request, "directOrderItem");
        
        if (directOrderItem != null) {
            // 직접 주문인 경우
            model.addAttribute("orderType", "direct");
            model.addAttribute("directOrderItem", directOrderItem);
            
            // 세션에서 직접 주문 정보 제거 (한 번만 사용)
            SessionUtil.remove(request, "directOrderItem");
            
            return "productOrder/productOrder";
        }
        
        // 세션에서 장바구니 데이터 가져오기
        List<CartInfoVO> cartItems = (List<CartInfoVO>) SessionUtil.getObject(request, "orderCartItems");
        
        if (cartItems == null || cartItems.isEmpty()) {
            // 장바구니 데이터가 없으면 장바구니 페이지로 리다이렉트
            return "redirect:/camperX_cart";
        }
        
        // 장바구니 주문인 경우
        model.addAttribute("orderType", "cart");
        model.addAttribute("cartItems", cartItems);
        
        // 로그인된 경우 주문 페이지 표시
        return "productOrder/productOrder";
    }

    @RequestMapping("/camperX/SaveOrder")
    @ResponseBody
    public boolean SaveOrder(HttpServletRequest request) throws Exception{
        VO.UserInfoVO userInfo = (VO.UserInfoVO) com.CamperX.util.SessionUtil.getObject(request, "userInfo");
        
        ProductOrderInfoVO orderInfo = new ProductOrderInfoVO();
        
        if (userInfo != null) {
            orderInfo.setUserId(userInfo.getUserId());
        }
        
        try {
            // buyQty 변환
            String buyQtyStr = request.getParameter("buyQty");
            if (buyQtyStr != null && !buyQtyStr.trim().isEmpty()) {
                orderInfo.setBuyQty(Integer.parseInt(buyQtyStr.trim()));
            } else {
                orderInfo.setBuyQty(0);
            }
            
            // price 변환
            String priceStr = request.getParameter("price");
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                orderInfo.setPrice(Integer.parseInt(priceStr.trim()));
            } else {
                orderInfo.setPrice(0);
            }
            
            // deliveryCost 변환
            String deliveryCostStr = request.getParameter("deliveryCost");
            if (deliveryCostStr != null && !deliveryCostStr.trim().isEmpty()) {
                orderInfo.setDeliveryCost(Integer.parseInt(deliveryCostStr.trim()));
            } else {
                orderInfo.setDeliveryCost(0);
            }
            
        } catch (NumberFormatException e) {
            orderInfo.setBuyQty(0);
            orderInfo.setPrice(0);
            orderInfo.setDeliveryCost(0);
        }
        
        // 나머지 문자열 필드들 설정
        orderInfo.setPrdCode(request.getParameter("prdCode"));
        orderInfo.setOrderStatus(request.getParameter("orderStatus"));
        orderInfo.setReceiverLastname(request.getParameter("receiverLastname"));
        orderInfo.setReceiverFirstname(request.getParameter("receiverFirstname"));
        orderInfo.setAddress(request.getParameter("address"));
        orderInfo.setBuildingDetail(request.getParameter("buildingDetail"));
        orderInfo.setState(request.getParameter("state"));
        orderInfo.setCity(request.getParameter("city"));
        orderInfo.setDistrict(request.getParameter("district"));
        orderInfo.setPhone(request.getParameter("phone"));
        orderInfo.setEmail(request.getParameter("email"));
        orderInfo.setPaymentMethod(request.getParameter("paymentMethod"));
        
        int save = service.SaveOrder(orderInfo);
        return save > 0;
    }
}
