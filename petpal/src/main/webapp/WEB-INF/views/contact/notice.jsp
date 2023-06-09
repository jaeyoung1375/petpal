<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/commons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/contact/notice.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<style>
#top {
  margin-top: 50px;
}
</style>
</head>
<body>

 <div class="container-900" id="top">
       <div class="row-menu">
            <div class="row-menu-title">
                <h3>  </h3>
            </div>
            
            
       </div>
       <div class="header_search ">
            	<form action="${pageContext.request.contextPath}/contact/notice" method="get">
				<c:choose>
					<c:when test="${vo.column == 'board_content'}">
						<select name="column" class="keyword_search">
							<option value="board_title">제목</option>
							<option value="board_content" selected>내용</option>
							<option value="board_writer">작성자</option>	
						</select>
					</c:when>
					<c:when test="${vo.column == 'board_writer'}">
						<select name="column" class="keyword_search">
							<option value="board_title">제목</option>
							<option value="board_content">내용</option>
							<option value="board_writer" selected>작성자</option>	
						</select>
					</c:when>
					<c:otherwise>
						<select name="column" class="keyword_search">
							<option value="board_title" selected>제목</option>
							<option value="board_content">내용</option>
							<option value="board_writer">작성자</option>
						</select>
					</c:otherwise>
				</c:choose>
				
                <div class="top_search">
                    <input type="search" class="input_search" name="keyword" placeholder="검색어를 입력하세요.">
                    <button type="submit" class="btn_top_search" id="btnTopSearch"><i class="fas fa-search fa-lg"></i></button>   
                </div>
                </form>
            </div>
       <div class="row table">
            <table style="width: 900px;">
                <colgroup>
                    <col style="width:80px">
                    <col style="width:auto">
                    <col style="width:120px">
                </colgroup>
                <tbody>
                	<c:forEach items="${noticeList}" var="list">
                	 <tr>
                        <td class="text-center">${list.boardNo}</td>
                        <td class="text-left">
                        <a href="${pageContext.request.contextPath}/noticeDetail?boardNo=${list.boardNo}">${list.boardTitle}</a></td>
                        <td class="text-center">${list.boardDate}</td>
                    </tr>
                	</c:forEach>                           
                </tbody>
            </table>
       </div>

       	<!-- 페이징 영역 -->
		<div class="page_wrap">
			<div class="page_nation">
				<c:if test="${vo.startBlock != 1}">
				<a class="arrow prev" href="${pageContext.request.contextPath}/contact/notice?page=${vo.prevPage}">&lt;</a>
				</c:if>
					<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
						<a href="${pageContext.request.contextPath}/contact/notice?page=${i}">${i}</a>
					</c:forEach>
				<c:if test="${vo.page != vo.totalPage}">
				<a class="arrow next" href="${pageContext.request.contextPath}/contact/notice?page=${vo.nextPage}">&gt;</a>
				</c:if>
			</div>
		</div>
	
    </div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
