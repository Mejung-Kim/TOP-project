package kdb.spring.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kdb.spring.service.MagazineService;
import kdb.spring.vo.MagazineVo;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pdf.MakePdf;

import com.itextpdf.text.DocumentException;



@Controller
public class MagazineController {	
	@Resource(name="magazineService") //객체 생성.
	private MagazineService magazineService;	
	
	/**
	 * magazine table에 insert
	 * */
/*	@RequestMapping("/magazineInsert.do")
	public ModelAndView insert(@RequestParam(value="boardNoList")List<String> list,HttpSession session){
		MagazineVo vo = new MagazineVo();	
		int data=0;
		for(String boardList:list)
		{
			int boardNo=Integer.parseInt(boardList);
			vo.setMmemNo((int)session.getAttribute("userNo"));
			vo.setBoardNo(boardNo);
			data = magazineService.magazineInsert(vo);
		}	
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", data);
		mv.setViewName("jsonView");
		return mv;
	}*/
	
	
	/*@RequestMapping("magazineInsert.do")
	public ResponseEntity<String> insert(CheckboxList list,HttpSession session){
		MagazineVo vo = new MagazineVo();	
		int data=0;
		System.out.println("==============");
		System.out.println("=========vcvcvcvc=====" + list.getList().size());
		System.out.println("==============");
		String message="magazine으로 추가 실패!";
		for(String boardList:list.getList())
		{
			int boardNo=Integer.parseInt(boardList);
			vo.setMmemNo((int)session.getAttribute("userNo"));
			vo.setBoardNo(boardNo);
			data = magazineService.magazineInsert(vo);
		}	
		if(data>0)message="magazine에 추가되었습니다.!";		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity<String> re = 
				new ResponseEntity<String>(message, header, HttpStatus.OK);
		
		return re;
	}*/
	
	
	@RequestMapping("magazineInsert.do")
	public ResponseEntity<String> insert(@RequestParam("list") List<String> list,HttpSession session){
		MagazineVo vo = new MagazineVo();	
		int data=0;
		System.out.println("==============");
		System.out.println("==============" + list.size());
		System.out.println("==============");
		String message="magazine으로 추가 실패!";
		for(String boardList:list)
		{
			int boardNo=Integer.parseInt(boardList);
			vo.setMmemNo((int)session.getAttribute("userNo"));
			vo.setBoardNo(boardNo);
			data = magazineService.magazineInsert(vo);
		}	
		if(data>0)message="magazine에 추가되었습니다.!";		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity<String> re = 
				new ResponseEntity<String>(message, header, HttpStatus.OK);
		
		return re;
	}
	

	/**
	 * pdf만들기
	 * */
	@RequestMapping("/makePdf.do")
	public ModelAndView makePdf(@RequestParam(value="boardNoList2")List<String> list,HttpSession session){
		MagazineVo vo = new MagazineVo();	
		ArrayList<String> boardNoList=new ArrayList<String>();
		String path= session.getServletContext().getRealPath("\\boardImage");		
		System.out.println("MagazineController_makePdf.do  path:"+path);		
		for(String boardList:list)
		{			
			int boardNo=Integer.parseInt(boardList);
			vo.setMmemNo((int)session.getAttribute("userNo"));
			vo.setBoardNo(boardNo);
			for( int test : magazineService.makePdf(vo) ){
				
				boardNoList.add(Integer.toString(test));
				System.out.println(test);
				System.out.println(test);
				System.out.println(test);
				System.out.println(test);
				System.out.println(test);
				
			}
		}	
		MakePdf pdf = new MakePdf();		
		try {
			pdf.makePdf(boardNoList,path);
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", boardNoList);
		mv.setViewName("jsonView");
		return mv;
	}
	
	/**
	 * 체크된 게시글 삭제
	 * */
	@RequestMapping("/magazineDelete.do")
	public ModelAndView delete(@RequestParam(value="boardNoList3")List<String> list,HttpSession session){
		MagazineVo vo = new MagazineVo();	
		int data=0;
		for(String boardList:list)
		{
			int boardNo=Integer.parseInt(boardList);
			vo.setMmemNo((int)session.getAttribute("userNo"));
			vo.setBoardNo(boardNo);
			data = magazineService.magazineDelete(vo);
		}	
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", data);
		mv.setViewName("jsonView");
		return mv;
	}
		
	/**
	 * magazine page에 뿌리기
	 * */
	@RequestMapping(value = "/loadMyMagazine.do", method = RequestMethod.POST)
	public ModelAndView loadMyMagazine(HttpServletRequest request, HttpServletResponse response, HttpSession session){
		System.out.println("loadMyMagazine::ENTER");
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		int curPage = Integer.parseInt(request.getParameter("curPage"));
		//int userNo = (int)session.getAttribute("userNo");
		List<MagazineVo> magazineVoList = magazineService.loadMyMagazine(userNo);
		ArrayList<MagazineVo> resultMagazineVoList = new ArrayList<MagazineVo>();
		
		int i=0;		
		for(MagazineVo vo : magazineVoList){
			if((curPage-1)*12 <= i && i < curPage*12){
				resultMagazineVoList.add(vo);
				System.out.println(vo);
			}
			i++;
		}
		
		ModelAndView mv = new ModelAndView("jsonView");
		mv.addObject("resultMagazineVoList",resultMagazineVoList);
		System.out.println("loadMyMagazine::magazineVoList.size() = "+magazineVoList.size());
		System.out.println("loadMyMagazine::curPage = "+curPage);
		System.out.println("loadMyMagazine::END");
		return mv;
	}
	
	@RequestMapping(value = "/getNumOfMyMagazine.do"/*, method = RequestMethod.POST*/)
	public @ResponseBody int getNumOfMyMagazine(int userNo) {                 
		 System.out.println("getNumOfMyMagazine::");
		 int result = magazineService.getNumOfMyMagazine(userNo);
		 System.out.println(result);
		 return result;
	}
		
}
