package com.CamperX.productCart.dao;

import VO.CartInfoVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductCartDao {

    @Autowired
    private SqlSession sqlSession;

    public List<CartInfoVO> getCartItems(String userId) {
        return sqlSession.selectList("com.CamperX.productCart.dao.ProductCartDao.getCartItems", userId);
    }
    
    public int getCartCount(String userId) {
        return sqlSession.selectOne("com.CamperX.productCart.dao.ProductCartDao.getCartCount", userId);
    }
    
    public int updateCartQuantity(String cartId, int quantity) {
        java.util.Map<String, Object> params = new java.util.HashMap<>();
        params.put("cartId", cartId);
        params.put("quantity", quantity);
        return sqlSession.update("com.CamperX.productCart.dao.ProductCartDao.updateCartQuantity", params);
    }
    
    public int removeFromCart(String cartId) {
        return sqlSession.delete("com.CamperX.productCart.dao.ProductCartDao.removeFromCart", cartId);
    }
} 