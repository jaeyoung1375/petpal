<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>



<div class="container-800">
	<div class="row center">
		<h2>${memberDto.memberNick}님의 개인 프로필</h2>
	</div>
    
	<div class="row">
		<table class="center">
			<tbody>
				<tr>
					<th>아이디</th>
					<td>${memberDto.memberId }</td>				
				</tr>
				<tr>
					<th>이름</th>
					<td>${memberDto.memberName }</td>				
				</tr>
				<tr>
					<th>닉네임</th>
					<td>${memberDto.memberNick }</td>				
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${memberDto.memberTel }</td>				
				</tr>
				<tr>
					<th>이메일</th>
					<td>${memberDto.memberEmail }</td>				
				</tr>
				<tr>
					<th>등급</th>
					<td>
						<c:if test="${memberDto.adminCk == 1 }"> 관리자 </c:if>
                  		<c:if test="${memberDto.adminCk == 0 }"> 일반회원</c:if>				
					</td>				
				</tr>
				<tr>
					<th>가입일</th>
					<td>
						<fmt:formatDate value="${memberDto.memberRegdate}"
										pattern="y년 M월 d일 E a h시 m분 s초"/> 
					</td>				
				</tr>
				<tr>
					<th>주소</th>
					<td>[${memberDto.memberPost }]</td>				
					<td>${memberDto.memberBasicAddr }</td>
					<td>${memberDto.memberDetailAddr }</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="row right">
		<!-- 회원 관리 메뉴 -->
		<h2><a class="link" href="edit?memberId=${memberDto.memberId }">개인정보 변경</a></h2>
		<h2><a class="link" href="password?memberId=${memberDto.memberId}">일회용 비밀번호 설정</a></h2>
		<h2><a class="link" href="delete?memberId=${memberDto.memberId}">회원 강제 탈퇴</a></h2>
		<h2><a class="link" href="list">목록 보기</a></h2>
	</div>

</div>


<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>