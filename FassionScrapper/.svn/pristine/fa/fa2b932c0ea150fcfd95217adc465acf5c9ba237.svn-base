package kdb.spring.web.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kdb.spring.service.FriendService;
import kdb.spring.service.UserService;
import kdb.spring.vo.FriendVo;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FriendController {
	@Resource(name="friendService") //객체 생성.
	private FriendService friendService;
	
	@Resource(name="userService")
	private UserService userService;
	/**
	 * 즐겨찾기(친구추가)
	 * */
	@RequestMapping("/addFriend.do")
	public ResponseEntity<String> insert(int fmemNo,HttpSession session){
		FriendVo vo = new FriendVo();
		int data = 0;
		System.out.println(fmemNo);
		System.out.println("=============");
		vo.setMemNo((int)session.getAttribute("userNo"));
		vo.setFmemNo(fmemNo);	
		String message="이미 즐겨찾기 실패!";
		//현재 page의 user정보 저장
		data = friendService.addFriend(vo);
		if(data>0)message="즐겨찾기를 하였습니다.!";		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity<String> re = 
				new ResponseEntity<String>(message, header, HttpStatus.OK);
		
		return re;
	}
	
/*	@RequestMapping("/addFriend.do")
	public ResponseEntity<String> addFriend(FriendVo vo){//받는인수 : 이름이 동일해야 자동 맴핑
		String message = "놉";
		int data = friendService.addFriend(vo);
		if(data>0)message="즐겨찾기에 추가되었습니다.";
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity<String> re = 
				new ResponseEntity<String>(message, header, HttpStatus.OK);
		
		return re;
	}*/

	
	@RequestMapping("/goFriendListPage.do")
	public String goFofFPage(HttpServletRequest request, HttpSession session) 
	{	String userNo = request.getParameter("owner");
		String sessionUserNo = String.valueOf(session.getAttribute("userNo"));
		List<FriendVo> list = friendService.getFriendList(userNo);
		for(FriendVo vo:list){
			System.out.println(vo);
		}
		request.setAttribute("friendList", list);
		request.setAttribute("owner",userNo);
		request.setAttribute("intro",userService.getIntro(userNo));
		System.out.print("userNo = ");
		System.out.print(userNo);
		if(userNo.equals(sessionUserNo)){
			return "friendList";
		}
		else
			return "f_fList";
	}
	
	@RequestMapping("/deleteF.do")
	@ResponseBody
	public String delFriend(int fmemNo){
		System.out.println("친구번호:" + fmemNo);
		int data = friendService.delFriend(fmemNo);
		return data+"";
	}
}
