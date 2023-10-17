<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>회원목록</title>
<body>
    <div class="container my-3">
    <!-- 검색 폼 -->
    <form method="get">  
    <table border="1" width="90%" class="table table-bordered">
    <tr>
        <td align="center">
            <div class="input-group">
            <select name="searchField" class="form-select" style="display:inline">
                <option value="nickname">별명</option>
                <option value="name">이름</option>
                <option value="id">아이디</option>
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
            <th width="20%">별명</th>
            <th width="*">아이디</th>
            <th width="20%">이름</th>
            <th width="20%">이메일</th>
            <th width="15%">우편번호</th>
        </tr>
        
<c:choose>
	<c:when test="${empty memberLists }">
        <tr>
            <td colspan="6" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
        </c:when>
        
        <c:otherwise>
        <!-- 게시물이 있을때 컬렉션에 저장된 목록의 개수만큼 반복한다. -->
        <c:forEach items="${memberLists }" var="row" varStatus="loop">
        <!-- 
        	가상번호 계산하기
        	=> 전체 게시물개수 - (((페이지번호-1) * 페이지당 게시물수) + 해당 ㄹ후푸의 index)
        	참고로 varStatus 속성의 index는 0부터 시작한다.
        	
        	전체 게시물의 개수가 5개이고 페이지당 2개씩만 출력한다면
        	1페이지의 첫번째 게시물 번호 : 5 - (((1-1)*2)+0) = 5
        	2페이지의 첫번째 게시물 번호 : 5 - (((2-1)*2)+0) = 3
        	...
         -->
        
        <tr align="center">
            <td>
            	${row.nickname }
            </td>
            <td align="center">
                <a href="../admin/view.do?nickname=${row.nickname }">
                	${row.id }</a>
            </td> 
            <td>${row.name }</td>
            <td>${row.email }</td>
            <td>${row.postcode }</td>
        </tr>
        </c:forEach>
        </c:otherwise>
        </c:choose>
    </table>
   
   <!-- 하단 메뉴(바로가기, 글쓰기) -->
    <table border="1" width="90%" class="table table-bordered">
        <tr align="center">
            <td>
            	<!-- 
            		컨트롤러(서블릿)에서 클래스 호출을 통해 이미 페이지 번호가 문자열로
            		만들어져 있는 상태이므로 뷰(JSP)에서는 출력만 해주면 된다.
            	 -->
                ${map.pagingImg }
            </td>
            <td width="150"><button type="button" class="btn btn-outline-secondary"
                onclick="location.href='../home/main.do';">메인으로</button></td>
        </tr>
    </table>
</div>
</body>
</html>
