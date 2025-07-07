package VO;

import lombok.Data;

@Data
public class CategoryInfoVO {

    private String categoryCode;
    private String categoryName;
    private String categoryLv;
    private String categoryUplv;
    private String delStatus;
    private String createdAt;
}
