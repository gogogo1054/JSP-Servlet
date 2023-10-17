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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.min.css">

<meta charset="UTF-8">

<script>
	function adminCheckEdit()
	{
		var uid = "${sessionScope.nick}";
		
		if(uid != "관리자")
		{
			alert("관리자만 수정 및 삭제가 가능합니다.");
		}
		else
		{
			location.href="../announcement/pass.do?mode=edit&idx=${param.idx}";
		}
	}

	function adminCheckDelete()
	{
		var uid = "${sessionScope.nick}"; 

		if(uid != "관리자")
		{
			alert("관리자만 수정 및 삭제가 가능합니다.");
		}
		else
		{
			if(confirm("삭제하시겠습니까?"))
	        {
				location.href="../announcement/pass.do?mode=delete&idx=${param.idx}";
	        } 
	        else
	        {
	        	alert("취소했습니다.");
	        }
		}
	}
</script>

</head>
<title>파일 첨부형 게시판</title>
<body>
<div class="container my-3">
<h2 align="center">공지사항</h2>

<table border="1" width="90%" class="table table-bordered">
    <colgroup>
        <col width="15%"/> <col width="35%"/>
        <col width="15%"/> <col width="*"/>
    </colgroup> 
    <tr>
        <td>번호</td> <td>${dto.idx }</td>
        <td>작성자</td> <td>${dto.name }</td>
    </tr>
    <tr>
        <td>작성일</td> <td>${dto.postdate }</td>
        <td>조회수</td> <td>${dto.visitcount }</td>
    </tr>
    <tr>
    	<!-- 
    		첨부된 파일이 있는 경우에는 파일명과 다운로드 링크를 출력한다.
    		다운로드가 완료되면 다운로드 횟수를 1 증가시키기 위해 게시물의 일련번호를
    		파라미터로 전달한다.
    	 -->
        <td>제목</td>
        <td colspan="3">${dto.title }</td>
    </tr>
    <tr>
        <td>내용</td>
        <td colspan="3" height="100">
        ${dto.content } 
        <c:if test="${isImage eq true }">
        	<p>
        		<img src="../Uploads/${dto.sfile }" alt="" width="500"/>
        	</p>
        </c:if>
        </td>
    </tr> 
    <tr>
        <td>첨부파일</td>
        <td>            
        	<c:if test="${not empty dto.ofile }">
        	${dto.ofile }
        	<a href="../announcement/download.do?ofile=${dto.ofile }&sfile=${dto.sfile}&idx=${dto.idx}">
                [다운로드]            
        	</a>
        	</c:if>
        </td>
         <td>다운로드수</td>
        <td>${dto.downcount }</td>
    </tr> 
    <tr>
        <td colspan="4" align="center">
            <button type="button" onclick="adminCheckEdit()" class="btn btn-outline-primary" name="mode" value="edit"> 
                수정하기
            </button>
            <button type="button" onclick="adminCheckDelete()" class="btn btn-outline-primary" name="mode" value="delete">
                삭제하기
            </button>
            <button type="button" onclick="location.href='../announcement/list.do';" class="btn btn-outline-primary">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>
</div>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
</body>
</html>
