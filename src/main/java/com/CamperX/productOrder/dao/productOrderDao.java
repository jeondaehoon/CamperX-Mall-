package com.CamperX.productOrder.dao;

import VO.UserInfoVO;
import org.springframework.stereotype.Repository;
import VO.ProductOrderInfoVO;

@Repository
public interface productOrderDao {

    public UserInfoVO getLoginId(UserInfoVO vo) throws Exception;

    public UserInfoVO getLoginPwd(UserInfoVO vo) throws Exception;

    public int SaveOrder(ProductOrderInfoVO vo) throws Exception;
}
