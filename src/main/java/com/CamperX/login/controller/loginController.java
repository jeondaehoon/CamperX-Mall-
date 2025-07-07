package com.CamperX.login.controller;

import VO.UserInfoVO;
import com.CamperX.login.service.loginService;
import com.CamperX.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
public class loginController {
    @Autowired
    private loginService service;

    @RequestMapping("/camperX_loginId")
    public String camperX_loginId(@ModelAttribute UserInfoVO vo, Model model) throws Exception {
        model.addAttribute("url", vo.getUrl());
        return "login/loginId";
    }

    @RequestMapping("/camperX_loginPwd")
    public String camperX_loginPwd(@ModelAttribute UserInfoVO vo, Model model) throws Exception {
        model.addAttribute("url", vo.getUrl());
        return "login/loginPwd";
    }

    // 로그인 상태 체크 (AJAX용)
    @RequestMapping(value = "/camperX/checkLogin", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> checkLogin(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 세션에서 사용자 정보 확인
            Object userInfo = SessionUtil.getObject(request, "userInfo");
            
            if (userInfo != null) {
                response.put("loggedIn", true);
                response.put("message", "로그인된 상태입니다.");
            } else {
                response.put("loggedIn", false);
                response.put("message", "로그인이 필요합니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("loggedIn", false);
            response.put("message", "로그인 상태 확인 중 오류가 발생했습니다.");
        }
        
        return response;
    }

    // 로그인 ID 확인 (POST)
    @RequestMapping(value = "/camperX/loginId", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkLoginId(@RequestParam String userId, HttpServletRequest request) {
        try {
            // 사용자 ID 존재 여부 확인
            UserInfoVO userInfo = service.getLoginId(userId);
            if (userInfo != null) {
                // 세션에 사용자 ID 저장
                SessionUtil.set(request, "tempUserId", userId);
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 로그인 비밀번호 확인 (POST)
    @RequestMapping(value = "/camperX/loginPwd", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkLoginPwd(@RequestParam String userId, @RequestParam String userPwd, HttpServletRequest request) {
        try {
            // 사용자 비밀번호 확인
            UserInfoVO userInfo = service.getLoginPwd(userId, userPwd);
            
            if (userInfo != null) {
                // 로그인 성공 시 세션에 사용자 정보 저장
                SessionUtil.set(request, "userInfo", userInfo);
                SessionUtil.set(request, "userId", userInfo.getUserId());
                SessionUtil.set(request, "userName", userInfo.getUserName());
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 회원가입 처리 (POST)
    @RequestMapping(value = "/camperX/signup", method = RequestMethod.POST)
    @ResponseBody
    public boolean signupUser(@RequestParam String userId, 
                             @RequestParam String userPwd, 
                             @RequestParam String userName, 
                             @RequestParam String userEmail, 
                             @RequestParam String userPhone) {
        try {
            // 회원가입 처리
            boolean result = service.signupUser(userId, userPwd, userName, userEmail, userPhone);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 아이디 중복체크 (POST)
    @RequestMapping(value = "/camperX/checkUserIdDuplicate", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkUserIdDuplicate(@RequestParam String userId) {
        try {
            // 아이디 중복체크 (true: 사용 가능, false: 중복)
            boolean isAvailable = service.checkUserIdDuplicate(userId);
            return isAvailable;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
