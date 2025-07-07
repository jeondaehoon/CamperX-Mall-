<%--
  Created by IntelliJ IDEA.
  User: ascde
  Date: 2025-06-16
  Time: 오후 4:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CAMPERX</title>
    <link rel="icon" type="image/svg+xml" href="/assets/logo/CAMPERX_favicon .svg">
    <link rel="stylesheet" href="/assets/css/mainpage/mainpage.css">
    <script src="/assets/js/jquery-3.7.1.min.js"></script>
    <script src="/assets/js/common.js"></script>
    <script src="/assets/js/cookie.js"></script>
</head>
<body>
<!--header-->
<%@ include file="/WEB-INF/jsp/common/Header.jsp" %>
<!--main-->
<div class="page-content">
    <div id="slide1" class="slide">
        <div class="banner_text">
            <a href="#">
                <div id="main_banner_txt_og">
                    Step into the stories that nature whispers.<br>
                    Prepare for a perfect day of relaxation, embraced by nature.<br>
                    With the breeze, the warmth of a campfire,<br>
                    and a camping story crafted just for you,<br>
                    CamperX is here to make it unforgettable.
                </div>
            </a>
            <div class="arrow" onclick="goToProductList()"></div>
        </div>
    </div>

    <div id="slide2" class="slide">
        <!-- 이미지 섹션 -->
        <div class="product-list" id="Top3tentIMG">
        </div>
        <div class="product-description">
            <h2>캠퍼들의 텐트 리뷰</h2>
            <p>캠퍼들이 들려주는 텐트 리뷰를 확인해 보세요.</p>
            <button class="review-button">상품 보기</button>
        </div>
    </div>
    <div id="slide3" class="slide">
        <div class="best-text-container">
            <h1 class="best-text">베스트</h1>
        </div>
        <div class="category-buttons">
            <a href="#" class="category-button active">ALL</a>
            <a href="#" class="category-button">텐트</a>
            <a href="#" class="category-button">타프</a>
            <a href="#" class="category-button">의자</a>
            <a href="#" class="category-button">테이블</a>
            <a href="#" class="category-button">기타</a>
        </div>
        <div id="Top5product" class="product-gallery">
            <!-- top5product -->
        </div>
        <!--footer-->
        <%@ include file="/WEB-INF/jsp/common/Footer.jsp" %>
    </div>
    <div class="dot-container">
        <span class="dot" onclick="currentSlide(1)"></span>
        <span class="dot" onclick="currentSlide(2)"></span>
        <span class="dot" onclick="currentSlide(3)"></span>
    </div>
</div>

<script>
    let currentSlideIndex = 1;
    const sensitivity = 50;
    let isScrolling = false;
    let scrollTimeout;

    showSlide(currentSlideIndex);

    window.addEventListener('wheel', function(event) {
        event.preventDefault();

        if (isScrolling) return;

        clearTimeout(scrollTimeout);
        scrollTimeout = setTimeout(() => {
            isScrolling = false;
        }, 300);

        let delta = event.deltaY;

        if (Math.abs(delta) > sensitivity) {
            isScrolling = true;

            if (delta > 0) {
                currentSlideIndex = (currentSlideIndex % 3) + 1;
            } else {
                currentSlideIndex = (currentSlideIndex - 2 + 3) % 3 + 1;
            }

            showSlide(currentSlideIndex);
        }
    }, { passive: false });

    function currentSlide(n) {
        showSlide(currentSlideIndex = n);
    }

    function showSlide(n) {
        let slides = document.querySelectorAll('.slide');
        let dots = document.getElementsByClassName("dot");

        for (let i = 0; i < slides.length; i++) {
            slides[i].classList.remove("active");
        }

        for (let i = 0; i < dots.length; i++) {
            dots[i].classList.remove("active");
        }

        if (slides[n - 1]) {
            slides[n - 1].classList.add("active");
        }

        dots[n - 1].classList.add("active");
    }

    //리뷰이미지 불러오기
    //베스트 상품 불러오기
    // 화살표 클릭 함수
    function goToProductList() {
        console.log('goToProductList function called!');
        window.location.href = '/camperX_productList?category=tent';
    }

    $(document).ready(function (){
        getTop3tent()
        getTop5product('ALL');
        
        // 화살표 클릭 이벤트 추가
        $('.arrow').on('click', function(e) {
            console.log('Arrow clicked!');
            e.preventDefault();
            e.stopPropagation();
            goToProductList();
        });
    });

    function getTop3tent(){
        set_server('/camperX/getTop3tent', setTop3tentIMG);
    }

    function setTop3tentIMG(list) {
        console.log('Received data:', list);
        var container = $('#Top3tentIMG');
        container.empty();
        for (var i = 0; i < list.length; i++) {
            console.log('Image path:', list[i].prdImg);
            var str = '<div class="product-item">';
            var fileName = list[i].prdImg.split('/').pop();
            str += '<img src="/images/' + fileName + '" alt="Product ' + (i + 1) + '">';
            str += '</div>';
            container.append(str);
        }
    }

    $('.category-button').click(function(e){
        e.preventDefault();
        $('.category-button').removeClass('active');
        $(this).addClass('active');
        getTop5product($(this).text());
    });

    function getTop5product(category){
        set_server('/camperX/getTop5product?category=' + category, setTop5product);
    }

    function setTop5product(list){
        var container = $('#Top5product');
        container.empty();
        for (var i = 0; i < list.length; i++) {
            var str = '<a href="/camperX/productView?prdCode=' + list[i].prdCode + '" class="product-link">';
            str += '<div class="product-container">';
            str += '<span class="product-number">' + (i + 1) + '</span>';
            var fileName = list[i].prdImg.split('/').pop();
            str += '<img src="/images/' + fileName + '" alt="' + list[i].prdName + '" class="product-image">';
            str += '<div class="product-description_1">';
            str += '<p class="product-brand">' + list[i].vendorName + '</p>';
            str += '<p class="product-name">' + list[i].prdName + '</p>';
            str += '<p class="product-price">' + addComma(list[i].price) + '원</p>';
            str += '</div>';
            str += '</div>';
            str += '</a>';
            
            container.append(str);  
        }
    }
</script>
</body>
</html>
