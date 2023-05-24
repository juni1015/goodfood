<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>

</style>
<nav class="navbar navbar-expand-lg bg-body-tertiary navbar-extra-padding">
  <div class="container-fluid navbar-extra-width">
    <a class="navbar-brand" href="/">goodfood</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="/board/list?boardCategory=1">food</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/board/list?boardCategory=2">cafe</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/board/list?boardCategory=3">Alcohol</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">question</a>
        </li>
      </ul>
      <ul class="navbar-nav ml-auto">
        <c:if test="${sessionScope.loginEmailFull == null}">
          <li>
            <a href="/member/login" class="d-flex nav-link">sign in</a>
          </li>
          <li>
            <a href="/member/save" class="d-flex nav-link">sign up</a>
          </li>
        </c:if>
        <c:if test="${sessionScope.loginEmailFull.length() > 0}">
          <li>
            <a href="/member/mypage" class="d-flex nav-link">mypage</a>
          </li>
          <li>
            <a href="/member/logout" class="d-flex nav-link">logout</a>
          </li>
        </c:if>
      </ul>
      <form class="d-flex mt-3" role="search" action="/board/list" method="get">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="q">
        <button class="btn btn-outline-primary" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>
</script>