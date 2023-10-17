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
function CheckEdit()
{
	var uid = "${sessionScope.nick}";
	var writer = "${dto.name }";
	
	if(uid != writer && uid != "관리자")
	{
		alert("작성자만 수정가능합니다.");
	}
	else
	{
		location.href="../community/pass.do?mode=edit&idx=${param.idx}";
	}
}

function CheckDelete()
{
	var uid = "${sessionScope.nick}";
	var writer = "${dto.name }";
	
	if(uid != writer && uid != "관리자")
	{
		alert("작성자만 수정가능합니다.");
	}
	else
	{
		if(confirm("삭제하시겠습니까?"))
        {
			location.href="../community/pass.do?mode=delete&idx=${param.idx}";
        } 
        else
        {
        	alert("취소했습니다.");
        }
	}
}

//댓글 등록
function writeCmt()
{
	
	var form = document.getElementById("writeCommentForm");
	var reply_content = form.reply_content.value;
	var uid = "${sessionScope.nick}";
	var reply = form.reply.value;
	
	if(!reply_content)
	{
		alert("내용을 입력하세요.");
	}
	else
	{	
		if(uid == null)
		{
			location.href="../comment/write.do?idx=${param.idx}&writer=${dto.name }&reply_content="+reply_content;
		}
		else
		{
			location.href="../comment/write.do?idx=${param.idx}&reply=${sessionScope.nick}&writer=${dto.name }&reply_content="+reply_content;
		}
	}
}

function commentDelete()
{
	var reply = $('input[name=reply]').val();
	var uid = "${sessionScope.nick}";
	var board_idx = ${dto. idx}
	var idx = $('input[name=comment_idx]').val();
	
	if(reply != uid && uid != "관리자")
	{
		alert("작성자만 삭제가능합니다.");
	}
	else
	{
		if(confirm("삭제하시겠습니까?"))
        {
			location.href="../comment/delete.do?board_idx="+board_idx+"&idx="+idx;
        } 
        else
        {
        	alert("취소했습니다.");
        }
		
	}
}


</script>

</head>
<title>자유게시판</title>
<body>
<div class="container my-3">
<h2 align="center">자유게시판</h2>

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
        	<a href="../community/download.do?ofile=${dto.ofile }&sfile=${dto.sfile}&idx=${dto.idx}">
                [다운로드]            
        	</a>
        	</c:if>
        </td>
         <td>다운로드수</td>
        <td>${dto.downcount }</td>
    </tr> 
    <tr>
        <td colspan="4" align="center">
            <button type="button" onclick="CheckEdit()" class="btn btn-outline-primary" name="mode" value="edit"> 
                수정하기
            </button>
            <button type="button" onclick="CheckDelete()" class="btn btn-outline-primary" name="mode" value="delete">
                삭제하기
            </button>
            <button type="button" onclick="location.href='../community/list.do';" class="btn btn-outline-primary">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>
</div>

<div id="comment" class="input-group">
		<table border="1" bordercolor="lightgray" width="87%" align="center" border-collapse="collapse">
		
	<!-- 댓글 목록 -->	
	<c:if test="${requestScope.commentList != null}">
		<c:forEach var="comment" items="${requestScope.commentList}">
		<input type="hidden" name="reply" value="${comment.reply}">
		<input type="hidden" name="comment_idx" value="${comment.idx}">
			<tr border="1" bordercolor=lightgray">
				<!-- 아이디, 작성날짜 -->
				<td width="20%" style="background-color: lightgray">
					<div align="center">
						${comment.reply}<br>
						<font size="2">${comment.reply_date}</font>
					</div>
				</td>
				<!-- 본문내용 -->
				<td width="60%">
					<div class="text_wrapper">
						${comment.reply_content}
					</div>
				</td>
				<!-- 버튼 -->
				<td width="10%">
					<div id="btn" style="text-align:center;">
            		 <button type="button" onclick="commentDelete()" class="btn btn-outline-dark">
                		삭제	
            		 </button>
					</div>
				</td>
			</tr>
			
		</c:forEach>
	</c:if>
	<tr style="height:3px">
	<td colspan="3"></td>
	<tr/>
	<tr bgcolor="#F5F5F5" border="1">
			<form id="writeCommentForm" action="../comment/write.do"> 
				<input type="hidden" name="idx" value="${board.idx }">
				
								<!-- 아이디-->
				<td width="20%">
				
				<c:choose>
				<c:when test="${sessionScope.nick != null}">
			<input type="hidden" name="reply" value="${sessionScope.nick}">
				</c:when>
				<c:otherwise>
			<input type="hidden" name="reply" value="카카오">
				</c:otherwise>
			</c:choose> 
				
				<c:choose>
				<c:when test="${sessionScope.nick != null}">
			<div align="center">${sessionScope.nick}</div>
				</c:when>
				<c:otherwise>
			<div align="center">카카오</div>
				</c:otherwise>
			</c:choose> 
				</td>
				<!-- 본문 작성-->
				<td width="60%">
					<textarea name="reply_content" rows="2" cols="70" maxlength="100" ></textarea>
				</td>
				<!-- 댓글 등록 버튼 -->
				<td width="20%">
					<div id="btn" align="center">
					 <button type="button" onclick="writeCmt()" class="btn btn-outline-dark">
                		댓글등록	
            		 </button>
					</div>
				</td>
			</form>
			</tr>
		</table>
	</div>












<script src="http://code.jquery.com/jquery-latest.js"></script> 
</body>
</html>
