<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CamperX</title>
    <link rel="stylesheet" href="/assets/css/common/Header.css">
    <link rel="stylesheet" href="/assets/css/common/Footer.css">
    <link rel="stylesheet" href="/assets/css/login/loginId.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.0/dist/webfont.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<header id="fixed-header">
    <div class="logo-container">
        <img src="/assets/logo/CAMPERX LOGO.svg" alt="CamperX Logo">
    </div>
</header>
<div class="container-wrapper">
    <div class="form-container">
        <h1 class="center-text">가입 또는 로그인을 위해 아이디를 <br>입력하세요.</h1>
        <input type="text" class="email-input" placeholder="아이디를 입력하세요" id="userId">
        <p class="terms-text">계속 진행하면 캠퍼엑스의 개인정보 처리방침 및 <br> 이용약관에 동의하게 됩니다.</p>
        <a href="#" class="signup-link" id="open-signup-form" onclick="toggleSignupForm()">회원가입</a>
        <button type="button" class="next-button" onclick="loginUser()">다음</button>
        
        <!-- 회원가입 폼 -->
        <div class="signup-form" id="signupForm">
            <h2 class="signup-title">회원가입</h2>
            <div class="id-check-container">
                <input type="text" class="signup-input" placeholder="아이디" id="signupUserId">
                <button type="button" class="id-check-button" onclick="checkUserId()">중복체크</button>
            </div>
            <div class="id-check-result" id="idCheckResult"></div>
            <input type="password" class="signup-input" placeholder="비밀번호" id="signupUserPwd">
            <input type="password" class="signup-input" placeholder="비밀번호 확인" id="signupUserPwdConfirm">
            <div class="pwd-check-result" id="pwdCheckResult"></div>
            <input type="text" class="signup-input" placeholder="이름" id="signupUserName">
            <input type="email" class="signup-input" placeholder="이메일" id="signupUserEmail">
            <input type="tel" class="signup-input" placeholder="전화번호" id="signupUserPhone">
            <button type="button" class="signup-button" onclick="signupUser()">가입하기</button>
        </div>
    </div>
</div>


<script src="/assets/js/jquery-3.7.1.min.js"></script>
<script src="/assets/js/common.js"></script>
<script src="/assets/js/cookie.js"></script>
<script>
    $(document).ready(function (){
        var userId = getCookie("userId");
        $('#userId').val(userId);
    });

    function rememberUser() {
        var userId = $('userId').val();

        if(userId) {
            setCookie("userId", userId, 7 );
        } else {
            deleteCookie("userId");
        }
    }

    function loginUser() {
        var userId = $('#userId').val();
        
        // userId를 쿠키에 저장
        if (userId && userId.trim() !== '') {
            setCookie("userId", userId, 7);
        }
        
        $.ajax({
            type : "post",
            url : '/camperX/loginId',
            data : {
                userId : userId
            },

            success: function (response) {
                if(response) {
                    window.location.href = "/camperX_loginPwd?url=${url}";
                } else {
                    alert("로그인 실패: 사용자 이름 또는 비밀번호가 틀립니다.");
                }
            },
            error: function () {
                alert("서버 오류");
            }
        });
    }

    // 회원가입 폼 토글 함수
    function toggleSignupForm() {
        var signupForm = document.getElementById('signupForm');
        var signupLink = document.getElementById('open-signup-form');
        
        if (signupForm.style.display === 'none' || signupForm.style.display === '') {
            signupForm.style.display = 'block';
            signupForm.classList.add('show');
            signupLink.textContent = '회원가입 닫기';
        } else {
            signupForm.style.display = 'none';
            signupForm.classList.remove('show');
            signupLink.textContent = '회원가입';
        }
    }

    // 회원가입 처리 함수
    function signupUser() {
        var userId = $('#signupUserId').val();
        var userPwd = $('#signupUserPwd').val();
        var userPwdConfirm = $('#signupUserPwdConfirm').val();
        var userName = $('#signupUserName').val();
        var userEmail = $('#signupUserEmail').val();
        var userPhone = $('#signupUserPhone').val();

        // 유효성 검사
        if (!userId || !userPwd || !userPwdConfirm || !userName || !userEmail || !userPhone) {
            alert("모든 필드를 입력해주세요.");
            return;
        }

        // 아이디 중복체크 확인
        if (!isUserIdChecked) {
            alert("아이디 중복체크를 해주세요.");
            return;
        }

        if (userPwd !== userPwdConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            return;
        }

        if (userPwd.length < 6) {
            alert("비밀번호는 6자 이상이어야 합니다.");
            return;
        }

        $.ajax({
            type: "post",
            url: '/camperX/signup',
            data: {
                userId: userId,
                userPwd: userPwd,
                userName: userName,
                userEmail: userEmail,
                userPhone: userPhone
            },
            success: function(response) {
                if (response) {
                    alert("회원가입이 완료되었습니다. 로그인해주세요.");
                    // 회원가입 폼 숨기기
                    toggleSignupForm();
                    // 입력 필드 초기화
                    $('#signupUserId').val('');
                    $('#signupUserPwd').val('');
                    $('#signupUserPwdConfirm').val('');
                    $('#signupUserName').val('');
                    $('#signupUserEmail').val('');
                    $('#signupUserPhone').val('');
                    // 중복체크 상태 초기화
                    isUserIdChecked = false;
                    $('#idCheckResult').text('').removeClass('success error');
                } else {
                    alert("회원가입에 실패했습니다. 다시 시도해주세요.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }

    // 아이디 중복체크 함수
    var isUserIdChecked = false;
    
    function checkUserId() {
        var userId = $('#signupUserId').val();
        var resultDiv = $('#idCheckResult');
        
        if (!userId || userId.trim() === '') {
            resultDiv.text('아이디를 입력해주세요.').removeClass('success').addClass('error');
            return;
        }
        
        if (userId.length < 4) {
            resultDiv.text('아이디는 4자 이상이어야 합니다.').removeClass('success').addClass('error');
            return;
        }
        
        $.ajax({
            type: "post",
            url: '/camperX/checkUserIdDuplicate',
            data: {
                userId: userId
            },
            success: function(response) {
                if (response) {
                    // 중복되지 않음 (사용 가능)
                    resultDiv.text('사용 가능한 아이디입니다.').removeClass('error').addClass('success');
                    isUserIdChecked = true;
                    $('.id-check-button').prop('disabled', true).text('확인완료');
                } else {
                    // 중복됨 (사용 불가)
                    resultDiv.text('이미 사용 중인 아이디입니다.').removeClass('success').addClass('error');
                    isUserIdChecked = false;
                }
            },
            error: function() {
                resultDiv.text('중복체크 중 오류가 발생했습니다.').removeClass('success').addClass('error');
                isUserIdChecked = false;
            }
        });
    }

    // 아이디 입력 필드 변경 시 중복체크 상태 초기화
    $('#signupUserId').on('input', function() {
        if (isUserIdChecked) {
            isUserIdChecked = false;
            $('#idCheckResult').text('').removeClass('success error');
            $('.id-check-button').prop('disabled', false).text('중복체크');
        }
    });

    // 비밀번호 확인 기능
    $('#signupUserPwdConfirm').on('input', function() {
        checkPasswordMatch();
    });

    $('#signupUserPwd').on('input', function() {
        checkPasswordMatch();
    });

    function checkPasswordMatch() {
        var password = $('#signupUserPwd').val();
        var confirmPassword = $('#signupUserPwdConfirm').val();
        var resultDiv = $('#pwdCheckResult');
        
        if (confirmPassword === '') {
            resultDiv.text('').removeClass('success error');
            return;
        }
        
        if (password === confirmPassword) {
            resultDiv.text('비밀번호가 일치합니다.').removeClass('error').addClass('success');
        } else {
            resultDiv.text('비밀번호가 일치하지 않습니다.').removeClass('success').addClass('error');
        }
    }
</script>
</body>
</html>
