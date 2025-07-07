package com.CamperX.Mainpage.dao;

import VO.PrdInfoVO;
import VO.ReviewInfoVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MainpageDao {

    public List<ReviewInfoVO> getTop3tent(ReviewInfoVO vo) throws Exception;

    public List<PrdInfoVO> selectAllTop5Products(PrdInfoVO vo) throws Exception;

    public List<PrdInfoVO> selectTentTop5Products(PrdInfoVO vo) throws Exception;

    public List<PrdInfoVO> selectTarpTop5Products(PrdInfoVO vo) throws Exception;

    public List<PrdInfoVO> selectChairTop5Products(PrdInfoVO vo) throws Exception;

    public List<PrdInfoVO> selectTableTop5Products(PrdInfoVO vo) throws Exception;
    
    public List<PrdInfoVO> selectEtcTop5Products(PrdInfoVO vo) throws Exception;
}
