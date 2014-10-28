package kdb.spring.dao;

import java.util.List;
import java.util.Map;

import kdb.spring.vo.BoardVo;
import kdb.spring.vo.PageRequestVo;

public interface BoardDao {
	
	/**
	 * 내가 쓴 글
	 * */
	public List<BoardVo> loadMyScrap(String userNo);
	
	/**
	 * 가져온글
	 * */
	public List<BoardVo> loadGetScrap(String userNo);

	/**
	 * 내가쓴글의 수
	 * */
	public int getNumOfMyScrap(String userNo);
	
	/**
	 * 스크랩해온 글의 수
	 * */
	public int getNumOfGetScrap(String userNo);
	
	/**
	 * 해시태그검색 
	 * */
	public List<BoardVo> search(String tag);
	
	/**
	 * 게시물 상세보기
	 * */
	public BoardVo detail(int boardNo);
	
	/**
	 * 조회수증가
	 * */
	public int viewCnt(int boardNo);
	
	/**
	 * 추천수증가
	 * */
	public int recomCnt(int boardNo);
	
	/**
	 * usedItem 뿌리기
	 * */	
	public List<String> usedItem(int boardNo);

	/*
	 * 전체게시판 가져오기 - 인기순
	 */
	public List<BoardVo> getAllBoardByRecomm(PageRequestVo prvo);
	public List<BoardVo> getAllBoardByDate(PageRequestVo prvo);
	
	public int deleteMyScrap(String boardNo);
}
