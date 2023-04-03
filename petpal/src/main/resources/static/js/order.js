$(function(){

            //주소 
            $(".btn-post").click(function(){
                       
                new daum.Postcode({ //new는 객체를 만드는 함수
                    oncomplete: function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수

                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.querySelector("[name=receiveZipcode]").value = data.zonecode;
                        document.querySelector("[name=receiveAddress]").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.querySelector("[name=receiveAddressSub]").focus();
                    }
                    }).open();
            
        });
         


            //휴대폰 번호 인증
            var code2 = "";
            $("#phoneChk").click(function(){
            alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");
            var phone = $("#phone").val();   
            
            
            $.ajax({   
                    type:"GET",
                    url:"/member/phoneCheck?phone=" + phone,
                    cache : false,
                    success:function(data){
                    
                    console.log(data);
                    
                    $("#phone2").on("propertychange change keyup paste input",function(){
                        var phone2 = $("#phone2").val();
                        console.log(phone2);
                        
                        if(data == phone2){
                            $(".successPhoneChk").text("올바른 번호입니다.");
                            $(".successPhoneChk").css("color","green");
            
                        }else{
                            $(".successPhoneChk").text("유효한 번호를 입력해주세요.");
                            $(".successPhoneChk").css("color","red")
                        }
                    });
                    
                
                    
                    }
                });
            });
        
            //내용 삭제
            $(".btn-clear1").click(function(){
                $("#phone").val("");
            })           
            $(".btn-clear2").click(function(){
                $("#phone2").val("");
            })           
            $(".btn-clear3").click(function(){
                $("#receive-name").val("");
            })           
            $(".btn-clear4").click(function(){
                $("#receive-tel").val("");
            })           
            $(".btn-clear5").click(function(){
                $("#receive-address-detail").val("");
            })    
            
            //수령인 미 입력시 문구 나오게 하기
            $("[name=receiveName]").blur(function(){
                var isValid = $(this).val().length>0;
                if(!isValid){
                    $("[name=txt-p1]").show().css("display");
                }else{
                    $("[name=txt-p1]").hide().css("display");
                }
            });
            //휴대폰 번호 미 입력시 문구 나오게 하기
                $("[name=receiveMobile]").blur(function(){
                    var isValid = $(this).val().length>0;
                    if(!isValid){
                        $("[name=txt-p2]").show().css("display");
                    }else{
                        $("[name=txt-p2]").hide().css("display");
                    }
                });
            //상세주소 미 입력시 문구 나오게 하기
            $("[name=receiveAddressSub]").blur(function(){
                var isValid = $(this).val().length>0;
                if(!isValid){
                    $("[name=txt-p3]").show().css("display");
                }else{
                    $("[name=txt-p3]").hide().css("display");
                }
            });
            //

    });  