package com.CamperX.productView.dao;

import VO.FeatureVO;
import VO.PrdImageVO;
import VO.PrdInfoVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductViewDao {
    
    PrdInfoVO getProductInfo(String prdCode) throws Exception;

    List<PrdImageVO> getProductImages(String prdCode) throws Exception;

    List<FeatureVO> getProductFeatures(String prdCode) throws Exception;

    List<PrdInfoVO> getRelatedProducts(String prdCode) throws Exception;

    List<PrdInfoVO> getRecommendedProducts() throws Exception;
}
