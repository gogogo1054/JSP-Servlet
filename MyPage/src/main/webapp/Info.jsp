<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
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
      background: linear-gradient(to top right, #92b5db 0%, #B2FFD9 100%);
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
<!-- 주소 찾기 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>

<body>
  <div class="container">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3" align="center">회원정보</h4>
        <form class="validation-form" action="../home/main.do">
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="id">아이디</label>
              <input type="text" class="form-control" value="${dto.id }">
            </div>
            <div class="col-md-6 mb-3">
              <label for="name">이름</label>
              <input type="text" class="form-control" value="${dto.name }">
             </div>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="name">닉네임</label>
              <input type="text" class="form-control" value="${dto.nickname }">
            </div>
            <div class="col-md-6 mb-3">
              <label for="phonenumber">전화번호</label>
              <input type="text" class="form-control" value="${dto.phone }">
            </div>
          </div>

          <div class="mb-3">
            <label for="email">이메일</label>
            <input type="text" class="form-control" value="${dto.email }">
          </div>

          <div class="mb-3" >
            <label for="address">주소</label>
            <br>
            <input type="text" class="form-control" value="우편번호   :   ${dto.postcode }" style="width:400px;">
            <br>
            <input type="text" class="form-control" value="${dto.post }" >
          </div>
          <div class="mb-4"></div>
          <button class="btn btn-primary btn-lg btn-block">뒤로</button>
        </form>
    </div>
  </div>

</body>

</html>