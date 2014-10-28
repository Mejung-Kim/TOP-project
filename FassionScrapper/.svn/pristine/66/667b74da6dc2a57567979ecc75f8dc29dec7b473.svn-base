package kdb.spring.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Iterator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kdb.spring.service.HashTagService;
import kdb.spring.service.StylerService;
import kdb.spring.vo.BoardVo;
import kdb.spring.vo.HashTagVo;
import kdb.spring.vo.ItemVo2;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StylerController {
	@Resource(name="stylerService")
	private StylerService stylerService;
	
	@Resource(name="hashTagService")
	private HashTagService hashTagService;
	
	private String selectedCategoriNo=null;
	private String item2UserDir = null;
	private int test=0;
	
	@RequestMapping(value = "/insertItemToUSerCloset.do", method = RequestMethod.POST)
	public @ResponseBody String upload(MultipartHttpServletRequest request, HttpServletResponse response, HttpSession session) {                 
		 System.out.println("insertItemToUSerCloset controller");
		 
		 String item2Name = null;
		 
	     Iterator<String> itr =  request.getFileNames();
	     while(itr.hasNext()){
	    	 String fname = itr.next();
	    	 MultipartFile mpf = request.getFile(fname);
	    	 item2Name = System.currentTimeMillis()+"_"+mpf.getOriginalFilename();
	    	 
	    	 try {
				mpf.transferTo(new File(item2UserDir+"\\"+selectedCategoriNo+"\\"+item2Name));
				System.out.println("path:"+item2UserDir+"\\"+selectedCategoriNo+"\\"+item2Name);
			} catch (Exception e) {
				e.printStackTrace();
			}
	    	 
	    	 ItemVo2 uci = new ItemVo2(String.valueOf(session.getAttribute("userNo")), item2Name);
	    	 stylerService.insertItemToUSerCloset(uci);
	     }
	     
	     System.out.println("Controller end");
	     return item2Name;
	  }
	
	@RequestMapping(value = "/loadItem2.do", method = RequestMethod.POST)
	public ModelAndView loadItem2(HttpServletRequest request, HttpServletResponse response, HttpSession session) {                 
		 System.out.println("loadItem2 controller");
		 ArrayList<String> fileArrayList = new ArrayList<String>();
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName("jsonView");
		 
		 //카테고리 받아오기
		 selectedCategoriNo = request.getParameter("selectedCategoriNo");
		 File userCatagoriFile = new File(item2UserDir+'\\'+selectedCategoriNo);
		 System.out.println("path :"+item2UserDir+'\\'+selectedCategoriNo);
		 String[] fileList = userCatagoriFile.list();
		 
		 if(fileList==null){
			 System.out.println("list is null");
			 return mv;
		 }
		 
		 System.out.println("length = "+fileList.length);
		 for(int i=0; i<fileList.length; i++){
			 fileArrayList.add(fileList[i]);
			 System.out.println(fileList[i]);
		 }
		 
		 mv.addObject("numFile", fileList.length);
		 mv.addObject("fileArrayList", fileArrayList);
	     return mv;
	  }
	
	@RequestMapping(value = "/loadCategori.do", method = RequestMethod.POST)
	public @ResponseBody String loadCategori(HttpServletRequest request, HttpServletResponse response, HttpSession session) {                 
		 System.out.println("loadCategori controller");
		 
		 //카테고리 받아오기
		 selectedCategoriNo = request.getParameter("selectedCategoriNo");
		 File userCatagoriFile = new File(item2UserDir+'\\'+selectedCategoriNo);
		 String[] fileList = userCatagoriFile.list();
		 
		 if(fileList==null){
			 System.out.println("list is null");
			 return "0";
		 }
		 
		 System.out.println("length = "+fileList.length);
	     return String.valueOf(fileList.length);
	  }
	
	
	@RequestMapping(value = "/loadPage.do", method = RequestMethod.POST)
	public ModelAndView loadPage(HttpServletRequest request, HttpServletResponse response, HttpSession session) {                 
		 System.out.println("loadItem2 controller");
		 ArrayList<String> fileArrayList = new ArrayList<String>();
		 int curPage = Integer.parseInt(request.getParameter("curPage"));
		 
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName("jsonView");
		 
		 //카테고리 받아오기
		 File userCatagoriFile = new File(item2UserDir+'\\'+selectedCategoriNo);
		 String[] fileList = userCatagoriFile.list();
		 
		 if(fileList==null){
			 System.out.println("list is null");
			 return mv;
		 }
		 
		 System.out.println("curPage = "+curPage);
		 System.out.println("length = "+fileList.length);
		 for(int i=(curPage-1)*12; i<fileList.length && i<curPage*12; i++){
			 fileArrayList.add(fileList[i]);
			 System.out.println(fileList[i]);
		 }
		 
		 mv.addObject("fileArrayList", fileArrayList);
	     return mv;
	  }
	
	@RequestMapping(value = "/stylerConfiguration.do", method = RequestMethod.POST)
	public String stylerConfiguration(HttpServletResponse request, HttpServletResponse response, HttpSession session) {                 
		 System.out.println("styler Configuration");
		 
		 //item2 디렉토리 생성 
		 String functionPath = session.getServletContext().getRealPath("\\save\\item2");
		 
		 File functionDir = new File(functionPath);
		 if(!functionDir.exists()){
			 functionDir.mkdir();
			 System.out.println("item2's user directory creation");
		 }
		 
		 
		 //유저 넘버 가져오기
		 String userNo = String.valueOf(session.getAttribute("userNo"));
		
		//item2.userNo 디렉토리 생성
		 item2UserDir = functionPath + "\\" + userNo;
		 File item2UserDirFile = new File(item2UserDir);
		 
		 if(!item2UserDirFile.exists()){
			 item2UserDirFile.mkdir();
			 for(int i=1; i<6; i++){
				 new File(item2UserDir+"\\"+i).mkdir();
				 System.out.println("카테고리 "+i+" 생성");
			 }
		 }
		 return "myPage";
	  }
	
	@RequestMapping(value = "/postScrap.do", method = RequestMethod.POST)
	public @ResponseBody String postScrap(HttpServletRequest request, HttpServletResponse response, HttpSession session) {                 
		 System.out.println("postScrap controller");
		 
		 //게시글 파라미터 가져오기
		 String pic = String.valueOf(request.getParameter("pic"));
		 String subject = String.valueOf(request.getParameter("subject"));
	
		 //게시글 번호 가져오기
		 int nextBoardNo = stylerService.getLastBoardNo(); 
		
		 //유저정보 가져오기
		 String userNo = String.valueOf(session.getAttribute("userNo"));
		 String userNick = String.valueOf(session.getAttribute("nickname"));
		 
		 //경로 및 파일 이름
		 String functionPath = session.getServletContext().getRealPath("\\boardImage");
		 String fullName = null;
		 
		 //데이터 가공
		 pic = pic.replace("data:image/png;base64,", "");
		 pic = pic.replace(" ", "+");
		 
		 //전체이름 
		 fullName = functionPath + "\\" + (nextBoardNo) + ".png";
		 
		 //디렉토리 만들기
		 File functionDir = new File(functionPath);
		 System.out.println(functionPath);
		 if(!functionDir.exists()){
			 functionDir.mkdir();
			 System.out.println("boardImage directory creation");
		 }

		// 디코딩하여 파일로 저장
		try {
			byte[] decodedBytes = org.apache.tomcat.util.codec.binary.Base64
					.decodeBase64(pic);
			FileOutputStream output = new FileOutputStream(new File(fullName));
			IOUtils.write(decodedBytes, output);
			output.close();

		} catch (Exception e) {
			e.printStackTrace();
		}


		 //게시글 생성 및 insert
		 BoardVo bdvo = new BoardVo();
		 
		 System.out.println("subject = "+subject+", userNo = "+userNo+", userNick ="+userNick+", boardNo = "+(nextBoardNo));
		 bdvo.setTitle(subject);
		 bdvo.setUserNo(userNo);
		 bdvo.setImg("nonono");
		 bdvo.setUserNick(userNick);
		 bdvo.setBoardNo(nextBoardNo);
		 stylerService.insertBoard(bdvo);
		 
		 //태그 가져오기 및 insert
		 String tag = request.getParameter("tag");
		 HashTagVo hsvo = new HashTagVo();
		 hsvo.setMemNo(userNo);
		 hsvo.setBoardNo(nextBoardNo);
		 hsvo.setTagName(tag);
		 hashTagService.insertHashTag(hsvo);
		 System.out.println(subject);
	     return "myPage";
	  }
	
}
