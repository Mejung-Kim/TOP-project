package kdb.spring.dao;

import kdb.spring.vo.BoardVo;
import kdb.spring.vo.ItemVo2;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class StylerDaoImpl extends SqlSessionDaoSupport implements StylerDao {
	
	@Override
	public int insertItemToUSerCloset(ItemVo2 uci){

		System.out.println("StylerDao");
		return super.getSqlSession().insert("styler.insertItemToUSerCloset", uci);
	}

	public int getLastBoardNo(){
		return super.getSqlSession().selectOne("styler.getLastBoardNo");
		
	}
	
	public int insertBoard(BoardVo vo){
		return super.getSqlSession().insert("board.insertBoard",vo);
	};
}
