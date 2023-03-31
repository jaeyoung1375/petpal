package com.petpal.dto;



import java.sql.Date;

import lombok.Data;

@Data
public class SalesDto {
	
	private Date orderDate;
	private int productCount;
	private int productPrice;
	private long total;
	private String receiverName;
	private String receiverBasicAddr;
	private String receiverPost;
	private String receiverDetailAddr;
	private String receiverTel;
	private String productName;
	
	
	
	
	
}
