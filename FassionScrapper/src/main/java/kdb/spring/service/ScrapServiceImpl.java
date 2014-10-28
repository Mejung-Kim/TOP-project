package kdb.spring.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kdb.spring.dao.BoardDao;
import kdb.spring.dao.ScrapDao;
import kdb.spring.dao.StylerDao;
import kdb.spring.vo.BoardVo;
import kdb.spring.vo.ScrapVo;

public class ScrapServiceImpl implements ScrapService {
	@Resource(name="scrapDao")
	private ScrapDao scrapDao;
	
	/**
	 * 스크랩2
	 * */
	@Override
	public int scrapB(ScrapVo vo) {
		return scrapDao.scrapB(vo);
	}

	@Override
	public int getLastBNo() {
		return scrapDao.getLastBNo();
	}

	
}
