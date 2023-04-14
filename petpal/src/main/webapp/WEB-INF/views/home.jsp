<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<title>Insert title here</title>
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>

    <style>
    *{
    	font-family: 카페24 써라운드 에어 가늘게;
    }
    footer {
	  position: ;
	  bottom: 0;
	  left: 0%;
	  transform: translateX(35%);
	}
    	.swiper{
    		width: 1160px;
    		heigth:250px;
    	}
        .swiper-slide>img{
            width: 100%;
            height: 400px;
        }
        hr{
            background-color: #D2DAFF ;
            height: 1px;
            border: 0;
        }
        label{
            font-family: 카페24 써라운드 에어 가늘게;
            font-size: 25px;
            font-weight: bolder;
        }
        .itme>a>img{
            width: 290px;
            height: 200px;
        }
        .itmeL>a>img{
            width: 590px;
            height: 200px;
        }
        label>span{
            color: #9091E6;
            font-size: 28px;
        }
        #box{
            border: 1px solid #D2DAFF;
            border-radius: 10px;
            width: 220px;
            height: 200px;
            padding:10px;
            margin-bottom:10px;
            /* background-color: #d2daff42; */
        }
        .flex-box.item{
            flex-direction: column;
            font-size: 15px;
            margin-bottom: 50px;
            width: 200px;
            height: 300px;
            flex-grow:2;
        }
        strong{
            color: #cc2424;
            font-size: 16px;
        }
        .form-btn{
            border: 2px solid #D2DAFF;
            border-radius: 25px;
            background-color: white;
            color: #9091E6;
            padding-left: 50px;
            padding-right: 50px;
        }
        del{
        	color:darkgray;
        }
        strong{
            color: #cc2424;
            font-size: 16px;
        }
    </style>

    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    
    <script type="text/javascript">
        //독립형 자바스크립트 템플릿
        window.addEventListener("load", function(){
            var swiper = new Swiper('.swiper', {
                // Optional parameters
                // direction: 'vertical',
                slidesPerView :'auto' ,
                loop: true,
                autoHeight : true,

                pagination: {
                    el: '.swiper-pagination',
                    type:'bullets',
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                autoplay:{
                    delay:3000
                },
                speed: 1000, // 슬라이드 전환 속도
                effect: 'slide', // 슬라이드 전환 효과
                // 슬라이드 전환 transition 설정
                slideTransition: {
                    // "ease", "linear", "ease-in", "ease-out", "ease-in-out" 등 사용 가능
                    // 기본값은 "ease" 입니다.
                    // 자세한 설정값은 Swiper API 문서를 참조하세요.
                    easing: 'ease',
                    // 슬라이드 전환 속도(ms)
                    speed: 1000
                }

            });
        });
        </script>
        
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <script type="text/javascript">
        $(function(){

        });
        
    </script>
</head>
<body>
	<div>
		<a href="${pageContext.request.contextPath}/shop/goods/goods_list?categoryCode=1010"></a>
		<a href="${pageContext.request.contextPath}/shop/goods/goods_list?categoryCode=3010"></a>
	</div>
            <div class="row ms-70"> 
                <!-- Slider main container -->
                <div class="swiper">
                    <!-- Additional required wrapper -->
                    <div class="swiper-wrapper">
                        <!-- Slides -->
                        <div class="swiper-slide"><img src="https://file.cafe24cos.com/banner-admin-live/upload/harimpetfood/a880bdaa-03e2-4da6-92bb-bf0d931b5d16.jpeg" alt=""></div>
                        <div class="swiper-slide"><img src="https://file.cafe24cos.com/banner-admin-live/upload/harimpetfood/fe10f57a-098c-4ac1-91bd-7aef32040c4a.jpeg" alt=""></div>
                        <div class="swiper-slide"><img src="https://file.cafe24cos.com/banner-admin-live/upload/harimpetfood/e3cbad86-c965-463c-e9b0-bf895be695d3.jpeg" alt=""></div>
                        <div class="swiper-slide"><img src="https://file.cafe24cos.com/banner-admin-live/upload/harimpetfood/c0fab775-86a7-4081-c48d-3ebfb0f001c8.jpeg" alt=""></div>
                    </div>
                    <!-- If we need pagination -->
                    <div class="swiper-pagination"></div>
                    
                    <!-- If we need navigation buttons -->
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>
            </div>
            
            <div class="row left">
                <label></label>
            </div>
            <br>

	<div class="container-1100">
            <div class="row flex-box ms-80">
            <c:forEach items="${list}" var="list">
            
                <div class="me-20 flex-box item ">
                <a href="${pageContext.request.contextPath}/product/detail?productNo=${list.productNo}">
                    <img src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${list.attachmentNo}" id="box">
                    <span>${list.productName}</span>
                </a>               
                <span style="color: red">${list.productDiscount}%
                    <del>${list.productPrice}</del>
                </span>
                    <strong class="price">
                    <span>   
                    <fmt:formatNumber value="${list.productPrice *  (100-list.productDiscount) / 100}"/>원
                    </span>
                    </strong>
                </div>
            
            </c:forEach>   
 
         </div>
                
         <h1>CI/CD 변경을 환영합니다</h1>
      
            <div class="row flex-box ms-80">
            <c:forEach items="${list2}" var="list">
                <div class="me-20 flex-box item ">
                 <a href="${pageContext.request.contextPath}/product/detail?productNo=${list.productNo}">
                     <img src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${list.attachmentNo}" id="box">
                    <span>${list.productName}</span>
                </a>
                <span style="color: red">${list.productDiscount}%
                    <del>${list.productPrice}</del>
                </span>
                    <strong class="price">
                    <span>
                    <fmt:formatNumber value="${list.productPrice *  (100-list.productDiscount) / 100}"/>원           
                    </span>
                    </strong>
                </div>
            </c:forEach>
             
      </div>

      </div>

               
            <br>
            <br>
            <br>
            <!-- 
            <div class="row left mt-30">
                <img src="img/logo2.png" width="100" style="margin-bottom: -10px;">
                <label><span class="ms-10">펫팔</span>의 기분좋은 혜택</label>
                <hr class="mb-30">
            </div>
            <div class="row flex-box" style="width: 200px; height: 200px;">
                <img class="me-40" src="img/01.PNG">
                <img class="me-40"src="img/02.PNG">
                <img class="me-40"src="img/03.PNG">
                <img class="me-40"src="img/04.PNG">
            </div>
             -->
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

