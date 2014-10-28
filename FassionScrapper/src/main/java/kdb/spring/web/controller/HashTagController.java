package kdb.spring.web.controller;

import javax.annotation.Resource;

import kdb.spring.service.HashTagService;
import kdb.spring.vo.HashTagVo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HashTagController {

	@Resource(name="hashTagService")
	private HashTagService hashTagService;
	
	@RequestMapping("tag.do")
	public ModelAndView tagName(int boardNo){
		
		System.out.println("boardNp="+boardNo);
		HashTagVo vo = hashTagService.tagName(boardNo);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("jsonView");
		if(vo==null)
			return mv;
		
		mv.addObject("name", vo.getTagName());
		System.out.println(mv);
		System.out.println(boardNo);
		
		return mv;
		
		
	}

}
