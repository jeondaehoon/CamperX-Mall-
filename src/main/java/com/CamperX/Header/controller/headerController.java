package com.CamperX.Header.controller;

import com.CamperX.Header.service.headerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;
import java.util.Map;

@Controller
public class headerController {
    
    @Autowired
    private headerService service;
    
    // 상품 검색 API
    @RequestMapping("/camperX/search")
    @ResponseBody
    public List<Map<String, Object>> searchProducts(@RequestParam String searchText) {
        try {
            return service.searchProducts(searchText);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
