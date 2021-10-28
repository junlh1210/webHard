<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
  <script type="text/javascript" src="/resources/js/webHard.js"></script>
  <body>
    <div>
      <!-- Button trigger modal -->
      <div class="container px-0 mr-0">
        <div class="row justify-content-end mb-1" style="margin-right: -7px">
          <button class="btn btn-success btn-sm col-2 m-2" type="button" data-toggle="modal" data-target="#fileUpload">
            파일 업로드
          </button>
          <button class="btn btn-primary btn-sm col-2 m-2" type="button" data-toggle="modal" data-target="#makeFolder">
            폴더 만들기
          </button>
          <button
            class="btn btn-danger btn-sm col-2 m-2 mr-0"
            type="button"
            data-target="#deleteFile"
            id="deleteButton"
          >
            삭제
          </button>
        </div>
      </div>

      <!-- Toast Grid -->
      <div id="webHard_grid"></div>
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
            <button id="deleteFileOrFolderButton" type="button" class="btn btn-primary">지우기</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript">
    $(document).ready(function(){
    	
    	// 더블 클릭시 폴더면 해당 폴더로 이동, 파일이면 다운로드
        webHard_grid.on("dblclick", function (e) {
		  
          let CAPACITY = e.instance.getRow(e.rowKey).TYPE; // 값이 없으면 ''
          var currentFILENAME = '${sessionScope.authUser.DIR_REALNAME}'
        
          // modifyDate가 null이면 Folder
          if (CAPACITY == "Folder") {
        	  
            // fileName이 . 이면 현재폴더
            if (e.instance.getRow(e.rowKey).FILENAME === ".") {
              console.log("현재 폴더를 리플레쉬");
    		  util.requestSync('/webhard/refreshDir', '', 'GET', gridResetData);
              
            } else if (e.instance.getRow(e.rowKey).FILENAME === "..") { // fileName이 .. 이면 부모폴더
            	
              if (e.instance.getRow(e.rowKey).DIR_NO == 0) { // 최상위 폴더의 DIR_REALNAME은 null.
            	  alert("현재폴더가 최상위 폴더 입니다.");
              } else {
            	  // 상위 폴더로 이동
            	  console.log("상위 폴더로 이동");
            	  let target = {
            			EMAIL: '${sessionScope.authUser.EMAIL}', 
            			DIR_NO: e.instance.getRow(0).DIR_NO
      				 };
      			  util.requestSync('/webhard/gotoUpDir', target, 'GET', gridResetData);
              }
              
            } else {
            	// 선택한 폴더로 이동
            	console.log("선택한 폴더로 이동");
            	let target = {
            					EMAIL: '${sessionScope.authUser.EMAIL}',  
            					DIR_REALNAME: e.instance.getRow(e.rowKey).FILENAME,
            					DIR_NO: e.instance.getRow(e.rowKey).DIR_NO,
            					PDIR_NO: e.instance.getRow(0).DIR_NO
            				 };
            	util.requestSync('/webhard/list', target, 'GET', gridResetData);
            	
            }
          } else {
            // 폴더가 아닌 파일을 선택하면 파일 다운로드
        	console.log(e.instance.getRow(e.rowKey).FILENAME + " 파일을 다운로드");
            location.href = "/webhard/getFileDownload?FILE_REALNAME="+encodeURI(e.instance.getRow(e.rowKey).FILENAME);
          }
          
        });

        // 폴더 만들기
        $("#createFolder").on("click", function () {          
          let dir_realname = $('#recipient-name').val();
          
          console.log(dir_realname + " 폴더 만들기");
          
          $.ajax({
            url        : "/webhard/createDirectory",
            method     : "POST",
            contentType: "application/json; charset=utf-8",
            data       : JSON.stringify( { DIR_REALNAME: dir_realname } ),
            dataType   : "JSON",
            error      : function() {alert('Cannot Create Directory')},
            success    : function (result) {
            	webHard_grid.resetData(result);
                $("#makeFolder").modal("hide"); // 모달창 닫기
                $("#recipient-name").val(""); // input field 내용 비우기
            },
          });
          
        });

        // 파일 및 폴더 지우기
        $("#deleteButton").on("click", function () {
        	
            if (webHard_grid.getFocusedCell().rowKey === null) {
                alert("파일이나 폴더를 선택하여야만 합니다.");
            } else if (
                webHard_grid.getRow(webHard_grid.getFocusedCell().rowKey).FILENAME === "." ||
                webHard_grid.getRow(webHard_grid.getFocusedCell().rowKey).FILENAME === ".."
            ) {
                alert("삭제할 수 없는 폴더입니다.");
            } else {
            	let data = {
            				  NAME: webHard_grid.getRow(webHard_grid.getFocusedCell().rowKey).FILENAME,
            				  TYPE: webHard_grid.getRow(webHard_grid.getFocusedCell().rowKey).TYPE
            			   };
            	$("#selectedFiles").val(data.NAME);
                $("#deleteFile").modal("show");
                
                $("#deleteFileOrFolderButton").on("click", function () {
                	let delete_url = "";
                	if (data.TYPE === "File") {
                		delete_url = "/webhard/deleteFile";
                	} else if (data.TYPE === "Folder") {
                		delete_url = "/webhard/deleteDir";
                	} else {
                		console.log("지우는 데 실패");
                	}
                	$.ajax({
                        url: delete_url,
                        method: "DELETE",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(data),
                        dataType: "JSON",
                        error: function () { alert('Cannot delete') },
                        success: function (result) {
                            webHard_grid.resetData(result);
                            $("#deleteFile").modal("hide"); // 모달창 닫기
                            $("#selectedFiles").val(""); // input field 내용 비우기
                        },
                    });
                });
            }
          
        });

        // 파일 업로드
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

          let files = e.originalEvent.dataTransfer.files;
          if (files.length < 1) return;

          for (let i = 0; i < files.length; i++) {
            let file = files[i];
          }
          F_FileMultiUpload(files, obj);
        });        
    });
    </script>
    <script type="text/javascript">
     	var initTarget = {
     						EMAIL: '${sessionScope.authUser.EMAIL}',
     						DIR_REALNAME: null,
     						DIR_NO: '${sessionScope.authUser.DIR_NO}',
     						PDIR_NO: 0,
	     	             };
    	util.requestSync('/webhard/list', initTarget, 'GET', gridResetData);
    </script>
  </body>
</html>
