package kdb.spring.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import kdb.spring.vo.UserVo;

public class UserDaoImpl extends SqlSessionDaoSupport implements UserDao {

	@Override
	public int createUser(UserVo vo) {
		//System.out.println(vo);
		return super.getSqlSession().insert("user.createUser", vo);
	}
	
	//facebook가입
		@Override
		public int insertFB(UserVo vo) {
			return super.getSqlSession().insert("user.insertFb", vo);
		}

	@Override
	public UserVo idCheck(String userId) {
		return super.getSqlSession().selectOne("user.idCheck", userId);
	}

	@Override
	public UserVo nickCheck(String nickname) {
		return super.getSqlSession().selectOne("user.nickCheck", nickname);
	}
	
	//로그인 처리

	@Override
	public  UserVo loginCheck(UserVo vo) {
		return super.getSqlSession().selectOne("user.login", vo);
	}
	
	//회원정보수정
	@Override
	public int updateInfo(UserVo vo) {
		return super.getSqlSession().update("user.update", vo);
	}
	
	//회원탈퇴
	@Override
	public int deleteUser(String userId) {
		return super.getSqlSession().delete("user.delete", userId);	
	}
	
	//프로필사진 수정
	@Override
	public int updateProfile(UserVo vo) {
		return super.getSqlSession().update("user.updateProfile", vo);
	}
	
	//자기소개 수정
	@Override
	public int updateIntro(UserVo vo) {
		return super.getSqlSession().update("user.updateIntro", vo);
	}
	
	//자기소개 가져오기
	public String getIntro(String userNo){
		return super.getSqlSession().selectOne("user.getIntro", userNo);
	}


}
