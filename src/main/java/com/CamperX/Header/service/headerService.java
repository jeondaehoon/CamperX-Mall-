package com.CamperX.Header.service;

import com.CamperX.Header.dao.headerDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class headerService {
    
    @Autowired
    private headerDao dao;
    
    // 상품 검색
    public List<Map<String, Object>> searchProducts(String searchText) throws Exception {
        return dao.searchProducts(searchText);
    }
}
