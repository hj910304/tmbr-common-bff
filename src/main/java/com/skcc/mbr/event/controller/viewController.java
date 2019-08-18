package com.skcc.mbr.event.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class viewController {
    
	// tmbr-customer-api 도메인 
	@Value("${tmbr-customer-api}")
	private String tmbrCustDomain;
	
	@Value("${tmbr-event-master-api}")
	private String tmberEventMasterDomain;
	
	@Value("${tmbr-event-api}")
	private String tmberEventDomain;
	
    @RequestMapping(value="/testv")
    public String index() {
        return "index";
    }
    
    @RequestMapping(value="/eventList",method=RequestMethod.GET)
    public ModelAndView evnetList(String custId, String custGrade) {
    	HashMap<String, String> map = new HashMap<String,String>(); 
    	map.put("custId",custId);
    	map.put("custGrade", custGrade);
    	ModelAndView mav = new ModelAndView("eventList");
    	mav.addObject("custMap",map);
    	mav.addObject("tmberEventMasterDomain",tmberEventMasterDomain);
    	mav.addObject("tmberEventDomain",tmberEventDomain);
    	return mav;
    }
    
    @RequestMapping("/login")
	public ModelAndView index( Model model,ModelMap modelmap) {
		ModelAndView mav = new ModelAndView("login");
		mav.addObject("tmbrCustDomain", tmbrCustDomain);
		return mav;
	}

}
