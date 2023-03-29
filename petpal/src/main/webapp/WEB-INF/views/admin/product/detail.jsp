<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="container-1200">
	<div class="row center">
		<h2>${productDto.productName}</h2>
	</div>
	<div class="row center mt-30">
		${productDto.productDesc }
		<img src="${productDto.imageURL}">
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>
