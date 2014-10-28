package kdb.spring.service;

import kdb.spring.vo.RecomVo;


public interface RecomService {
	
	/**
	 * inset
	 * */
	public int recomIn(RecomVo vo);
	
	/**
	 * 추천테이블insert
	 * */
	public int recomS(RecomVo vo);
		
}
