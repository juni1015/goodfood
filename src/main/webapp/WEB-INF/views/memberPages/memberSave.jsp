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
      <label for="email" class="form-label">이메일</label>
      <div class="row">
        <div class="col-4">
          <input type="email" class="form-control" id="email" name="memberEmail" placeholder="이메일 입력" onblur="email_check()">
        </div>
        <div class="col-1">
          <p id="emailSign">@</p>
        </div>
        <div class="col-4">
          <input type="email" class="form-control" id="domain" name="memberDomain" placeholder="도메인 입력" onblur="email_check()">
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
      <p id="email-result"></p>
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
      <input type="text" class="form-control" id="name" name="memberName" placeholder="이름 입력" onblur="name_check()">
      <p id="name-result"></p>
    </div>
    <div class="mb-3">
      <label for="nickname" class="form-label">닉네임</label>
      <input type="text" class="form-control" id="nickname" name="memberNickname" placeholder="닉네임 입력" onblur="nickname_check()">
      <p id="nickname-result"></p>
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
      <label for="profile" class="form-label">프로필 사진</label>
      <input type="file" class="form-control" id="profile" name="memberProfile">
    </div>
    <button type="submit" class="btn btn-primary" id="sign-up">가입</button>
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
  // 중복된 아이디가 있는지 확인
  const email_check = () => {
    const email = document.getElementById("email").value;
    const domain = document.getElementById("domain").value;
    const emailResult = document.getElementById("email-result");
    const exp = /^[a-z\d]{6,20}$/;
    let rtn = false;

    $.ajax({
      type: "post",
      url: "/member/email-check",
      async: false,
      data: {
        "memberEmail": email,
        "memberDomain": domain
      },
      success: function () {
        if (email.length == 0 || domain.length == 0) {
          emailResult.innerHTML = "필수정보입니다.";
          emailResult.style.color = "red";
        } else if (email.match(exp)) {
          emailResult.innerHTML = "사용가능한 이메일입니다.";
          emailResult.style.color = "green";
          rtn = true;
        } else {
          emailResult.innerHTML = "6~20자의 숫자, 영문 소문자만 사용 가능합니다.";
          emailResult.style.color = "red";
        }
      },
      error: function () {
        emailResult.innerHTML = "중복된 이메일입니다. 다른 이메일을 작성해주세요";
        emailResult.style.color = "red";
      }
    });
    return rtn
  }

  // 중복된 닉네임이 있는지 확인
  const nickname_check = () => {
    const nickname = document.getElementById("nickname").value;
    const nicknameResult = document.getElementById("nickname-result");
    let rtn = false;

    $.ajax({
      type: "post",
      url: "/member/nickname-check",
      async: false,
      data: {
        "memberNickname": nickname
      },
      success: function () {
        if (nickname.length == 0) {
          nicknameResult.innerHTML = "필수정보입니다.";
          nicknameResult.style.color = "red";
        } else {
          nicknameResult.innerHTML = "사용가능한 닉네임입니다.";
          nicknameResult.style.color = "green";
          rtn = true;
        }
      },
      error: function () {
        nicknameResult.innerHTML = "중복된 닉네임입니다. 다른 닉네임을 작성해주세요";
        nicknameResult.style.color = "red";
      }
    });
    return rtn
  }

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

  // 이름 정규식 확인
  const name_check = () => {
    const name = document.getElementById("name").value;
    const nameResult = document.getElementById("name-result");
    const exp = /^[가-힣a-zA-Z]+$/;
    if (name == "") {
      nameResult.innerHTML = "필수 정보입니다.";
      nameResult.style.color = "red";
      return true;
    } else if (name.match(exp)) {
      nameResult.innerHTML = "";
      nameResult.style.color = "green";
    } else {
      nameResult.innerHTML = "영문과 한글만 사용 가능합니다.";
      nameResult.style.color = "red";
    }
  }

  // 모바일 번호 정규식 확인
  const mobile_check = () => {
    const mobile = document.getElementById("mobile").value;
    const mobileResult = document.getElementById("mobile-result");
    const exp = /^\d{3}-\d{3,4}-\d{4}$/;
    if (mobile.match(exp) || mobile == "") {
      mobileResult.innerHTML = "";
      return false;
    } else {
      mobileResult.innerHTML = "3자리-3 또는 4자리-4자리 형식에 맞게 작성";
      mobileResult.style.color = "red";
      return true;
    }
  }

  // 도메인 선택 시 도메인 input 폼에 셋팅
  const domain_select = () => {
    const domain = document.getElementById("domain-select");
    const domainResult = document.getElementById("domain");
    domainResult.value = domain.value;
    email_check()
  }
</script>
</html>
