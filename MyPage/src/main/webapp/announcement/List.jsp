<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<script>
	function adminCheck()
	{
		var uid = "${sessionScope.nick}";
	
		if(uid != "관리자")
		{
			alert("관리자만 글쓰기가 가능합니다.")
		}
		else
		{
			location.href="../announcement/write.do";
		}
	}
</script>
</head>
<title>게시판</title>
<body>
    <div class="container my-3">
    <h2 align="center">공지사항</h2>
    <!-- 검색 폼 -->
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
            <th width="*">제목</th>
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
            	${map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index) }
            </td>
            <td align="left">
            <!-- 제목을 클릭할 경우 내용보기 페이지로 이동한다. -->
                <a href="../announcement/view.do?idx=${row.idx }">
                	${row.title}
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
            <!-- 
	            첨부파일의 경우 필수사항이 아니므로 테이블 생성시에도 not null 조건이 적용되어
	            있지 않다. 따라서 첨부파일이 있을때만 다운로드 링크를 출력한다. 
            -->
                <c:if test="${not empty row.ofile }">
                	<a href="../announcement/download.do?ofile=${row.ofile }&sfile=${row.sfile}&idx=${row.idx}">
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
            	<!-- 
            		컨트롤러(서블릿)에서 클래스 호출을 통해 이미 페이지 번호가 문자열로
            		만들어져 있는 상태이므로 뷰(JSP)에서는 출력만 해주면 된다.
            	 -->
                ${map.pagingImg }
            </td>
            <td width="150"><button type="button" class="btn btn-outline-secondary"
                onclick="location.href='../home/main.do';">메인으로</button></td>
            <td width="100"><button type="button" class="btn btn-outline-secondary"
                onclick="adminCheck()">글쓰기</button></td>
        </tr>
    </table>
</div>
</body>
</html>
