package kr.co.erion.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.erion.domain.DelVarials;
import kr.co.erion.repository.CommonDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardService {

	private final CommonDao dao;

	@Transactional
	public List<Map<String, Object>> getBoardList(Map<String, Object> param) {
//		log.info("param :::::: " + param);

		List<Map<String, Object>> resultList = dao.selectList("board.getBoardList", param);

		return resultList;
	}

	@Transactional
	public int getTotalRowSize(Map<String, Object> param) {
//		log.info("totalItemsParam ::::: " + param);

		return dao.selectInt("board.getTotalRowSize", param);
	}

	@Transactional
	public String writeArticleInBoard(Map<String, Object> map) {
		String resultPage = "home/addFail";

		
//		1. 3에서 사용할 GROUP_ID를 저장해 놓는다.
		String group_id = map.get("GROUP_ID").toString();
		
		
//		2. 사용자가 선택한 게시판의 가장 마지막 NO를 구한다.
		map.put("GROUP_ID", "ALL"); // 게시판의 가장 마지막 번호가 필요
		int no = this.getTotalRowSize(map) + 1;
		
//		3. 입력할 자료를 만든다.
		map.put("NO", no);
		map.put("SEQ", 1); // 처음 등록하는 글은 최초의 글이기 때문에 1
		map.put("GROUP_ID", group_id); // 저장해 놓은 게시판 정보를 입력
		if(group_id.equals("NOTICE")) {
			map.put("NOTICE", 'Y');
		} else {
			map.put("NOTICE", 'N');
		}
		map.put("CNT", 0);
		map.put("DEL", DelVarials.DEL_NO.getYn());
		
//		5. 현재 로그인 한 사람의 email로 부터 닉네임을 알아온다.
		map.put("REG_ID", "abc");
		
		log.info("writeArticleInBoard ::::: " + map);
		
		
		
//		6. 게시판에 글을 insert 한다.
		if(dao.insert("board.insertBoardItem", map) > 0) {
		  resultPage = "home/addOK";
		}
		
		return resultPage;
	}
	
	public Map<String, Object> getDataByNo(Map<String, Object> map) {
		
		return dao.selectOne("board.getDataByNO", map);
	}

}
