package kdb.spring.dao;

import java.util.List;

import kdb.spring.vo.FriendVo;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class FriendDaoImpl extends SqlSessionDaoSupport implements FriendDao {

	@Override
	public int addFriend(FriendVo vo) {
		return super.getSqlSession().insert("friend.addFriend",vo);
	}
	public List<FriendVo> getFriendList(String userNo){
		return super.getSqlSession().selectList("friend.getFriendList",userNo);
	}
	public int delFriend(int fmemNo){
		return super.getSqlSession().delete("friend.delFriend", fmemNo);
	}
}
