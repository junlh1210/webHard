package kr.co.erion.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.erion.repository.CommonDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommonService {

	private final CommonDao dao;

	@Transactional
	public List<Map<String, Object>> getCodeList(Map<String, Object> params) {
		List<Map<String, Object>> resultList = dao.selectList("common.selectItems", params);

//		log.info("result ::::::: " + resultList);
		
		return resultList;
	}

}
