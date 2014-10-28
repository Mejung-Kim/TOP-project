package kdb.spring.dao;

import kdb.spring.vo.BoardVo;
import kdb.spring.vo.ItemVo2;

public interface StylerDao {
	public int insertItemToUSerCloset(ItemVo2 uci);
	public int getLastBoardNo();
	public int insertBoard(BoardVo vo);
}
