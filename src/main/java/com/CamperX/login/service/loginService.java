package com.CamperX.login.service;

import VO.UserInfoVO;
import com.CamperX.login.dao.loginDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class loginService {
    @Autowired
    loginDao dao;

    // 사용자 ID로 사용자 정보 조회
    public UserInfoVO getLoginId(String userId) throws Exception {
        UserInfoVO vo = new UserInfoVO();
        vo.setUserId(userId);
        return dao.getLoginId(vo);
    }

    // 사용자 비밀번호로 사용자 정보 조회
    public UserInfoVO getLoginPwd(String userId, String userPwd) throws Exception {
        UserInfoVO vo = new UserInfoVO();
        vo.setUserId(userId);
        vo.setUserPwd(userPwd);
        return dao.getLoginPwd(vo);
    }

    // 회원가입 처리
    public boolean signupUser(String userId, String userPwd, String userName, String userEmail, String userPhone) throws Exception {
        UserInfoVO vo = new UserInfoVO();
        vo.setUserId(userId);
        vo.setUserPwd(userPwd);
        vo.setUserName(userName);
        vo.setUserEmail(userEmail);
        vo.setUserPhone(userPhone);
        return dao.signupUser(vo);
    }

    // 아이디 중복체크
    public boolean checkUserIdDuplicate(String userId) throws Exception {
        UserInfoVO vo = new UserInfoVO();
        vo.setUserId(userId);
        UserInfoVO existingUser = dao.getLoginId(vo);
        return existingUser == null; // null이면 사용 가능, 있으면 중복
    }
}
