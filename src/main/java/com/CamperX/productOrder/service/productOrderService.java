package com.CamperX.productOrder.service;

import VO.UserInfoVO;
import com.CamperX.productOrder.dao.productOrderDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import VO.ProductOrderInfoVO;

@Service
public class productOrderService {
    @Autowired
    productOrderDao dao;

    public UserInfoVO getLoginId(UserInfoVO vo) throws Exception{
        return dao.getLoginId(vo);
    }

    public UserInfoVO getLoginPwd(UserInfoVO vo) throws Exception{
        return dao.getLoginPwd(vo);
    }

    public int SaveOrder(ProductOrderInfoVO vo) throws Exception{
        return dao.SaveOrder(vo);
    }
}
