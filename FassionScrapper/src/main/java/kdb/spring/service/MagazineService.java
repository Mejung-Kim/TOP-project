package kdb.spring.service;

import java.util.List;

import kdb.spring.vo.MagazineVo;

public interface MagazineService {

	//insert
	public int magazineInsert(MagazineVo vo);	
	
	//magazine page에 게시물 나타내기
	public List<MagazineVo> loadMyMagazine(int mmemNo);	
	public int getNumOfMyMagazine(int mmemNo);

	//pdf만들기
	public List<Integer> makePdf(MagazineVo vo);	
	
	// 체크된 매거진 게시글 delete
	public int magazineDelete(MagazineVo vo);
}
