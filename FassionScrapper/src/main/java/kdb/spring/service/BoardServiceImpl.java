package kdb.spring.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kdb.spring.dao.BoardDao;
import kdb.spring.dao.StylerDao;
import kdb.spring.vo.BoardVo;
import kdb.spring.vo.PageRequestVo;

public class BoardServiceImpl implements BoardService {
	@Resource(name="boardDao")
	private BoardDao boardDao;
	@Override
	public List<BoardVo> loadMyScrap(String userNo) {
		return boardDao.loadMyScrap(userNo);
	}
	@Override
	public List<BoardVo> loadGetScrap(String userNo) {
		return boardDao.loadGetScrap(userNo);
	}

	
	@Override
	public int getNumOfMyScrap(String userNo) {
		return boardDao.getNumOfMyScrap(userNo);
	}
	
	@Override
	public int getNumOfGetScrap(String userNo) {
		return boardDao.getNumOfGetScrap(userNo);
	}
	
	/**
	 * 해시태그 검색
	 * */
	@Override
	public List<BoardVo> search(String tag) {
		return boardDao.search(tag);
	}
	/**
	 * 게시물 상세보기
	 * */
	@Override
	public BoardVo detail(int boardNo) {
		return boardDao.detail(boardNo);
	}
	/**
	 * 조회수증가
	 * */
	@Override
	public int viewCnt(int boardNo) {
		return boardDao.viewCnt(boardNo);
	}
	/**
	 * 추천수증가
	 * */
	@Override
	public int recomCnt(int boardNo) {
		return boardDao.recomCnt(boardNo);
	}

	/**
	 * usedItem 뿌리기
	 * */
	@Override
	public List<String> usedItem(int boardNo) {
		return boardDao.usedItem(boardNo);
	}
	
	/*
	 * 전체게시판 가져오기 - 인기순
	 */
	public List<BoardVo> getAllBoardByRecomm(PageRequestVo prvo){
		return boardDao.getAllBoardByRecomm(prvo);
	}
	public List<BoardVo> getAllBoardByDate(PageRequestVo prvo){
		return boardDao.getAllBoardByDate(prvo);
	}
	
	public int deleteMyScrap(String boardNo){
		return boardDao.deleteMyScrap(boardNo);
	}

}
