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
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<!-- 입력 확인 경고 -->
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
      var name = document.getElementById('user_name').value;
      var pw1 = document.getElementById('user_pwd').value;
      var pw2 = document.getElementById('pwd_check').value;
      var nickname = document.getElementById('nickname').value;
      var email = document.getElementById('email').value;
      var post = document.getElementById('sample6_detailAddress').value;

    	// 글자 수 체크
    	if(id.length == 0)
  		{
   			document.getElementById('user_id').focus();
   			return false;
    	}
    	
    	if(name.length == 0) 
    	{
      	  document.getElementById('user_name').focus();
      	  return false;
    	}
    	
    	if(pw1.length == 0) 
    	{
      	  document.getElementById('user_pwd').focus();
      	  return false;
    	}
    	
    	// 비밀번호 확인
    	if( pw1 != pw2 ) 
    	{
	      	document.getElementById('pwd_check').value = "";
	      	document.getElementById('pwd_check').focus();
	      	return false;
    	}
    	
    	if(nickname.length == 0) 
    	{
      	  document.getElementById('nickname').focus();
      	  return false;
    	}
    	
    	if(email.length == 0) 
    	{
      	  document.getElementById('email').focus();
      	  return false;
    	}
    	
    	if(post.length == 0) 
    	{
      	  document.getElementById('sample6_detailAddress').focus();
      	  return false;
    	}
    	
    	
    }
  </script>

</head>

<body>
  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        <form class="validation-form" action="membership/join.do" method="post" novalidate>
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
              <div class="invalid-feedback">
                비밀번호가 일치하지 않습니다.
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="name">닉네임</label>
              <input type="text" class="form-control" id="nickname" maxlength="10" name="nickname" 
              required>
              <div class="invalid-feedback">
                닉네임을 입력해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="phonenumber">전화번호(필수아님)</label>
              <br>
              <input type="text" class="form-control" id="phone1" maxlength="3" pattern="[0-9]+"
              style="width:75px; margin-right:5px; margin-left:4px; display:inline;" name="pnum1">-
              <input type="text" class="form-control" id="phone2" maxlength="4" pattern="[0-9]+"
              style="width:85px; margin-right:5px; margin-left:4px; display:inline;" name="pnum2">-
              <input type="text" class="form-control" id="phone3" maxlength="4" pattern="[0-9]+"
              style="width:85px; margin-left:4px; display:inline;" name="pnum3">
              <div class="invalid-feedback">
                숫자를 입력해주세요.
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label for="email">이메일</label>
            <input type="text" class="form-control" id="email" placeholder="example@site.com" maxlength="40" name="email"
            required>
            <div class="invalid-feedback">
              이메일을 입력해주세요.
            </div>
          </div>

          <div class="mb-3">
            <label for="address">주소</label>
            <br>
            
            <input type="text" id="sample6_postcode" class="form-control" placeholder="우편번호" required
            style="width:200px; display:inline;" name="postcode">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
            <input type="text" class="form-control" id="sample6_address" placeholder="서울특별시 강남구" required
            style="margin-top: 10px;" name="post1">
            <input type="text" class="form-control" id="sample6_detailAddress" placeholder="상세주소"
            style="width:300px; margin-top: 10px; margin-right-11px; display:inline;" required name="post2">
			<input type="text" class="form-control" id="sample6_extraAddress" placeholder="참고항목"
			style="width:300px; display:inline;" name="post3">
            <div class="invalid-feedback">
              주소를 제대로 입력해주세요.
            </div>
            
          </div>

          <hr class="mb-4">
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div>
          <div class="mb-4"></div>
          <button class="btn btn-primary btn-lg btn-block" type="submit" onclick="check()">회원 가입</button>
        </form>
      </div>
    </div>
  </div>

</body>

</html>