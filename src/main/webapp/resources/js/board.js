  

var board_grid = new tui.Grid({
  el: document.getElementById("board_grid"),
  scrollX: false,
  scrollY: false,
  columns: [
    {
      header: "번호",
      name: "NO",
      width: 80,
      align: "center",
    },
    {
      header: "제목",
      name: "TITLE",
    },
    {
      header: "작성자",
      name: "REG_ID",
      width: 200,
      align: "center",
    },
    {
      header: "날짜",
      name: "REG_DATE",
      width: 200,
      align: "center",
    },
    {
      header: "조회수",
      name: "CNT",
      width: 100,
      align: "center",
    },
  ],
});


// Toast UI Grid의 테마 변경
tui.Grid.applyTheme("default", {
  cell: {
    header: {
      background: "#E0E0F8",
      border: "#E0E0F8",
      },
  },
  row: {
	even: {
	  background: "#E0F8E0",
	},
	  hover: {
	    background: "#FADBD8",
	  },
	},
});

// 비동기 통신이 완료된 후 받은 자료로 그리드 새로 그리기
function gridResetData(result) {
  // console.log(result);
  // 받아온 자료로부터 데이터를 Toast UI Grid에 표시
  board_grid.resetData(result);
  
}
