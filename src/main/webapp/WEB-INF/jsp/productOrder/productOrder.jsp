<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>CamperX</title>
  <link rel="stylesheet" href="/assets/css/common/Header.css">
  <link rel="stylesheet" href="/assets/css/common/Footer.css">
  <link rel="stylesheet" href="/assets/css/productOrder/prdorder.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretendard@1.3.0/dist/webfont.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<header id="fixed-header">
  <div class="header-container">
    <div class="logo">
      <a href="/camperX_mainpage">
        <img src="/assets/logo/CAMPERX LOGO.svg" alt="CamperX Logo">
      </a>
    </div>
  </div>
</header>

<div class="container">
  <div class="delivery-options">
    <h2>배송 옵션</h2>
    <form id="orderForm" name="orderForm">
      <input type="hidden" name="orderStatus" value="ORDERED" />
      <div class="input-group">
        <label for="lastname">성*</label>
        <input type="text" id="lastname" placeholder="" class="textbox" name="receiverLastname">
      </div>
      <div class="input-group">
        <label for="firstname">이름*</label>
        <input type="text" id="firstname" placeholder="" name="receiverFirstname">
      </div>
      <div class="input-group">
        <label for="state">도/광역시*</label>
        <select id="state" name="state">
          <option value="">선택하세요</option>
          <option>서울특별시</option>
          <option>부산광역시</option>
          <option>대구광역시</option>
          <option>인천광역시</option>
          <option>광주광역시</option>
          <option>대전광역시</option>
          <option>울산광역시</option>
          <option>세종특별자치시</option>
          <option>경기도</option>
          <option>강원도</option>
          <option>충청북도</option>
          <option>충청남도</option>
          <option>전라북도</option>
          <option>전라남도</option>
          <option>경상북도</option>
          <option>경상남도</option>
          <option>제주특별자치도</option>
        </select>
      </div>
      <div class="input-group">
        <label for="city">시 또는 구군</label>
        <input type="text" id="city" placeholder="" name="city">
      </div>
      <div class="input-group">
        <label for="district">읍/면/동</label>
        <input type="text" id="district" placeholder="" name="district">
      </div>
      <div class="input-group">
        <label for="address">도로명 주소*</label>
        <input type="text" id="address" placeholder="" name="address">
      </div>
      <div class="input-group">
        <label for="building">건물/아파트, 층, 호수</label>
        <input type="text" id="building" placeholder="" name="buildingDetail">
      </div>
      <div class="input-group">
        <label for="phone">전화번호*</label>
        <input type="text" id="phone" placeholder="" name="phone">
      </div>
      <div class="input-group">
        <label for="email">이메일*</label>
        <input type="email" id="email" placeholder="" name="email">
      </div>
      <h2>결제 수단</h2>
      <div class="payment-methods">
        <label class="payment-option">
          <input type="checkbox" id="kakao-pay" name="paymentMethod" value="카카오페이">
          <span>카카오페이</span>
        </label>

        <label class="payment-option">
          <input type="checkbox" id="credit-card" name="paymentMethod" value="신용카드">
          <span>신용카드</span>
        </label>

        <label class="payment-option">
          <input type="checkbox" id="naver-pay" name="paymentMethod" value="네이버페이">
          <span>네이버페이</span>
        </label>

        <label class="payment-option">
          <input type="checkbox" id="kpay" name="paymentMethod" value="코페이">
          <span>코페이</span>
        </label>

        <label class="payment-option">
          <input type="checkbox" id="bank-transfer" name="paymentMethod" value="실시간 계좌이체">
          <span>실시간 계좌이체</span>
        </label>
      </div>
      <c:forEach items="${cartItems}" var="item">
        <input type="hidden" name="prdCode" value="${item.prdCode}" />
        <input type="hidden" name="buyQty" value="${item.quantity != null && item.quantity ne '' ? item.quantity : 0}" />
        <input type="hidden" name="price" value="${item.price != null && item.price ne '' ? item.price : 0}" />
      </c:forEach>
      <c:if test="${orderType == 'direct' && directOrderItem != null}">
        <input type="hidden" name="prdCode" value="${directOrderItem.productInfo.prdCode}" />
        <input type="hidden" name="buyQty" value="${directOrderItem.quantity != null && directOrderItem.quantity ne '' ? directOrderItem.quantity : 0}" />
        <input type="hidden" name="price" value="${directOrderItem.productInfo.price != null && directOrderItem.productInfo.price ne '' ? directOrderItem.productInfo.price : 0}" />
      </c:if>
      <input type="hidden" name="subtotal" id="formSubtotal" value="0">
      <input type="hidden" name="deliveryCost" id="formDeliveryCost" value="0">
      <input type="hidden" name="totalAmount" id="formTotalAmount" value="0">
      <input type="hidden" name="orderType" id="formOrderType">
      <input type="hidden" name="orderItems" id="formOrderItems">
    </form>
  </div>
  <div class="order-summary">
    <h2>주문 상품</h2>
    <div class="order-details">
      <p>상품 금액<span id="price">0원</span></p>
      <p>배송비<span id="deliveryCost">0원</span></p>
      <p class="total">총 결제 금액<span id="totalprice">0원</span></p>
    </div>
    <!-- 상품 정보 섹션 -->
    <div id="product-list">
      <!-- 상품들이 여기에 동적으로 추가됩니다 -->
    </div>
    <button class="order-button" onclick="SaveOrder()">주문결제</button>
  </div>
</div>

<!-- 주문 타입 정보 -->
<div id="order-type" style="display: none;" data-order-type="${orderType}"></div>

<div id="cart-data" style="display: none;">
  <c:forEach items="${cartItems}" var="item">
    <div class="cart-item" 
         data-cart-id="${item.cartId}"
         data-prd-name="${item.prdName}"
         data-prd-img="${item.prdImg}"
         data-price="${item.price}"
         data-quantity="${item.quantity}"
         data-vendor-name="${item.vendorName}"
         data-prd-code="${item.prdCode}">
    </div>
  </c:forEach>
</div>

<div id="direct-order-data" style="display: none;">
  <c:if test="${orderType == 'direct' && directOrderItem != null}">
    <div class="direct-order-item" 
         data-prd-name="${directOrderItem.productInfo.prdName}"
         data-prd-img="${directOrderItem.productInfo.prdImg}"
         data-price="${directOrderItem.productInfo.price}"
         data-quantity="${directOrderItem.quantity}"
         data-vendor-name="${directOrderItem.productInfo.vendorName}"
         data-prd-code="${directOrderItem.prdCode}">
    </div>
  </c:if>
</div>

<script src="/assets/js/jquery-3.7.1.min.js"></script>
<script src="/assets/js/common.js"></script>
<script>

  $(document).ready(function() {
    loadOrderData();
  });

  function loadOrderData() {
    let subtotal = 0;
    let totalQuantity = 0;
    
    const orderType = $('#order-type').data('order-type');
    
    if (orderType === 'direct') {
      $('.direct-order-item').each(function() {
        const item = $(this);
        const prdName = item.data('prd-name');
        const prdImg = item.data('prd-img') || '/assets/logo/CAMPERX LOGO.svg';
        const price = parseInt(item.data('price')) || 0;
        const quantity = parseInt(item.data('quantity')) || 0;
        const vendorName = item.data('vendor-name');
        const prdCode = item.data('prd-code');
        
        const itemTotal = price * quantity;
        subtotal += itemTotal;
        totalQuantity += quantity;
        
        // 상품 정보를 화면에 추가
        const productHtml = 
          '<div class="product-info" data-prd-code="' + prdCode + '">' +
            '<img src="' + prdImg + '" alt="' + prdName + '" class="product-image" onerror="this.src=\'/assets/logo/CAMPERX LOGO.svg\'">' +
            '<div class="product-details">' +
              '<p>상품명: <span>' + prdName + '</span></p>' +
              '<p>브랜드: <span>' + vendorName + '</span></p>' +
              '<p>수량: ' +
                '<button class="qty-btn minus">-</button>' +
                '<span class="quantity">' + quantity + '</span>' +
                '<button class="qty-btn plus">+</button>' +
              '</p>' +
              '<p>가격: <span class="item-price">' + new Intl.NumberFormat('ko-KR').format(price) + '원</span></p>' +
              '<button class="delete-btn">삭제</button>' +
            '</div>' +
          '</div>';
        
        $('#product-list').append(productHtml);
      });
    } else {
      $('.cart-item').each(function() {
        const item = $(this);
        const prdName = item.data('prd-name');
        const prdImg = item.data('prd-img') || '/assets/logo/CAMPERX LOGO.svg';
        const price = parseInt(item.data('price')) || 0;
        const quantity = parseInt(item.data('quantity')) || 0;
        const vendorName = item.data('vendor-name');
        const prdCode = item.data('prd-code');
        
        const itemTotal = price * quantity;
        subtotal += itemTotal;
        totalQuantity += quantity;
        
        // 상품 정보를 화면에 추가
        const productHtml = 
          '<div class="product-info" data-prd-code="' + prdCode + '">' +
            '<img src="' + prdImg + '" alt="' + prdName + '" class="product-image" onerror="this.src=\'/assets/logo/CAMPERX LOGO.svg\'">' +
            '<div class="product-details">' +
              '<p>상품명: <span>' + prdName + '</span></p>' +
              '<p>브랜드: <span>' + vendorName + '</span></p>' +
              '<p>수량: ' +
                '<button class="qty-btn minus">-</button>' +
                '<span class="quantity">' + quantity + '</span>' +
                '<button class="qty-btn plus">+</button>' +
              '</p>' +
              '<p>가격: <span class="item-price">' + new Intl.NumberFormat('ko-KR').format(price) + '원</span></p>' +
              '<button class="delete-btn">삭제</button>' +
            '</div>' +
          '</div>';
        
        $('#product-list').append(productHtml);
      });
    }
    
    // 배송비 계산
    let shippingFee = 0;
    let shippingText = '';
    
    if (subtotal >= 100000) {
      shippingFee = 0;
      shippingText = '무료';
    } else if (subtotal >= 50000) {
      shippingFee = 2000;
      shippingText = '2,000원';
    } else if (subtotal >= 30000) {
      shippingFee = 3000;
      shippingText = '3,000원';
    } else {
      shippingFee = 5000;
      shippingText = '5,000원';
    }
    
    const totalAmount = subtotal + shippingFee;
    
    // 가격 정보 업데이트
    $('#price').text(new Intl.NumberFormat('ko-KR').format(subtotal) + '원');
    $('#deliveryCost').text(shippingText);
    $('#totalprice').text(new Intl.NumberFormat('ko-KR').format(totalAmount) + '원');
  }

  // 수량 조절 및 삭제 이벤트 위임
  $('#product-list').on('click', '.qty-btn', function() {
    const $info = $(this).closest('.product-info');
    let qty = parseInt($info.find('.quantity').text());
    if ($(this).hasClass('plus')) {
      qty++;
    } else if ($(this).hasClass('minus') && qty > 1) {
      qty--;
    }
    $info.find('.quantity').text(qty);
    // 수량 변경 시 가격/합계 재계산
    recalculateOrder();
  });

  $('#product-list').on('click', '.delete-btn', function() {
    $(this).closest('.product-info').remove();
    recalculateOrder();
  });

  function recalculateOrder() {
    let subtotal = 0;
    $('#product-list .product-info').each(function() {
      const price = parseInt($(this).find('.item-price').text().replace(/[^0-9]/g, '')) || 0;
      const qty = parseInt($(this).find('.quantity').text()) || 0;
      subtotal += price * qty;
    });
    
    // 배송비 계산
    let shippingFee = 0;
    let shippingText = '';
    
    if (subtotal >= 100000) {
      shippingFee = 0;
      shippingText = '무료';
    } else if (subtotal >= 50000) {
      shippingFee = 2000;
      shippingText = '2,000원';
    } else if (subtotal >= 30000) {
      shippingFee = 3000;
      shippingText = '3,000원';
    } else {
      shippingFee = 5000;
      shippingText = '5,000원';
    }
    
    const totalAmount = subtotal + shippingFee;
    
    // 가격 정보 업데이트
    $('#price').text(new Intl.NumberFormat('ko-KR').format(subtotal) + '원');
    $('#deliveryCost').text(shippingText);
    $('#totalprice').text(new Intl.NumberFormat('ko-KR').format(totalAmount) + '원');
  }

  function processOrder() {
    // 결제 수단 선택 확인
    const selectedPayment = $('input[name="paymentMethod"]:checked').length;
    if (selectedPayment === 0) {
      alert('결제 수단을 선택해주세요.');
      return;
    }
    
    // 필수 입력 필드 확인
    const lastname = $('#lastname').val().trim();
    const firstname = $('#firstname').val().trim();
    const address = $('#address').val().trim();
    const phone = $('#phone').val().trim();
    const email = $('#email').val().trim();
    
    if (!lastname || !firstname || !address || !phone || !email) {
      alert('필수 입력 항목을 모두 입력해주세요.');
      return;
    }
    
    // SaveOrder 함수 호출 (prepareFormData는 SaveOrder 내부에서 호출됨)
    SaveOrder();
  }
  
  function prepareFormData() {
    // 가격 정보를 hidden input에 설정
    const subtotal = parseInt($('#price').text().replace(/[^0-9]/g, '')) || 0;
    const deliveryCost = getDeliveryCost();
    const totalAmount = parseInt($('#totalprice').text().replace(/[^0-9]/g, '')) || 0;
    const orderType = $('#order-type').data('order-type');
    
    $('#formSubtotal').val(subtotal);
    $('#formDeliveryCost').val(deliveryCost);
    $('#formTotalAmount').val(totalAmount);
    $('#formOrderType').val(orderType);
    const orderItems = getOrderItems();
    $('#formOrderItems').val(JSON.stringify(orderItems));
  }
  
  // 주문 상품 정보 수집
  function getOrderItems() {
    const items = [];
    $('#product-list .product-info').each(function() {
      const $item = $(this);
      items.push({
        prdCode: $item.data('prd-code'),
        prdName: $item.find('.product-details p:first span').text(),
        vendorName: $item.find('.product-details p:nth-child(2) span').text(),
        quantity: parseInt($item.find('.quantity').text()) || 0,
        price: parseInt($item.find('.item-price').text().replace(/[^0-9]/g, '')) || 0
      });
    });
    return items;
  }
  
  // 배송비 반환
  function getDeliveryCost() {
    const deliveryText = $('#deliveryCost').text();
    if (deliveryText === '무료') {
      return 0;
    }
    return parseInt(deliveryText.replace(/[^0-9]/g, '')) || 0;
  }
  
  function SaveOrder() {
    // 폼 데이터 준비
    prepareFormData();
    
    call_server('#orderForm', '/camperX/SaveOrder', SaveOrderInfo);
  }

  function SaveOrderInfo(response) {
    if (response) {
      alert("주문이 완료되었습니다!");
      window.location.href = "/camperX_mainpage";
    } else {
      alert("주문 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
    }
  }
</script>
</body>
</html>
