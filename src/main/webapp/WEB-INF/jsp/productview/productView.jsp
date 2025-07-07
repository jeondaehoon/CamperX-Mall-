<%--
  Created by IntelliJ IDEA.
  User: ascde
  Date: 2025-06-20
  Time: 오후 3:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CAMPERX - 상품상세</title>
    <link rel="icon" type="image/svg+xml" href="/assets/logo/CAMPERX_favicon .svg">
    <link rel="stylesheet" href="/assets/css/common/Header.css">
    <link rel="stylesheet" href="/assets/css/common/Footer.css">
    <link rel="stylesheet" href="/assets/css/ProductView/ProductView.css">
    <script src="/assets/js/jquery-3.7.1.min.js"></script>
    <script src="/assets/js/common.js"></script>
    <script src="/assets/js/cookie.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/Header.jsp" %>


<div class="contents">
    <section class="product-section">
        <div class="image-container">
            <div class="small-images">
                <!-- Thumbnail images will be dynamically inserted here -->
            </div>
            <div class="big-image-wrapper">
                <img src="" class="big-image" alt="Main Product Image">
            </div>
        </div>
        <div class="product-details">
            <form id="addform">
                <input type="hidden" id="prdCode" name="prdCode">
                <p class="product-brand" id="vendorName"></p>
                <h1 class="product-title" id="prdName"></h1>
                <p class="product-description" id="prdDesc"></p>
                <div class="price-wrapper">
                    <span class="product-price" id="price"></span>
                </div>
                
                <div class="color-selection">
                    <span class="label">색상</span>
                    <span class="product-color" id="prdColor"></span>
                </div>
                
                <div class="action-buttons">
                    <button type="button" class="btn-buy" onclick="handleBuyClick()">구매하기</button>
                    <button type="button" class="btn-cart" onclick="handleCartClick()">장바구니</button>
                </div>

                <div class="product-extra-details">
                    <details class="accordion-item" open>
                        <summary class="accordion-header">상품 특징</summary>
                        <div class="accordion-content" id="product-features">
                            <!-- Dynamic features will be inserted here -->
                        </div>
                    </details>
                    <details class="accordion-item">
                        <summary class="accordion-header">배송 및 반품</summary>
                        <div class="accordion-content">
                            <strong>일반 배송</strong>
                            <p>• 배송지역: 전국 (일부 지역 제외)</p>
                            <p>• 배송비: <span id="shipping">무료배송</span></p>
                            <p>• 제품 수령일로부터 14일 이내 제품에 대해서만 무료 반품 서비스가 가능합니다.</p>
                        </div>
                    </details>
                    <details class="accordion-item">
                        <summary class="accordion-header">추가 정보</summary>
                        <div class="accordion-content">
                            <ul>
                                <li><strong>제조연월:</strong> 수입제품으로 각 제품별 입고 시기에 따라 상이하여 정확한 제조연월 제공이 어렵습니다.</li>
                                <li><strong>A/S 책임자와 전화번호:</strong> camper_X 온라인 스토어 고객센터 / 080-000-0000</li>
                                <li><strong>품질보증기준:</strong> 품질보증기간-섬유 및 일반 소재(구입 후 6개월), 가죽소재(구입 후 1년).</li>
                            </ul>
                        </div>
                    </details>
                </div>
            </form>
        </div>
    </section>

    <div class="product-details-section related-products-section">
        <div class="product-slider">
            <h2 class="prdsub-title">다른 관련 상품</h2>
            <button class="slider-btn prev-btn">‹</button>
            <div class="slider-container">
                <ul class="slider-items related-products" id="relatedproducts">
                    <!-- Related products will be dynamically inserted here -->
                </ul>
            </div>
            <button class="slider-btn next-btn">›</button>
        </div>
    </div>

    <div class="product-details-section recommended-products-section">
        <div class="product-slider">
            <h2 class="prdsub-title">추천 상품</h2>
            <button class="slider-btn prev-btn">‹</button>
            <div class="slider-container">
                <ul class="slider-items recommended-products">
                    <!-- Recommended products will be dynamically inserted here -->
                </ul>
            </div>
            <button class="slider-btn next-btn">›</button>
        </div>
    </div>
</div>


<%@ include file="/WEB-INF/jsp/common/Footer.jsp" %>
<script>
    // 받아온 데이터로 화면 전체를 렌더링하는 함수
    function renderProduct(data) {
        if (!data || !data.info) {
            document.querySelector('.contents').innerHTML = '<h2>상품 정보가 없습니다.</h2>';
            return;
        }

        // 1. 기본 정보 렌더링
        const info = data.info;
        document.querySelector('.product-brand').textContent = info.vendorName || '';
        document.querySelector('.product-title').textContent = info.prdName || '';
        document.querySelector('.product-description').textContent = info.prdDesc || '';
        document.querySelector('.product-price').textContent = new Intl.NumberFormat('ko-KR').format(info.price || 0) + '원';
        document.querySelector('.product-color').textContent = info.prdColor || '';
        document.querySelector('#shipping').textContent = info.shipping || '무료배송';
        
        // prdCode를 hidden input에 설정
        document.getElementById('prdCode').value = info.prdCode || '';

        // 2. 이미지 렌더링
        renderImages(data.images);

        // 3. 상품 특징 렌더링
        renderFeatures(data.features);
    }

    // 이미지 렌더링 및 이벤트 처리
    function renderImages(images) {
        const bigImage = document.querySelector('.big-image');
        const smallImagesContainer = document.querySelector('.small-images');
        smallImagesContainer.innerHTML = '';

        if (!images || images.length === 0) {
            bigImage.src = '/assets/logo/CAMPERX LOGO.svg';
            return;
        }

        // null이나 undefined인 이미지 필터링
        const validImages = images.filter(img => img && img.prdImg && img.prdImg.trim() !== '');
        
        if (validImages.length === 0) {
            bigImage.src = '/assets/logo/CAMPERX LOGO.svg';
            return;
        }

        let mainImageSrc = validImages.find(img => img.imgType === 'main')?.prdImg || validImages[0].prdImg;
        if (mainImageSrc) {
            bigImage.src = mainImageSrc;
        } else {
            bigImage.src = '/assets/logo/CAMPERX LOGO.svg';
        }

        validImages.forEach((image, index) => {
            if (image.prdImg && image.prdImg.trim() !== '') {
                const thumbWrapper = document.createElement('div');
                thumbWrapper.className = 'small-image-wrapper';

                const thumb = document.createElement('img');
                thumb.src = image.prdImg;
                thumb.alt = 'Product Thumbnail';
                thumb.onerror = function() {
                    this.src = '/assets/logo/CAMPERX LOGO.svg';
                };

                if (thumb.src === mainImageSrc || index === 0) {
                    thumbWrapper.classList.add('active');
                }

                thumbWrapper.appendChild(thumb);
                smallImagesContainer.appendChild(thumbWrapper);
            }
        });

        smallImagesContainer.addEventListener('click', function(e) {
            const wrapper = e.target.closest('.small-image-wrapper');
            if (wrapper) {
                const img = wrapper.querySelector('img');
                if (img && img.src) {
                    bigImage.src = img.src;
                    this.querySelectorAll('.small-image-wrapper').forEach(w => w.classList.remove('active'));
                    wrapper.classList.add('active');
                }
            }
        });
    }

    function renderFeatures(features) {
        const container = document.getElementById('product-features');
        container.innerHTML = '';
        
        if(!features || features.length === 0) {
            container.closest('.accordion-item').style.display = 'none';
            return;
        }
        container.closest('.accordion-item').style.display = 'block';

        const dl = document.createElement('dl');
        features.forEach(feature => {
            if (feature.title && feature.description) {
                const dt = document.createElement('dt');
                dt.textContent = feature.title;

                const dd = document.createElement('dd');
                dd.textContent = feature.description;

                dl.appendChild(dt);
                dl.appendChild(dd);
            }
        });
        container.appendChild(dl);
    }

    function renderRecommendedProducts(products) {
        const section = document.querySelector('.recommended-products-section');
        if (!section) return;
        const container = section.querySelector('.slider-items.recommended-products');
        container.innerHTML = '';

        if (!products || products.length === 0) {
            const messageDiv = document.createElement('div');
            messageDiv.style.cssText = `
                text-align: center;
                padding: 40px 20px;
                color: #666;
                font-size: 16px;
                background-color: #f8f8f8;
                border-radius: 8px;
                margin: 20px 0;
            `;
            messageDiv.textContent = '현재 추천 상품이 없습니다.';
            container.appendChild(messageDiv);
            section.style.display = 'block';
            return;
        }
        section.style.display = 'block';

        products.forEach(product => {
            const li = document.createElement('li');
            li.className = 'slider-item';
            const formattedPrice = new Intl.NumberFormat('ko-KR').format(product.price || 0) + '원';
            const productImage = product.prdImg && product.prdImg.trim() !== '' ? product.prdImg : '/assets/logo/CAMPERX LOGO.svg';
            li.innerHTML =
                '<a href="/camperX/productView?prdCode=' + product.prdCode + '">' +
                '    <div class="img-wrapper">' +
                '        <img src="' + productImage + '" alt="' + (product.prdName || '상품 이미지') + '" onerror="this.src=\'/assets/logo/CAMPERX LOGO.svg\'">' +
                '    </div>' +
                '    <div class="slider-item-info">' +
                '        <p class="brand">' + (product.vendorName || '') + '</p>' +
                '        <p class="name">' + (product.prdName || '') + '</p>' +
                '        <p class="price">' + formattedPrice + '</p>' +
                '    </div>' +
                '</a>';
            container.appendChild(li);
        });
        
        setupSlider(section.querySelector('.product-slider'));
    }

    function setupSlider(sliderElement) {
        if (!sliderElement) return;

        const container = sliderElement.querySelector('.slider-container');
        const items = sliderElement.querySelector('.slider-items');
        const prevBtn = sliderElement.querySelector('.prev-btn');
        const nextBtn = sliderElement.querySelector('.next-btn');
        
        if (!items || !prevBtn || !nextBtn || items.children.length < 2) {
            sliderElement.classList.add('no-slide');
            return;
        }
        sliderElement.classList.remove('no-slide');

        let currentIndex = 0;
        const itemWidth = items.children[0].offsetWidth + 20; // 20 is gap
        const visibleItems = Math.floor(container.clientWidth / itemWidth);
        const totalItems = items.children.length;
        
        const updateButtons = () => {
            prevBtn.disabled = currentIndex === 0;
            nextBtn.disabled = currentIndex >= totalItems - visibleItems;
        };

        nextBtn.addEventListener('click', () => {
            if (currentIndex < totalItems - visibleItems) {
                currentIndex++;
                updateSliderPosition();
            }
        });

        prevBtn.addEventListener('click', () => {
            if (currentIndex > 0) {
                currentIndex--;
                updateSliderPosition();
            }
        });

        function updateSliderPosition() {
            items.style.transform = `translateX(-${currentIndex * itemWidth}px)`;
            updateButtons();
        }
        
        updateButtons();
    }

    $(document).ready(function () {
        const urlParams = new URLSearchParams(window.location.search);
        const prdCode = urlParams.get('prdCode');

        if (prdCode) {
            // 1. 메인 상품 정보 가져오기
            $.ajax({
                url: '/camperX/productDetailSearch',
                type: 'GET',
                data: { prdCode: prdCode },
                success: function(data) {
                    renderProduct(data);
                },
                error: function(xhr, status, error) {
                    $('.contents').html('<h2>상품 정보를 불러오는 데 실패했습니다.</h2>');
                }
            });

            // 2. 관련 상품 정보 가져오기
            getRelatedProducts(prdCode);

            // 3. 추천 상품 정보 가져오기
            getRecommendedProducts();

        } else {
            $('.contents').html('<h2>잘못된 접근입니다. 상품 코드가 없습니다.</h2>');
        }
    });

    // set_server 대신 표준 $.ajax를 사용하여 관련 상품 데이터를 가져오는 함수
    function getRelatedProducts(prdCode) {
        if (!prdCode) {
            setRelatedProducts([]);
            return;
        }

        $.ajax({
            url: '/camperX/getRelatedProducts',
            type: 'GET',
            data: { prdCode: prdCode },
            dataType: 'json',
            success: function(list) {
                setRelatedProducts(list);
            },
            error: function(xhr, status, error) {
                setRelatedProducts([]); // 에러 발생 시 빈 목록으로 처리하여 메시지 표시
            }
        });
    }

    function getRecommendedProducts() {
        $.ajax({
            url: '/camperX/getRecommendedProducts',
            type: 'GET',
            dataType: 'json',
            success: function(list) {
                renderRecommendedProducts(list);
            },
            error: function(xhr, status, error) {
                renderRecommendedProducts([]); // 에러 발생 시 빈 목록으로 처리하여 메시지 표시
            }
        });
    }

    // 관련 상품 목록을 화면에 렌더링하는 함수
    function setRelatedProducts(list) {
        const container = $('#relatedproducts');
        container.empty();

        if (!list || list.length === 0) {
            const messageDiv = `
                <div style="text-align: center; padding: 40px 20px; color: #666; font-size: 16px; background-color: #f8f8f8; border-radius: 8px; margin: 20px 0; width: 100%;">
                    현재 관련 상품이 없습니다.
                </div>`;
            container.html(messageDiv);
            $('.related-products-section .product-slider').addClass('no-slide');
            return;
        }

        $('.related-products-section .product-slider').removeClass('no-slide');

        list.forEach((product, index) => {
            try {
                if (!product || !product.prdCode) {
                    return;
                }

                const li = document.createElement('li');
                li.className = 'slider-item';

                const formattedPrice = new Intl.NumberFormat('ko-KR').format(product.price || 0) + '원';
                const productImage = product.prdImg && product.prdImg.trim() !== '' ? product.prdImg : '/assets/logo/CAMPERX LOGO.svg';

                li.innerHTML =
                    '<a href="/camperX/productView?prdCode=' + product.prdCode + '">' +
                    '    <div class="img-wrapper">' +
                    '        <img src="' + productImage + '" alt="' + (product.prdName || '상품 이미지') + '" onerror="this.src=\'/assets/logo/CAMPERX LOGO.svg\'">' +
                    '    </div>' +
                    '    <div class="slider-item-info">' +
                    '        <p class="brand">' + (product.vendorName || '') + '</p>' +
                    '        <p class="name">' + (product.prdName || '') + '</p>' +
                    '        <p class="price">' + formattedPrice + '</p>' +
                    '    </div>' +
                    '</a>';

                container.append(li);

            } catch (e) {
            }
        });
        
        setupSlider(document.querySelector('.related-products-section .product-slider'));
    }

    // 구매하기 버튼 클릭 처리
    function handleBuyClick() {
        checkLoginAndRedirect('/camperX_order', 'buy');
    }

    // 장바구니 버튼 클릭 처리
    function handleCartClick() {
        checkLoginAndRedirect('/camperX_cart');
    }

    // 로그인 상태 확인 및 리다이렉트
    function checkLoginAndRedirect(redirectUrl, action) {
        // 쿠키에서 userId 확인
        var userId = getCookie("userId");
        
        if (userId && userId.trim() !== '') {
            // 로그인된 경우
            if (redirectUrl === '/camperX_cart') {
                // 장바구니 페이지로 이동하는 경우, 현재 상품을 장바구니에 추가
                var prdCode = document.getElementById('prdCode').value;
                
                if (prdCode) {
                    var cartData = {
                        userId: userId,
                        prdCode: prdCode,
                        quantity: 1
                    };
                    
                    post_server('/camperX/addToCart', cartData, function(response) {
                        if (response.success) {
                            alert('장바구니에 추가되었습니다.');
                            window.location.href = redirectUrl;
                        } else {
                            alert('장바구니 추가에 실패했습니다.');
                        }
                    });
                } else {
                    window.location.href = redirectUrl;
                }
            } else if (redirectUrl === '/camperX_order' && action === 'buy') {
                // 구매하기인 경우, 현재 상품 정보를 세션에 저장
                var prdCode = document.getElementById('prdCode').value;
                
                if (prdCode) {
                    var orderData = {
                        prdCode: prdCode,
                        quantity: 1
                    };
                    
                    post_server('/camperX/saveProductToOrder', orderData, function(response) {
                        if (response.success) {
                            window.location.href = redirectUrl;
                        } else {
                            alert('주문 페이지 이동에 실패했습니다.');
                        }
                    });
                } else {
                    window.location.href = redirectUrl;
                }
            } else {
                // 일반적인 경우 주문 페이지로 이동
                window.location.href = redirectUrl;
            }
        } else {
            // 로그인되지 않은 경우 로그인 페이지로 이동
            window.location.href = '/camperX_loginId?url=' + encodeURIComponent(redirectUrl);
        }
    }
</script>
</body>
</html>
