package VO;

import lombok.Data;

@Data
public class PrdInfoVO {

    private String prdCode;
    private String prdName;
    private String prdColor;
    private String price;
    private String prdDesc;
    private String prdImg;
    private String categoryCode;
    private String vendorCode;
    private String categoryName;
    private String vendorName;
    private String buyQty;
    private String payAmount;
    private String category;
    private String shipping;

    public String getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(String payAmount) {
        this.payAmount = payAmount;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
