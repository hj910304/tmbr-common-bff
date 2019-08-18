<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<html>
<head>
<%
String tmbrCustDomain= (String)request.getAttribute("tmbrCustDomain");
response.addHeader("Access-Control-Allow-Origin", "*");  
response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");

 
%>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/resources/assets/vendor/bootstrap/css/bootstrap.min.css">
    <link href="/resources/assets/vendor/fonts/circular-std/style.css" rel="stylesheet">
    <link rel="stylesheet" href="/resources/assets/libs/css/style.css">
    <link rel="stylesheet" href="/resources/assets/vendor/fonts/fontawesome/css/fontawesome-all.css">
    <!-- jquery 3.3.1 -->
    <script src="/resources/assets/vendor/jquery/jquery-3.3.1.min.js"></script>
    <style>
    html,
    body {
        height: 100%;
    }

    body {
        display: -ms-flexbox;
        display: flex;
        -ms-flex-align: center;
        align-items: center;
        padding-top: 40px;
        padding-bottom: 40px;
    }
    </style>
    
	<script>
	document.domain = "localhost";
	function goLogin(){
		
		var loginId = $("#loginId").val(); 
		var goUrl = "http://"+"<%=tmbrCustDomain%>"+"/customer/getOneCustomer?custId="+loginId;
		var html = ""; 
		$.ajax({
            type : "GET", 
            url : goUrl,
            dataType : "json",
            success : function(data){
                console.log(data);
                setVal(data.cust_id, data.grade);
                goEventList();
            },
            error : function(){
                alert("로그인 실패 !!!!");
            }
        });
	}
	
	function chkLogin(){
		var loginId = $("#loginId").val(); 
		var goUrl = "http://"+"<%=tmbrCustDomain%>"+"/customer/getOneCustomer?custId="+loginId;
		var html = ""; 
		$.ajax({
            type : "GET", 
            url : goUrl,
            dataType : "json",
            success : function(data){
                console.log(data);
                $("#custId").val(data.cust_id);
                $("#grade").val(data.grade);
                html += "<text>아이디: "+data.cust_id +"</text><br>";
                html += "<text>이름: "+data.cust_name+"</text><br>";
                html += "<text>등급: "+data.grade + "</text>"; 
                $("#chkedLoginInfo").html(html).show();
                setVal(data.cust_id, data.grade);
            },
            error : function(){
                alert("회원 정보 로딩 실패 !!!!");
            }
        });
	}
	
	function goEventList(){
		var custId = $("#custId").val(); 
		var grade = $("#grade").val();
		var goUrl = "/eventList?custId="+custId+"&custGrade="+grade; 
		location.href=goUrl;
	}
	
	function setVal(custId,grade){
		$("#custId").val(custId); 
		$("#grade").val(grade); 
	}
	/* function test(){
		$.ajax({
		    url : "http://localhost:7070/customer/getOneCustomer?custId=hjleeid",
		    dataType : "jsonp",
		    success: function(data) {
		    	console.log(data);
		        if(data != null)    {
		            alert(data.cust_id);
		        }
		    },
		    contentType: 'application/javascript',
	        error : function(){
	            alert("로그인 실패 ");
	        }
		});
	}
	function callback(json){
		console.log(json);
	}
	 */
	</script>
</head>

<body>
    <!-- ============================================================== -->
    <!-- login page  -->
    <!-- ============================================================== -->
    
    
    <div class="splash-container">
    	<input type="hidden" id="custId" name="custId" value="">
    	 <input type="hidden" id="grade" name="grade" value="">
        <div class="card ">
            <div class="card-header text-center"><a href="/index.html">
            <img class="logo-img" src="/resources/assets/images/logo.png" alt="logo">
            </a><span class="splash-description">T 멤버십입니다.<br> 로그인해주세요. </span></div>
            <div class="card-body">
                <form>
                    <div class="form-group">
                        <input class="form-control form-control-lg" id="loginId" type="text" placeholder="사용자 ID " autocomplete="off">
                    </div>
                    <!-- <button class="btn btn-primary btn-lg btn-block" onclick="javascript:goLogin();">로그인</button> -->
                    <a href="javascript:goLogin();" class="btn btn-primary btn-lg">로그인 </a><br><br>
                    <a href="javascript:chkLogin();" class="btn btn-primary btn-lg">고객 정보 체크 </a>
                </form>
            </div>
            <div class="card-footer bg-white p-0  ">
                <div class="card-footer-item card-footer-item-bordered" style="display:none" id="chkedLoginInfo">
                    <text id="custInfo">create an account</text>
                </div>
            </div>
        </div>
    </div>
  
    <script src="/resources/assets/vendor/jquery/jquery-3.3.1.min.js"></script>
    <script src="/resources/assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
</body>
 
</html>