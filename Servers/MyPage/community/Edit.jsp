<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1">   
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous"> 
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.min.css">
<script type="text/javascript">

	function validateForm(form)
	{
		if(form.title.value == "")
		{
			alert("제목을 입력하세요.");
			form.name.focus();
			return false;
		}
		if(form.content.value == "")
		{
			alert("내용을 입력하세요.");
			form.name.focus();
			return false;
		}
	}
</script>
</head>
<body>

	 <div class="container my-3">
	 <h2 align="center">자유게시판</h2>
	<form name="writeFrm" method="post" enctype="multipart/form-data"
		action="../community/edit.do" onsubmit="return validateForm(this);">
	<input type="hidden" name="idx" value="${dto.idx }" />
	<input type="hidden" name="prevOfile" value="${dto.ofile }" />
	<input type="hidden" name="prevSfile" value="${dto.sfile }" />
	
	<table border="1" width="90%" class="table table-bordered">
		<tr>
			<td>작성자</td>
			<td>
				<input type="text" name="name" style="width:150px" value="${dto.name }" />
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" name="title" style="width:90%;" value="${dto.title }" />
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<textarea name="content" style="width:90%; height:100px">
					${dto.content }
				</textarea>
			</td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td>
				<input type="file" name="ofile" />
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit" class="btn btn-outline-primary">작성 완료</button>
				<button type="reset" class="btn btn-outline-primary">RESET</button>
				<button type="button" onclick="location.href='../community/list.do';" class="btn btn-outline-primary">
				목록 바로가기
				</button>
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>