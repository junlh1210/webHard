package kr.co.erion.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.erion.domain.PageInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class PaginationController {
	
	@ResponseBody
	@GetMapping("pageInfo")
	public Map<String, Object> pagination(@RequestParam Map<String, Object> model) {
		
//		model.put("totalItems", PageInfo.TOTAL_ITEMS);
		model.put("pageSize", PageInfo.PAGE_SIZE);
		
		log.info("pagination :::: " + model);
		
		return model;
	}
}
