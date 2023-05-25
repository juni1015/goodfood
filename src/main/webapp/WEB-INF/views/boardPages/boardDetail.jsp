<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-16
  Time: 오후 2:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/main.css">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
    <style>
        .detail-table {
            font-size: 15px;
        }
        th, td {
            padding: 3px 10px 2px 0;
        }
        .store-information {
            font-size: 15px;
            padding-right: 10px;
        }
    </style>
</head>
<body>
<%@include file="../component/nav.jsp"%>
<div id="section">
    <div class="container">
        <div class="row">
            <%--        파일 있으면 보여지고 없으면 안 보여짐--%>
            <c:if test="${board.fileAttached == 1}">
                <div class="col-5">
                    <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}" alt="" width="100%">
                </div>
            </c:if>
            <div class="col-7">
                <div class="row">
                    <div class="col-9">
                        <h4>${board.boardStoreName}</h4>
                    </div>
                    <div class="col-3 star">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
                            <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
                        </svg>
                    </div>
                </div>

                <span class="store-information">조회수 ${board.boardStoreHits}</span>
                <span class="store-information">리뷰수 ${board.boardStoreReview}</span>
                <span class="store-information">찜수 ${board.boardStoreChoice}</span>
                <hr style="border-top: solid 1px black;">
                <table class="detail-table">
                    <tr>
                        <th>주소</th>
                        <td>${board.boardStoreAddress}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td>${board.boardStoreNumber}</td>
                    </tr>
                    <tr>
                        <th>음식종류</th>
                        <td>${board.boardStoreKind}</td>
                    </tr>
                    <tr>
                        <th>영업시간</th>
                        <td>${board.boardStoreTime}</td>
                    </tr>
                    <tr>
                        <th>웹사이트</th>
                        <td><a href="${board.boardStoreHomepage}">${board.boardStoreHomepage}</a></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="../component/footer.jsp"%>
</body>
</html>
