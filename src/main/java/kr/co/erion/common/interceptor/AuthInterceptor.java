package kr.co.erion.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession(false);
		
		log.info("******************************");
		log.info(request.getRequestURL().toString());
		log.info("******************************");
		
		if (session == null || session.getAttribute("authUser") == null) {
			response.sendRedirect(request.getContextPath() + "/nosession/loginForm");
			return false;
		}
		
		return true;
	}
}
