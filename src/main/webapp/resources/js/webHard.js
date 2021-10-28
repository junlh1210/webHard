

// 비동기 통신이 완료된 후 받은 자료로 그리드 새로 그리기
function gridResetData(result) {
    // console.log(result);
    // 받아온 자료로부터 데이터를 Toast UI Grid에 표시
    webHard_grid.resetData(result);
}

//파일 멀티 업로드
function F_FileMultiUpload(files, obj) {
    if (confirm(files.length + "개의 파일을 업로드 하시겠습니까?")) {
        let data = new FormData();
        for (let i = 0; i < files.length; i++) {
            data.append("files", files[i]);
        }

        $.ajax({
            url: "/webhard/upload",
            method: "POST",
            data: data,
            dataType: "json",
            processData: false,
            contentType: false,
            success: function (res) {
                alert("업로드가 완료되었습니다.");
                $("#fileUpload").modal("hide"); // 모달창 닫기
                gridResetData(res);
            },
            error: function (res) {
                alert("업로드 중에 에러가 발생했습니다.");
                console.dir(res);
            },
        });
    }
}


var webHard_grid = new tui.Grid({
    el: document.getElementById("webHard_grid"),
    scrollX: false,
    scrollY: false,
    columns: [
        {
            header: "파일명",
            name: "FILENAME",
        },
        {
            header: "수정일자",
            name: "MODIFYDATE",
            width: 200,
            align: "center",
        },
        {
            header: "유형",
            name: "TYPE",
            width: 150,
            align: "center",
        },
        {
            header: "파일크기",
            name: "CAPACITY",
            width: 150,
            align: "right",
        },
        {
            header: "폴더번호",
            name: "DIR_NO",
            width: 150,
            align: "right",
            hidden: true,
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

