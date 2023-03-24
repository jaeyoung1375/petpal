<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록 페이지</title>
<link rel="stylesheet" href="/static/css/commons.css">
<link rel="stylesheet" href="/static/css/contact/notice.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet" href="/static/css/test.css">
</head>

<body>
    <div class="container-1100 center">
    	<div class="row">
    		<h3>상품 목록</h3>
    	</div>
    	<!-- 상품 목록 테이블 -->
        <div class="row">
            <table class="table table-border">
                <thead>
                    <tr>
                        <th>상품 번호</th>
                        <th>카테고리 번호</th>
                        <th>상품 이름</th>
                        <th>상품 가격</th>
                        <th>상품 재고</th>
                        <th>상품 설명</th>
                        <th>상품 등록일</th>
                        <th>상품 할인률</th>
                        <th>상품 조회수</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach items="${productList}" var="list">
	                    <tr class="center">
	                        <td >${list.productNo}</td>
	                        <td>${list.categoryCode}</td>
	                        <td>${list.productName}</td>
	                        <td>${list.productPrice}원</td>
	                        <td>${list.productStock}개</td>
	                        <td>${list.productDesc}</td>
	                        <td>${list.productRegdate}</td>
	                        <td>${list.productDiscount}</td>
	                        <td>${list.productViews}</td>
	                        <td>
	                        	<a href="edit?productNo=${list.productNo}">수정</a>
	                        	<a href="delete?productNo=${list.productNo}">삭제</a>
	                        </td>
	                    </tr>
                		
                	</c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- 페이징 영역 -->
		<div class="page_wrap">
			<div class="page_nation">
				<c:if test="${vo.startBlock != 1}">
				<a class="arrow prev" href="list?page=${vo.prevPage}">&lt;</a>
				</c:if>
					<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
						<a href="list?page=${i}">${i}</a>
					</c:forEach>
				<c:if test="${vo.page != vo.totalPage}">
				<a class="arrow next" href="list?page=${vo.nextPage}">&gt;</a>
				</c:if>
			</div>
		</div>
       
    </div>
</body>
</html>