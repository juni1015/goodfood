<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-16
  Time: 오후 2:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/main.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="../component/nav.jsp"%>
<div id="section">
    <!-- 검색 -->
    <c:if test="${boardCategory != 0}">
        <div id="search-area" class="container">
            <form action="/board/list" method="get">
                <input type="text" name="boardCategory" hidden="hidden" value="${boardCategory}">
                <input type="text" name="q" placeholder="검색어 입력">
                <input type="submit" value="검색">
            </form>
        </div>
    </c:if>
    <!-- 조회된 글 리스트 -->
    <div class="container" id="list">
        <table class="table table-success table-striped">
            <tr>
                <th>no</th>
                <th>이름</th>
                <th>종류</th>
                <th>주소</th>
                <th>조회수</th>
                <th>리뷰수</th>
                <th>찜수</th>
            </tr>
            <c:forEach items="${boardList}" var="board">
                <tr>
                    <td>${board.id}</td>
                    <td>${board.boardStoreName}</td>
                    <td>${board.boardStoreKind}</td>
                    <td>${board.boardStoreAddress}</td>
                    <td>${board.boardStoreHits}</td>
                    <td>${board.boardStoreReview}</td>
                    <td>${board.boardStoreChoice}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <!-- 페이징 -->
    <div class="container">
        <ul class="pagination justify-content-center">
            <c:choose>
                <%--                현재 페이지에서 이전 페이지 없으면 클릭되지 않게 비활성화--%>
                <c:when test="${paging.page<=1}">
                    <li class="page-item disabled">
                        <a class="page-link">[이전]</a>
                    </li>
                </c:when>
                <%--                현재 페이지에서 이전 페이지가 있으면 버튼 활성화--%>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="/board/list?boardCategory=${boardCategory}&page=${paging.page-1}&q=${q}">[이전]</a>
                    </li>
                </c:otherwise>
            </c:choose>

            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                <c:choose>
                    <%--                    현재 페이지의 경우 클릭되지 않게 비활성화 --%>
                    <c:when test="${i eq paging.page}">
                        <li class="page-item active">
                            <a class="page-link">${i}</a>
                        </li>
                    </c:when>

                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="/board/list?boardCategory=${boardCategory}&page=${i}&q=${q}">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:choose>
                <%--                현재 페이지에서 다음 페이지 없으면 클릭되지 않게 비활성화--%>
                <c:when test="${paging.page>=paging.maxPage}">
                    <li class="page-item disabled">
                        <a class="page-link">[다음]</a>
                    </li>
                </c:when>
                <%--                현재 페이지에서 다음 페이지가 있으면 버튼 활성화--%>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="/board/list?boardCategory=${boardCategory}&page=${paging.page+1}&q=${q}">[다음]</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
<%@include file="../component/footer.jsp"%>
</body>
</html>
