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
  <h3>로그인</h3>
  <form action="/member/login" method="post" onsubmit="return login_check()">
    <div class="mb-3">
      <label for="email-full" class="form-label">이메일</label>
      <input type="email" class="form-control" id="email-full" name="memberEmailFull" placeholder="이메일과 도메인 입력">
    </div>
    <div class="mb-3">
      <label for="password" class="form-label">비밀번호</label>
      <input type="password" class="form-control" id="password" name="memberPassword" placeholder="비밀번호 입력" onblur="password_check()">
    </div>
    <button type="submit" class="btn btn-primary" id="sign-in">로그인</button>
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
  // 로그인 전 아이디, 비밀번호 작성했는지 체크
  const login_check = () => {
    const emailFull = document.getElementById("email");
    const password = document.getElementById("password");
    if (emailFull.value == "") {
      alert("이메일을 입력하세요");
      emailFull.focus();
      return false;
    } else if (password.value == "") {
      alert("비밀번호를 입력하세요");
      password.focus();
      return false;
    } else {
      return true;
    }
  }
</script>
</html>
