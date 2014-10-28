package kdb.spring.dao;

import java.util.List;

import kdb.spring.vo.MagazineVo;

public interface MagazineDao {	
	/**
	 * magazine table에 현재 세션에 해당하는 mem_num의 이미지들 insert
	 * */
	public int magazineInsert(MagazineVo vo);
	
	//magazine page에 게시물 나타내기
	public List<MagazineVo> loadMyMagazine(int mmemNo);	
	
	public int getNumOfMyMagazine(int mmemNo);
	
	//pdf만들기
	public List<Integer> makePdf(MagazineVo vo);
	
	// 체크된 매거진 게시글 delete
	public int magazineDelete(MagazineVo vo);

}
