package com.CamperX.productView.service;

import VO.FeatureVO;
import VO.PrdImageVO;
import VO.PrdInfoVO;
import com.CamperX.productView.dao.ProductViewDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductViewService {

    private static final Logger logger = LoggerFactory.getLogger(ProductViewService.class);

    @Autowired
    ProductViewDao dao;

    // 이미지 경로를 웹 접근 가능한 경로로 변환
    private String convertImagePath(String dbPath) {
        if (dbPath == null || dbPath.trim().isEmpty()) {
            return "/assets/logo/CAMPERX LOGO.svg"; // 기본 이미지 경로
        }
        // 파일명만 추출
        String fileName = dbPath.substring(dbPath.lastIndexOf('/') + 1);
        return "/images/" + fileName;
    }

    public Map<String, Object> getProductDetail(String prdCode) throws Exception{
        Map<String, Object> productData = new HashMap<>();

        PrdInfoVO info = dao.getProductInfo(prdCode);
        if (info != null) {
            info.setPrdImg(convertImagePath(info.getPrdImg()));
        }

        List<PrdImageVO> images = dao.getProductImages(prdCode);
        if (images != null) {
            images.forEach(img -> {
                if (img != null) img.setPrdImg(convertImagePath(img.getPrdImg()));
            });
        }
        
        List<FeatureVO> features = dao.getProductFeatures(prdCode);
        logger.info("Fetched " + (features != null ? features.size() : "null") + " features for prdCode: " + prdCode);

        if (images != null) {
            logger.info("Image count: " + images.size());
            for (int i = 0; i < images.size(); i++) {
                PrdImageVO img = images.get(i);
                logger.info("Image " + i + ": " + (img != null ? img.getPrdImg() : "null") + ", Type: " + (img != null ? img.getImgType() : "null"));
            }
        } else {
            logger.warn("Images list is null");
        }

        productData.put("info", info);
        productData.put("images", images);
        productData.put("features", features);

        return productData;
    }

    public List<PrdInfoVO> getRelatedProducts(String prdCode) throws Exception {
        List<PrdInfoVO> related = dao.getRelatedProducts(prdCode);
        if (related != null) {
            related.forEach(product -> {
                if (product != null) product.setPrdImg(convertImagePath(product.getPrdImg()));
            });
        }
        return related;
    }

    public List<PrdInfoVO> getRecommendedProducts() throws Exception {
        List<PrdInfoVO> recommended = dao.getRecommendedProducts();
        if (recommended != null) {
            recommended.forEach(product -> {
                if (product != null) product.setPrdImg(convertImagePath(product.getPrdImg()));
            });
        }
        return recommended;
    }
}
