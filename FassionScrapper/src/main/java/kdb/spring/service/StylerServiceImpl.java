package kdb.spring.service;

import java.io.IOException;
import java.sql.Blob;

import javax.annotation.Resource;
import javax.sql.rowset.serial.SerialBlob;

import kdb.spring.dao.StylerDao;
import kdb.spring.dao.StylerDaoImpl;
import kdb.spring.dao.UserDao;
import kdb.spring.vo.BoardVo;
import kdb.spring.vo.ItemVo2;
import kdb.spring.vo.UserVo;

import org.springframework.web.multipart.MultipartFile;

public class StylerServiceImpl implements StylerService{
	@Resource(name="stylerDao")
	private StylerDao stylerDao;
	
	@Resource(name="userDao") //UserDaoImpl객체생성
	private UserDao userDao;
	
	@Override
	public int insertItemToUSerCloset(ItemVo2 uci) {
		System.out.println("StylerService");
		return stylerDao.insertItemToUSerCloset(uci);
	}

	@Override
	public int updateProfile(UserVo vo) {//프로필수정
			return userDao.updateProfile(vo);
		}
	
	public int getLastBoardNo(){
		return stylerDao.getLastBoardNo();
	}
	
	public int insertBoard(BoardVo vo){
		return stylerDao.insertBoard(vo);
	}
}
