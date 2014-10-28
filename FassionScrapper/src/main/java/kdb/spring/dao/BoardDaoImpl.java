package kdb.spring.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import kdb.spring.vo.BoardVo;
import kdb.spring.vo.PageRequestVo;

public class BoardDaoImpl extends SqlSessionDaoSupport implements BoardDao {
	
	public List<BoardVo> loadMyScrap(String userNo){
		System.out.println("BoardDaoImpl:: loadMyScrap");
		return super.getSqlSession().selectList("board.boardList", userNo);
	}
	
	@Override
	public List<BoardVo> loadGetScrap(String userNo) {
		return super.getSqlSession().selectList("board.getItList", userNo);
	};

	@Override
	public int getNumOfMyScrap(String userNo) {
		return super.getSqlSession().selectOne("board.getNumOfMyScrap", userNo);
	}
	
	@Override
	public int getNumOfGetScrap(String userNo) {
		return super.getSqlSession().selectOne("board.getNumOfGetScrap", userNo);
	}
	
	/**
	 * 해시태그검색
	 * */
	@Override
	public List<BoardVo> search(String tag) {
		//System.out.println("dao.search");
		return super.getSqlSession().selectList("board.search", tag);
	}
	
	/**
	 * 게시물 상세보기
	 * */
	@Override
	public BoardVo detail(int boardNo) {
		return super.getSqlSession().selectOne("board.read", boardNo);
	}
	
	/**
	 * 조회수증가
	 * */
	@Override
	public int viewCnt(int boardNo) {
		return super.getSqlSession().update("board.viewCnt", boardNo);
	}
	
	/**
	 * 추천수증가
	 * */
	@Override
	public int recomCnt(int boardNo) {
		return super.getSqlSession().update("board.recommend", boardNo);
	}	
	
	/**
	 * usedItem 뿌리기
	 * */
	public List<String> usedItem(int boardNo){
		return super.getSqlSession().selectList("board.usedItem", boardNo);
	}

	/*
	 * 전체게시판 가져오기 - 인기순
	 */
	public List<BoardVo> getAllBoardByRecomm(PageRequestVo prvo){
		return super.getSqlSession().selectList("board.getAllBoardByRecomm",prvo);
	}
	
	/*
	 * 전체게시판 가져오기 - 등록일자순
	 */
	public List<BoardVo> getAllBoardByDate(PageRequestVo prvo){
		return super.getSqlSession().selectList("board.getAllBoardByDate",prvo);
	}
	
	public int deleteMyScrap(String boardNo){
		return super.getSqlSession().delete("board.deleteMyScrap",boardNo);
	}



	
}
