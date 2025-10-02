# CamperX

> **캠핑용품 전문 쇼핑몰 플랫폼**

CamperX는 캠핑 애호가들을 위한 종합 쇼핑몰 플랫폼입니다. 텐트, 타프, 의자, 테이블 등 다양한 캠핑용품을 카테고리별로 분류하여 제공하며, 사용자 친화적인 인터페이스와 효율적인 쇼핑 경험을 제공합니다.

## 기술 스택

### **Backend Framework**
- **Spring Boot 2.7.18**: 메인 프레임워크
- **Spring MVC**: 웹 애플리케이션 아키텍처
- **MyBatis 2.2.2**: 데이터베이스 ORM
- **Oracle JDBC**: 데이터베이스 연결

### **Frontend**
- **JSP (JavaServer Pages)**: 서버사이드 뷰 템플릿
- **JSTL**: JSP 표준 태그 라이브러리
- **JavaScript (jQuery 3.7.1)**: 클라이언트 사이드 로직
- **CSS3**: 반응형 웹 디자인

### **Database**
- **Oracle Database**: 메인 데이터베이스
- **JDBC Driver (ojdbc11)**: 데이터베이스 연결

### **Development Tools**
- **Lombok**: 코드 간소화
- **Maven**: 의존성 관리 및 빌드 도구
- **Spring Boot DevTools**: 개발 편의성
- **Apache POI 5.2.3**: Excel 파일 처리
- **Commons IO 2.8.0**: 파일 처리 유틸리티

### **Security & Session**
- **Spring Security**: 웹 보안 프레임워크
- **Session 기반 인증**: 서버 사이드 세션 관리
- **Cookie 활용**: 사용자 편의성 제공

## 구현 기능

### **1. 사용자 인증 시스템**
- 세션 기반 로그인/로그아웃
- 회원가입 및 아이디 중복 확인
- 사용자 정보 관리 (이름, 이메일, 전화번호)
- 로그인 상태 유지 및 자동 로그인

### **2. 상품 관리 시스템**
- **카테고리별 상품 분류**
  - 텐트 & 타프
  - 테이블 & 의자
  - 주방용품
  - 침낭 & 매트
  - 조명
  - 기타 용품
- **상품 검색 및 필터링**
  - 브랜드별 필터
  - 가격대별 필터
  - 색상별 필터
  - 정렬 기능 (추천순, 가격순, 인기순)
- **상품 상세 정보**
  - 상품 이미지 갤러리
  - 상세 설명 및 스펙
  - 리뷰 및 평점 시스템

### **3. 쇼핑몰 기능**
- **장바구니 시스템**
  - 상품 추가/삭제
  - 수량 조정
  - 장바구니 아이템 관리
- **주문 관리**
  - 주문서 작성
  - 배송 정보 관리
  - 주문 내역 조회
- **인기 상품 추천**
  - 카테고리별 TOP 5 상품
  - 메인페이지 추천 상품

### **4. 사용자 마이페이지**
- 개인정보 관리
- 주문 내역 조회
- 장바구니 관리
- 관심 상품 관리

### **5. 관리자 기능**
- 상품 등록 및 관리
- 카테고리 관리
- 주문 처리
- 사용자 관리

## 사용 API 및 오픈 API

### **데이터베이스 연동**
- **Oracle JDBC**: 메인 데이터베이스 연결
- **MyBatis Mapper**: SQL 매핑 및 쿼리 관리
- **트랜잭션 관리**: Spring의 선언적 트랜잭션

### **파일 업로드**
- **MultipartFile**: 이미지 업로드 지원
- **Apache POI**: Excel 파일 데이터 처리
- **Commons IO**: 파일 처리 유틸리티

### **세션 관리**
- **HttpSession**: 사용자 세션 관리
- **Cookie**: 사용자 편의 기능
- **SessionUtil**: 커스텀 세션 유틸리티

## 프로젝트 특징

### **MVC 아키텍처**
- **Controller**: 웹 요청 처리 및 응답
- **Service**: 비즈니스 로직 처리
- **DAO**: 데이터 접근 계층
- **VO**: 데이터 전송 객체

### **모듈형 구조**
- **패키지별 기능 분리**: 각 도메인별 독립적인 개발
- **계층형 구조**: Controller → Service → DAO → Mapper 패턴
- **의존성 주입**: Spring IoC 컨테이너 활용

### **반응형 웹 디자인**
- **모바일 최적화**: 다양한 화면 크기 지원
- **사용자 친화적 UI**: 직관적인 네비게이션
- **필터링 시스템**: 효율적인 상품 검색

### **캠핑 특화 기능**
- **카테고리 시스템**: 캠핑용품 특화 분류
- **상품 비교**: 유사 상품 비교 기능
- **추천 시스템**: 인기 상품 및 추천 상품

## 프로젝트 구조

```
src/main/java/com/CamperX/
├── CamperXApplication.java     # 메인 애플리케이션
├── Header/                     # 헤더 공통 기능
│   ├── controller/
│   ├── dao/
│   └── service/
├── login/                      # 로그인 인증
│   ├── controller/
│   ├── dao/
│   └── service/
├── Mainpage/                   # 메인페이지
│   ├── controller/
│   ├── dao/
│   └── service/
├── productList/                # 상품 목록
│   ├── controller/
│   ├── dao/
│   ├── service/
│   └── productCart/            # 장바구니
├── productView/                # 상품 상세
│   ├── controller/
│   ├── dao/
│   └── service/
├── productOrder/               # 주문 관리
│   ├── controller/
│   ├── dao/
│   └── service/
├── Mypage/                     # 마이페이지
│   ├── controller/
│   ├── dao/
│   └── service/
├── util/                       # 유틸리티
│   ├── Constant.java
│   ├── DBConfiguration.java
│   └── SessionUtil.java
└── WebMvcConfig.java          # 웹 설정

src/main/resources/
├── application.properties      # 설정 파일
└── mapper/                     # MyBatis 매퍼
    ├── Header.xml
    ├── login.xml
    ├── Mainpage.xml
    ├── ProductList.xml
    ├── ProductView.xml
    └── productOrder.xml

src/main/webapp/
├── assets/                     # 정적 리소스
│   ├── css/                   # 스타일시트
│   ├── js/                    # JavaScript
│   ├── logo/                  # 로고 이미지
│   └── icon/                  # 아이콘
└── WEB-INF/jsp/               # JSP 페이지
    ├── common/                # 공통 JSP
    ├── login/                 # 로그인 페이지
    ├── mainpage/              # 메인페이지
    ├── productList/           # 상품 목록
    ├── productview/           # 상품 상세
    ├── productCart/           # 장바구니
    ├── productOrder/          # 주문 페이지
    └── mypage/                # 마이페이지
```

## 로드맵

### **Phase 1: 기본 플랫폼 구축**
- [x] 사용자 인증 시스템
- [x] 상품 카테고리 시스템
- [x] 장바구니 및 주문 기능
- [x] 반응형 웹 디자인
- [x] MyBatis 데이터베이스 연동

### **Phase 2: 기능 확장**
- [ ] **결제 시스템 통합**
  - PG사 연동 (토스페이먼츠, 카카오페이)
  - 결제 내역 관리
  - 환불/취소 처리

- [ ] **리뷰 시스템 고도화**
  - 상품 리뷰 및 평점
  - 이미지 리뷰 지원
  - 리뷰 신고 및 관리

- [ ] **알림 시스템**
  - 이메일 알림
  - SMS 알림
  - 푸시 알림 (웹)

### **Phase 3: 고급 기능**
- [ ] **추천 시스템**
  - AI 기반 상품 추천
  - 사용자 행동 패턴 분석
  - 개인화된 상품 추천

- [ ] **소셜 기능**
  - 상품 공유 기능
  - 위시리스트
  - 상품 비교 기능

- [ ] **모바일 앱**
  - React Native 기반 앱
  - 푸시 알림
  - 오프라인 모드

### **Phase 4: 비즈니스 확장** 
- [ ] **판매자 시스템**
  - 판매자 회원가입
  - 상품 등록 및 관리
  - 매출 관리

- [ ] **배송 추적**
  - 택배사 API 연동
  - 실시간 배송 추적
  - 배송 상태 알림

## 시작하기

### **필수 요구사항**
- Java 17 이상
- Oracle Database 11g 이상
- Maven 3.6 이상
- Tomcat 9.0 이상 (배포용)

### **설치 및 실행**

1. **저장소 클론**
```bash
git clone https://github.com/your-username/CamperX.git
cd CamperX
```

2. **데이터베이스 설정**
```properties
# application.properties
spring.datasource.hikari.jdbc-url=jdbc:oracle:thin:@localhost:1521:orcl
spring.datasource.hikari.username=c##CamperX
spring.datasource.hikari.password=11111111
```

3. **Maven 빌드**
```bash
mvn clean install
```

4. **애플리케이션 실행**
```bash
mvn spring-boot:run
```

5. **브라우저에서 접속**
```
http://localhost:8080
```

### **데이터베이스 스키마**
주요 테이블:
- `USER_INFO`: 사용자 정보
- `PRD_INFO`: 상품 정보
- `CATEGORY_INFO`: 카테고리 정보
- `CART_INFO`: 장바구니 정보
- `PRODUCT_ORDER_INFO`: 주문 정보
- `VENDER_INFO`: 벤더 정보

## 주요 API 엔드포인트

### **인증**
- `GET /camperX_loginId` - 로그인 ID 입력 페이지
- `POST /camperX/loginId` - 로그인 ID 확인
- `POST /camperX/loginPwd` - 로그인 비밀번호 확인
- `POST /camperX/signup` - 회원가입
- `POST /camperX/checkUserIdDuplicate` - 아이디 중복 확인

### **상품**
- `GET /camperX_productList` - 상품 목록
- `POST /camperX/getProductList` - 필터링된 상품 목록
- `GET /camperX_productView` - 상품 상세 정보
- `GET /camperX/getSubCategories` - 서브카테고리 조회

### **장바구니**
- `GET /camperX_cart` - 장바구니 페이지
- `POST /camperX/addToCart` - 장바구니 추가
- `GET /camperX/getCartCount` - 장바구니 개수 조회

### **주문**
- `GET /camperX_order` - 주문 페이지
- `POST /camperX/SaveOrder` - 주문 저장

### **마이페이지**
- `GET /camperX_mypage` - 마이페이지
- `POST /camperX/updateUserInfo` - 사용자 정보 수정

## 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

---
