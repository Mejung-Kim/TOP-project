package kdb.spring.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import kdb.spring.vo.CommVo;

public class CommDaoImpl extends SqlSessionDaoSupport implements CommDao {

	@Override
	public int commentW(CommVo vo) {
		return super.getSqlSession().insert("comm.commentW", vo);
	}

	@Override
	public List<CommVo> commentR(int boardNo) {
		return super.getSqlSession().selectList("comm.commentR", boardNo);
	}

	@Override
	public int commentD(int comNo) {
		return super.getSqlSession().delete("comm.commentD", comNo);
	}

}
