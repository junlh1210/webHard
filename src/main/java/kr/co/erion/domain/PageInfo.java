package kr.co.erion.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum PageInfo {
	
	MAX_PAGE_VISIBLE(5), // pagination에서 몇게의 번호가 보일지 설정
	PAGE_SIZE(5); // 하나의 페이지에 몇개의 글이 표시될 지 설정
	
	private final int number;
}
