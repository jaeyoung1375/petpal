<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="container-1100 center">
    	<div class="row">
    		<h3>상품 목록</h3>
    	</div>
    	<!-- 상품 목록 테이블 -->
        <div class="row container-1200">
            <table class="table table-border">
                <thead>
                    <tr>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>가입일</th>
                        <th>등급</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach items="${memberList}" var="list">
	                    <tr class="center">
	                        <td>${list.memberId}</td>
	                        <td>${list.memberName}</td>
	                        <td>${list.memberRegdate}</td>
	                       	<td>
	                       		<c:if test="${list.adminCk == 1 }"> 관리자 </c:if>
                  				<c:if test="${list.adminCk == 0 }"> 일반회원 </c:if>
	                       	</td>
	                        <td>
	                        	<a class="link" href="detail?memberId=${list.memberId}">상세</a>
	                        	<a class="link" href="edit?memberId=${list.memberId}">수정</a>
	                        	<a class="link" href="delete?memberId=${list.memberId}">탈퇴</a>
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
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>