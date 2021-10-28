package kr.co.erion.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.erion.common.auth.UserAuth;
import kr.co.erion.repository.CommonDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MenuService {
	
	private final CommonDao dao;

	@Transactional
	public List<Map<String, Object>> getMenuList(HttpServletRequest req) {
		
		List<Map<String, Object>> result = new ArrayList<>();
		
		Map<String, Object> param = new HashMap<>();
		UserAuth authUser = (UserAuth) req.getSession().getAttribute("authUser");
		param.put("GRP_CD", authUser.getGRP_CD());
		
		result = dao.selectList("menu.getMenuList", param);
		return result;
	}
}
