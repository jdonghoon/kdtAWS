<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>StyleGuide</title>
		<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.js"></script>
		<link href = "join.css" type = "text/css" rel = "stylesheet">
	</head>
	<body>
		<script>
			// 페이지 로딩 완료 후 id 입력란에 focus
			$(document).ready(function() {
				$("input[name=id]").focus();
			});
			
			// 아이디 중복 체크
			function idCheck() {
				let id = $("input[name=id]").val().trim();
				
				if(id == "") {
					$(".msg:eq(0)").html("<span style='color: red'>아이디를 입력해주세요.</span>");
					return false;
				}
				
				// checkID에서 DB조회 후 얻은 값으로 아이디 체크
				$.ajax({
					url : "<%=request.getContextPath()%>/data/checkID.jsp",
					type : "GET",
					data : "id=" + id,
					success : function(data) {
						if(data.trim() == "isId") {
							$(".msg:eq(0)").html("<span style='color: red'>사용 중인 아이디입니다. 다른 아이디를 입력해주세요.</span>");
							return false;
						} else {
							$(".msg:eq(0)").html("<span style='color: grey'>사용 가능한 아이디입니다.</span>");
							return false;
						}
					}
				});
			}
			
			// 패스워드 입력 조건 : 입력 필요, 8글자 이상
			function pwCheck() {
				let pw = $("input[name=password]").val().trim();
				let msg = $(".msg:eq(1)");
				
				if(pw == "") {
					msg.html("<span style='color: red'>비밀번호를 입력해주세요.</span>");
					return false;
				} else if(pw.length < 8) {
					msg.html("<span style='color: red'>비밀번호는 8글자 이상 입력해주세요.</span>");
					return false;
				} else {
					msg.html("");
					return true;
				}
			}
			
			// 패스워드 재확인
			function pwcCheck() {
				let pw = $("input[name=password]").val().trim();
				let pwc = $("input[name=passwordcheck]").val().trim();
				let msg = $(".msg:eq(2)");
				
				if(pwc == "") {
					msg.html("<span style='color: red'>비밀번호를 다시 입력해주세요.</span>");
					return false;
				} else if(pw != pwc) {
					msg.html("<span style='color: red'>비밀번호가 일치하지 않습니다.</span>");
					return false;
				} else {
					msg.html("");
					return true;
				}
			}
			
			// 이름 확인
			function nameCheck() {
				let name = $("input[name=name]").val().trim();
				let namePattern = /^[가-힣]+$/;
				let msg = $(".msg:eq(3)");
				
				if(name == "") {
					msg.html("<span style='color: red'>이름을 입력해주세요.</span>");
					return false;
				} else if(!namePattern.test($("input[name=name]").val())) {
					msg.html("<span style='color: red'>한글만 입력해주세요.</span>");
					return false;
				}
				
				if(name.length < 2) {
					msg.html("<span style='color: red'>이름을 2글자 이상 입력해주세요.</span>");
					return false;
				} else {
					msg.html("");
					return true;
				}
			}
			
			// 나이 확인
			function ageCheck() {
				let age = $("input[name=age]").val().trim();
				let msg = $(".msg:eq(4)");
				
				if(age == "" || isNaN(age)) {
					msg.html("<span style='color: red'>나이를 입력해주세요.</span>");
					return false;
				} else if(age < 0) {
					msg.html("<span style='color: red'>나이를 다시 입력해주세요.</span>");
					return false;
				} else {
					msg.html("");
					return true;
				}
			}
			
			// 이메일 형식 검사
			function emailCheck() {
				let email = $("input[name=email]").val().trim();
				// 입력 가능한 이메일 형식을 설정 (영문 대/소문자)@(영문 대/소문자).(영문 대/소문자)
				let emailPattern = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
				let msg = $(".msg:eq(5)");
				
				if(email == "") {
					msg.html("<span style='color: red'>이메일을 입력해주세요.</span>");
					return false;
				} else if(!emailPattern.test($("input[name=email]").val())) {
					msg.html("<span style='color: red'>유효한 이메일을 입력해주세요.</span>");
					$("input[name=email]").focus();
					return false;
				} else {
					msg.html("");
					return true;
				}
			}
			
			// 휴대폰 형식 검사
			function phoneCheck() {
				let phone = $("input[name=phone]").val().trim();
				// 휴대폰 번호 형식 설정 (00(0)-000(0)-0000)
				let phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
				let msg = $(".msg:eq(6)");
				
				if(!phonePattern.test($("input[name=phone]").val())) {
					msg.html("<span style='color: red'>유효한 휴대폰 번호를 입력해주세요.</span>");
					$("input[name=phone]").focus();
					return false;
				} else {
					msg.html("");
					return true;
				}
			}
			
			// submit 실행 시 재확인
			function doJoin() {
				if(idCheck() == false) {
			          return false;
			      }
				
			    if(pwCheck() == false) {
			          return false;
			      }
			    
			    if(pwcCheck() == false) {
			          return false;
			      }
			    
			    if(nameCheck() == false) {
			          return false;
			      }
			    
			    if(ageCheck() == false) {
			          return false;
			      }
			    
			    if(emailCheck() == false) {
			          return false;
			      }
			    
			    if(phoneCheck() == false) {
			          return false;
			      }
			}
			
		</script>
		<header>
            <div class="logo">
                <a href="<%=request.getContextPath()%>/index.jsp"><img src="<%=request.getContextPath()%>/logo/logo.PNG" width="150px"></a>
            </div>
        </header>
        <section>
            <article>
                <div class="join_title">Join</div>
                <form action="joinOk.jsp" method="post" onsubmit="return doJoin();">
                    <div class="join_text">아이디</div>
                    <div>
                        <input type="text" class="input_box" name="id" onblur="idCheck();">
                        <div class="msg"></div>
                    </div>
                    <div class="join_text">비밀번호</div>
                    <div>
                        <input type="password" class="input_box" name="password" onblur="pwCheck();">
                        <div class="msg"></div>
                    </div>
                    <div class="join_text">비밀번호 확인</div>
                    <div>
                        <input type="password" class="input_box" name="passwordcheck" onblur="pwcCheck();">
                        <div class="msg"></div>
                    </div>
                    <div class="join_text">이름</div>
                    <div>
                        <input type="text" class="input_box" name="name" onblur="nameCheck()">
                        <div class="msg"></div>
                    </div>
                    <div class="join_text">나이</div>
                    <div>
                        <input type="number" maxlength="3" min="1" max="150" class="input_box" name="age" onblur="ageCheck()">
                        <div class="msg"></div>
                    </div>
                    <div class="join_text">이메일</div>
                    <div>
                        <input type="email" class="input_box" name="email" onblur="emailCheck()">
                        <div class="msg"></div>
                    </div>
                    <div class="gender">
                        <div class="join_text">성별</div>
                        <ul>
                            <li class="gender_radio" >
                                <label>
                                    <input type="radio" id="gender1" name="gender" value="M">남자
                                </label>
                            </li>
                            <li class="gender_radio">
                                <label>
                                    <input type="radio" id="gender2" name="gender" value="F">여자
                                </label>
                            </li>
                            <li class="gender_radio">
                                <label>
                                    <input type="radio" id="gender3" name="gender" value="O" checked="checked">미공개
                                </label>
                            </li>
                        </ul>
                    </div>
                    <div class="join_text">휴대폰 번호</div>
                    <div>
                        <input type="text" class="input_box" name="phone" onblur="phoneCheck()">
                        <div class="msg"></div>
                    </div>
                    <button class="join_button">가입하기</button>
                </form>
            </article>
        </section>
	</body>
</html>
