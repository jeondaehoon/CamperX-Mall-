package com.CamperX.productList.service;

import com.CamperX.productList.dao.ProductListDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductListService {

    @Autowired
    ProductListDao dao;

    // 사이드바 필터 데이터 조회
    public Map<String, Object> getSidebarData(String category) throws Exception {
        Map<String, Object> sidebarData = new HashMap<>();
        
        // 카테고리별 제목 설정
        switch(category) {
            case "tent":
                sidebarData.put("title", "텐트 & 타프");
                break;
            case "table":
                sidebarData.put("title", "테이블 & 의자");
                break;
            case "kitchen":
                sidebarData.put("title", "주방용품");
                break;
            case "sleeping":
                sidebarData.put("title", "침낭 & 매트");
                break;
            case "lighting":
                sidebarData.put("title", "조명");
                break;
            case "etc":
                sidebarData.put("title", "기타");
                break;
            default:
                sidebarData.put("title", "텐트 & 타프");
                break;
        }
        
        // 기본 필터 데이터 조회
        sidebarData.put("categories", dao.getSubCategories(category));
        sidebarData.put("brands", dao.getBrands(category));
        
        // 가격대 데이터 처리
        List<Map<String, Object>> priceRangesMap = dao.getPriceRanges(category);
        List<Map<String, String>> priceRanges = new ArrayList<>();
        if (priceRangesMap != null) {
            for (Map<String, Object> priceMap : priceRangesMap) {
                Object priceRangeValue = priceMap.get("PRICERANGE");
                if (priceRangeValue != null) {
                    String displayValue = priceRangeValue.toString();
                    String keyValue = "";
                    switch(displayValue) {
                        case "~50,000원":
                            keyValue = "0-50000";
                            displayValue = "0~50,000원";
                            break;
                        case "50,000원~100,000원":
                            keyValue = "50000-100000";
                            break;
                        case "100,000원~200,000원":
                            keyValue = "100000-200000";
                            break;
                        case "200,000원 이상":
                            keyValue = "200000";
                            break;
                    }
                    if (!keyValue.isEmpty()) {
                        priceRanges.add(Map.of("key", keyValue, "value", displayValue));
                    }
                }
            }
        }
        sidebarData.put("priceRanges", priceRanges);
    
        // 색상 데이터 처리
        List<Map<String, Object>> colorsMap = dao.getColors(category);
        List<String> colors = new ArrayList<>();
        if (colorsMap != null) {
            for (Map<String, Object> colorMap : colorsMap) {
                Object colorValue = colorMap.get("COLOR");
                if (colorValue != null) {
                    colors.add(colorValue.toString());
                }
            }
        }
        sidebarData.put("colors", colors);
        
        return sidebarData;
    }

    // 상품 목록 조회
    public List<Map<String, Object>> getProductList(Map<String, Object> filterData) throws Exception {
        return dao.getProducts(filterData);
    }

    // 서브카테고리 조회
    public List<Map<String, Object>> getSubCategories(String category) throws Exception {
        return dao.getSubCategories(category);
    }
}
