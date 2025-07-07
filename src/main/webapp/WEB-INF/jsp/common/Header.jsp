<%--
  Created by IntelliJ IDEA.
  User: ascde
  Date: 2025-06-16
  Time: 오후 4:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/assets/css/common/Header.css">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<header class="header">
    <nav class="nav-container">

        <!-- 왼쪽 메뉴 -->
        <div class="nav-left">
            <div class="dropdown">
                <a href="#">CATEGORY</a>
                <ul class="dropdown-menu">
                    <li><a href="/camperX_productList?category=tent">TENT & TARP</a></li>
                    <li><a href="/camperX_productList?category=table">TABLE & CHAIR</a></li>
                    <li><a href="/camperX_productList?category=kitchen">COOKING</a></li>
                    <li><a href="/camperX_productList?category=sleeping">SLEEPING</a></li>
                    <li><a href="/camperX_productList?category=lighting">LIGHTING</a></li>
                    <li><a href="/camperX_productList?category=etc">ETC</a></li>
                </ul>
            </div>

            <div class="dropdown">
                <a href="#">BRAND</a>
                <ul class="dropdown-menu">
                    <li><a href="#">Helinox</a></li>
                    <li><a href="#">Snow Peak</a></li>
                    <li><a href="#">KZM</a></li>
                    <li><a href="#">Logos</a></li>
                    <li><a href="#">NatureHike</a></li>
                </ul>
            </div>

            <a href="#">BEST</a>
            <a href="#">NEW</a>
        </div>

        <!-- 로고 -->
        <div class="nav-center">
            <a href="/camperX_mainpage" class="logo">
                <img src="/assets/logo/CAMPERX LOGO-white.svg" alt="CAMPEX Logo">
            </a>
        </div>

        <!-- 오른쪽 메뉴 -->
        <div class="nav-right">
            <div class="search-container">
                <input type="text" class="search-box" id="searchInput" placeholder="Search..." onkeypress="handleSearchKeyPress(event)">
                <div id="searchResults" class="search-results" style="display: none;"></div>
            </div>
            <a href="/camperX_mypage">MY PAGE</a>
            <a href="javascript:void(0)" onclick="checkLoginAndGoToCart()">CART (<span id="cartCount">0</span>)</a>
        </div>
    </nav>
</header>

<script src="/assets/js/jquery-3.7.1.min.js"></script>
<script src="/assets/js/common.js"></script>

<script>
    // 장바구니 개수 업데이트
    function updateCartCount() {
        fetch('/camperX/getCartCount', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById('cartCount').textContent = data.count;
            } else {
                document.getElementById('cartCount').textContent = '0';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById('cartCount').textContent = '0';
        });
    }

    // 로그인 체크 후 장바구니 페이지로 이동
    function checkLoginAndGoToCart() {
        // 세션 체크를 위한 AJAX 요청
        fetch('/camperX/checkLogin', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.loggedIn) {
                // 로그인된 경우 장바구니 페이지로 이동
                window.location.href = '/camperX_cart';
            } else {
                // 로그인되지 않은 경우 로그인 페이지로 이동
                window.location.href = '/camperX_loginId';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            // 에러 발생 시 로그인 페이지로 이동
            window.location.href = '/camperX_loginId';
        });
    }

    // 검색 기능
    function handleSearchKeyPress(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
            const searchText = document.getElementById('searchInput').value.trim();
            if (searchText) {
                performSearch(searchText);
            }
        } else if (event.key === 'Escape') {
            hideSearchResults();
        }
    }

    // 검색 실행
    function performSearch(searchText) {
        const resultsContainer = document.getElementById('searchResults');
        if (resultsContainer) {
            resultsContainer.innerHTML = '<div class="no-results">검색 중...</div>';
            resultsContainer.style.display = 'block';
        }
        set_server('/camperX/search?searchText=' + encodeURIComponent(searchText), function(data) {
            if (data === null || data === undefined) {
                displaySearchResults([]);
            } else {
                displaySearchResults(data);
            }
        });
    }

    // 검색 결과 표시
    function displaySearchResults(results) {
        const resultsContainer = document.getElementById('searchResults');
        if (!resultsContainer) return;
        if (!results || results.length === 0) {
            resultsContainer.innerHTML = '<div class="no-results">검색 결과가 없습니다.</div>';
            resultsContainer.style.display = 'block';
            return;
        }
        let html = '';
        results.forEach(function(product) {
            const price = new Intl.NumberFormat('ko-KR').format(product.PRICE || 0);
            const image = product.PRD_IMG || '/assets/logo/CAMPERX LOGO.svg';
            html += '<div class="search-result-item" onclick="goToProduct(\'' + product.PRD_CODE + '\')">' +
                '<img src="' + image + '" alt="' + product.PRD_NAME + '" onerror="this.src=\'/assets/logo/CAMPERX LOGO.svg\'">' +
                '<div class="search-result-info">' +
                '<div class="search-result-name">' + product.PRD_NAME + '</div>' +
                '<div class="search-result-brand">' + (product.VENDOR_NAME || '') + '</div>' +
                '<div class="search-result-price">' + price + '원</div>' +
                '</div>' +
                '</div>';
        });
        resultsContainer.innerHTML = html;
        resultsContainer.style.display = 'block';
    }

    // 상품 상세 페이지로 이동
    function goToProduct(prdCode) {
        hideSearchResults();
        window.location.href = '/camperX/productView?prdCode=' + prdCode;
    }

    // 검색 결과 숨기기
    function hideSearchResults() {
        const resultsContainer = document.getElementById('searchResults');
        if (resultsContainer) {
            resultsContainer.style.display = 'none';
        }
    }

    // 검색 결과 외부 클릭 시 숨기기
    document.addEventListener('click', function(event) {
        const searchContainer = document.querySelector('.search-container');
        const searchResults = document.getElementById('searchResults');
        if (searchContainer && searchResults && !searchContainer.contains(event.target)) {
            hideSearchResults();
        }
    });

    // 검색 입력 시 실시간 검색 (선택사항)
    let searchTimeout;
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const searchText = this.value.trim();
            if (searchText.length >= 2) {
                searchTimeout = setTimeout(function() {
                    performSearch(searchText);
                }, 300);
            } else {
                hideSearchResults();
            }
        });
    }

    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Header search functionality loaded');
        const searchInput = document.getElementById('searchInput');
        const searchResults = document.getElementById('searchResults');
        console.log('Search input found:', !!searchInput);
        console.log('Search results container found:', !!searchResults);
        
        // 페이지 로드 시 장바구니 개수 업데이트
        updateCartCount();
        
        // 30초마다 장바구니 개수 업데이트 (선택사항)
        setInterval(updateCartCount, 30000);
    });
</script>