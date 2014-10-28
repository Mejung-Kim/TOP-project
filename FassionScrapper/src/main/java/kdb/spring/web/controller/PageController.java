package kdb.spring.web.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kdb.spring.service.UserService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PageController {
	@Resource(name="userService")
	private UserService userService;
	
	@RequestMapping("/goUserPage.do")
	public String getNumOfMyScrap(HttpServletRequest request) 
	{	String userNo = request.getParameter("userNo");
		String sessionUserNo = request.getParameter("sessionUserNo");
		System.out.print("userNo = ");
		System.out.print(userNo);
		System.out.print("sessionUserNo = ");
		System.out.println(sessionUserNo);
		
		if(userNo.equals(sessionUserNo))
			return "myPage";
		else{
			System.out.println("친구페이지로 가자");
			System.out.println("intro : "+userService.getIntro(userNo));
			request.setAttribute("owner", userNo);
			request.setAttribute("intro", userService.getIntro(userNo));
			return "friendPage";
		}
	}
}
