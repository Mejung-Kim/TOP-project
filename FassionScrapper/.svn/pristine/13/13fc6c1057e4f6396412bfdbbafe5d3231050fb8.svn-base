package kdb.spring.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import kdb.spring.vo.RecomVo;

public class RecomDaoImpl extends SqlSessionDaoSupport implements RecomDao {

	@Override
	public int recomIn(RecomVo vo) {
		return super.getSqlSession().insert("reco.recomIn", vo);
	}
	
	/**
	 * 추천테이블insert
	 * */
	public int recomS(RecomVo vo){
		return super.getSqlSession().selectOne("reco.recomS",vo);
	}

}
