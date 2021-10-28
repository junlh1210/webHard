package kr.co.erion.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class DownloadView extends AbstractView{

	public DownloadView() {
		log.info("DownloadView 생성자 == ");
    	setContentType("application/download; charset=utf-8");
    }
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Map<String, Object> map = (HashMap) model.get("downloadFile");

		log.info("DownLoadView.renderMergeOutputModel :: " + map);
		
        File file = (File) map.get("model");
        
        response.setContentType(getContentType());
        response.setContentLength((int) file.length());
        
        String userAgent = request.getHeader("User-Agent");
        
        // IE에서 한글 파일 이름이 정상적으로 저장되게 한다.
        String fileName = String.valueOf(map.get("FILE_REALNAME"));
        
        boolean ie = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1;
        
        if (ie) {
            fileName = URLEncoder.encode(fileName, "utf-8");
        } else {
            fileName = new String(fileName.getBytes("UTF-8"), "8859_1");
        }
        response.setHeader("Content-Disposition", "attachment; filename=\""
                + fileName + "\";");	
        response.setHeader("Content-Transfer-Encoding", "binary");
        
        OutputStream out = response.getOutputStream();
        try(FileInputStream fis = new FileInputStream(file);) {
            FileCopyUtils.copy(fis, out);
        } catch (Exception e) {
			log.info("" + e.getMessage());
		} 
        
        out.flush();
	}

}
