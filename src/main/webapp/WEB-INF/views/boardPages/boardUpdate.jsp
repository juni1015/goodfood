<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-17
  Time: 오후 4:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="/resources/css/form.css">
  <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="../component/nav.jsp"%>
<div id="section">
  <h3>게시글 작성</h3>
  <form action="/board/update?id=${board.id}&boardCategory=${boardCategory}&page=${paging.page}&q=${q}" method="post" enctype="multipart/form-data" onsubmit="return update_check()">
    <div class="mb-3">
      <label for="board-category" class="form-label">카테고리</label>
      <select id="board-category" class="form-select" name="boardCategory">
        <option value=1>food</option>
        <option value=2>cafe</option>
        <option value=3>alcohol</option>
      </select>
    </div>
    <div class="mb-3">
      <label for="store-name" class="form-label">가게명</label>
      <input type="text" class="form-control" id="store-name" name="boardStoreName" placeholder="가게명 입력" value="${board.boardStoreName}" onblur="double_check()">
    </div>
    <div class="mb-3">
      <label for="store-address" class="form-label">주소</label>
      <input type="text" class="form-control" id="store-address" name="boardStoreAddress" placeholder="가게 주소 입력" value="${board.boardStoreAddress}" onblur="double_check()">
      <p id="double-check-result"></p>
    </div>
    <div class="mb-3">
      <label for="store-kind" class="form-label">종류</label>
      <input type="text" class="form-control" id="store-kind" name="boardStoreKind" placeholder="음식 종류 입력" value="${board.boardStoreKind}">
    </div>
    <div class="mb-3">
      <label for="store-number" class="form-label">전화번호</label>
      <input type="text" class="form-control" id="store-number" name="boardStoreNumber" placeholder="가게 번호 입력" value="${board.boardStoreNumber}" onblur="number_check()">
      <p id="number-check-result"></p>
    </div>
    <div class="mb-3">
      <label for="store-time" class="form-label">영업시간</label>
      <input type="text" class="form-control" id="store-time" name="boardStoreTime" placeholder="가게 영업시간 입력" value="${board.boardStoreTime}">
    </div>
    <div class="mb-3">
      <label for="store-homepage" class="form-label">홈페이지</label>
      <input type="text" class="form-control" id="store-homepage" name="boardStoreHomepage" placeholder="가게 홈페이지 입력" value="${board.boardStoreHomepage}">
    </div>
    <%--    <div class="mb-3">--%>
    <%--      <label for="file" class="form-label">이미지 파일</label>--%>
    <%--      <input type="file" class="form-control" id="file" name="boardFile" value="${boardFile.storedFileName}">--%>
    <%--    </div>--%>
    <button type="submit" class="btn btn-primary" id="board-update">수정</button>
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
  // 카테고리 값 가져오기
  const boardCategory = '${board.boardCategory}';
  if (boardCategory == 1) {
    $('#board-category').val(1).prop("selected",true);
  } else if (boardCategory == 2) {
    $('#board-category').val(2).prop("selected",true);
  } else if (boardCategory == 3) {
    $('#board-category').val(3).prop("selected",true);
  }

  // 중복된 가게가 있는지 확인
  const double_check = () => {
    const storeName = document.getElementById("store-name").value;
    const storeAddress = document.getElementById("store-address").value;
    const doubleCheckResult = document.getElementById("double-check-result");
    const storeNameOrigin = '${board.boardStoreName}';
    const storeAddressOrigin = '${board.boardStoreAddress}';
    let rtn = false;

    $.ajax({
      type: "post",
      url: "/board/double-check",
      async: false,
      data: {
        "boardStoreName": storeName,
        "boardStoreAddress": storeAddress
      },
      success: function () {
        if (storeName.length == 0 || storeAddress.length == 0) {
          doubleCheckResult.innerHTML = "가게명과 가게 주소는 필수정보입니다.";
          doubleCheckResult.style.color = "red";
        } else {
          doubleCheckResult.innerHTML = "";
          rtn = true;
        }
      },
      error: function () {
        if (storeName == storeNameOrigin && storeAddress == storeAddressOrigin) {
          doubleCheckResult.innerHTML = "";
          rtn = true;
        } else {
          doubleCheckResult.innerHTML = "중복된 가게명과 주소입니다. 동일한 가게가 작성되어 있는지 확인하세요";
          doubleCheckResult.style.color = "red";
        }
      }
    });
    return rtn
  }

  // 전화번호 정규식 확인
  const number_check = () => {
    const number = document.getElementById("store-number").value;
    const numberResult = document.getElementById("number-check-result");
    const exp = /^\d{2,4}-\d{3,4}-\d{4}$/;
    if (number.match(exp) || number == "") {
      numberResult.innerHTML = "";
      return false;
    } else {
      numberResult.innerHTML = "2 또는 4자리-3 또는 4자리-4자리 형식에 맞게 작성";
      numberResult.style.color = "red";
      return true;
    }
  }

  const update_check = () => {
    const storeName = document.getElementById("store-name");
    const storeAddress = document.getElementById("store-address");
    const number = document.getElementById("store-number");
    if (storeName.value == "") {
      alert("가게명을 입력하십시오");
      storeName.focus();
      return false;
    } else if (storeAddress.value == "") {
      alert("주소를 입력하십시오");
      storeAddress.focus();
      return false;
    } else if (number_check()) {
      alert("전화번호를 확인하십시오");
      number.focus();
      return false;
    } else if (!double_check()) {
      alert("가게명과 주소를 확인하십시오");
      storeName.focus();
      return false;
    } else {
      return true;
    }
  }
</script>
</html>
