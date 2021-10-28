<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <%@ page session="false"%> <% %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
      crossorigin="anonymous"
    />
    <link rel="shortcut icon" type="image/x-icon" href="/resources/favicon.ico" />
    <link rel="stylesheet" href="/resources/tui-grid/tui-grid.css" />
    <link rel="stylesheet" href="/resources/css/dragAndDrop.css" />
    <script type="text/javascript" src="/resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="/resources/tui-grid/tui-grid.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
      crossorigin="anonymous"
    ></script>
    <title>내 웹하드</title>
  </head>
  <body>
    <div id="wrapper">
      <div class="container">
        <div class="row justify-content-end p-3 pt-0 pb-2 sticky-top">
          <button
            class="btn btn-success btn-sm col-2 m-2"
            type="button"
            data-bs-toggle="modal"
            data-bs-target="#fileUpload"
          >
            파일 업로드
          </button>
          <button
            class="btn btn-primary btn-sm col-2 m-2"
            type="button"
            data-bs-toggle="modal"
            data-bs-target="#makeFolder"
          >
            폴더 만들기
          </button>
          <button
            class="btn btn-danger btn-sm col-2 m-2"
            type="button"
            data-bs-target="#deleteFile"
            onclick="findSelectedFileName()"
          >
            삭제
          </button>
        </div>
        <div class="row">
          <div id="grid"></div>
        </div>
      </div>
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
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="recipient-name" class="col-form-label">이곳에 파일을 드롭하세요</label>
              <div id="dropzone">Drag &#38; Drop Files Here</div>
              <div id="downloadzone"></div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
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
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
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
            <h5 class="modal-title">선택 파일 지우기</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
            <button id="deleteFileButton" type="button" class="btn btn-primary">파일 지우기</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>

    <script type="text/javascript" src="/resources/js/common.js"></script>
    <script type="text/javascript" src="/resources/js/drapAndDrop.js"></script>
  </body>
</html>
