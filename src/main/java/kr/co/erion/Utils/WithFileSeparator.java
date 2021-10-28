package kr.co.erion.Utils;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WithFileSeparator {
	
	public static String removeLastStr(String str) {
		
		// mutable이 되지 않도록 ArrayList 생성
		List<String> list = new ArrayList<>(Arrays.asList(str.split("/")));
		
		log.info(list.toString());
		
		
		// 첫번째 요소는 공백이므로 삭제한다.
		list.remove(0);
		
		// 두번째 요소는 특정한 문자열(webhard)이므로 삭제한다.
		list.remove(0);
		
		// 마지막 요소는 특정한 문자열이므로 삭제한다.
		list.remove(list.size() - 1);
		
		log.info(list.toString());
		
		// 남은 요소는 반환
		return list.stream().collect(Collectors.joining(File.separator));
	}
	
}
