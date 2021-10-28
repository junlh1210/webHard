// $(function () {
  var obj = $("#dropzone");

  obj.on("dragenter", function (e) {
    e.stopPropagation(); //상위 노드로 가는 이벤트를 멈춘다.
    e.preventDefault(); //현재 객체에 있는 모든 실행요소를 멈춘다.
    $(this).css("border", "2px solid #5272A0");
  });

  obj.on("dragleave", function (e) {
    e.stopPropagation();
    e.preventDefault();
    $(this).css("border", "2px dotted #8296C2");
  });

  obj.on("dragover", function (e) {
    e.stopPropagation();
    e.preventDefault();
  });

  obj.on("drop", function (e) {
    e.stopPropagation();
    e.preventDefault();
    $(this).css("border", "2px dotted #8296C2");

    var files = e.originalEvent.dataTransfer.files;
    if (files.length < 1) return;

    for (var i = 0; i < files.length; i++) {
      var file = files[i];
    }
    F_FileMultiUpload(files, obj);
  });
  //파일 멀티 업로드
  function F_FileMultiUpload(files, obj) {
    if (confirm(files.length + "개의 파일을 업로드 하시겠습니까?")) {
      var data = new FormData();
      for (var i = 0; i < files.length; i++) {
        data.append("files", files[i]);
      }

      $.ajax({
        url: "http://localhost:8080/upload",
        method: "POST",
        data: data,
        dataType: "json",
        processData: false,
        contentType: false,
        success: function (res) {
          alert("업로드가 완료되었습니다.");
          // F_FileMultiUpload_Callback(res.files);
        },
        error: function (res) {
          alert("업로드 중에 에러가 발생했습니다. 파일은 10M를 넘을 수 없습니다.");
          console.dir(res);
        },
      });
    }
  }

  // 파일 멀티 업로드 Callback
  function F_FileMultiUpload_Callback(files) {
    for (var i = 0; i < files.length; i++) {
      $("#downloadzone").append(
        "<a href='<c:url value='/board/getFileDownload'/>?filename=" + files[i] + "'>" + files[i] + "</a><br>\n"
      );
    }
  }
  function fnAlert(e, msg) {
    e.stopPropagation();
    alert(msg);
  }
// });
