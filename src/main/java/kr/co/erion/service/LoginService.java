package kr.co.erion.service;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.erion.repository.UserDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class LoginService {
	
	public final UserDao dao;
	
	@Transactional
	public Map<String, Object> selectUserByEmail(Map<String, Object> map) {

		// 1. 데이터 확인
		Map<String, Object> userInfo = dao.selectOne("user.selectUserByEmail", map);
		
		if (userInfo == null) {
			log.info("email이 " + (String)map.get("email") + "인 데이터는 존재하지 않습니다.");
		} else {
			log.info("조회 결과 확인 : " + userInfo.toString());
		}
		
		return userInfo;
	}
	
	@Transactional
	public Map<String, Object> selectWebHardInfo(Map<String, Object> param) {
		return dao.selectOne("webHard.getRootDirInfo", param);
	}
}
