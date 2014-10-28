package kdb.spring.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import kdb.spring.vo.HashTagVo;

public class HashTagDaoImpl extends SqlSessionDaoSupport implements HashTagDao {
	public int insertHashTag(HashTagVo vo){
		System.out.println("HashTagDaoImpl");
		return super.getSqlSession().insert("hashtag.insertHashTag",vo);
	}

	@Override
	public HashTagVo tagName(int boardNo) {
		System.out.println("dao ="+boardNo);
		return super.getSqlSession().selectOne("hashtag.tagname", boardNo);
	}
}
