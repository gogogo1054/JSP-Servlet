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
<script type="text/javascript" src="script.js" charset="utf-8"></script>
<script>
    function checkDelete() 
    {
    	if(confirm("탈퇴처리하시겠습니까?"))
        {
         location.href ="./delete.do?id=${dto.id}";
          	alert("삭제되었습니다.");
        } 
        else
        {
        	alert("취소했습니다.");
        }
    }
    
    function checkBan()
    {
    	if(confirm("정지처리하시겠습니까?"))
        {
         location.href ="./ban.do?id=${dto.id}";
          	alert("정지되었습니다.");
        } 
        else
        {
        	alert("취소했습니다.");
        }
    }
    
    function checkBanClear()
    {
    	if(confirm("정지해제하시겠습니까?"))
        {
         location.href ="./banclear.do?id=${dto.id}";
          	alert("해제되었습니다.");
        } 
        else
        {
        	alert("취소했습니다.");
        }
    }
</script>

</head>
<title>관리</title>
<body>
<div class="container my-3">
<h2 align="center">회원 상세 정보</h2>

<table border="1" width="90%" class="table table-bordered">
    <colgroup>
        <col width="15%"/> <col width="20%"/>
        <col width="15%"/> <col width="*"/>
    </colgroup> 
    <tr>
        <td>닉네임</td> <td>${dto.nickname }</td>
        <td>이름</td> <td>${dto.name }</td>
    </tr>
    <tr>
        <td>아이디</td> <td>${dto.id }</td>
        <td>비밀번호</td> <td>${dto.pwd }</td>
    </tr>
    <tr>
        <td>이메일</td> <td>${dto.email }</td>
        <td>번호</td> <td>${dto.phone }</td>
    </tr>
    <tr>
        <td>우편번호</td> <td>${dto.postcode }</td>
        <td>상세주소</td> <td>${dto.post }</td>
    </tr>
       <tr>
        <td colspan="4" align="center">
            <button type="button" onclick="checkBan()" class="btn btn-outline-primary"> 
                회원정지
            </button>
            <button type="button" onclick="checkBanClear()" class="btn btn-outline-primary"> 
                정지해제
            </button>
            <button type="button" onclick="checkDelete()" class="btn btn-outline-primary">
                회원삭제
            </button>
            <button type="button" onclick="location.href='../admin/list.do';" class="btn btn-outline-primary">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>
</div>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
</body>
</html>
