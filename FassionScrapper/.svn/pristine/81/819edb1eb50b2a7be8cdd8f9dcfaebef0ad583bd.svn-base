package kdb.spring.service;

import javax.annotation.Resource;

import kdb.spring.dao.HashTagDao;
import kdb.spring.vo.HashTagVo;

public class HashTagServiceImpl implements HashTagService {
	@Resource(name="hashTagDao")
	private HashTagDao hashTagDao;
	public int insertHashTag(HashTagVo vo){
		return hashTagDao.insertHashTag(vo);
	}
	@Override
	public HashTagVo tagName(int boardNo) {
		return hashTagDao.tagName(boardNo);
	};
}
