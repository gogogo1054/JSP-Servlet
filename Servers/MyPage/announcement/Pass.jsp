<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>패스</title>
</head>
<body>
	<input type="hidden" name="idx" value="${param.idx }" />
	<input type="hidden" name="mode" value="${param.mode }" />
	<script>
		location.href="../announcement/pass.do";
	</script>
</body>
</html>