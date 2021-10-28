<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%

%>

<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" type="image/x-icon"
	href="/resources/favicon.ico" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css" />
<link rel="stylesheet" href="/resources/tui-grid/tui-grid.css" />
<script type="text/javascript" src="/resources/tui-grid/tui-grid.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>
<script type="text/javascript">
	function goLoginForm() {
		location = "/nosession/loginForm"
	}
</script>
<title>Login Fail!!!</title>
</head>
<body onLoad="setTimeout('goLoginForm()', 3000)">

	<!-- Login Fail Modal-->
	<div class="modal fade" id="loginFailModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">로그인 실패</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>이메일 혹은 비밀번호를 확인하세요.</p>
					<p style="color: red;">3초후에 로그인 페이지로 이동합니다.</p>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		let loginFailModal = new bootstrap.Modal(document
				.getElementById('loginFailModal'), {
			backdrop : 'static',
			keyboard : false
		});
		loginFailModal.show();
	</script>
</body>
</html>
