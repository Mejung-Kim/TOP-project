package kdb.spring.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kdb.spring.service.BoardService;
import kdb.spring.service.ScrapService;
import kdb.spring.vo.BoardVo;
import kdb.spring.vo.HashTagVo;
import kdb.spring.vo.ScrapVo;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ScrapController {
	@Resource(name="scrapService")
	private ScrapService scrapService;
			
/*	@RequestMapping("/scrapboard.do")
	public ModelAndView scrapB(ScrapVo vo, HttpSession session){
		
		vo.setUserNo((int) session.getAttribute("userNo"));
		vo.setUserNick((String) session.getAttribute("nickname"));
		vo.setTitle((String) session.getAttribute("title"));
		int data = scrapService.scrapB(vo);
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", data);
		mv.setViewName("jsonView");
		System.out.println("스크랩될까?");
		System.out.println(mv);
		
		return mv;
	}*/
	
	@RequestMapping(value = "/scrapboard.do")
	@ResponseBody
	public String postScrap(int boardNo, HttpSession session) {                 
		 System.out.println("Scrapboard controller");
		 System.out.println(boardNo);
		 String path = session.getServletContext().getRealPath("\\boardImage");
		 //게시글 번호 가져오기
		 int nextBoardNo = scrapService.getLastBNo();
		 System.out.println("다음번호 = "+nextBoardNo);
		 //session.setAttribute("nextBoardNo", nextBoardNo);
		 
		 FileInputStream fi = null;
		 BufferedInputStream bi = null;
		 BufferedOutputStream bo = null;
		 
		 try{
			 fi = new FileInputStream(path+"/"+boardNo+".png");
			 bi = new BufferedInputStream(fi);
			 bo = new BufferedOutputStream(new FileOutputStream(path+"/"+nextBoardNo+".png"));
			 
			 int i =0;
			 while((i=bi.read()) != -1){
				 bo.write(i);
			 }
			 
			 System.out.println(nextBoardNo+"파일 copy 완료!!!");
		 }catch(Exception e){
			 e.printStackTrace();
		 }finally{
			 try{
				 bi.close();
				 fi.close();
				 bo.close();
			 }catch(IOException e){
				 System.out.println("파일닫기 fail" + e);
			 }
		 }

		 ScrapVo vo = new ScrapVo();
		 
		 //title 가지고 와서 저장.
		 
		 vo.setTitle((String) session.getAttribute("title"));
		 vo.setUserNo((int) session.getAttribute("userNo"));
		 vo.setNickname((String) session.getAttribute("nickname"));
		 vo.setBoardNo(nextBoardNo);
		 vo.setImg("스크랩이미지");
		 
		 System.out.println("subject = "+vo.getTitle()+", userNo = "+vo.getUserNo()+", userNick ="+vo.getNickname()+", boardNo = "+vo.getBoardNo());
		 scrapService.scrapB(vo);
		
		 return path;	  
		
	}
	
	
	
}
