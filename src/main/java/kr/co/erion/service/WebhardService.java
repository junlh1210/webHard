package kr.co.erion.service;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.erion.common.auth.UserAuth;
import kr.co.erion.domain.Variables;
import kr.co.erion.repository.CommonDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class WebhardService {

	private final CommonDao dao;

	@Transactional
	public List<Map<String, Object>> getFileList(HttpServletRequest req, Map<String, Object> param) {
		List<Map<String, Object>> result = new ArrayList<>();
		
		log.info("param ::::: " + param);
		result = dao.selectList("webHard.getFileListByDIR_REALNAME", param);
		
		// 현재 폴더 만들기
		Map<String, Object> result0 = new HashMap<>();
		result0.put("FILENAME", ".");
		result0.put("MODIFYDATE", null);
		result0.put("TYPE", "Folder");
		result0.put("CAPACITY", null);
		result0.put("DIR_NO", param.get("DIR_NO"));
				
		
		// 상위 폴더로 가기 만들기
		Map<String, Object> result1 = new HashMap<>();
		result1.put("FILENAME", "..");
		result1.put("MODIFYDATE", null);
		result1.put("TYPE", "Folder");
		result1.put("CAPACITY", null);
		result1.put("DIR_NO", param.get("PDIR_NO"));
		
		result.add(0, result0);
		result.add(1, result1);
		
		
		// 세션의 authUser를 업데이트
		String DIR_REALNAME = (String) param.get("DIR_REALNAME");
		
		UserAuth authUser = (UserAuth) req.getSession().getAttribute("authUser");
		if (DIR_REALNAME == null || DIR_REALNAME.equals("")) {
			authUser.setDIR_REALNAME(null);
		} else {
			authUser.setDIR_REALNAME(DIR_REALNAME);
		}
		authUser.setDIR_NO(Integer.valueOf(String.valueOf(param.get("DIR_NO"))));
		authUser.setPDIR_NO(Integer.valueOf(String.valueOf(param.get("PDIR_NO"))));
		
		req.getSession().setAttribute("authUser", authUser);

		
		return result;
	}
	
	@Transactional
	public List<Map<String, Object>> gotoUpDir(HttpServletRequest req, Map<String, Object> param) {
		// EMAIL과 DIR_NO를 이용하여 부모폴더의 정보를 가져온다.
		Map<String, Object> map = new HashMap<>();
		map = dao.selectOne("webHard.getUpDirInfo", param);
		
		// 폴더정보를 가져왔으므로 해당 폴더의 리스트를 가져온다.
		return this.getFileList(req, map);
	}

	@Transactional
	public List<Map<String, Object>> refreshDir(HttpServletRequest req) {
		Map<String, Object> param = new HashMap<>();
		// EMAIL과 DIR_NO를 이용하여 부모폴더의 정보를 가져온다.
		
		UserAuth authUser = (UserAuth) req.getSession().getAttribute("authUser");
		param.put("DIR_NO", authUser.getDIR_NO());
		param.put("PDIR_NO", authUser.getPDIR_NO());
		param.put("EMAIL", authUser.getEMAIL());
		param.put("DIR_REALNAME", authUser.getDIR_REALNAME());
		
		// 폴더정보를 가져왔으므로 해당 폴더의 리스트를 가져온다.
		return this.getFileList(req, param);
	}
	
	@Transactional
	public boolean createDirectory(HttpServletRequest req, Map<String, Object> map) {
		
		boolean result = false;
		int insertCount = 0;
		
		insertCount = dao.insert("webHard.createDirectory", map);
		
		if(insertCount == 1) {
			result = true;
		}
		
		return result;
	}
	
	@Transactional
	public int getMaxRow(Map<String, Object> table) {
		
		return dao.selectInt("common.getMaxRow", table);
	}
	
	@Transactional
	public int deleteDir(Map<String, Object> row) {
		return dao.delete("webHard.deleteDir", row);
	}
	
	@Transactional
	public int deleteFile(Map<String, Object> row) {
		return dao.delete("webHard.deleteFile", row);
	}
	
	@Transactional
	public boolean upload(MultipartHttpServletRequest req, Map<String, Object> map) {
		boolean result = false;

		// 파일 저장을 위한 정보 구하기
		Map<String, Object> info = new HashMap<>();
		info = dao.selectOne("webHard.getInfoForFile", null);
		
		// 1. 파일에 관련된 정보를 저장
		Map<String, Object> param = new HashMap<>();
		param.put("GROUP_KEY", info.get("GUID"));  							// 파일업로드 그룹이름
		param.put("FILE_PATH", info.get("CURRENT_DATE"));					// 실제 파일저장 폴더명
		param.put("DIR_NO", map.get("DIR_NO"));    							// DB 가상폴더의 번호
		param.put("EMAIL", map.get("EMAIL"));								// 파일을 업로드한 사람의 이메일

		List<MultipartFile> files = req.getFiles("files");
		try {
			for(int cnt = 0; cnt < files.size(); cnt++) {
				param.put("FILE_SEQ", cnt);                							// 파일업로드 그룹속에서의 순서
				param.put("FILE_REALNAME", files.get(cnt).getOriginalFilename());	// DB에 저장될 파일의 실제 이름
				param.put("FILE_LENGTH", files.get(cnt).getBytes().length);			// 파일의 크기
				param.put("FILE_NAME", Calendar.getInstance().getTimeInMillis());	// 폴더에 저장될 파일의 가상 이름
				
				log.info(files.get(cnt).getOriginalFilename() + " uploaded!!!");
				
				// 2. 운영체제를 구분하여 자장될 위치를 구한다.(리눅스에 폴더 권한을 줄 필요 없음)
				String sPath;
				if (System.getProperty("os.name").toLowerCase().indexOf("win") >= 0) {
					sPath = Variables.WIN_LOCAL_HDD_ROOT.getStorage() + File.separator + String.valueOf(info.get("CURRENT_DATE"));
				} else {
					sPath = Variables.LINUX_LOCAL_HDD_ROOT.getStorage() + File.separator + String.valueOf(info.get("CURRENT_DATE"));
				}

				// 3. 지정된 위치가 존재하는지 확인하고 없으면 경로를 생성한다.
				File chkDir = new File(sPath);
				if (!chkDir.isDirectory()) {
					chkDir.mkdirs();
					
				}
				
				// 4. 지정된 위치에 파일을 복사한다.(리눅스에 파일 권한을 줄 필요 없음)
				FileCopyUtils.copy(files.get(cnt).getBytes(), new FileOutputStream(sPath + File.separator + param.get("FILE_NAME")));
				dao.insert("webHard.insertFile", param);
				
			}
			
			result = true;
			
		} catch (Exception e) {
			log.info("" + e.getMessage());
		}

		return result;

	}
	
	@Transactional
	public Map<String, Object> getFileData(HttpServletRequest req, Map<String, Object> map) {
		
		return dao.selectOne("webHard.fileInfoByFILE_REALNAME", map);
	}
	
	
}
