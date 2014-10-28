package kdb.spring.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import kdb.spring.vo.ScrapVo;

public class ScrapDaoImpl extends SqlSessionDaoSupport implements ScrapDao {

	@Override
	public int scrapB(ScrapVo vo) {
		return super.getSqlSession().insert("scrap.scrapBoard", vo);
	}

	@Override
	public int getLastBNo() {
		return super.getSqlSession().selectOne("scrap.getLastBNo");
	}

}
