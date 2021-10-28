package kr.co.erion.Utils;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FindPathAndName {

	public static Map<String, String> find(String str) {
		Map<String, String> map = new HashMap<>();
		List<String> list = new ArrayList<>(Arrays.asList(str.split("/")));

		log.info(list.toString());

		// 첫번째 요소는 공백이므로 삭제한다.
		list.remove(0);

		// 두번째 요소는 특정한 문자열(webhard)이므로 삭제한다.
		list.remove(0);

		// str의 가장 마지막 요소는 folder or file
		String kind = list.remove(list.size() - 1);
		map.put("kind", kind);

		// 남은 list의 가장 마지막 요소는 폴더 이름 혹은 파일 이름
		String name = list.remove(list.size() - 1);
		map.put("name", name);

		// 남은 list는 부모 path 이거나 file의 path
		map.put("path", list.stream().collect(Collectors.joining(File.separator)));

		return map;
	}
}
