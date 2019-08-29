<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Concept - Bootstrap 4 Admin Dashboard Template</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css">
    <link href="/resources/assets/vendor/fonts/circular-std/style.css" rel="stylesheet">
    <link rel="stylesheet" href="/resources/assets/libs/css/style.css">
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/fontawesome/css/fontawesome-all.css">
    <script src="/resources/assets/vendor/jquery/jquery-3.3.1.min.js"></script>
    <%
	String tmberEventMasterDomain= (String)request.getAttribute("tmberEventMasterDomain");
    String tmberEventDomain = (String)request.getAttribute("tmberEventDomain");
    HashMap<String,String> map = (HashMap)request.getAttribute("custMap");
	response.addHeader("Access-Control-Allow-Origin", "*");  
	response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");
	%>
	<script>
	
	$(document).ready(function(){
		getEvent(); 
	}); 
	
	function getCoupon(eventId, eventGrade){
		var custGrade = "<%=map.get("custGrade")%>";
		var custId = "<%=map.get("custId")%>";
		
		if(eventGrade=="GOLD"&&custGrade=="SILVER"){
			alert("GOLD 이상 고객만 쿠폰 발급 가능합니다. ");
		}

		$.when(executeEntryEvent(eventId,custId)          
		).then(function() {
			getCouponResult();
		});
	//	return timeAsync(2, "A").then(function(result) { console.log(result); //성공 시 노출 }, function(reason) { console.log(reason); //실패 시 노출 });

	}
	function getCouponResult(){
		var delay=300; 
	   	 setTimeout(function() {
	   		console.log($("#entryId").val());
	   		checkCouponRes(); 
	     }, delay);
	}
	
	function checkCouponRes(){
		var entryId = $("#entryId").val(); 
		var goUrl = "http://"+"<%=tmberEventDomain%>"+"/saga/getCouponResult?entryId="+entryId;
		$.ajax({
            type : "GET", 
            url : goUrl,
            dataType : "json",
            success : function(data){
            	var state = data.state;
            	var barcodeNum = data.BarcodeNum; 
            	if(state=="FULL"){
            		alert("쿠폰이 이미 품절되었습니다. 감사합니다.");
            	}else if(state=="REJECTED"){
            		alert("유효하지 않은 쿠폰/이벤트 정보입니다. - 오류 ");
            	}else if(state=="APPROVED"){
            		alert("쿠폰이 발급되었습니다. 바코드번호 : "+barcodeNum);
            	}
            },
            error : function(){
                alert("쿠폰 발급 실패 !!!!");
            }
        });
	}
	
	function executeEntryEvent(eventId,custId){
		var goUrl = "http://"+"<%=tmberEventDomain%>"+"/saga/entryEvent?eventId="+eventId+"&custId="+custId;
		var delay = 0; 
		$("#entryId").val("");
		$.ajax({
            type : "GET", 
            url : goUrl,
            dataType : "json",
            success : function(data){
            	 setTimeout(function() {
                     $("#entryId").val(data.entryId);
                     $("#entryState").val(data.state);
                 }, delay);
            },
            error : function(){
                alert("쿠폰 발급 실패 !!!!");
            }
        });
	}
	
	function getEvent(){
		
		var custGrde = "<%=map.get("custGrade")%>";
		var loginId = $("#loginId").val(); 
		var goUrl = "http://"+"<%=tmberEventMasterDomain%>"+"/EventMaster/getAllEventInfo";
		var html = ""; 
		$.ajax({
            type : "GET", 
            url : goUrl,
            dataType : "json",
            success : function(data){
                console.log(data.length);
                var html = ""; 
                for(var i=0; i<data.length; i++){
               
                	html += "<div class='cd-timeline__block js-cd-content'>";
                	html += "   <div class='cd-timeline__img cd-timeline__img--picture js-cd-img'>";
                	
                if(i%2==0){
                	html += "		<img src='/resources/assets/vendor/timeline/img/cd-icon-picture.svg' alt='Picture'>";
                }else{
                	html += "		<img src='/resources/assets/vendor/timeline/img/cd-icon-location.svg' alt='Location'>"; 
                }	
                	
                	html += "	</div>";
                	html += "	<div id='eventTimeLinle'>"; 
                	html += "		<div class='cd-timeline__content js-cd-content'>"; 
                	html += "			<h3>"+data[i].event_name+"</h3>"; 
                	html += "			<p>"+data[i].event_content+"</p>"; 
                	html += "			<a href=\"javascript:getCoupon("+data[i].eventId+",'"+data[i].max_grade+"');\" class='btn btn-primary btn-lg'>쿠폰 발급 받기</a>"; 
                	html += "		</div>"; 
                	html += "	</div>"; 
                	html += "</div>"; 
                }
                
                $("#eventTimeLinle").html(html);
            },
            error : function(){
                alert("이벤트 로딩 실패 !!!!");
            }
        });
	}
	
	</script>
</head>
<body>
<%-- <%=map%>
<%=tmberEventMasterDomain%> --%>
   <!-- ============================================================== -->
    <!-- main wrapper -->
    <!-- ============================================================== -->
    <div class="dashboard-main-wrapper">
    <input type="hidden" id="entryId" name="entryId" value="">
    <input type="hidden" id="entryState" name="entryState" value="">
        <div class="dashboard-wrapper">
            <div class="container-fluid dashboard-content">
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="page-header">
                           <h2 class="pageheader-title"> 이벤트 리스트 </h2>
                            <p class="pageheader-text">Proin placerat ante duiullam scelerisque a velit ac porta, fusce sit amet vestibulum mi. Morbi lobortis pulvinar quam.</p>
                            <div class="page-breadcrumb">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="#" class="breadcrumb-link">T멤버십 </a></li>
                                        <li class="breadcrumb-item"><a href="#" class="breadcrumb-link">이벤트 </a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Timeline</li>
                                      </ol>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>

                    <section class="cd-timeline js-cd-timeline">
                        <div class="cd-timeline__container">
                            <div class="cd-timeline__block js-cd-block">
                                <div class="cd-timeline__img cd-timeline__img--picture js-cd-img">
                                    <img src="/resources/assets/vendor/timeline/img/cd-icon-picture.svg" alt="Picture">
                                </div>
                                <div id="eventTimeLinle">
                                	<div class="cd-timeline__content js-cd-content">
	                                    <h3>이벤트명 </h3>
	                                    <p> 이벤트 컨텐츠  </p>
	                                    <a href="javascript:getEvent();" class="btn btn-primary btn-lg">쿠폰 발급 받기</a>
                                	</div>
                                </div>
                            </div>
                       </div>
                            
                    </section>
            </div>
        </div>
    </div>
    <script src="/resources/assets/vendor/jquery/jquery-3.3.1.min.js"></script>
    <script src="/resources/assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
    <script src="/resources/assets/vendor/slimscroll/jquery.slimscroll.js"></script>
    <script src="/resources/assets/libs/js/main-js.js"></script>
    <script src="/resources/assets/vendor/timeline/js/main.js"></script>
</body>
</html>