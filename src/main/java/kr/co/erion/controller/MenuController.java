package kr.co.erion.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.erion.service.MenuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MenuController {
	
	private final MenuService service;
	
	@ResponseBody
	@GetMapping("menuList")
	public List<Map<String, Object>> getMenuList(Model model, HttpServletRequest req) {
		
		return service.getMenuList(req);
	}

}
