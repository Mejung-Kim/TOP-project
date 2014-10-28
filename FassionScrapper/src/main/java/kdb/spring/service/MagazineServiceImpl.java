package kdb.spring.service;


import java.util.List;

import javax.annotation.Resource;

import kdb.spring.dao.MagazineDao;
import kdb.spring.vo.MagazineVo;

public class MagazineServiceImpl implements MagazineService {
	@Resource(name="magazineDao") //UserDaoImpl객체생성
	private MagazineDao magazineDao;

	@Override
	public int magazineInsert(MagazineVo vo) {
		return magazineDao.magazineInsert(vo);
	}

	@Override
	public List<Integer> makePdf(MagazineVo vo) {
		return magazineDao.makePdf(vo);
	}

	@Override
	public List<MagazineVo> loadMyMagazine(int mmemNo) {
		return magazineDao.loadMyMagazine(mmemNo);
	}

	@Override
	public int magazineDelete(MagazineVo vo) {
		return magazineDao.magazineDelete(vo);
	}

	@Override
	public int getNumOfMyMagazine(int mmemNo) {
		return magazineDao.getNumOfMyMagazine(mmemNo);
	}


}
