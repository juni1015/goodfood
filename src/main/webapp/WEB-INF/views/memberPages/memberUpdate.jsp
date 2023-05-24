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
  <style>
    #now-password-check {
      width: 100%;
    }
  </style>
</head>
<body>
<%@include file="../component/nav.jsp"%>
<div id="section">
  <h3>정보수정</h3>
  <form action="/member/update" method="post" onsubmit="return update_check()">
    <input type="text" name="id" value="${member.id}" hidden="hidden">
    <div class="mb-3">
      <label for="emailFull" class="form-label">이메일 (변경 불가)</label>
      <input type="text" class="form-control" id="emailFull" name="memberEmailFull" value="${member.memberEmailFull}" readonly>
    </div>
    <div class="mb-3">
      <label for="now-password" class="form-label">현재 비밀번호 확인 (비밀번호 변경시)</label>
      <div class="row">
        <div class="col-8">
          <input type="password" class="form-control" id="now-password" placeholder="현재 비밀번호 입력">
        </div>
        <div class="col-4">
          <input type="button" class="btn btn-primary" id="now-password-check" value="현재 비밀번호 확인" onclick="nowPassword_check()">
        </div>
      </div>
<%--      <input type="text" id="now-passowrd-result">--%>
    </div>
    <div id="password-update" style="display: none">
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
    </div>
    <div class="mb-3">
      <label for="name" class="form-label">이름</label>
      <input type="text" class="form-control" id="name" name="memberName" placeholder="이름 입력" value="${member.memberName}" onblur="name_check()">
      <p id="name-result"></p>
    </div>
    <div class="mb-3">
      <label for="nickname" class="form-label">닉네임</label>
      <input type="text" class="form-control" id="nickname" name="memberNickname" placeholder="닉네임 입력" value="${member.memberNickname}" onblur="nickname_check()">
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
          <input type="text" class="form-control" id="mobile" name="memberMobile" placeholder="모바일 번호 입력" value="${member.memberMobile}" onblur="mobile_check()">
        </div>
        <p id="mobile-result"></p>
      </div>
    </div>
<%--    <div class="mb-3">--%>
<%--      <label for="profile" class="form-label">프로필 사진</label>--%>
<%--      <input type="file" class="form-control" id="profile" name="memberProfile">--%>
<%--    </div>--%>
    <button type="submit" class="btn btn-primary" id="sign-up">수정</button>
  </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
  // 통신사 값 가져오기
  const memberMobileAgency = '${member.memberMobileAgency}';
  if (memberMobileAgency == "skt") {
    $('#mobile-agency').val('skt').prop("selected",true);
  } else if (memberMobileAgency == "kt") {
    $('#mobile-agency').val('kt').prop("selected",true);
  } else if (memberMobileAgency == "lg") {
    $('#mobile-agency').val('lg').prop("selected",true);
  } else if (memberMobileAgency == "mvno") {
    $('#mobile-agency').val('mvno').prop("selected",true);
  }
  <%--// 저장된 모바일 통신사(mobile agency) 값--%>
  <%--const memberMobileAgency = '${member.memberMobileAgency}';--%>

  <%--// `select` 요소 가져오기--%>
  <%--const mobileAgencySelect = document.getElementById('mobile-agency');--%>

  <%--// 저장된 모바일 통신사(mobile agency) 값에 따라 옵션 선택--%>
  <%--if (memberMobileAgency === 'skt') {--%>
  <%--  mobileAgencySelect.value = 'skt';--%>
  <%--} else if (memberMobileAgency === 'kt') {--%>
  <%--  mobileAgencySelect.value = 'kt';--%>
  <%--} else if (memberMobileAgency === 'lg') {--%>
  <%--  mobileAgencySelect.value = 'lg';--%>
  <%--} else if (memberMobileAgency === 'mvno') {--%>
  <%--  mobileAgencySelect.value = 'mvno';--%>
  <%--}--%>

  // 중복된 닉네임이 있는지 확인
  const nickname_check = () => {
    const nickname = document.getElementById("nickname").value;
    const nicknameResult = document.getElementById("nickname-result");
    const nowNickname = '${member.memberNickname}';
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
        if (nickname == nowNickname) {
          nicknameResult.innerHTML = "";
          rtn = true;
        } else {
          nicknameResult.innerHTML = "중복된 닉네임입니다. 다른 닉네임을 작성해주세요";
          nicknameResult.style.color = "red";
        }
      }
    });
    return rtn
  }

  // 현재 비밀번호 확인
  const nowPassword_check = () => {
    const nowPassword = document.getElementById("now-password");
    const password = '${member.memberPassword}';
    const passwordUpdate = document.getElementById("password-update");
    // const nowPasswordResult = document.getElementById("now-password-result");
    if (nowPassword.value == password) {
      // passwordUpdate.classList.remove("hidden"); // hidden 클래스 제거
      passwordUpdate.style.display = ""; // Remove the "display" style
      alert("확인 완료");
      // nowPasswordResult.value = "1";
    } else {
      alert("비밀번호가 다릅니다. 다시 입력");
      nowPassword.focus();
    }
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

    if (password == "") {
      passwordResult.innerHTML = "";
      return false;
    } else if(password.match(exp)) {
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
    if (password == "" && passwordConfirm == "") {
      return false;
    } else if (password == "") {
      passwordConfirmResult.innerHTML = "비밀번호 입력필요";
      passwordConfirmResult.style.color = "red";
      return true;
    } else if (password == passwordConfirm) {
      passwordConfirmResult.innerHTML = "일치";
      passwordConfirmResult.style.color = "green";
      return false;
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
      return false;
    } else {
      nameResult.innerHTML = "영문과 한글만 사용 가능합니다.";
      nameResult.style.color = "red";
      return true;
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

  const update_check = () => {
    const password = document.getElementById("password");
    const passwordConfirm = document.getElementById("confirm-password");
    const name = document.getElementById("name");
    const nickname = document.getElementById("nickname");
    const mobile = document.getElementById("mobile");
    if (password_check()) {
      alert("비밀번호을 확인하십시오");
      password.focus();
      return false;
    } else if (password_confirm()) {
      alert("비밀번호 확인을 확인하십시오");
      passwordConfirm.focus();
      return false;
    } else if (name_check()) {
      alert("이름을 확인하십시오");
      name.focus();
      return false;
    } else if (!nickname_check()) {
      alert("닉네임을 확인하십시오");
      nickname.focus();
      return false;
    } else if (mobile_check()) {
      alert("모바일 번호를 확인하십시오");
      mobile.focus();
      return false;
    } else {
      if (password.value == "" && passwordConfirm.value == "") {
        password.value = '${member.memberPassword}';
      }
      return true;
    }
  }
</script>
</html>
