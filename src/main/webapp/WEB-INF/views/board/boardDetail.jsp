<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
  <style type="text/css">
    .pointer {
      cursor: pointer;
    }
    .red {
      color: red;      
    }
  </style>
  <script type="text/javascript">
    //NO를 이용하여 자료 가져오기
    function getDataByNO(result) {
     console.log(result);
     document.getElementById("CDNM").innerHTML = result.CDNM;
     document.getElementById("TITLE").innerHTML = result.TITLE;
     document.getElementById("REG_ID").innerHTML = result.REG_ID;
     document.getElementById("NO").innerHTML = result.NO;
     document.getElementById("REG_DATE").innerHTML = new Date(result.REG_DATE).toISOString();
     document.getElementById("CONTENTS").innerHTML = result.CONTENTS;
    }
    
  </script>
</head>
<body>
  <div class="container">
    <div class="row">
      <div class="col-2 text-left text-dark" style="line-height: 38px;"><span id="CDNM"></span></div>
    </div>
    <hr class="my-1 bg-dark" />
    <div class="row my-2">
      <div class="col-10 h5 text-dark mb-0"><span id="TITLE"></span></div>
      <div class="col-2 ext-dark text-right" style="font-size: 12px; line-height: 24px;"><span id="REG_ID"></span></div>
    </div>
    <hr class="my-1" />
    <div class="row justify-content-between">
      <div class="col-2 text-dark text-left" style="font-size: 12px">글번호: <span id="NO"></span></div>
      <div class="col-4 text-dark text-right" style="font-size: 12px"><span id="REG_DATE"></span></div>
    </div>
    <div class="row">
      <div id="CONTENTS" class="col-12 text-dark mt-3"></div>
    </div>
    <hr class="my-3" />
    <div class="row">
      <div class="col-1 text-dark">댓글</div>
      <div id="asc" class="pr-3 red" style="font-size: 14px;">등록순</div>
      <div id="desc" class="pointer" style="font-size: 14px;">최신순</div>
    </div>
    <div class="row">
      <div id="comment" class="col-12 text-dark mt-3">댓글이 보일 자리</div>
      <div id="myComment" class="col-12 text-dark mt-3">
        <textarea rows="" cols=""></textarea>
      </div>
    </div>
    <hr class="my-3" />
    <div class="row justify-content-end">
      <div id="goTo" class="col-1 btn btn-danger" style="margin-right: 10px">목록</div>
      <div id="goTo" class="col-1 btn btn-secondary" style="margin-right: 10px">TOP</div>
    </div>
  </div>
<script>
  $(document).ready(function(){
	// NO를 이용하여 해당 글을 가져온다. GROUP_ID는 목록을 클릭했을 때 이전 목록으로 되돌아 가기 위한 DATA
    var param = {
	 		      NO: '${NO}',
	 		      GROUP_ID: '${GROUP_ID}',
	 		      CURRENT_PAGE : '${CURRENT_PAGE}'
	            };

    // 해당 NO의 글을 비동기통신으로 가져와서 화면에 표시한다.
    util.requestSync("/board/detail", param, "GET", getDataByNO);
    
    // 목록 버튼을 클릭하면 해당 게시판으로 돌아간다.
    $('#goTo').on('click', function() {
    	// console.log("목록으로 되돌아 가기 :: " + param.CURRENT_PAGE);
    	showLoad($('#CDNM').text(), '/board/' + param.GROUP_ID + "/" + param.CURRENT_PAGE);
    });
   
    // 댓글 정렬순서를 변경한다.
    $('#asc').on('click', function() {
    	$(this).removeClass('pointer').addClass('red');
    	$('#desc').addClass('pointer').removeClass('red');
    });    	
    $('#desc').on('click', function() {
    	$(this).removeClass('pointer').addClass('red');
    	$('#asc').addClass('pointer').removeClass('red');
    });
    
  });
</script>
</body>
</html>