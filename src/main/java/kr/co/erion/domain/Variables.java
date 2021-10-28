package kr.co.erion.domain;

import java.io.File;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum Variables {

	WIN_LOCAL_HDD_ROOT("C:" + File.separator + "NAS"),
	LINUX_LOCAL_HDD_ROOT("fileData" + File.separator + "Downloads");
	
	private final String storage;
}
