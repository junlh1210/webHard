package kr.co.erion.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	/**
	 * 
	 * @param model
	 * @return String
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		log.info("http://localhost:8080으로 접속했습니다.");
		
		// model.addAttribute("ServerInfo", System.getProperty("spring.profiles.active"));
		
		return "auth/loginForm";
	}
	
}
