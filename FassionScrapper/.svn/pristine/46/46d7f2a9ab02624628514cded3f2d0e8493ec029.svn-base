package kdb.spring.service;

import java.util.List;

import javax.annotation.Resource;

import kdb.spring.dao.CommDao;
import kdb.spring.vo.CommVo;

public class CommServiceImpl implements CommService {
	
	@Resource(name="commDao") //CommDaoImpl객체생성
	private CommDao commDao;
	
	/**
	 * 댓글쓰기
	 * */
	@Override
	public int commentW(CommVo vo) {
		return commDao.commentW(vo);
	}
	/**
	 * 댓글보기
	 * */
	@Override
	public List<CommVo> commentR(int boardNo) {
		return commDao.commentR(boardNo);
	}
	/**
	 * 댓글삭제
	 * */
	@Override
	public int commentD(int comNo) {
		return commDao.commentD(comNo);
	}

}
