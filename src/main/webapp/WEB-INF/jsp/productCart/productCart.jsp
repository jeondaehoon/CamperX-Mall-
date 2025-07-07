<%--
  Created by IntelliJ IDEA.
  User: ascde
  Date: 2025-06-24
  Time: 오후 3:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>장바구니 - CAMPERX</title>
    <link rel="icon" type="image/svg+xml" href="/assets/logo/CAMPERX_favicon .svg">
    <link rel="stylesheet" href="/assets/css/common/Header.css">
    <link rel="stylesheet" href="/assets/css/common/Footer.css">
    <link rel="stylesheet" href="/assets/css/productCart/productCart.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="/assets/js/jquery-3.7.1.min.js"></script>
    <script src="/assets/js/common.js"></script>
    <script src="/assets/js/cookie.js"></script>
</head>
<body>
    <!-- Header -->
    <%@ include file="/WEB-INF/jsp/common/Header.jsp" %>

    <div class="container">
        <!-- 페이지 헤더 -->
        <div class="cart-header">
            <h1>장바구니</h1>
            <p>선택하신 상품들을 확인하고 주문을 진행해주세요</p>
        </div>

        <!-- 장바구니 상태 -->
        <div class="cart-status">
            <div class="status-step active">
                <div class="step-number">1</div>
                <div class="step-text">장바구니</div>
            </div>
            <div class="status-step inactive">
                <div class="step-number">2</div>
                <div class="step-text">주문/결제</div>
            </div>
            <div class="status-step inactive">
                <div class="step-number">3</div>
                <div class="step-text">주문완료</div>
            </div>
        </div>

        <!-- 장바구니 내용 -->
        <div id="cart-content">
            <!-- 장바구니 데이터가 여기에 동적으로 로드됩니다 -->
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="/WEB-INF/jsp/common/Footer.jsp" %>

    <script>
        // 페이지 로드 시 장바구니 데이터 가져오기
        $(document).ready(function() {
            loadCartData();
        });

        // 장바구니 데이터 로드
        function loadCartData() {
            var userId = getCookie("userId");
            
            if (!userId || userId.trim() === '') {
                // 로그인되지 않은 경우
                showEmptyCart();
                return;
            }

            set_server('/camperX/getCartItems?userId=' + userId, function(data) {
                if (data && data.length > 0) {
                    renderCartItems(data);
                } else {
                    showEmptyCart();
                }
            });
        }

        // 장바구니 아이템 렌더링
        function renderCartItems(cartItems) {
            let html = '<table class="cart-table">' +
                '<thead>' +
                '<tr>' +
                '<th style="width: 50%;">상품정보</th>' +
                '<th style="width: 15%;">수량</th>' +
                '<th style="width: 20%;">가격</th>' +
                '<th style="width: 10%;">삭제</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>';

            let subtotal = 0;
            cartItems.forEach(function(item) {
                const itemTotal = item.price * item.quantity;
                subtotal += itemTotal;
                
                html += '<tr>' +
                    '<td>' +
                    '<div class="product-info">' +
                    '<img src="' + (item.prdImg || '/assets/logo/CAMPERX LOGO.svg') + '" alt="' + item.prdName + '" class="product-image" onerror="this.src=\'/assets/logo/CAMPERX LOGO.svg\'">' +
                    '<div class="product-details">' +
                    '<h3>' + item.prdName + '</h3>' +
                    '<div class="brand">' + item.vendorName + '</div>' +
                    '<div class="product-code">' + item.prdCode + '</div>' +
                    '</div>' +
                    '</div>' +
                    '</td>' +
                    '<td>' +
                    '<div class="quantity-control">' +
                    '<button class="quantity-btn" onclick="updateQuantity(\'' + item.cartId + '\', -1)">-</button>' +
                    '<input type="number" class="quantity-input" value="' + item.quantity + '" min="1" max="99" onchange="updateQuantityDirect(\'' + item.cartId + '\', this.value)">' +
                    '<button class="quantity-btn" onclick="updateQuantity(\'' + item.cartId + '\', 1)">+</button>' +
                    '</div>' +
                    '</td>' +
                    '<td>' +
                    '<div class="price-info">' +
                    '<div class="price">' + new Intl.NumberFormat('ko-KR').format(item.price) + '원</div>' +
                    '</div>' +
                    '</td>' +
                    '<td>' +
                    '<button class="delete-btn" onclick="removeFromCart(\'' + item.cartId + '\')">삭제</button>' +
                    '</td>' +
                    '</tr>';
            });

            html += '</tbody></table>' +
                '<!-- 장바구니 요약 -->' +
                '<div class="cart-summary">' +
                '<div class="summary-row">' +
                '<span class="summary-label">상품금액</span>' +
                '<span class="summary-value">' + new Intl.NumberFormat('ko-KR').format(subtotal) + '원</span>' +
                '</div>' +
                '<div class="summary-row">' +
                '<span class="summary-label">배송비</span>' +
                '<span class="summary-value">' + getShippingFee(subtotal) + '</span>' +
                '</div>' +
                '<div class="summary-row">' +
                '<span class="summary-label">총 결제금액</span>' +
                '<span class="summary-value">' + new Intl.NumberFormat('ko-KR').format(getTotalAmount(subtotal)) + '원</span>' +
                '</div>' +
                '</div>' +
                '<!-- 결제 버튼 -->' +
                '<div class="checkout-section">' +
                '<a href="javascript:void(0)" onclick="proceedToOrder()" class="checkout-btn">주문하기</a>' +
                '<a href="/camperX_productList" class="continue-shopping">쇼핑 계속하기</a>' +
                '</div>';

            $('#cart-content').html(html);
        }

        // 배송비 계산 함수
        function getShippingFee(subtotal) {
            if (subtotal >= 100000) {
                return '무료';
            } else if (subtotal >= 50000) {
                return '2,000원';
            } else if (subtotal >= 30000) {
                return '3,000원';
            } else {
                return '5,000원';
            }
        }

        // 총 결제금액 계산 함수
        function getTotalAmount(subtotal) {
            let shippingFee = 0;
            if (subtotal >= 100000) {
                shippingFee = 0;
            } else if (subtotal >= 50000) {
                shippingFee = 2000;
            } else if (subtotal >= 30000) {
                shippingFee = 3000;
            } else {
                shippingFee = 5000;
            }
            return subtotal + shippingFee;
        }

        // 빈 장바구니 표시
        function showEmptyCart() {
            let html = '<div class="empty-cart">' +
                '<img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjEyMCIgdmlld0JveD0iMCAwIDEyMCAxMjAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGQ9Ik0zMCAzMEg5MFY5MEgzMFYzMFoiIGZpbGw9IiNFRUVFRUUiLz4KPHBhdGggZD0iTTQ1IDQ1SDc1VjU1SDQ1VjQ1WiIgZmlsbD0iI0NDQ0NDQyIvPgo8L3N2Zz4K" alt="Empty Cart">' +
                '<h2>장바구니가 비어있습니다</h2>' +
                '<p>캠핑용품을 담아보세요!</p>' +
                '<a href="/camperX_productList" class="shop-btn">쇼핑 계속하기</a>' +
                '</div>';
            $('#cart-content').html(html);
        }

        // 수량 업데이트 함수
        function updateQuantity(cartId, change) {
            const input = document.querySelector('input[onchange*="' + cartId + '"]');
            let newQuantity = parseInt(input.value) + change;
            
            if (newQuantity < 1) newQuantity = 1;
            if (newQuantity > 99) newQuantity = 99;
            
            input.value = newQuantity;
            updateCartItem(cartId, newQuantity);
        }

        // 직접 수량 입력
        function updateQuantityDirect(cartId, quantity) {
            if (quantity < 1) quantity = 1;
            if (quantity > 99) quantity = 99;
            
            updateCartItem(cartId, quantity);
        }

        // 장바구니 아이템 업데이트
        function updateCartItem(cartId, quantity) {
            var data = {
                    cartId: cartId,
                    quantity: quantity
            };
            
            post_server('/camperX/updateCart', data, function(response) {
                    if (response.success) {
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert('수량 업데이트에 실패했습니다.');
                }
            });
        }

        // 장바구니에서 삭제
        function removeFromCart(cartId) {
            if (confirm('정말로 이 상품을 장바구니에서 삭제하시겠습니까?')) {
                var data = {
                        cartId: cartId
                };
                
                post_server('/camperX/removeFromCart', data, function(response) {
                        if (response.success) {
                            location.reload(); // 페이지 새로고침
                        } else {
                            alert('삭제에 실패했습니다.');
                    }
                });
            }
        }

        // 주문 페이지로 이동
        function proceedToOrder() {
            var userId = getCookie("userId");
            
            if (!userId || userId.trim() === '') {
                alert('로그인이 필요합니다.');
                return;
            }

            // 현재 장바구니 데이터를 가져와서 주문 페이지로 전달
            set_server('/camperX/getCartItems?userId=' + userId, function(cartItems) {
                if (cartItems && cartItems.length > 0) {
                    // 장바구니 데이터를 세션에 저장
                    $.ajax({
                        url: '/camperX/saveCartToSession',
                        method: 'POST',
                        data: JSON.stringify(cartItems),
                        contentType: 'application/json',
                        success: function(response) {
                            if (response.success) {
                                // 주문 페이지로 이동
                                window.location.href = '/camperX_order';
                            } else {
                                alert('주문 페이지 이동에 실패했습니다.');
                            }
                        },
                        error: function() {
                            alert('서버 오류가 발생했습니다.');
                        }
                    });
                } else {
                    alert('장바구니가 비어있습니다.');
                }
            });
        }
    </script>
</body>
</html>
