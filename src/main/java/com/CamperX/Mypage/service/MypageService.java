package com.CamperX.Mypage.service;

import VO.ProductOrderInfoVO;
import com.CamperX.Mypage.dao.MypageDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MypageService {
    
    @Autowired
    private MypageDao dao;
}
