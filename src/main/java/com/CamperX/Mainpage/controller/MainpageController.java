package com.CamperX.Mainpage.controller;

import VO.PrdInfoVO;
import VO.ReviewInfoVO;
import com.CamperX.Mainpage.service.MainpageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MainpageController {

    @Autowired
    private MainpageService service;

    @RequestMapping("/camperX_mainpage")
    public String camperX_mainpage() throws Exception {
        return "mainpage/mainpage";
    }

    @RequestMapping("/camperX/getTop3tent")
    @ResponseBody
    public List<ReviewInfoVO> getTop3tent(@ModelAttribute ReviewInfoVO vo) throws Exception {
        List<ReviewInfoVO> list = service.getTop3tent(vo);
        return list;
    }

    @RequestMapping("/camperX/getTop5product")
    @ResponseBody
    public List<PrdInfoVO> getTop5product(@RequestParam String category) throws Exception {
        PrdInfoVO vo = new PrdInfoVO();
        vo.setCategory(category);
        List<PrdInfoVO> list = service.getTop5product(vo);
        return list;
    }
}
