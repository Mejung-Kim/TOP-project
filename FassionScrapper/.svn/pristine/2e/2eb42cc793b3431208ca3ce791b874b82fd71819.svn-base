package kdb.spring.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.omg.CORBA.FREE_MEM;

import kdb.spring.dao.FriendDao;
import kdb.spring.vo.FriendVo;

public class FriendServiceImpl implements FriendService {
	@Resource(name="friendDao") //FriendDaoImpl객체생성
	private FriendDao friendDao;

	@Override
	public int addFriend(FriendVo vo) {
		return friendDao.addFriend(vo);
	}
	
	public List<FriendVo> getFriendList(String userNo){
		return friendDao.getFriendList(userNo);
	}
	
	public int delFriend(int fmemNo){
		return friendDao.delFriend(fmemNo);
	}
}
