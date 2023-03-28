<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="container-800">
<div class="row center">
	<h1>상품 정보 변경</h1>
</div>
<div class="row">
	<form action="edit" method="post">
		<input type="hidden" name="productNo" value="${productDto.productNo }">
		<table style="margin-left:auto; margin-right:auto;">
			<tbody>
				<tr>
					<th>카테고리 번호<th>
					<td>
						<input type="text" name="categoryCode" value="${productDto.categoryCode}">
					</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td>
						<input type="text" name="productName" value="${productDto.productName}">
					</td>
				</tr>
				<tr>
					<th>상품 상세설명</th>
					<td>
						<input type="text" name="productDesc" value="${productDto.productDesc}">
					</td>
				</tr>
				<tr>
					<th>상품가격</th>
					<td>
						<input type="text" name="productPrice" value="${productDto.productPrice }">
					</td>
				</tr>
				<tr>
					<th>상품재고</th>
					<td>
						<input type="text" name="productStock" value="${productDto.productStock }">
					</td>
				</tr>
				<tr>
					<th>상품할인률</th>
					<td>
						<input type="text" name="productDiscount" value="${productDto.productDiscount }">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<button>수정</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>