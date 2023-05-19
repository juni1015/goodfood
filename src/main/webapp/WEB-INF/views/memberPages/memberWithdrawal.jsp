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
  <form action="/member/withdrawal" method="post" onsubmit="return password_check()">
    <div class="mb-3">
      <label for="password" class="form-label">비밀번호</label>
      <input type="password" class="form-control" id="password" placeholder="비밀번호 입력">
    </div>
    <button type="submit" class="btn btn-primary" id="password-check">비밀번호 확인</button>
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
  // 로그인한 회원 비밀번호와 입력한 비밀번호가 같은지 확인
  const password_check = () => {
    const password = document.getElementById("password");
    const loginPassword = '${member.memberPassword}';
    if (password.value != loginPassword) {
      alert("비밀번호가 틀렸습니다. 다시 입력하세요");
      password.value = "";
      password.focus();
      return false;
    } else {
      alert("탈퇴 완료");
      return true;
    }
  }
</script>
</html>
