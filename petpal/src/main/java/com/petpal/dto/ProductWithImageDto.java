package com.petpal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ProductWithImageDto{
	//상품(product) 필드
	private int productNo; // 상품번호
	private String categoryCode; // 카테고리코드
	private String productName; // 상품이름
	private int productPrice; // 상품가격
	private int productStock; // 상품수량
	private String productDesc; // 상품설명
	private Date productRegdate; // 상품등록일
	private int productDiscount; // 상품할인율
	private int productViews; //조회수
	private Integer attachmentNo;
	private String categoryParent;
	
	//이미지의 URL을 반환하는 메소드
	public String getImageURL() {
		if(attachmentNo == null) return "https://via.placeholder.com/150x150";
		else return "/attachment/download?attachmentNo="+attachmentNo;
	}
	

}
