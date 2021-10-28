package kr.co.erion.domain;

import java.io.File;
import java.text.DecimalFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class FileData {

	private String fileName;
	private String modifyDate;
	private String type;
	private String capacity;

	public FileData(File file) {
		this.fileName = file.getName();
		this.modifyDate = this.longToLocalDateTime(file);
		this.type = this.convertIsDirectory(file);
		this.capacity = this.convertFileSize(file);
	}

	private String longToLocalDateTime(File file) {
		if (this.convertIsDirectory(file).equals("Folder")) {
			return null;
		} else {
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
//			return sdf.format(file.lastModified());
			
			LocalDateTime ldt = LocalDateTime.ofInstant(Instant.ofEpochMilli(file.lastModified()), ZoneId.of("Asia/Seoul")); 
			return ldt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd a hh:mm:ss"));
		}
	}

	private String convertIsDirectory(File file) {
		if (file.isDirectory()) {
			return "Folder";
		} else {
			return "File";
		}
	}

	private String convertFileSize(File file) {
		if (this.convertIsDirectory(file).equals("Folder")) {
			return null;
		} else {
			DecimalFormat df = new DecimalFormat("###,###K");
			return df.format(Math.ceil((double) file.length() / 1024));
		}
	}
}
