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
  <link rel="stylesheet" href="/resources/css/memberSave.css">
  <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="../component/nav.jsp"%>
<div id="section">
  <h3>회원가입</h3>
  <form action="/member/save" method="post" enctype="multipart/form-data" onsubmit="return save_check()">
    <div class="mb-3">
      <label for="id" class="form-label">아이디</label>
      <input type="text" class="form-control" id="id" name="memberId" placeholder="아이디 입력">
      <p id="id-result"></p>
    </div>
    <div class="mb-3">
      <label for="password" class="form-label">비밀번호</label>
      <input type="password" class="form-control" id="password" name="memberPassword" placeholder="비밀번호 입력" onblur="password_check()">
      <p id="password-result"></p>
    </div>
    <div class="mb-3">
      <label for="confirm-password" class="form-label">비밀번호 확인</label>
      <input type="password" class="form-control" id="confirm-password" placeholder="비밀번호 확인 입력" onblur="password_confirm()">
      <p id="confirm-password-result"></p>
    </div>
    <div class="mb-3">
      <label for="name" class="form-label">이름</label>
      <input type="text" class="form-control" id="name" name="memberName" placeholder="이름 입력">
    </div>
    <div class="mb-3">
      <label for="nickname" class="form-label">닉네임</label>
      <input type="text" class="form-control" id="nickname" name="memberNickname" placeholder="닉네임 입력">
    </div>
    <div class="mb-3">
      <label for="mobile" class="form-label">모바일</label>
      <div class="row">
        <div class="col-4">
          <select id="mobile-agency" class="form-select" name="memberMobileAgency">
            <option value="">통신사 선택</option>
            <option value="skt">SKT</option>
            <option value="kt">KT</option>
            <option value="lg">LG</option>
            <option value="mvno">MVNO</option>
          </select>
        </div>
        <div class="col-8">
          <input type="text" class="form-control" id="mobile" name="memberMobile" placeholder="모바일 번호 입력" onblur="mobile_check()">
        </div>
        <p id="mobile-result"></p>
      </div>
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">이메일</label>
      <div class="row">
        <div class="col-4">
          <input type="email" class="form-control" id="email" name="memberEmail" placeholder="이메일 입력">
        </div>
        <div class="col-1">
          <p id="emailSign">@</p>
        </div>
        <div class="col-4">
          <input type="email" class="form-control" id="domain" name="memberDomain" placeholder="도메인 입력">
        </div>
        <div class="col-3">
          <select id="domain-select" class="form-select" onchange="domain_select()">
            <option value="">직접입력</option>
            <option value="naver.com">네이버</option>
            <option value="gmail.com">지메일</option>
            <option value="hanmail.net">한메일</option>
            <option value="daum.net">다음</option>
          </select>
        </div>
      </div>
    </div>
    <div class="mb-3">
      <label for="profile" class="form-label">프로필 사진</label>
      <input type="file" class="form-control" id="profile" name="memberProfile">
    </div>
    <button type="submit" class="btn btn-primary" id="sign-up">가입</button>
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
  // 비밀번호 정규식 확인
  const password_check = () => {
    const password = document.getElementById("password").value;
    const passwordConfirm = document.getElementById("confirm-password").value;
    const passwordResult = document.getElementById("password-result");
    const exp = /^(?=.*[a-z])(?=.*\d)(?=.*[!#$%])[a-z\d!#$%]{8,16}$/;

    //비밀번호 확인이 입력된 후 비밀번호가 변경되면 바로 비밀번호 확인이 일치하는지 확인
    if (passwordConfirm != "") {
      password_confirm()
    }

    if(password.match(exp)) {
      passwordResult.innerHTML = "";
      return false;
    } else {
      passwordResult.innerHTML = "영문 소문자와 숫자, 특수문자(!, #, $, %) 필수 입력";
      passwordResult.style.color = "red";
      return true;
    }
  }

  // 비밀번호와 비밀번호 확인이 일치하는지 확인
  const password_confirm = () => {
    const password = document.getElementById("password").value;
    const passwordConfirm = document.getElementById("confirm-password").value;
    const passwordConfirmResult = document.getElementById("confirm-password-result");
    if (password == "") {
      passwordConfirmResult.innerHTML = "비밀번호 입력필요";
      passwordConfirmResult.style.color = "red";
      return false;
    } else if (password == passwordConfirm) {
      passwordConfirmResult.innerHTML = "일치";
      passwordConfirmResult.style.color = "green";
    } else {
      passwordConfirmResult.innerHTML = "불일치";
      passwordConfirmResult.style.color = "red";
      return true;
    }
  }

  // 모바일 번호 정규식 확인
  const mobile_check = () => {
    const mobile = document.getElementById("mobile").value;
    const mobileResult = document.getElementById("mobile-result");
    const exp = /^\d{3}-\d{4}-\d{4}$/;
    if(mobile.match(exp)) {
      mobileResult.innerHTML = "";
      return false;
    } else {
      mobileResult.innerHTML = "000-0000-0000 형식에 맞게 작성";
      mobileResult.style.color = "red";
      return true;
    }

  }

  // 도메인 선택 시 도메인 input 폼에 셋팅
  const domain_select = () => {
    const domain = document.getElementById("domain-select");
    const domainResult = document.getElementById("domain");
    domainResult.value = domain.value;
  }
</script>
</html>
