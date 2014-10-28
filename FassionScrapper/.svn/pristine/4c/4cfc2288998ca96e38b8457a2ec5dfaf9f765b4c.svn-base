package kdb.spring.web.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kdb.spring.service.BoardService;
import kdb.spring.service.RecomService;
import kdb.spring.vo.RecomVo;

@Controller
public class RecomController {
	@Resource(name="recomService") //객체 생성.
	private RecomService recomService;
	@Resource(name="boardService")
	private BoardService boardService;
	
	@RequestMapping("/recomIn.do")
	@ResponseBody
	public String recomIn(RecomVo vo){
		int data = recomService.recomIn(vo);
		return data+"";		
	}
	
	@RequestMapping("/recomS.do")
	@ResponseBody
	public String recomS(RecomVo vo, HttpSession session){

		String message = "0";
		vo.setMem_num((int) session.getAttribute("userNo"));
		vo.setBoard_num((int) session.getAttribute("boardNo"));
		int data = recomService.recomS(vo);
		System.out.println("recomS"+data);
		if(data==0){
			message = "1";
			int a = recomService.recomIn(vo);
			int b = boardService.recomCnt(vo.getBoard_num());
		}
		
		return message;
		
	}
	

}
