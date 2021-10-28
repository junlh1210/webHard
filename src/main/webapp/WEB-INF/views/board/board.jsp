<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/pageButton.css">
<script type="text/javascript" src="/resources/js/board.js"></script>
<script type="text/javascript" src="/resources/js/pageButton.js"></script>
<script type="text/javascript">
// 페이지 버튼을 그리기 위하여 서버로 부터 자료를 받는다.
var pageParam = {
				  GROUP_ID: '${GROUP_ID}',
				  totalPages: Number('${totalPages}'),
				  maxPagesVisible: Number('${maxPagesVisible}'),
				  CURRENT_PAGE: Number('${CURRENT_PAGE}')
				};
	  		
// 게시판 글을 가지고 오기위한 자료
var boardParam = {
					GROUP_ID: '${GROUP_ID}',
					TOTAL_ITEMS: '${TOTAL_ITEMS}',
					CURRENT_PAGE: '${CURRENT_PAGE}'
				 };

// 객체를 선언하고 페이지 버튼을 그린다.
var paginationButtons = new PaginationButton(pageParam.totalPages, pageParam.maxPagesVisible, pageParam.CURRENT_PAGE);
paginationButtons.render();

// 버튼을 클릭했을 때 동작
paginationButtons.onChange(e => {
//	console.log('-- changed', e.target.value)
	boardParam.CURRENT_PAGE = e.target.value;
	util.requestSync("/board/list", boardParam, "GET", gridResetData);
});

// 글쓰기 버튼을 눌렀을 때 동작
$('#writeBoardArticle').on('click', function(){
	showLoad("게시판 글쓰기", "/board/boardWriteArticleForm");
});

// 게시판의 cell을 클릭하면 글을 읽을 수 있는 페이지로 이동

</script>
</head>
<body>
<div>
  <div class="px-0">
  	<div class="row justify-content-end  pr-3">
  	  <button id="writeBoardArticle" class="btn btn-primary mb-3 px-4">글쓰기</button>
  	</div>
	  <div id="board_grid"></div>
	<div class="row justify-content-center mt-3">
	  <div class="col">
	    <div id="pagination"></div>
	  </div>
	</div>
  </div>
</div>  
<script>
$(document).ready(function(){
	util.requestSync("/board/list", boardParam, "GET", gridResetData);
	
	// 게시판을 클릭하면 글을 읽을 수 있는 페이지로 이동
	board_grid.on("click", e => {
	// console.log(e.instance.getRow(e.rowKey).NO);
	showLoad("게시글 보기", "/board/form/"
			+ boardParam.GROUP_ID + "/"
			+ boardParam.CURRENT_PAGE + "/"
			+ e.instance.getRow(e.rowKey).NO);
	});	
});
</script>
</body>
</html>