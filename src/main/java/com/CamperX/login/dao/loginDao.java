package com.CamperX.login.dao;

import VO.UserInfoVO;
import org.springframework.stereotype.Repository;

@Repository
public interface loginDao {
    // 사용자 ID로 사용자 정보 조회
    UserInfoVO getLoginId(UserInfoVO vo);
    
    // 사용자 비밀번호로 사용자 정보 조회
    UserInfoVO getLoginPwd(UserInfoVO vo);
    
    // 회원가입 처리
    boolean signupUser(UserInfoVO vo);
}
