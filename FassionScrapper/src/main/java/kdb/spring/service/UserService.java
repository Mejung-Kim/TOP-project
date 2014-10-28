package kdb.spring.service;

import kdb.spring.vo.UserVo;

public interface UserService {
	int createUser(UserVo vo);
	
	//insertFB
	public int insertFb(UserVo vo);
	
	UserVo idCheck(String userId);
	
	UserVo nickCheck(String nickname);
	
	//login
	public UserVo loginCheck(UserVo vo);
	//정보수정
	public int updateInfo(UserVo vo);
	//회원탈퇴
	public int deleteUser(String userId);
	
	//자기소개 수정
	public int updateIntro(UserVo vo);
	
	public String getIntro(String userNo);
}
