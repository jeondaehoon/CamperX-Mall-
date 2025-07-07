package VO;

import lombok.Data;

@Data
public class CartInfoVO {

    private String cartId;      // 장바구니 고유 ID
    private String userId;      // 사용자 ID
    private String prdCode;     // 상품 코드
    private int quantity;       // 담은 수량
    private String addedDate;   // 장바구니 담은 날짜
    
    // 상품 정보 (JOIN으로 가져올 데이터)
    private String prdName;     // 상품명
    private int price;          // 상품 가격
    private String prdImg;      // 상품 이미지
    private String vendorName;  // 브랜드명
}
