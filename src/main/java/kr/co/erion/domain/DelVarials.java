package kr.co.erion.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum DelVarials {
	
	NOTICE_NO('N'),
	DEL_NO('N');
	
	private final char yn;
}
