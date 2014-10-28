package kdb.spring.service;

import kdb.spring.vo.HashTagVo;

public interface HashTagService {
	public int insertHashTag(HashTagVo vo);
	
	public HashTagVo tagName(int boardNo);
}
