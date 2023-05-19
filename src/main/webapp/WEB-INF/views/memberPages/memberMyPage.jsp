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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"
            integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"
            integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ"
            crossorigin="anonymous"></script>
    <style>
        .rounded-circle {
            width: 200px; /* 원하는 크기로 설정 */
            height: 200px;
            border-radius: 50%; /* border를 원형으로 만듦 */
            overflow: hidden; /* 넘치는 부분을 숨김 */
            margin-bottom: 30px;
            margin-top: 20px;
        }

        .rounded-circle img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지가 div 영역에 꽉 차도록 설정 */
        }
    </style>
</head>
<body>
<%@include file="../component/nav.jsp" %>
<div id="section">
    <h3>마이페이지</h3>
    <c:if test="${member.profileAttached == 1}">
        <div class="rounded-circle">
                <%--               src="${pageContext.request.contextPath} : 현재 돌고있는 서버에 접근한다--%>
            <img src="${pageContext.request.contextPath}/upload/${memberProfile.storedFileName}" alt="" width="300"
                 height="300">
        </div>
    </c:if>
    <div class="mb-3">
        <h6>닉네임</h6>
        <span>${member.memberNickname}</span>
    </div>
    <div class="mb-3">
        <h5>이름</h5>
        <span>${member.memberName}</span>
    </div>
    <div class="mb-3">
        <h5>이메일</h5>
        <span>${member.memberEmailFull}</span>
    </div>
    <div class="mb-3">
        <h5>모바일</h5>
        <span>${member.memberMobileAgency}</span>
        <span>${member.memberMobile}</span>
    </div>
    <button class="btn btn-primary" onclick="member_update()">정보수정</button>
    <button class="btn btn-primary" onclick="member_withdrawal()">회원탈퇴</button>
</div>
<%@include file="../component/footer.jsp" %>
</body>
<script>
  const member_update = () => {
    location.href = "/member/update";
  }
  const member_withdrawal = () => {
    location.href = "/member/withdrawal";
  }
</script>
</html>
