<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%> <% %>

<html>
  <style>
    #dropzone {
      border: 2px dotted #3292a2;
      color: #92aab0;
      text-align: center;
      font-size: 24px;
      line-height: 100px;
      height: 110px;
    }
  </style>

  <script>
    let grid; // toast grid를 저장하기 위한 변수

    // let current_url = '<c:out value="${current_url}"/>';
    let current_url = ""; // 현재의 path를 저장하기 위한 변수

    function findSelectedFileName() {
      if (grid.getFocusedCell().rowKey === null) {
        alert("파일이나 폴더를 선택하여야만 합니다.");
      } else if (
        grid.getRow(grid.getFocusedCell().rowKey).fileName === "." ||
        grid.getRow(grid.getFocusedCell().rowKey).fileName === ".."
      ) {
        alert("삭제할 수 없는 폴더입니다.");
      } else {
        $("#deleteFile").modal("show");
        // document.getElementById("selectedFiles").value = grid.getRow(grid.getFocusedCell().rowKey).fileName;
        $("#selectedFiles").val(grid.getRow(grid.getFocusedCell().rowKey).fileName);
      }
    }

    function getFolderList(url) {
      $.ajax({
        url,
        method: "GET",
      })
        .fail(function () {
          alert("에러가 났네");
        })
        .done(function (result) {
          grid.resetData(result);
        });
    }

    grid = new tui.Grid({
      el: document.getElementById("grid"),
      scrollX: false,
      scrollY: false,
      columns: [
        {
          header: "파일명",
          name: "fileName",
        },
        {
          header: "수정일자",
          name: "modifyDate",
          width: 200,
          align: "center",
        },
        {
          header: "유형",
          name: "type",
          width: 150,
          align: "center",
        },
        {
          header: "파일크기",
          name: "capacity",
          width: 150,
          align: "right",
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

    // 더블 클릭시 폴더면 해당 폴더로 이동, 파일이면 다운로드
    grid.on("dblclick", function (e) {
      let final_path = "";

      console.log("modifyDate dblclick!", e);

      let date = grid.getRow(e.rowKey).modifyDate;
      if (date == null) {
        // modifyDate가 null이면 Folder
        if (grid.getRow(e.rowKey).fileName === ".") {
          // fileName이 . 이면 현재폴더
          alert("현재 폴더입니다.");
        } else if (grid.getRow(e.rowKey).fileName === "..") {
          // fileName이 .. 이면 부모폴더

          // 최상위 폴더에서는 부모 폴더가 없다.
          if (current_url === "") {
            alert("이곳이 루트 폴더 입니다.");
          } else {
            let temp_value = current_url.split("/");

            // 배열의 마지막 요소를 제거한다.
            temp_value.pop();

            // 배열을 다시 하나의 문자열로 만들고 이는 새로운 current_url이 되어야 한다.
            current_url = temp_value.join("/");

            // 갱신된 current_url로 final_path를 재정의
            final_path = current_url;

            // 폴더를 클릭하면 현재 url에 특정한 문자열을 붙인 문자열을 생성
            if (final_path === "") {
              final_path = "webhard/list";
            } else {
              final_path = "webhard/" + encodeURI(final_path, "UTF-8") + "/list";
            }
            console.log("final_path : " + final_path);

            getFolderList(final_path);
          }
        } else {
          // 선택한 폴더로 이동하기 위하여 url을 갱신한다.
          if (current_url === "") {
            current_url = grid.getRow(e.rowKey).fileName;
          } else {
            current_url = current_url + "/" + grid.getRow(e.rowKey).fileName;
          }

          // 갱신된 url로 final_path를 재정의
          final_path = current_url;

          // 폴더를 클릭하면 현재 url에 특정한 문자열을 붙인 문자열을 생성
          final_path = "webhard/" + encodeURI(final_path, "UTF-8") + "/list";

          console.log("final_path : " + final_path);

          getFolderList(final_path);
        }
      } else {
        // 폴더가 아닌 파일을 선택하면
        console.log(grid.getRow(e.rowKey).fileName);
        if (current_url === "") {
          location.href = "webhard/getFileDownload?FILE_NAME=" + encodeURI(grid.getRow(e.rowKey).fileName, "UTF-8");
        } else {
          location.href =
            "webhard/" +
            current_url +
            "/getFileDownload?FILE_NAME=" +
            encodeURI(grid.getRow(e.rowKey).fileName, "UTF-8");
        }
      }
    });

    // 폴더 생성
    $("#createFolder").on("click", function () {
      let final_path = current_url;

      // 폴더를 클릭하면 현재 url에 /createFolder를 붙인 문자열을 생성
      final_path =
        "webhard" + "/" + encodeURI(final_path + "/" + $("#recipient-name").val(), "UTF-8") + "/createFolder";

      $.ajax({
        url: final_path,
        method: "GET",
        success: function (result) {
          grid.resetData(result);
          $("#makeFolder").modal("hide"); // 모달창 닫기
          $("#recipient-name").val(""); // input field 내용 비우기
        },
      });
    });

    // 파일 지우기
    $("#deleteFileButton").on("click", function () {
      let final_path = current_url;

      // 선택한 파일의 full path name을 반환한다.
      if (final_path === "") {
        final_path = "webhard" + "/" + encodeURI($("#selectedFiles").val(), "UTF-8");
      } else {
        final_path = "webhard" + "/" + encodeURI(final_path + "/" + $("#selectedFiles").val(), "UTF-8");
      }

      if (grid.getRow(grid.getFocusedCell().rowKey).modifyDate == null) {
        final_path += "/folder";
      } else {
        final_path += "/file";
      }

      console.log(final_path);
      $.ajax({
        url: final_path,
        method: "DELETE",
        success: function (result) {
          grid.resetData(result);
          $("#deleteFile").modal("hide"); // 모달 창 닫기
          $("#selectedFiles").val(""); // input field 내용 비우기
        },
      });
    });

    // 파일 업로드
    let obj = $("#dropzone");

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

      let files = e.originalEvent.dataTransfer.files;
      if (files.length < 1) return;

      for (let i = 0; i < files.length; i++) {
        let file = files[i];
      }
      F_FileMultiUpload(files, obj);
    });

    //파일 멀티 업로드
    function F_FileMultiUpload(files, obj) {
      if (confirm(files.length + "개의 파일을 업로드 하시겠습니까?")) {
        let data = new FormData();
        for (let i = 0; i < files.length; i++) {
          data.append("files", files[i]);
        }

        $.ajax({
          url: "webhard/upload",
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
      for (let i = 0; i < files.length; i++) {
        $("#downloadzone").append(
          "<a href='<c:url value='/board/getFileDownload'/>?filename=" + files[i] + "'>" + files[i] + "</a><br>\n"
        );
      }
    }
    function fnAlert(e, msg) {
      e.stopPropagation();
      alert(msg);
    }

    // 이 페이지가 불러오게 되면 바로 실행된다.
    history.pushState(null, null, "");
    getFolderList("/webhard/list");
    

  </script>

  <body>
    <div>
      <!-- Button trigger modal -->
      <div class="container">
        <div class="row justify-content-end p-3 pt-0 pb-2 ">
          <button class="btn btn-success btn-sm col-2 m-2" type="button" data-toggle="modal" data-target="#fileUpload">
            파일 업로드
          </button>
          <button class="btn btn-primary btn-sm col-2 m-2" type="button" data-toggle="modal" data-target="#makeFolder">
            폴더 만들기
          </button>
          <button
            class="btn btn-danger btn-sm col-2 m-2"
            type="button"
            data-target="#deleteFile"
            onclick="findSelectedFileName()"
          >
            삭제
          </button>
        </div>
      </div>

      <!-- Toast Grid -->
      <div id="grid"></div>
    </div>

    <!-- Modal for File Upload -->
    <div
      class="modal fade"
      id="fileUpload"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="fileUploadLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">파일 업로드</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="recipient-name" class="col-form-label">이곳에 파일을 드롭하세요</label>
              <div id="dropzone">Drag &#38; Drop Files Here</div>
              <div id="downloadzone"></div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal for Folder Create -->
    <div
      class="modal fade"
      id="makeFolder"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="makeFolderLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">폴더 만들기</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="mb-3">
                <label for="recipient-name" class="col-form-label">폴더 이름을 입력하세요</label>
                <input type="text" class="form-control" id="recipient-name" />
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button id="createFolder" type="button" class="btn btn-primary">폴더 만들기</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal for Delete File -->
    <div
      class="modal fade"
      id="deleteFile"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="deleteFileLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">파일 및 폴더 삭제</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="mb-3">
                <label for="selectedFiles" class="col-form-label">아래의 파일 혹은 폴더를 삭제합니다.</label>
                <input type="text" class="form-control" id="selectedFiles" value="" disabled />
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button id="deleteFileButton" type="button" class="btn btn-primary">지우기</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
