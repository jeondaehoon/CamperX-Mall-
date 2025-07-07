package com.CamperX.Mypage.controller;

import VO.UserInfoVO;
import com.CamperX.util.SessionUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class MypageControleer {

    @RequestMapping("/camperX_mypage")
    public String camperX_mypage(HttpServletRequest request, Model model) throws Exception {
        // 로그인 체크
        Object userInfoObj = SessionUtil.getObject(request, "userInfo");
        
        if (userInfoObj == null) {
            // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
            return "redirect:/camperX_loginId";
        }
        
        // 로그인된 경우 사용자 정보를 모델에 추가
        UserInfoVO userInfo = (UserInfoVO) userInfoObj;
        model.addAttribute("userInfo", userInfo);
        model.addAttribute("userId", userInfo.getUserId());
        model.addAttribute("userName", userInfo.getUserName());
        model.addAttribute("userEmail", userInfo.getUserEmail());
        model.addAttribute("userPhone", userInfo.getUserPhone());
        
        // 실제 가입일 사용 (DB에서 가져온 값)
        String joinDate = userInfo.getJoinDate();
        if (joinDate == null || joinDate.isEmpty()) {
            joinDate = "2024-01-01"; // 기본값
        }
        model.addAttribute("joinDate", joinDate);
        
        // 로그인된 경우 마이페이지 표시
        return "mypage/Mypage";
    }

    // 로그아웃 처리
    @RequestMapping(value = "/camperX/logout", method = RequestMethod.POST)
    @ResponseBody
    public String logout(HttpServletRequest request) {
        try {
            // 세션에서 사용자 정보 제거
            SessionUtil.remove(request, "userInfo");
            SessionUtil.remove(request, "userId");
            SessionUtil.remove(request, "userName");
            SessionUtil.remove(request, "tempUserId");
            
            // 세션 무효화
            SessionUtil.removeAll(request);
            
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

}
