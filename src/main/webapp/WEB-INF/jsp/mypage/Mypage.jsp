<%--
  Created by IntelliJ IDEA.
  User: ascde
  Date: 2025-07-01
  Time: 오후 3:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/Header.jsp" %>
<link rel="stylesheet" href="/assets/css/mypage/mypage.css">

<div class="mypage-container">
    <div class="mypage-profile">
        <div class="profile-img">
            <img src="/assets/logo/CAMPERX LOGO.svg" alt="프로필 이미지">
        </div>
        <div class="profile-info">
            <div class="profile-name">${userName}</div>
            <div class="profile-email">${userEmail}</div>
            <div class="profile-join">가입일: ${joinDate}</div>
        </div>
    </div>
    <div class="mypage-main">
        <div class="mypage-card">
            <h2>주문 내역</h2>
            <div class="order-list">
                <div class="order-item">
                    <div>2025-06-30</div>
                    <div>텐트 & 타프</div>
                    <div>주문완료</div>
                </div>
                <div class="order-item">
                    <div>2025-06-15</div>
                    <div>테이블 & 의자</div>
                    <div>배송중</div>
                </div>
            </div>
        </div>
        <div class="mypage-card">
            <h2>회원 정보</h2>
            <div class="info-row"><span>아이디</span> ${userId}</div>
            <div class="info-row"><span>이름</span> ${userName}</div>
            <div class="info-row"><span>이메일</span> ${userEmail}</div>
            <div class="info-row"><span>전화번호</span> ${userPhone}</div>
            <button class="mypage-btn">정보 수정</button>
        </div>
        <div class="mypage-card logout-card">
            <button class="logout-btn" onclick="logout()">로그아웃</button>
        </div>
    </div>
</div>
<script src="/assets/js/jquery-3.7.1.min.js"></script>
<script src="/assets/js/common.js"></script>
<script>
function logout() {
    if (confirm('로그아웃 하시겠습니까?')) {
        fetch('/camperX/logout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            }
        })
        .then(response => {
            if (response.ok) {
                alert('로그아웃되었습니다.');
                window.location.href = '/camperX_mainpage';
            } else {
                alert('로그아웃 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('로그아웃 중 오류가 발생했습니다.');
        });
    }
}
</script>

<%@ include file="/WEB-INF/jsp/common/Footer.jsp" %>
