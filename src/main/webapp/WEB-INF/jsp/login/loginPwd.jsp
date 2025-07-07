<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CamperX</title>
    <link rel="stylesheet" href="/assets/css/common/Header.css">
    <link rel="stylesheet" href="/assets/css/common/Footer.css">
    <link rel="stylesheet" href="/assets/css/login/loginPwd.css">
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
        <h1 class="center-text">비밀번호를 입력하세요.</h1>
        <div class="password-container">
            <input type="password" class="email-input" placeholder="비밀번호를 입력하세요." id="userPwd">
            <i class="fas fa-eye password-toggle" onclick="togglePassword()"></i>
        </div>
        <p class="terms-text">비밀번호 확인</p>
        <button class="next-button" type="button" onclick="loginUser()">확인</button>
    </div>
</div>
<footer>
    <div class="footer-content">
        <!-- 왼쪽: 소셜 미디어 로고와 텍스트 -->
        <div class="footer-left">
            <div class="social-icons">
                <a href="#" class="social-icon" target="_blank">
                    <img src="/assets/images/Instagram.svg">
                </a>
                <a href="#" class="social-icon" target="_blank">
                    <img src="/assets/images/Naver.svg">
                </a>
                <a href="#" class="social-icon" target="_blank">
                    <img src="/assets/images/Facebook.svg">
                </a>
                <a href="#" class="social-icon" target="_blank">
                    <img src="/assets/images/Youtube.svg">
                </a>
            </div>
            <p>&copy; CamperX | 캠퍼엑스.</p>
        </div>

        <!-- 오른쪽: 회사 정보 텍스트 -->
        <div class="footer-text">
            <p>COMPANY CamperX / OWNER JEON DAE HOON / TEL 1004-1004 / E-MAIL ascdee1234@naver.com / BUSINESS NO 001-00-00000</p>
            <p>ADDRESS: 1234 56, Imaginary-dong, Nonexistent-gu, Fantasy City, Dreamland-do / AM 10:00 ~ PM 17:00</p>
        </div>
    </div>
</footer>

<script src="/assets/js/jquery-3.7.1.min.js"></script>
<script src="/assets/js/common.js"></script>
<script src="/assets/js/cookie.js"></script>
<script>
    function loginUser() {
        var userId = getCookie("userId");
        var userPwd = $('#userPwd').val();

        console.log("userId:", userId);
        console.log("userPwd:", userPwd);

        if (!userId) {
            alert("사용자 ID가 없습니다. 다시 로그인해주세요.");
            window.location.href = "/camperX_loginId";
            return;
        }

        console.log("AJAX 요청 시작...");
        $.ajax({
            type : "post",
            url : '/camperX/loginPwd',
            data : {
                userId : userId,
                userPwd : userPwd
            },
            beforeSend: function() {
            },

            success: function (response) {
                if(response) {
                    if('${url}'!=''){
                        window.location.href = "${url}";
                    }else {
                        window.location.href = "/camperX_mainpage";
                    }
                } else {
                    alert("로그인 실패: 사용자 이름 또는 비밀번호가 틀립니다.");
                }
            },
            error: function (xhr, status, error) {
                alert("서버 오류");
            }
        });
    }

    // 비밀번호 표시/숨김 토글 함수
    function togglePassword() {
        var passwordInput = document.getElementById('userPwd');
        var toggleIcon = document.querySelector('.password-toggle');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleIcon.classList.remove('fa-eye');
            toggleIcon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            toggleIcon.classList.remove('fa-eye-slash');
            toggleIcon.classList.add('fa-eye');
        }
    }
</script>
</body>
</html>
