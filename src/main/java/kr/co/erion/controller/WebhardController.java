package kr.co.erion.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.erion.common.auth.UserAuth;
import kr.co.erion.domain.Variables;
import kr.co.erion.service.WebhardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class WebhardController {
	
	private final WebhardService service;
	
	@RequestMapping(value = "/util/webhard", method = RequestMethod.GET)
	public String webHard(Model model) {
		log.info("http://localhost:8080/webHard로 접속했습니다.");
		
		return "webhard/webhard";
	}

	@ResponseBody
	@GetMapping("webhard/list")
	public List<Map<String, Object>> subDir1(HttpServletRequest req, @RequestParam Map<String, Object> param) {
		
		List<Map<String, Object>> fileList = service.getFileList(req, param);
		
		return fileList;
	}
	
	@ResponseBody
	@GetMapping("webhard/gotoUpDir")
	public List<Map<String, Object>> gotoUpDir(HttpServletRequest req, @RequestParam Map<String, Object> param) {
		
		List<Map<String, Object>> fileList = service.gotoUpDir(req, param);
		
		return fileList;
	}
	
	@ResponseBody
	@GetMapping("webhard/refreshDir")
	public List<Map<String, Object>> refreshDir(HttpServletRequest req) {
		
		List<Map<String, Object>> fileList = service.refreshDir(req);
		
		return fileList;
	}
	
	@ResponseBody
	@PostMapping("webhard/createDirectory")
	public List<Map<String, Object>> createFolder(HttpServletRequest req, @RequestBody Map<String, Object> map) {
		List<Map<String, Object>> result = new ArrayList<>();
		
		// 필요한 파라미터를 모두 넣어준다.
		map.put("TABLE_NAME", "WEBHARD_DIR");
		int maxRow = service.getMaxRow(map) + 1;
		
		UserAuth authUser = (UserAuth) req.getSession().getAttribute("authUser");
		map.put("DIR_NO", maxRow);
		map.put("PDIR_NO", authUser.getDIR_NO());
		map.put("EMAIL", authUser.getEMAIL());
		
		log.info("map ::::: " + map);
		
		boolean isCreateDirectory = service.createDirectory(req, map);
				
		if (isCreateDirectory) {
			map.clear();
			
			map.put("EMAIL", authUser.getEMAIL());
			map.put("DIR_NO", authUser.getDIR_NO());
			map.put("PDIR_NO", authUser.getPDIR_NO());
			map.put("DIR_REALNAME", authUser.getDIR_REALNAME());
			
			result = service.getFileList(req, map);
		}
		
		return result;
	}
	
	
	@ResponseBody
	@DeleteMapping("webhard/deleteDir")
	public List<Map<String, Object>> deleteDir(HttpServletRequest req, @RequestBody Map<String, Object> map) {
		List<Map<String, Object>> result = new ArrayList<>();
		log.info("delete param :::::: " + map);
		
		UserAuth authUser = (UserAuth) req.getSession().getAttribute("authUser");
		map.put("EMAIL", authUser.getEMAIL());
		
		int isDeleted = service.deleteDir(map);
		if (isDeleted != 0) {
			
			map.clear();
			
			map.put("EMAIL", authUser.getEMAIL());
			map.put("DIR_NO", authUser.getDIR_NO());
			map.put("PDIR_NO", authUser.getPDIR_NO());
			map.put("DIR_REALNAME", authUser.getDIR_REALNAME());
			
			result = service.getFileList(req, map);
		}
		
		return result;
	}
	
	@ResponseBody
	@DeleteMapping("webhard/deleteFile")
	public List<Map<String, Object>> deleteFile(HttpServletRequest req, @RequestBody Map<String, Object> map) {
		List<Map<String, Object>> result = new ArrayList<>();
		
		UserAuth authUser = (UserAuth) req.getSession().getAttribute("authUser");
		
		map.put("EMAIL", authUser.getEMAIL());
		map.put("DIR_NO", authUser.getDIR_NO());
		map.put("PDIR_NO", authUser.getPDIR_NO());
		map.put("DIR_REALNAME", authUser.getDIR_REALNAME());
		
		int isDeleted = service.deleteFile(map);
		if (isDeleted != 0) {
			
			result = service.getFileList(req, map);
		}
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("webhard/upload")
	public List<Map<String, Object>> upload(MultipartHttpServletRequest req) {
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		Map<String, Object> map = new HashMap<>();
		UserAuth authUser = (UserAuth) req.getSession().getAttribute("authUser");
		map.put("EMAIL", authUser.getEMAIL());
		map.put("DIR_NO", authUser.getDIR_NO());
		map.put("PDIR_NO", authUser.getPDIR_NO());
		map.put("DIR_REALNAME", authUser.getDIR_REALNAME());
		
		boolean isUploaded = service.upload(req, map);
		
		if(isUploaded) {
			resultList = service.getFileList(req, map);
		}
		
		return resultList;
	}
	
	@RequestMapping("webhard/getFileDownload")
	public ModelAndView getFileDownload(HttpServletRequest req, @RequestParam Map<String, Object> map) throws Exception {
				
		UserAuth authUser = (UserAuth) req.getSession().getAttribute("authUser");
		map.put("EMAIL", authUser.getEMAIL());
		map.put("DIR_NO", authUser.getDIR_NO());
		map.put("PDIR_NO", authUser.getPDIR_NO());
		map.put("DIR_REALNAME", authUser.getDIR_REALNAME());
		
		Map<String, Object> fileMap = service.getFileData(req, map);
		
		String path = "";
		if(fileMap != null) {
			// 운영체제를 구분하여 위치를 달리한다.
			if (System.getProperty("os.name").toLowerCase().indexOf("win") >= 0) {
				path = Variables.WIN_LOCAL_HDD_ROOT.getStorage() + File.separator + String.valueOf(fileMap.get("FILE_PATH"))
				 + File.separator + String.valueOf(fileMap.get("FILE_NAME"));
			} else {
				path = Variables.LINUX_LOCAL_HDD_ROOT.getStorage() + File.separator + String.valueOf(fileMap.get("FILE_PATH"))
				 + File.separator + String.valueOf(fileMap.get("FILE_NAME"));
			}
			
			log.info("파일 " + path + "을 다운로드 합니다.");
		}
		
		Map<String, Object> data = new HashMap<>();
		
		File downloadFile = new File(path);		
		data.put("model", downloadFile);
		data.put("FILE_REALNAME", fileMap.get("FILE_REALNAME"));
		
		return new ModelAndView("downloadView", "downloadFile", data);
	}
	
}
