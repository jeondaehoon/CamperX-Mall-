<%--
  Created by IntelliJ IDEA.
  User: ascde
  Date: 2025-06-17
  Time: 오후 11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CAMPERX - 상품목록</title>
    <link rel="icon" type="image/svg+xml" href="/assets/logo/CAMPERX_favicon .svg">
    <link rel="stylesheet" href="/assets/css/common/Header.css">
    <link rel="stylesheet" href="/assets/css/common/Footer.css">
    <link rel="stylesheet" href="/assets/css/ProductList/ProductList.css">
    <script src="/assets/js/jquery-3.7.1.min.js"></script>
    <script src="/assets/js/common.js"></script>
</head>
<body>
    <%@ include file="/WEB-INF/jsp/common/Header.jsp" %>

    <div class="container">
        <!-- 현재 위치 표시 -->
        <div class="breadcrumb">
            <a href="/">홈</a>
            <span class="divider">/</span>
            <a href="/camperX_productList">캠핑용품</a>
            <span class="divider">/</span>
            <span class="current">${category == 'tent' ? '텐트/타프' : 
                                  category == 'table' ? '테이블/체어' :
                                  category == 'kitchen' ? '주방용품' :
                                  category == 'sleeping' ? '침낭/매트' :
                                  category == 'lighting' ? '조명' : '전체'}</span>
        </div>

        <div class="product-header">
            <h1>${category == 'tent' ? '텐트/타프' : 
                 category == 'table' ? '테이블/체어' :
                 category == 'kitchen' ? '주방용품' :
                 category == 'sleeping' ? '침낭/매트' :
                 category == 'lighting' ? '조명' : '전체 상품'}</h1>
            <div class="product-controls">
                <button type="button" id="filterBtn" class="control-btn">
                    <img src="/assets/icon/filter-icon.svg" alt="필터" width="14" height="14">
                    필터
                </button>
                <button type="button" id="toggleSidebarBtn" class="control-btn">
                    필터 보이기
                </button>
                <div class="sort-dropdown">
                    <button type="button" id="sortBtn" class="control-btn">
                        <span id="currentSort">추천순</span>
                        <svg width="12" height="12" viewBox="0 0 12 12">
                            <path d="M2 4l4 4 4-4" fill="none" stroke="currentColor" stroke-width="2"/>
                        </svg>
                    </button>
                    <ul class="sort-menu" id="sortMenu">
                        <li><button type="button" data-sort="recommended" class="active">추천순</button></li>
                        <li><button type="button" data-sort="newest">최신순</button></li>
                        <li><button type="button" data-sort="priceAsc">가격 낮은순</button></li>
                        <li><button type="button" data-sort="priceDesc">가격 높은순</button></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="product-container">
            <!-- 사이드바 오버레이 -->
            <div class="sidebar-overlay" id="sidebarOverlay"></div>
            
            <!-- 사이드바 -->
            <aside class="filter-sidebar" id="filterSidebar">
                <!-- 닫기 버튼 추가 -->
                <button type="button" id="closeSidebarBtn" class="close-btn">
                    <span>&times;</span>
                </button>
                
                <!-- 카테고리 섹션 -->
                <div class="filter-section">
                    <h3>카테고리</h3>
                    <ul class="category-list">
                        <c:set var="cat" value="${category}" />
                        
                        <c:if test="${cat == 'tent_all' || cat == 'tent' || cat == 'tarp' || cat == 'C001' || cat == 'C002' || fn:startsWith(cat, 'C001') || fn:startsWith(cat, 'C002')}">
                            <li class="main-category">
                                <a href="#" class="sidebar-category" data-category="tent_all">텐트 &amp; 타프 전체</a>
                            </li>
                            <li class="main-category">
                                <a href="#" class="sidebar-category" data-category="tent">텐트</a>
                                <ul class="sub-categories" id="tentSubCategories" style="display: none;"></ul>
                            </li>
                            <li class="main-category">
                                <a href="#" class="sidebar-category" data-category="tarp">타프</a>
                                <ul class="sub-categories" id="tarpSubCategories" style="display: none;"></ul>
                            </li>
                        </c:if>
                        
                        <c:if test="${cat == 'table_all' || cat == 'table' || cat == 'chair' || cat == 'C003' || cat == 'C004' || fn:startsWith(cat, 'C003') || fn:startsWith(cat, 'C004')}">
                            <li class="main-category">
                                <a href="#" class="sidebar-category" data-category="table_all">테이블 &amp; 의자 전체</a>
                            </li>
                            <li class="main-category">
                                <a href="#" class="sidebar-category" data-category="table">테이블</a>
                                <ul class="sub-categories" id="tableSubCategories" style="display: none;"></ul>
                            </li>
                            <li class="main-category">
                                <a href="#" class="sidebar-category" data-category="chair">의자</a>
                                <ul class="sub-categories" id="chairSubCategories" style="display: none;"></ul>
                            </li>
                        </c:if>

                        <c:if test="${cat == 'kitchen' || cat == 'C005' || fn:startsWith(cat, 'C005')}">
                             <li class="main-category">
                                 <a href="#" class="sidebar-category" data-category="kitchen">주방용품</a>
                                 <ul class="sub-categories" id="kitchenSubCategories" style="display: none;"></ul>
                             </li>
                        </c:if>

                        <c:if test="${cat == 'sleeping' || cat == 'C006' || cat == 'C007' || fn:startsWith(cat, 'C006') || fn:startsWith(cat, 'C007')}">
                            <li class="main-category">
                                <a href="#" class="sidebar-category" data-category="sleeping">침낭 &amp; 매트</a>
                                <ul class="sub-categories" id="sleepingSubCategories" style="display: none;"></ul>
                            </li>
                        </c:if>

                        <c:if test="${cat == 'lighting' || cat == 'C008' || fn:startsWith(cat, 'C008')}">
                            <li class="main-category">
                                <a href="#" class="sidebar-category" data-category="lighting">조명</a>
                                <ul class="sub-categories" id="lightingSubCategories" style="display: none;"></ul>
                            </li>
                        </c:if>
                    </ul>
                </div>

                <!-- 브랜드 섹션 -->
                <div class="filter-section">
                    <h3>브랜드</h3>
                    <ul>
                        <c:forEach items="${sidebarData.brands}" var="brand">
                            <li>
                                <label>
                                    <input type="checkbox" name="brand" value="${brand}">
                                    ${brand}
                                </label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <!-- 가격대 섹션 -->
                <div class="filter-section">
                    <h3>가격대</h3>
                    <ul>
                        <c:forEach items="${sidebarData.priceRanges}" var="priceRange">
                            <li>
                                <label>
                                    <input type="checkbox" name="price" value="${priceRange.key}">
                                    ${priceRange.value}
                                </label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <!-- 색상 섹션 -->
                <div class="filter-section">
                    <h3>색상</h3>
                    <ul>
                        <c:forEach items="${sidebarData.colors}" var="color">
                            <li>
                                <label>
                                    <input type="checkbox" name="color" value="${color}">
                                    ${color}
                                </label>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="filter-actions">
                    <button type="button" class="btn-reset">초기화</button>
                    <button type="button" class="btn-apply">적용하기</button>
                </div>
            </aside>

            <main class="product-list">
                <c:choose>
                    <c:when test="${empty productList}">
                        <div class="no-products">
                            <p>상품이 없습니다.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="product-grid" id="productList">
                        </div>
                    </c:otherwise>
                </c:choose>
            </main>
        </div>
    </div>

    <%@ include file="/WEB-INF/jsp/common/Footer.jsp" %>

    <script>
        // 필터 사이드바 토글
        const filterBtn = document.getElementById('filterBtn');
        const toggleSidebarBtn = document.getElementById('toggleSidebarBtn');
        const filterSidebar = document.getElementById('filterSidebar');
        const sidebarOverlay = document.getElementById('sidebarOverlay');
        const closeSidebarBtn = document.getElementById('closeSidebarBtn');
        
        // 화면 크기에 따른 사이드바 동작 처리
        function toggleSidebar() {
            const isMobile = window.innerWidth <= 768;
            
            if (isMobile) {
                // 모바일에서는 오버레이와 함께 전체화면으로 표시
                filterSidebar.classList.toggle('active');
                sidebarOverlay.classList.toggle('active');
                document.body.style.overflow = filterSidebar.classList.contains('active') ? 'hidden' : '';
            } else {
                // 데스크톱에서는 숨기기/보이기만 처리
                filterSidebar.classList.toggle('hidden');
                // 필터 버튼 텍스트 업데이트
                toggleSidebarBtn.textContent = filterSidebar.classList.contains('hidden') ? '필터 보이기' : '필터 숨기기';
            }
        }

        // 이벤트 리스너 설정
        filterBtn.addEventListener('click', toggleSidebar);
        toggleSidebarBtn.addEventListener('click', toggleSidebar);
        closeSidebarBtn.addEventListener('click', () => {
            filterSidebar.classList.remove('active');
            sidebarOverlay.classList.remove('active');
            document.body.style.overflow = '';
        });
        sidebarOverlay.addEventListener('click', () => {
            filterSidebar.classList.remove('active');
            sidebarOverlay.classList.remove('active');
            document.body.style.overflow = '';
        });

        // 화면 크기 변경 시 처리
        window.addEventListener('resize', () => {
            const isMobile = window.innerWidth <= 768;
            if (!isMobile) {
                // 모바일 -> 데스크톱으로 변경 시 모바일 관련 클래스 제거
                filterSidebar.classList.remove('active');
                sidebarOverlay.classList.remove('active');
                document.body.style.overflow = '';
            }
        });

        // 정렬 드롭다운
        const sortBtn = document.getElementById('sortBtn');
        const sortMenu = document.getElementById('sortMenu');
        const currentSort = document.getElementById('currentSort');

        sortBtn.addEventListener('click', (e) => {
            sortMenu.classList.toggle('active');
            e.stopPropagation();
        });

        sortMenu.addEventListener('click', (e) => {
            if (e.target.tagName === 'BUTTON') {
                const sortText = e.target.textContent;
                const sortValue = e.target.dataset.sort;
                
                // 현재 정렬 텍스트 업데이트
                currentSort.textContent = sortText;
                
                // 활성 클래스 변경
                sortMenu.querySelectorAll('button').forEach(btn => {
                    btn.classList.remove('active');
                });
                e.target.classList.add('active');
                
                // 정렬 메뉴 닫기
                sortMenu.classList.remove('active');
                
                // TODO: 여기에 정렬 로직 추가
            }
        });

        // 외부 클릭시 드롭다운 닫기
        document.addEventListener('click', (e) => {
            if (!sortBtn.contains(e.target)) {
                sortMenu.classList.remove('active');
            }
        });

        // --- 전역 필터 상태 관리 ---
        let currentFilterState = {
            category: '${category}',
            sort: 'recommended',
            brands: [],
            prices: [],
            colors: []
        };
        
        // --- 필터 및 상품 로드 함수 ---
        function filterAndLoadProducts() {
            // 현재 필터 상태에서 값 수집
            currentFilterState.brands = Array.from(document.querySelectorAll('input[name="brand"]:checked')).map(cb => cb.value);
            currentFilterState.prices = Array.from(document.querySelectorAll('input[name="price"]:checked')).map(cb => cb.value);
            currentFilterState.colors = Array.from(document.querySelectorAll('input[name="color"]:checked')).map(cb => cb.value);
            
            // 현재 활성화된 정렬 기준 가져오기
            const activeSortButton = document.querySelector('#sortMenu button.active');
            if (activeSortButton) {
                currentFilterState.sort = activeSortButton.dataset.sort;
            }

            getProductList(currentFilterState);
        }
        
        // 필터 초기화
        const resetBtn = document.querySelector('.btn-reset');
        resetBtn.addEventListener('click', () => {
            document.querySelectorAll('.filter-section input[type="checkbox"]').forEach(checkbox => {
                checkbox.checked = false;
            });
            // 초기화 후 바로 적용
            filterAndLoadProducts();
        });

        // 필터 적용
        const applyBtn = document.querySelector('.btn-apply');
        applyBtn.addEventListener('click', () => {
            filterAndLoadProducts();
            
            // 모바일에서 사이드바 닫기
            if (window.innerWidth <= 768) {
                toggleSidebar();
            }
        });

        $(document).ready(function() {
            var initialCategory = '${category}';
            
            // 초기 카테고리에 해당하는 메인 카테고리 활성화
            $('.sidebar-category[data-category="' + initialCategory + '"]').addClass('active');
            
            // 서브카테고리 로드
            loadSubCategories(initialCategory);
            
            // 초기 상품 목록 로드
            filterAndLoadProducts();

            // 메인 카테고리 클릭 이벤트
            $('.sidebar-category').on('click', function(e) {
                e.preventDefault();
                var category = $(this).data('category');
                
                // 전역 상태 업데이트
                currentFilterState.category = category;
                
                $('.sidebar-category').removeClass('active');
                $(this).addClass('active');
                
                loadSubCategories(category);
                filterAndLoadProducts();
            });

            // 서브카테고리 클릭 이벤트
            $(document).on('click', '.sub-category-item', function(e) {
                e.preventDefault();
                var categoryCode = $(this).data('category-code');
                
                currentFilterState.category = categoryCode;
                
                $('.sub-category-item').removeClass('active');
                $(this).addClass('active');
                
                filterAndLoadProducts();
            });
            
            // 정렬 버튼 클릭 이벤트
            $('#sortMenu').on('click', 'button', function() {
                const sortValue = $(this).data('sort');
                currentFilterState.sort = sortValue;
                
                // UI 업데이트
                $('#currentSort').text($(this).text());
                $('#sortMenu button').removeClass('active');
                $(this).addClass('active');
                $('#sortMenu').removeClass('active');
                
                filterAndLoadProducts();
            });
        });

        // 제품 목록 로드 함수 (POST, JSON)
        function getProductList(filterData) {
            $.ajax({
                url: '/camperX/getProductList',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(filterData),
                success: function(products) {
                    var productList = $('#productList');
                    productList.empty();
                    
                    if (products && products.length > 0) {
                        products.forEach(function(product) {
                            var formattedPrice = new Intl.NumberFormat('ko-KR').format(product.PRICE);
                            var detailUrl = '/camperX/productView?prdCode=' + product.PRD_CODE;
                            
                            var productHtml = 
                                '<a href="' + detailUrl + '" class="product-link">' +
                                    '<div class="product-card">' +
                                        '<div class="product-image">' +
                                            '<img src="' + (product.PRD_IMG || '') + '" alt="' + (product.PRD_NAME || '') + '">' +
                                        '</div>' +
                                        '<div class="product-info">' +
                                            '<div class="product-brand">' + (product.VENDOR_NAME || '') + '</div>' +
                                            '<div class="product-name">' + (product.PRD_NAME || '') + '</div>' +
                                            '<div class="product-price">' + formattedPrice + '원</div>' +
                                        '</div>' +
                                    '</div>' +
                                '</a>';
                            productList.append(productHtml);
                        });
                    } else {
                        productList.html('<div class="no-products"><p>조건에 맞는 상품이 없습니다.</p></div>');
                    }
                },
                error: function(xhr, status, error) {
                    $('#productList').html('<div class="no-products"><p>상품을 불러오는 중 오류가 발생했습니다.</p></div>');
                }
            });
        }

        // 서브카테고리 로드 및 표시 함수
        function loadSubCategories(category) {
            if (!category || category.endsWith('_all')) {
                $('.sub-categories').slideUp(200).empty();
                return;
            }
            
            // 다른 메인 카테고리의 서브카테고리는 닫기
            $('.sidebar-category[data-category!="' + category + '"] + .sub-categories').slideUp(200);

            $.ajax({
                url: '/camperX/getSubCategories',
                type: 'GET',
                data: { category: category },
                success: function(subCategories) {
                    var subCategoryList = $('.sidebar-category[data-category="' + category + '"] + .sub-categories');
                    subCategoryList.empty();
                    
                    if (subCategories && subCategories.length > 0) {
                        subCategories.forEach(function(subCategory) {
                            var li = $('<li>');
                            var a = $('<a>', {
                                href: '#',
                                class: 'sub-category-item',
                                'data-category-code': subCategory.CATEGORYCODE,
                                text: subCategory.CATEGORYNAME
                            });
                            
                            li.append(a);
                            subCategoryList.append(li);
                        });
                        
                        subCategoryList.slideDown(200);
                    } else {
                        subCategoryList.slideUp(200);
                    }
                },
                error: function() {
                }
            });
        }
    </script>
</body>
</html>
