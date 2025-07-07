package com.CamperX.productList.dao;

import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

@Repository
public interface ProductListDao {
    
    // 카테고리별 서브카테고리 조회
    public List<Map<String, Object>> getSubCategories(String category) throws Exception;
    
    // 카테고리별 브랜드 조회
    public List<String> getBrands(String category) throws Exception;
    
    // 카테고리별 가격대 조회
    public List<Map<String, Object>> getPriceRanges(String category) throws Exception;
    
    // 카테고리별 색상 조회
    public List<Map<String, Object>> getColors(String category) throws Exception;
    
    // 카테고리별 특징 조회
    public List<String> getFeatures(String category) throws Exception;
    
    // 카테고리별 사용용도 조회
    public List<String> getUsage(String category) throws Exception;
    
    // 카테고리별 상품 목록 조회
    public List<Map<String, Object>> getProducts(Map<String, Object> filterData) throws Exception;
}
