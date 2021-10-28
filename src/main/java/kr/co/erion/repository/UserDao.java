package kr.co.erion.repository;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Lazy
@Repository
@RequiredArgsConstructor
public class UserDao {

	final SqlSessionTemplate dao;

	public Map<String, Object> selectOne(String statement, Map<String, Object> condition) {
		return dao.selectOne(statement, condition);
	}
	
}
