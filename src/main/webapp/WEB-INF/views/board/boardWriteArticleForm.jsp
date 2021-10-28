<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
  <link href="/resources/css/summernote-lite.min.css" rel="stylesheet">
  <script src="/resources/js/summernote-lite.min.js"></script>
  <script src="/resources/js/lang/summernote-ko-KR.js"></script>
  <script type="text/javascript">
  
  // 게시판 종류를 선택할 수 있도록 하는 코드
  util.initSelectBox('selectGroupId', 'board', '', 'Y','새글을 추가하려는 게시판을 선택하세요');

  // board테이블에 입력하기 위한 자료들
  let boardWriteParam = {
	GROUP_ID: "",
	TITLE: "",
	CONTENTS: "" 
  };
  
  // 버트을 누르면 자료가 전송된다.
  function writeArticle() {
	  $('#form').submit();
  }
  </script>
</head>
<body>
  <form class="container" id="form" name="form" method="post" action="/board/writeArticleInBoard">
    <div class="row mb-2">
      <div class="col-7 pr-0">
        <select class="custom-select" id="selectGroupId" name="GROUP_ID"></select>
      </div>
      <div class="col-3 pr-0">
        <select class="custom-select" id="select2">
  		  <option selected>말머리 선택</option>
  		  <option value="1">One</option>
  		  <option value="2">Two</option>
  		  <option value="3">Three</option>
	    </select>
      </div>
      <div class="col-2">
      	<input type="button" value="등록" class="btn btn-danger" style="width: 100%;" onclick="javascript:writeArticle();" />
      </div>
    </div>
    <div class="row mb-2">
      <div class="col">
        <input type="text" class="form-control" id="title" name="TITLE" placeholder="제목을 입력하세요" />
      </div>
    </div>
    <div class="row">
      <div class="col">
        <textarea id="summernote" name="CONTENTS"></textarea>
      </div>
      
    </div>
  	
  </form>
  <script>
  $(document).ready(function(){
	// 게시판 종류를 가져와서 select문을 만든다.
	
	  
    $('#summernote').summernote({
	  lang: 'ko-KR',
      placeholder: '내용을 입력하세요.',
      tabsize: 4,
      height: 300,
      minHeight: null,             // set minimum height of editor
      maxHeight: null              // set maximum height of editor
    });
   
  });
  </script>
</body>
</html>