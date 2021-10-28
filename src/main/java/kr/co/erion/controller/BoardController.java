package kr.co.erion.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.erion.domain.DelVarials;
import kr.co.erion.domain.PageInfo;
import kr.co.erion.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BoardController {

	private final BoardService service;

	// /board가 아니라 /boardForm으로 변경하여 GROUP_ID가 list인 경우를 피해야 한다.
	@GetMapping("/board/{GROUP_ID}/{CURRENT_PAGE}")
	public String board(Model model, @PathVariable String GROUP_ID, @PathVariable String CURRENT_PAGE) {
		log.info("Path :: " + GROUP_ID + "/" + CURRENT_PAGE);
		
				
		// 원하는 게시판의 모든 게시글 수를 구하기 위한 파라미터 모음
		Map<String, Object> db_param = new HashMap<>();
		db_param.put("DEL", DelVarials.DEL_NO.getYn());
		db_param.put("GROUP_ID", GROUP_ID.toUpperCase());

		// 원하는 게시판의 모든 게시글 수를 구한다.
		int TOTAL_ITEMS = 0;
		TOTAL_ITEMS = service.getTotalRowSize(db_param);

		// 게시판의 페이지가 몇개인지 계산한다.
		int totalPages = (int) Math.ceil(Double.valueOf(TOTAL_ITEMS) / PageInfo.PAGE_SIZE.getNumber());

		model.addAttribute("GROUP_ID", GROUP_ID.toUpperCase());
		model.addAttribute("CURRENT_PAGE", CURRENT_PAGE);
		model.addAttribute("TOTAL_ITEMS", TOTAL_ITEMS);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("maxPagesVisible", PageInfo.MAX_PAGE_VISIBLE.getNumber());

		return "board/board";
	}

	@ResponseBody
	@GetMapping("/board/list")
	public List<Map<String, Object>> bardList(Model model, @RequestParam Map<String, Object> param) {
		log.info("type :: " + param);

		int lastNumber = Integer.valueOf((String) param.get("TOTAL_ITEMS"))
				- PageInfo.PAGE_SIZE.getNumber() * Integer.valueOf((String) param.get("CURRENT_PAGE"));
		int firstNumber = lastNumber + PageInfo.PAGE_SIZE.getNumber();

		param.put("DEL", DelVarials.DEL_NO.getYn());
		param.put("FIRST_NUMBER", firstNumber);
		param.put("LAST_NUMBER", lastNumber);

		log.info("mybatis param ::: " + param);

		// DB에서 가져온 게시판 자료
		return service.getBoardList(param);
	}

	@GetMapping("/board/boardWriteArticleForm")
	public String writeBoardArticle(Model model) {

		return "board/boardWriteArticleForm";
	}

	@PostMapping("/board/writeArticleInBoard")
	public String boardWriteArticle(@RequestParam Map<String, Object> model) {
		log.info("model ::::::: " + model);

		return service.writeArticleInBoard(model);
	}

	@GetMapping("/board/form/{GROUP_ID}/{CURRENT_PAGE}/{NO}")
	public String getBoardForm(Model model, @PathVariable String GROUP_ID, @PathVariable String CURRENT_PAGE,
			@PathVariable String NO) {
		
		model.addAttribute("GROUP_ID", GROUP_ID);
		model.addAttribute("CURRENT_PAGE", CURRENT_PAGE);
		model.addAttribute("NO", NO);
		
		return "board/boardDetail";
	}

	@ResponseBody
	@GetMapping("/board/detail")
	public Map<String, Object> getBoardDetail(Model model, @RequestParam Map<String, Object> param) {
		log.info("boardDetail :: " + param);

		return service.getDataByNo(param);
	}
}
