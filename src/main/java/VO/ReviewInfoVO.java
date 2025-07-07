package VO;

import lombok.Data;

@Data
public class ReviewInfoVO {
    private String reviewId;
    private String prdCode;
    private String userId;
    private String rating;
    private String content;
    private String createdAt;
    private String prdImg;
}
