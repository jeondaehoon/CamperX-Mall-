package VO;

import lombok.Data;

@Data
public class ProductOrderInfoVO {

    private String ordCode;
    private String prdCode;
    private String userId;
    private int buyQty;
    private String orderStatus;
    private String ordDate;
    private int price;
    private int deliveryCost;

    private String receiverLastname;
    private String receiverFirstname;
    private String address;
    private String buildingDetail;
    private String state;
    private String city;
    private String district;
    private String phone;
    private String email;
    private String paymentMethod;
    private String orderDate;
    
    // 주문 내역 조회를 위한 상품 정보 필드들
    private String prdName;
    private String prdImg;
    private String vendorName;
    private String categoryName;
}
