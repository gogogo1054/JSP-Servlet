<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

	<title>로그인</title>
   <!--Made with love by Mutiullah Samim -->
   
	<!--Bootsrap 4 CDN-->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    
    <!--Fontawesome CDN-->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

	<!--Custom styles-->
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<!-- kakao -->
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
 <style>
 	body
 	{
 		margin-top : 20%;
 		background-image : url('./images/space.jpg')
 	}
 </style>
</head>
<body>

<!-- kakao -->
<script type='text/javascript'>
    Kakao.init('3d92a88947dd20c2673dc3eebbc5e6f4');
    function loginWithKakao() {
      // 로그인 창을 띄웁니다.
      Kakao.Auth.login({
        success: function(authObj) {
          //alert(JSON.stringify(authObj));
          signIn(authObj);
        },
        fail: function(err) {
          alert(JSON.stringify(err));
        }
      });
    };

    function signIn(authObj) {
        //console.log(authObj);
        Kakao.API.request({
            url: '/v2/user/me',
            success: function(res) {
                //console.log(res);
                console.log(res.id);
                $('#login').css('display', 'none');
               	$('#logout').css('display', 'block');
               	location.href="./home/main.do";
             }
         })
	}

    function signOut() {
	    Kakao.Auth.logout(function () {
	    	$('#login').css('display', 'block');
	    	$('#logout').css('display', 'none');
	    	location.href="./Error.jsp";
	    });
	}
</script>

<div class="container" style="height:500;">
	<div class="d-flex justify-content-center h-100">
		<div class="card">
			<div class="card-header">
				<h3 align="center">로그인</h3>
			</div>
			<div class="card-body">
				<form action="membership/login.do" method="post">
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
						</div>
						<input type="text" class="form-control" placeholder="userid" name="id">
						
					</div>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div>
						<input type="password" class="form-control" placeholder="password" name="pwd">
					</div>
					<div class="form-group">
						<input type="submit" value="로그인" class="btn float-right login_btn">
					</div>
					<br /><br />
					<div id="login" style="display: block">
		    <a id="custom-login-btn" href="javascript:loginWithKakao()">
		    <img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
		    </a>
			</div>
				</form>
			</div>
			<div class="card-footer">
				<div class="d-flex justify-content-center links">
					계정이 없으신가요?&nbsp;&nbsp;<a href="./membership.jsp">회원가입</a>
				</div>
				<div class="d-flex justify-content-center">
					탈퇴하시겠습니까?&nbsp;&nbsp;&nbsp;<a href="./withdraw.jsp">회원탈퇴</a>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>