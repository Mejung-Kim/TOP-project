package kdb.spring.dao;


import java.util.List;

import kdb.spring.vo.MagazineVo;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class MagazineDaoImpl extends SqlSessionDaoSupport implements MagazineDao {

	@Override
	public int magazineInsert(MagazineVo vo) {
		return super.getSqlSession().insert("magazine.magazineInsert", vo);
	}

	@Override
	public List<Integer> makePdf(MagazineVo vo) {
		return super.getSqlSession().selectList("magazine.makePdf", vo);
	}

	@Override
	public List<MagazineVo> loadMyMagazine(int mmemNo) {
		return super.getSqlSession().selectList("magazine.loadMyMagazine", mmemNo);
	}

	@Override
	public int magazineDelete(MagazineVo vo) {
		return super.getSqlSession().delete("magazine.magazineDelete", vo);
	}

	@Override
	public int getNumOfMyMagazine(int mmemNo) {
		return super.getSqlSession().selectOne("magazine.getNumOfMyMagazine", mmemNo);
	}



}
