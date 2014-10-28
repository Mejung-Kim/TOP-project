package kdb.spring.service;

import javax.annotation.Resource;

import kdb.spring.dao.RecomDao;
import kdb.spring.vo.RecomVo;


public class RecomServiceImpl implements RecomService {
	
	@Resource(name="recomDao")
	private RecomDao recomDao;
	@Override
	public int recomIn(RecomVo vo) {
		return recomDao.recomIn(vo);
	}
	

	public int recomS(RecomVo vo){
		return recomDao.recomS(vo);
	}

}
