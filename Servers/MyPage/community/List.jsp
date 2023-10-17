<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">   
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous"> 
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script> 
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.min.css">
</head>
<title>게시판</title>
<body>
    <div class="container my-3">
    <h2 align="center">자유게시판</h2>
    <form method="get">  
    <table border="1" width="90%" class="table table-bordered">
    <tr>
        <td align="center">
            <div class="input-group">
            <select name="searchField" class="form-select" style="display:inline">
                <option value="title">제목</option>
                <option value="content">내용</option>
                <option value="name">작성자</option>
            </select>
            <input type="text" name="searchWord" class="form-control" style="width:300px; display:inline" />
            <input type="submit" value="검색하기" class="form-control"
            style="border:1px solid gray; background-color:#d3d3d3; width:50px; display:inline"/>
            </div>
        </td>
    </tr>
    </table>
    </form>

    <!-- 목록 테이블 -->
    <table border="1" width="90%" class="table table-bordered">
        <tr align="center">
            <th width="10%">번호</th>
            <th width="*">
            제목
            </th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
            <th width="8%">첨부</th>
        </tr>
        
<c:choose>
	<c:when test="${empty boardLists }">
        <tr>
            <td colspan="6" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
        </c:when>
        
        <c:otherwise>
        <!-- 게시물이 있을때 컬렉션에 저장된 목록의 개수만큼 반복한다. -->
        <c:forEach items="${boardLists }" var="row" varStatus="loop">
        
        <tr align="center">
            <td>
            	${map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index) }
            </td>
            <td align="left">
            <!-- 제목을 클릭할 경우 내용보기 페이지로 이동한다. -->
                <a href="../community/view.do?idx=${row.idx }">
                	${row.title }
                </a>
                <c:set var="now" value="<%=new java.util.Date()%>" /><!-- 현재시간 -->
				<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="today" /><!-- 현재시간을 숫자로 -->
				<fmt:parseNumber value="${row.postdate.time / (1000*60*60*24)}" integerOnly="true" var="chgDttm" /><!-- 게시글 작성날짜를 숫자로 -->
				<c:if test="${today - chgDttm < 1}"> <!-- 하루동안 신규글 확인 -->
					<img src="../images/new.jpg" alt="" style="width:20px; height:20px"/>
				</c:if>
            </td> 
            <td>${row.name }</td>
            <td>${row.visitcount }</td>
            <td>${row.postdate }</td>
            <td>

                <c:if test="${not empty row.ofile }">
                	<a href="../community/download.do?ofile=${row.ofile }&sfile=${row.sfile}&idx=${row.idx}">
                	[Down]
                	</a>
                </c:if>
            </td>
        </tr>
        </c:forEach>
        </c:otherwise>
        </c:choose>
    </table>
   
   <!-- 하단 메뉴(바로가기, 글쓰기) -->
    <table border="1" width="90%" class="table table-bordered">
        <tr align="center">
            <td>

                ${map.pagingImg }
            </td>
            <td width="150"><button type="button" class="btn btn-outline-secondary"
                onclick="location.href='../home/main.do';">메인으로</button></td>
            <td width="100"><button type="button" class="btn btn-outline-secondary"
                onclick="location.href='../community/write.do';">글쓰기</button></td>
        </tr>
    </table>
</div>
</body>
</html>
