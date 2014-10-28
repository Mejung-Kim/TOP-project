package kdb.spring.dao;

import kdb.spring.vo.RecomVo;

public interface RecomDao {
	
	/**
	 * 추천테이블insert
	 * */
	public int recomIn(RecomVo vo);
	
	/**
	 * 추천테이블insert
	 * */
	public int recomS(RecomVo vo);
		

}
