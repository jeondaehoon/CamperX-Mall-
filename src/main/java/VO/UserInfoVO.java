package VO;

import lombok.Data;

@Data
public class UserInfoVO {
    private String userId;
    private String userName;
    private String userPwd;
    private String userEmail;
    private String userPhone;
    private String userBasic;
    private String joinDate;
    private String userStatus;
    private String url;
}
