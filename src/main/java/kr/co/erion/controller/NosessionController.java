package kr.co.erion.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.erion.common.auth.UserAuth;
import kr.co.erion.service.LoginService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class NosessionController {

	private final LoginService service;

	@GetMapping("/registForm")
	public String registForm(Model model, HttpServletRequest req, HttpServletResponse res) {
		return "auth/registForm";
	}

	@RequestMapping(value = "nosession/doReg", method = RequestMethod.POST)
	public String doReg(Model model, HttpServletRequest req, HttpServletResponse res) {
		log.info("회원 가입 정보가 들어왔습니다.");
		log.info("회원 정보: ");

		return "auth/loginForm";
	}

	@RequestMapping(value = "nosession/loginForm", method = RequestMethod.GET)
	public String loginForm(Model model, HttpServletRequest req, HttpServletResponse res) {
		log.info("로그인 화면으로 들어왔습니다.");

		return "auth/loginForm";
	}

	@PostMapping("login")
	public String loginWithPassword(@RequestParam Map<String, Object> map, Model model, HttpServletRequest req,
			HttpServletResponse res, HttpSession session) {

		log.info("로그인 프로세스 시작 :: " + map);

		String page = null;

		// loginForm에서 email 과 password가 들어온다.
		Map<String, Object> userInfo = service.selectUserByEmail(map);
		
		// DB에 해당 email을 가진 data를 password를 이용하여 검증한다.
		if (userInfo != null && map.get("password").equals((String) userInfo.get("PASSWORD"))) {
			// 이동할 페이지를 지정
			page = "index";
			
			// WebHard에서 현재 로그인한 유저의 가장 최상위 디렉토리 번호(DIR_NO)를 DB에서 가져온다.
			Map<String, Object> param = new HashMap<>();
			param.put("EMAIL", map.get("email"));
			
			// 나중에 service.selectUserByEmail(map); 에 통합하자. *******************************
			Map<String, Object> webhard_location = new HashMap<>();
			webhard_location = service.selectWebHardInfo(param);
			
			// oracle에서는 int의 반환형이 BigDecimal이 된다.
			// log.info("!!!!!!!" + webhard_location.get("DIR_NO").getClass());
			
			// 세션에 유저에 대한 정보를 넣어준다.
			UserAuth authUser = UserAuth.builder()
										.EMAIL((String) userInfo.get("EMAIL"))
                    					.NICK_NAME((String) userInfo.get("NICK_NAME"))
                    					.GRP_CD((String) userInfo.get("GRP_CD"))
                    					.DIR_NO(Integer.parseInt(String.valueOf(webhard_location.get("DIR_NO"))))
                    					.PDIR_NO(Integer.parseInt(String.valueOf(webhard_location.get("PDIR_NO"))))
                    					.DIR_REALNAME((String) webhard_location.get("DIR_REALNAME"))
                    					.build();
			
			// 세션에 authUser를 넣어준다.
			session.setAttribute("authUser", authUser);
			
			// 접속환경에 대한 자료를 넣어준다.
			session.setAttribute("ServerInfo" , System.getProperty("spring.profiles.active"));
			
			
		} else {
			log.info("로그인 실패");

			// 로그인에 실패하면 loginFail.jsp로 이동
			page = "auth/loginFail";
		}

		return page;
	}

	@GetMapping("/nosession/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		log.info("로그아웃합니다.");
		return "redirect:/nosession/loginForm";
	}
}
