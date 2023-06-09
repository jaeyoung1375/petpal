<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/order.css">


   <!-- 결제 api -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
   <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
   
   
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
    <script src="${pageContext.request.contextPath}/static/js/cart.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/order.js"></script>
   
    <!-- 우편cdn -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   

<script type="text/javascript">
      
   var unitBuyerTel = false;
   var unitBuyer = false;
   var unitAgree = false;
   var unitReceiveTel = false;
   var unitDetail = false;

      $(function(){
         //체크박스 누르면 수령인,전화번호 불러오기(findDto때문에 여기에다가 작성)
         $("[name=order_copy]").change(function(){
               var txt = "";
               var vailName = "${findDto.memberName}";
               var vailTel = "${findDto.memberTel}";
               var vailPost = "${findDto.memberPost}";
               var vailBasicAddr = "${findDto.memberBasicAddr}";
               var vailDetailAddr = "${findDto.memberDetailAddr}";
               
               var receiverName =  $("input[name=receiverName]");                 
               var receiverTel =  $("input[name=receiverTel]");
               var receiverPost =  $("input[name=receiverPost]");
               var receiverBasicAddr =  $("input[name=receiverBasicAddr]");
               var receiverDetailAddr =  $("input[name=receiverDetailAddr]");
           
               
      
               var txt2 = $("[name=order_copy]").prop("checked");
      
               if(!txt2){ //체크박스에 체크가 되지 않았을때
                   $(receiverName).val(txt); //$()값은 값이 비어있다.
                   $(receiverTel).val(txt);
                   $(receiverPost).val(txt);
                   $(receiverBasicAddr).val(txt);
                   $(receiverDetailAddr).val(txt);
                   
                   unitBuyer = false;
                   unitDetail = false;
                   unitReceiveTel = false;
                   unitPost = false;
                   

               }else {//체크되었을때
               			
            	   if ($(receiverName).val() === '') {
                       $(receiverName).val(vailName);
                       unitBuyer = true;
                   }
                   if ($(receiverTel).val() === '') {
                       $(receiverTel).val(vailTel);
                       unitReceiveTel = true;
                   }
                   if ($(receiverPost).val() === '') {
                       $(receiverPost).val(vailPost);
                       unitPost = true;
                   }
                   if ($(receiverBasicAddr).val() === '') {
                       $(receiverBasicAddr).val(vailBasicAddr);
                   }
                   if ($(receiverDetailAddr).val() === '') {
                       $(receiverDetailAddr).val(vailDetailAddr);
                       unitDetail = true;
                   }
               }
           });
                        
     		
               
              
               
              // 할인 전 최종 금액        
               var totalPrice = 0;
                 var count = 0; //상품의 총 갯수를 위해 변수 선언
               $(".p").each(function(){
                  var productPrice = parseInt($(this).parent().find("#basicPrice").val());
                  var productCount = parseInt($(this).parent().find("#productCount").val());
                   totalPrice += productPrice;
                   count += parseInt($("#productCount").val());
                   
               });
               count -=1 ; //상품 외 -개
               
               var disCountPrice = $("#disCountPrice").val();
               $("#totalBasicPrice").text(totalPrice.toLocaleString()+"원");
               
               // 할인 후 최종 금액
               var discountTotalPrice = 0;
               $(".p").each(function(){
                  var productPrice = parseInt($(this).parent().find("#salePrice").val());
                  var productCount = parseInt($(this).parent().find("#productCount").val());
                  discountTotalPrice += productPrice;
               });
               $("#realTotalPrice").text(discountTotalPrice.toLocaleString()+"원");
               
               //hidden totalprice에 가격 넣어주기
               $("#totalPrice").val(discountTotalPrice);
               
               // 할인 금액
               $("#discountval").text((totalPrice- discountTotalPrice).toLocaleString()+"원");
            
                
        
                  
          
             //카카오페이 api    
               const IMP = window.IMP; // 생략 가능
             IMP.init("imp55345065");  // 예: imp00000000a
           
             var name = $("#productName").val(); //상품이름 변수로 선언
      
        
          //카카오 api (추후에 결제하기버튼을 누를때 호출하기위해 함수를 만들어줌)
          function kakao1() {
         

            
          // IMP.request_pay(param, callback) 결제창 호출
          IMP.request_pay({ // param
              pg: "kakaopay",
              pay_method: "card",
              merchant_uid : 'merchant_' + new Date().getTime(),
              name: name +" "+ count +"개 외",   //필수 파라미터 입니다.
              amount: parseInt(discountTotalPrice), //숫자타입
              buyer_email : 'iamport@siot.do1',
              buyer_name : '구매자이름',
              buyer_tel : '010-1234-5678',
              buyer_addr : '서울특별시 강남구 삼성동',
              buyer_postcode : '123-456'
          }, function (rsp) { // callback
              if (rsp.success) { 
                
               $("#jb-form").submit();   
                  // 결제 성공 시 로직,
              
              } else {
            	  unitAgree=false;
                 var msg = '결제에 실패하였습니다.';

                  // 결제 실패 시 로직,

              }

     
         }); 
      }

          
          
   //   //console.log(productName[0].val());    
      
      
            

        
         //1.인증번호 입력창이 null, 4자리가 확인 후 출력
            $("[name=phone2]").blur(function(){
                
                //this == 인증번호 입력창
                
                var number = $(this).val();
                
                if(number.length==0){//null일때
                    unitBuyerTel =false;
                  
                }else if(number.length==4){
                    unitBuyerTel = true;
                }
                
                
                
            })
          //2. 수령인 한글or영어 정규표현식 검사,null
            //수령인 미 입력시 문구 나오게 하기
            $("[name=receiverName]").blur(function(){
               var check = $(this).val();
                var isValid = $(this).val().length>0;
                var memberRegex = /^[가-힣a-zA-Z]+$/;
                var isOk = memberRegex.test(check);
                
                //console.log(isOk);
                
            //    //console.log(!isOk);
                if(!isValid){
                    $("[name=txt-p1]").show().css("display");
                    unitBuyer = false;
                }else if(!isOk){
                   $("[name=txt-p1-2]").show().css("display");
                   unitBuyer = false;
                
                }
                else{
                    $("[name=txt-p1]").hide().css("display");
                    $("[name=txt-p1-2]").hide().css("display");
                    unitBuyer = true;
                    
                }
            });
         
            
         
        
        //5.상세주소 null, 한글 글자 입력
         //상세주소 미 입력시 문구 나오게 하기
            $("[name=receiverDetailAddr]").blur(function(){
                var isValid = $(this).val().length>0;
                var check = $(this).val();
                var regex = /^[a-zA-Z0-9가-힣-]+$/;
                var isOk = regex.test(check);
   
                if(!isValid){
                    $("[name=txt-p5]").show().css("display");
                    unitDetail = false;
                }else if(!isOk){
                   $("[name=txt-p5-2]").show().css("display");
                   unitDetail = false;
                }else{
                	$("[name=txt-p5]").hide().css("display");
                    $("[name=txt-p5-2]").hide().css("display");
                    unitDetail = true; // 유효성 검사 통과
                }
               
            });
		
            
          //휴대폰 번호 미 입력시 문구 나오게 하기
            $("[name=receiverTel]").blur(function(){
                var isValid = $(this).val().length>0;
              
                var phone = $(this).val().length>11&& $(this).val().length<11;
                
                 
                 
                if(!isValid){
                    $("[name=txt-p2]").show().css("display");
                    $("[name=txt-p3]").hide().css("display");
                     unitReceiveTel = false;
                }else if(isValid){
                    $("[name=txt-p2]").hide().css("display");
                    $("[name=txt-p3]").hide().css("display");
                    unitReceiveTel = true;
                }else if(!phone){
					$("[name=txt-p3]").show().css("display");
					$("[name=txt-p2]").hide().css("display");
					unitReceiveTel = false;
				}else{
					$("[name=txt-p3]").hide().css("display");
					$("[name=txt-p2]").hide().css("display");
					unitReceiveTel = true;
				}
            });
       

          
         
         
           //결제하기 버튼을 누르면 form안에있는 데이터들이 컨트롤러로 넘어가게 되서 실제로 등록이된다.
            // 아래 코드와 겹쳐서 주석 처리하고 아래코드와 합침 $( '#jb-form' ).submit();

        //   $( '#submitSettleBtn' ).click( function() {
        //     $( '#jb-form' ).submit();
       //    });
      $("#submitSettleBtn").click(function(e){ //우선 버튼을 못 누르게 막아둠
          e.preventDefault();
          var checkBox = $("#puchase-ok").is(":checked");

          if(checkBox){
        	  unitAgree = true;
           }else{
              alert("개인정보 제3자 제공 동의 체크 해주세요")
              unitAgree = false;
           }

          var isAll = unitBuyerTel && unitBuyer && unitAgree && unitReceiveTel && unitDetail;
       
         if(isAll){
            var kakao = $("#payment-kakao").is(":checked");
              
               var checkBox = $("#puchase-ok").is(":checked");
                                 
               if(kakao){
                  kakao1();
               }
               else{
                  alert("결제 선택해주세요");
               }
               
               
            
         }else{
            e.preventDefault();
         }
      })
 
      });    
      
   
   

      
         

</script>

  <!-- 우편cdn -->
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 
 
<div class="container-1000" style="font-family: '카페24 써라운드 에어';">
    <div id="pay-step" class="order">
            <h1 id="logo">
            	
                <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/static/image/petpallong.png" width="100"></a>
                <sub style="top: 33px; left: auto; right: 0; color: #9091E6; font-weight: 500; margin-left:10px;">강아지용폼 전문몰 펫팔</sub>
            </h1>
            <div class="step-location">
                <ul style="margin-left: 70px;">
                    <li class="step01" style="padding-left: 60px;">
                        <sup>01</sup>
                        장바구니
                    </li>
                    <li class="step02">
                        <sup>02</sup>
                        주문/결제
                    </li>
                    <li class="step03">
                        <sup>03</sup>
                        결제완료
                    </li>
                </ul>
            </div>
             
           
                <div id="contents">
         <form id="jb-form" action="order" method="post">
                    <div class="sec">
                        <h2>주문내역</h2>
                        <div class="bundle__retail" data-componet="bundleInfo-retail">
                            <div class="bundle-info__pdd-group-box">
                                <div class="bundle-info__expected-delivery-date-box">
                                   <span class="bundle-info__expected-delivery-info">
                                    도그팡 배송
                                   </span> 
                                </div>
                            <div class="bunle-info__item-list">
                            <c:forEach items="${cartList}" var="list" varStatus="status">
                                <div class="bundle-info__vendor-tiem-box">
                                    <div style="position: absolute;">
                                        <img src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${list.attachmentNo}"
                                         height="50px">
                                         
                                    </div>
                                    <div class="bundle-info__vendor-item" style="padding-left: 50px;width: 100%;">
                                        <p class ="p">
                                            <span class="bundle-info__vendor-item__offer-condition">${list.productName} ${list.initSaleTotal()}</span>
                                            <br>
                                            <span>수량 : ${list.productCount}개<br>가격 : ${list.productCount*list.salePrice}</span>
                                            <input type="hidden" value="${list.productCount*list.productPrice}" id="basicPrice">
                                            
                                            <!-- public List<OrderDetailDto> orderDetailDto 를 화면에서 불러올수있는 코드 // varStatus="status" //이친구들을 날릴꺼면 form태그안에 생성-->
                                            <input type="hidden" name="orderDetailDto[${status.index}].productPrice" value="${list.productCount*list.salePrice}" id="salePrice">
                                            <input type="hidden" name="orderDetailDto[${status.index}].productCount"  value="${list.productCount}" id="productCount">
                                            <input type="hidden" name="orderDetailDto[${status.index}].productNo"  value="${list.productNo}" id="productNo">
                                            
                                            <input type="hidden" value="${totalPrice}" id="disCountPrice">
                                            <input type="hidden" value="${list.productName}" id="productName">
                                              <!-- input type hidden으로 하면 j쿼리에서도 값을 불러와서 사용가능(값을불러와서 변수로 넣고 사용해야함) -->
                                           
                                            <c:set var="productName" value="${list.productName}"/>
                                             <c:set var="totalPrice" value="${totalPrice+list.totalPrice}"/> 
                                            <c:set var="basicPrice" value="${productPrice+list.totalBasicPrice}"/>
                                            <c:set var="salePrice" value="${(productPrice+list.totalBasicPrice)-(totalPrice+list.totalPrice)}"/> 
                                          <!-- c태그 set으로 var로 변수를 넣으면 jsp에서만 불러와서 사용가능 -->
                                        </p>
                                    </div>
                                    <div class="bundel-info__delivery-service" style="padding-left: 50px;width: 100%;"></div>
                                    <div class="bundle-info__item-description" style="padding-left: 50px; width: 100%;"></div>
                                </div>
                             </c:forEach>       
                            </div>
                            </div>
                            <div class="bunle-info__item-list"></div>
                        </div>
                        <div class="bundle-info__bdd-group-title"></div>
                        <div></div>
                        <div></div>

 
                    </div>
             
                    <!-- 구매자 정보 div -->
                    <div class="sec">
                        <h2 class="tit type02">
                            <b>구매자 정보</b>
                        </h2>
                        <div class="sec type03">
                            <div class="inp-wrap val type03">
                                <strong>이름</strong>
                            <span class="val" id="order-name">${findDto.memberName}</span>
                            </div>
                            <div class="inp-wrap val type03">
                                <strong>이메일</strong>
                                <span class="val" id="order-email">${findDto.memberEmail}</span>
                            </div>
      
                            <div class="inp-wrap type03 btn-add wide">
                                <strong>휴대폰</strong>
                                <span class="val">
                                    <span class="num" id="member_tel">휴대폰 번호를 입력해주세요</span>
                                </span>
                                <div class="row" id="rowbtn1" style="margin-top:0px;">
                                    <input type="tel" name="memberTel" class="form-input w-60" readonly value="${findDto.memberTel}" id="phone" placeholder="대시(-)를 제외하고 작성" style="width:200px; height:35px; border:1px solid #ddd;">
                                    <div class="invalid-message">올바른 휴대전화번호가 아닙니다</div>
                                    <button type="button" class="form-btn positive w-30 ms-50" id="phoneChk" style="margin-left:30px">번호인증</button>
                                 </div>
                                 <div class="row" id="rowbtn2" style="margin-top:40px;">
                                 <input id="phone2" type="text"  class="form-input w-100"  name="phone2" placeholder="인증번호 입력"  required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
                                 <button id="btnC2" type="button" class="btn-clear2"></button>  
                                 <span class="point successPhoneChk" name="phonecheck" style="display: none; color:#145eaa;">인증번호 4자리를 입력 해주십시오.</span>
                                 <span class="point successPhoneChk" name="phonecheck2" style="display: none; color:#145eaa;">올바른 번호입니다.</span>
                                 </div>
                            </div>

                        </div>
                    </div>
                    
                     <!-- 받는사람 정보 div -->
              
                    <form action="order" method="post">
                    
              
                    <div class="sec">
                        <h2 class="tit type02">
                            <b>받는사람 정보</b>
                        </h2>
                        <div class="sec type03" id="rowbtn3">
                            <input type="checkbox" id="order_copy" name="order_copy" style="margin-left: 127px; margin-bottom: 2px;">
                            구매자 정보 동일
                            <button type="button" id="delivery-page" class="val-type type10" style="margin-left: 10px;margin-bottom: 2px;"></button>
                            
                            <div class="inp-wrap type03" id="row-btnC3">
                                <label for="receive-name">수령인</label>
                                <input type="text" name="receiverName" id="receive-name" style="margin-bottom: 10px;" required>
                                <button id="btnC3" type="button" class="btn-clear3" style="left: 480px;"></button>
                            </div>
                            <p id="receive-name-txt" class="warning-txt" name="txt-p1" style="margin-top: -2px;">수령인을 입력해주세요.</p>
                            <p id="receive-name-txt" class="warning-txt" name="txt-p1-2" style="margin-top: -2px;">한글 또는 영어로 입력해주세요</p>


                            <div class="inp-wrap type03" id="row-btnC4">
                                <label for="receive-tel">휴대폰</label>
                                <input type="tel" name="receiverTel" id="receive-tel" value="" style="margin-bottom: 10px;" size="11" maxlength="11" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                <button id="btnC4" type="button" class="btn-clear4" style="left: 480px;"></button>
                            </div>
                            <p id="receive-tel-txt" class="warning-txt" name="txt-p2">휴대폰 번호를 입력해주세요.</p>
                            <p id="receive-tel-txt" class="warning-txt" name="txt-p3">잘못된 입력형식입니다. 다시 입력해주세요</p>
     
                            <div class="inp-wrap type03 btn-add" id="row-btn6">
                                <label for="receive-address-num">우편번호</label>
                                <input type="text" name="receiverPost" id="receive-address-num" required value="" readonly="readonly" style="margin-bottom: 10px; background: rgb(246, 246, 246);" onclick="javascript:zipcode_click_search();">
                                <button type="button" class="btn-post" id="zipcode_search">우편번호 찾기</button>
                            </div>
                    
                            <div class="inp-wrap type03">
                                <label for="receive-address">주소</label>
                                <input type="text" name="receiverBasicAddr" id="receive-address" required value=""readonly="readonly" style="margin-bottom: 10px; background: rgb(246, 246, 246);" onclick="javascript:zipcode_click_search();">
                            </div>
                    
                            <div class="inp-wrap type03" id="row-btnC5">
                                <label for="receive-address-detail">상세주소</label>
                                <input type="text" name="receiverDetailAddr" id="receive-address-detail" value="" required>
                                <button  id="btnC5" type="button" class="btn-clear5" style="left: 480px;"></button>
                            </div>
                            <p id="receive-address-detail-txt" class="warning-txt" name="txt-p5">상세주소를 입력해주세요.</p>
                            <p id="receive-address-detail-txt" class="warning-txt" name="txt-p5-2" >한글 또는 영어로 입력해주세요</p>
                    
                        </div>
                        
                        
                    </div>
                    
            



                   
               
                    <div class="sec">
                        <h2 class="tit type02">
                            <b>결제금액</b>
                        </h2>

                        <div class="sec type03">
                            <div class="inp-wrap type03">
                                <strong>총 상품가격</strong>
                                <span class="val" name="totalPrice1" id="totalBasicPrice" ></span>
                                
                            </div>
                            <div class="inp-wrap type03">
                                <strong>할인금액</strong>
                                <span class="val" id="discountval" style="color:red;"></span>
                            </div>
                            <div class="inp-wrap type03">
                                <strong>배송비</strong>
                                <span class="val">무료</span>
                            </div>
                            <div class="inp-wrap type03" style="margin-top: 20px;">
                                <strong>
                                    <b>총 결제금액</b>
                                </strong>
                                <strong class="val malgun" id="realTotalPrice"></strong>
                                <input type="hidden" id="totalPrice" name="totalPrice" value="0">
                            </div>
                        </div>
                       
   
                        <div class="sec">
                            <h2 class="tit type02">
                                <b>결제 수단</b>
                            </h2>
                            <div class="sec type03" >
                                <div class="inp-wrap type03" style="width: 100%;">
                                    <label>결제</label>

                                    <div class="chk-wrap" style="margin-top: 3px; margin-left: 10px; font-size: 13px;">
                                        <input type="radio" id="payment-kakao" name="order-payment" value="KAKAO" style="display:none;"  checked="checked">
                                        <label for="payment-kakao"  class="kakaoBtn">카카오페이</label>
                                        <img src="${pageContext.request.contextPath}/static/image/kakaopay.png" style="height: 13px; border-radius: 10px 10px 10px 10px;" >
                                    </div>

                                    
                                </div>
                            </div>
                        </div>
                        <div class="term-pay-wrap" style="margin-top: 30px;">
                            <h2 class="tit type02" style="margin-left: 5px;">
                                <b>개인정보 제3자 제공 동의</b>
                            </h2>
                            <div class="sec type03 scroll-wrap" style="margin-top: 8px;">
                                <ol>
                                    <li>
                                        <strong>
                                            회원의 개인정보는 당사의 개인정보취급방침에 따라 안전하게 보호됩니다.
                                        </strong>
                                        <ul>
                                            <li>(주)펫팔은 이용자들의 개인정보를 "개인정보 취급방침의 개인정보의 수집 및 이용목적"에서 고지한 범위 내에서 사용하며, 
                                                이용자의 사전 동의 없이는 동 범위를 초과하여 이용하거나 원칙적으로 이용자의 개인정보를 외부에 공개하지 않습니다.
                                            </li>
                                            <li>
                                                (주)펫팔이 제공하는 서비스를 통하여 주문 및 결제가 이루어진 경우 구매자 확인 및 해피콜 등 
                                                거래이행을 위하여 관련된 정보를 필요한 범위 내에서 거래 업체에게 제공합니다.
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <strong>
                                            * 동의 거부권 등에 대한 고지
                                        </strong>
                                        <p>개인정보 제공은 서비스 이용을 위해 꼭 필요합니다. 개인정보 제공을 거부하실 수 있으나,
                                            이 경우 서비스 이용이 제한될 수 있습니다.
                                        </p>
                                    </li>
                                </ol>
                            </div>
                            <div class="chk-wrap">
                                <input type="checkbox" id="puchase-ok" style="display:none;" required>
                                <label for="puchase-ok">
                                    본인은 개인정보 제3자 제공 동의에 관한 내용을 모두 이해하였으며 이에 동의합니다.
                                </label>
                            </div>
                        </div>
                        <span></span>
                    </div>
                    <div class="btn-area">
                   
                        <button class="btn-type size04 size05 ico-ok" id="submitSettleBtn" style="border-radius: 3px;" type="submit">
                            <b>결제하기</b>
                        </button>
                 
                    </div>
                </div>
              </form>
      
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>