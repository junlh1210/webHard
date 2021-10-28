package kr.co.erion.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.erion.service.CommonService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class CommonController {
	
	private final CommonService service;
	
	@ResponseBody
	@GetMapping("common/getCodeList")
	public Map<String, Object> getCodeList(@RequestParam Map<String, Object> model) {
		log.info("map ::: " + model);
		
		Map<String, Object> result = new HashMap<>();
		result.put("codeList", service.getCodeList(model));
		
		return result;
	}

}
