package com.CamperX.Header.dao;

import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

@Repository
public interface headerDao {
    
    // 상품 검색
    public List<Map<String, Object>> searchProducts(String searchText) throws Exception;
}
