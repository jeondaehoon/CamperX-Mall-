package com.CamperX.Mainpage.service;

import VO.ReviewInfoVO;
import com.CamperX.Mainpage.dao.MainpageDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import VO.PrdInfoVO;

import java.util.List;

@Service
public class MainpageService {

    @Autowired
    MainpageDao dao;

    public List<ReviewInfoVO> getTop3tent(ReviewInfoVO vo) throws Exception {
        return dao.getTop3tent(vo);
    }

    public List<PrdInfoVO> getTop5product(PrdInfoVO vo) throws Exception {
        String category = vo.getCategory();
        if (category == null) {
            category = "ALL";
        }
        
        switch(category) {
            case "ALL":
                return dao.selectAllTop5Products(vo);
            case "텐트":
                return dao.selectTentTop5Products(vo);
            case "타프":
                return dao.selectTarpTop5Products(vo);
            case "의자":
                return dao.selectChairTop5Products(vo);
            case "테이블":
                return dao.selectTableTop5Products(vo);
            case "기타":
                return dao.selectEtcTop5Products(vo);
            default:
                return dao.selectAllTop5Products(vo);
        }
    }
}
