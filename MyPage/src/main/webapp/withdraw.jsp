<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>


  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원탈퇴</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

  <style>
    body {
      min-height: 100vh;

      background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
      background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: linear-gradient(to top right, #92b5db 0%, #FF7F00 100%);
    }

    .input-form 
    {
      max-width: 680px;

      margin-top: 30px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }

  </style>
<script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() == false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  </script>
  
<!-- 양식 설정 -->
 <script>
    function check() 
    {
      var id = document.getElementById('user_id').value;
      var pw1 = document.getElementById('user_pwd').value;
      var pw2 = document.getElementById('pwd_check').value;
      var name = document.getElementById('user_name').value;
    	
    	// 비밀번호 확인
    	if( pw1 != pw2 ) 
    	{
	      	alert("비밀번호가 일치 하지 않습니다");
	      	document.getElementById('pwd_check').value = "";
	      	document.getElementById('pwd_check').focus();
	      	return false;
    	}
    }
  </script>
</head>

<script>
	String message = request.getParameter("message");
	
	if(message != null && message.equals("0"))
	{
		alert('계정이 존재하지 않습니다.');
	}
	
	alert(var);
</script>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원탈퇴</h4>
        <form class="validation-form" method="post" action="membership/withdraw.do" novalidate>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="id">아이디</label>
              <input type="text" class="form-control" id="user_id" maxlength="20" name="id"
              required>
              <div class="invalid-feedback">
                아이디를 입력해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="name">이름</label>
              <input type="text" class="form-control" id="user_name" maxlength="10" name="name"
              required>
              <div class="invalid-feedback">
                이름을 입력해주세요.
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="password">비밀번호</label>
              <input type="password" class="form-control" id="user_pwd" maxlength="20" name="pwd"
              required>
              <div class="invalid-feedback">
                비밀번호를 입력해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="passwordcheck">비밀번호 확인</label>
              <input type="password" class="form-control" id="pwd_check" maxlength="20" 
              required>
            </div>
          </div>
          <button class="btn btn-primary btn-lg btn-block" type="submit" onclick="check()">회원 탈퇴</button>
        </form>
      </div>
    </div>
  </div>

</body>

</html>