<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
int boardNo = Integer.parseInt(request.getParameter("boardNo"));
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>Fashion Scrapper</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link href="lib/3-col-portfolio/css/bootstrap.css" rel="stylesheet">
		<link href="lib/3-col-portfolio/css/3-col-portfolio.css" rel="stylesheet">
		<!--[if lt IE 9]>
			<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
	<style type="text/css">
	footer{
		font-size:18px;
	}
	a{
		color:#C0C0C0;
		font-family:HY강M;
		font-size:20px;
	}
	.btn-danger, .btn-default{
			font-family:HY강M;	
			font-size:18px;
			height:34px;
	}
	
	.nav-pills>li{
		float:none ; font-size:20px
	}
	#date{
		font-family:a어린이날L;
		font-size:20px;
		float:right;
		width:610px;
		padding-left:5px;
	}
	.media-body{
		font-family:HY강M;
		font-size:15px;
	}
	.img-responsive{
		width:100%;
		margin-right:50px;
		border:2px dashed #C0C0C0;
		margin-top:15px;
		margin-bottom:15px;
	}
	#com{
		font-family:HY강M;
	}
	#scrapName{
		padding:0;
		height:39px;
		border:1px solid #C0C0C0; 
		font-size:25px;
		font-family:HY강M;
	}
	#hashtag{
		padding:0;
		height:39px;
		border:1px dashed #C0C0C0;
		font-size:20px;
		font-family:HY강M;
		color:#838383;
		padding-top:5px;
		padding-left:10px;
	}
	#usedItem{
		background-color:#C0C0C0;
		width:300px; 
		height:39px;
		color:white; 
		font-size:25px;
	}
	#usedDiv{
		position:fixed;
	}
	#commentHeader{
		background-color:#C0C0C0;
		width:100%; 
		height:30px;
		color:white; 
		font-size:20px;
	}
	#writer{
		font-family:HY강M;
	}
	#recom{
		font-size:20px;
		color:#D9534F;
		border:2px dashed #C0C0C0;
		cursor:pointer;
		float:right;
		margin-bottom:15px;
	
	}
	.com{
		padding-top:0px;
		margin-top:0px;
	}
	</style>
    <!-- jQuery Version 1.11.0 -->
	<script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="lib/3-col-portfolio/js/bootstrap.min.js"></script>
	
	<!-- logout -->
    <script type="text/javascript">
	$(function(){
		offLeft = $(".container").offset().left;
		document.getElementById('usedDiv').style.right = (offLeft)+"px";
		
		
		//logout	
		$("#logoutbt").click(function(){
			alert("로그아웃되었습니다.")
			location.href="logout.do";
		}); //click끝	
		
		$("#backBtn").click(function(){
			history.back();
		});
		
		$("#srchBtn").click(function(){
	 		//alert(111)
			$.ajax({
				url:"searchTag.do",
				type:"POST",
				dataType:"json",
				data:"tag="+$("#srch-term").val(),
				success:function(result){
					//alert(result);
					var div="";		
					//기존에 있는 테이블 첫행만 빼고 지우기
 					$(".reseltdiv").empty();
 					$(result.list).each(function(index, item){
 						div+="<div>";
						//div+="<div class='row'>";
						div+="<div class='col-md-4 portfolio-item'>";
						div+="<a href='details.do?boardNo="+item.boardNo+"'>"+"<img class='img-responsive' src='"+sessionRealPath+"boardImage/"+item.boardNo+".png' alt=''>";
						div+="</a>";
						div+="</div>";
						//div+="</div>";
						div+="</div>";		
					})//반복문 끝
			
					$(".reseltdiv:eq(0)").append(div);

				},
				error:function(err){//실패했을때
					alert(err+"=>에러발생");
				}
			});//ajax끝
	 });//click끝
	})
	</script>
	
	<script type="text/javascript">	
	 sessionRealPath = "http://localhost:8000//FassionScrapper/";
	 $(function(){
			getData();

			$.ajax({
				url:'read.do',
				type:"POST",
				dataType:"json",
				data:"boardNo="+<%=boardNo %>,
				success:function(result){					
					$("#boardimg").attr("src", sessionRealPath+'boardImage/'+result.boardNo+'.png');
								
					var div="";
					div+=result.boardDate;
					div+="&emsp;";
					div+="조회수:"+result.viewcnt;
					div+="&emsp;";
					div+="추천수:"+result.recom;
					div+="&emsp;&emsp;&emsp;&emsp;&emsp;";
					div+="&emsp;&emsp;&emsp;&emsp;";					
					div+="<img src='img/top.jpg' id='recom'>";

					$("#date").html(div);
					
					var str="";
					str+=result.title;
					$("#scrapName").html(str);
					
				 	var str="";
					str+="<a href='goUserPage.do?userNo="+result.userNo+"&sessionUserNo=${sessionScope.userNo}'>";
					str+="by &nbsp;"+result.userNick;
					str+="</a>";
					$("#writer").html(str); 
					
				},
				error:function(err){//실패했을때
					alert(err+"=>에러발생");
				}
			});//ajax끝
			
			$.ajax({
				url:'viewCnt.do',
				type:"POST",
				dataType:"text",
				data:"boardNo="+<%=boardNo %>,
				success:function(result){
				},
				error:function(err){//실패했을때
					alert(err+"=>에러발생");
				}
		
			});//ajax끝
			
			$(document).on("click", "#recom", function(){
				$.ajax({
					url:'recomS.do',
					type:"POST",
					dataType:"text",
					data:"boardNo="+<%=boardNo %>,
					success:function(result){
						//alert(result);
						if(result=='0'){
							alert("이미추천하였습니다.");
						}else
							alert("추천");
						window.location.reload();
					},
					error:function(err){//실패했을때
						alert(err+"오류");
					}
				});//ajax끝			
			})//click끝
			
			 $("#commbtn").click(function(){
				$.ajax({
					url:"commW.do",
					type:"post",
					dataType:"text", //결과데이터 타입
					data:"comContent="+$("#comContent").val()+"&boardNo="+<%=boardNo%>, //폼에 있는 모든 데이터 전송
					success: function(result){
							alert("등록");
							//text박스 모두 지우기
							$("input[type=text]").val("");
							//모든레코드 검색하는 함수 호출
							getData();
					},
					error: function(data){
						alert('댓글 입력 에러발생')
					}
				});//ajax끝
			});//click끝 
			function getData(){
				$.ajax({
					url:"commR.do",
					type:"post",
					dataType:"json",
					data:"boardNo="+<%=boardNo %>,
					success: function(data){	
						var div;
						var stmt="";
						$(".com").remove();
						$(data.list).each(function(index, item){
							stmt="";
			                div = document.createElement('DIV');
			                div.setAttribute('class','com');
			                stmt+="&emsp;"+"<a href='goUserPage.do?userNo="+item.memNo+"&sessionUserNo=${sessionScope.userNo}'>"+item.nickname+"</a>";
			                stmt+="&emsp;"+item.comContent;
			                stmt+="<div style='float:right; padding-right:15px'>&emsp;"+item.comDate+"</div>";
							//div+="<input type='button' value='삭제' id='del'name='"+item.comNo+"'>";
							//div+="</h5>";
							div.innerHTML = stmt;
							document.getElementById('comBox').appendChild(div);
						});//반복문 끝
						//테이블에 추가
						
					},
					error: function(err){//실패했을때
						alert("댓글 에러발생")
					}
				})//ajax끝
			}//getData끝
			
			//검색
			$("#srchBtn").click(function(){
		 		alert("hi");
				location.href="searchTag.do?tag="+$("#srch-term").val();
		 	});//click끝
				
			
				$("#getBtn").click(function(){
					$.ajax({
						url : 'scrapboard.do', //데이터베이스에 아이템 저장
						type : 'POST',
						dataTye : 'text',
						data:"boardNo="+<%=boardNo%>,
						success : function(data) {
							alert("Get it 성공");
							window.location.reload();
						},
						error : function(data) {
							alert("실패했습니다.");
						},
					});//ajax끝
					
				})//click 끝	
	
			
			
	 });
	</script>
	
	</head>
	<body>
	<!-- Wrap all page content here -->
		  <!-- Fixed navbar -->
		   <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="clientMain.do">Home</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
					<li><a href="myPage.do">MyPage</a></li>					
				</ul>

				<div class="col-sm-1 col-md-3 navbar-left">
					<form class="navbar-form" role="search">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Search"
								name="srch-term" id="srch-term">
					<div class="input-group-btn">
						<button class="btn btn-nav"	type="button" id="srchBtn">
							<i class="glyphicon glyphicon-search"></i>
						</button>
						</a>
					</div>
					</div>
					</form>
				</div>
				
				 <form class="navbar-form navbar-right">				 
				<button class="btn btn-nav" type="button">${sessionScope.nickname}님 환영합니다</button>
				<button class="btn btn-nav" type="button" id="logoutbt">Logout</button>
				</form>
			</div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
  
     <!-- Page Content -->
    <div class="container">

        <!-- Page Header -->
       		<div class="row">
       			<div class="col-lg-12">
       				<h3 class="page-header text-right">
						<button type="button" class="btn btn-danger" id="backBtn" onclick="location.href='historyback()'">Back</button>
					</h3>		       				
       			</div>
       		</div>
       		
	       	<div class="row">
				<div class="col-lg-7 portfolio-item" style="margin-bottom:15px">
					<div class="col-lg-12 text-center" id="scrapName" >
					Scrap Name
					</div>
					<div class="lead" align="right" id="writer">
                
                	</div>
				<!-- Author -->

                <!-- Date/Time -->
                <div class="glyphicon glyphicon-time" style="float:left; font-size:20px;"></div>
                <div id="date" align="left"></div>                
					<img class="img-responsive"  id="boardimg" src="" alt="">
					<div class="col-lg-10" id="hashtag"></div>
					<div class="col-lg-2 text-right"  style="padding:0;">
					<input type="button" class="btn btn-danger" style=" width:100%; height:39px; font-size:23px;" value="Get it" id="getBtn">
					</div>
				
						
				</div>
				<div class="col-lg-5">
					<div style="border:1px solid #C0C0C0; width:300px; height:451px;" id="usedDiv">
						<div class="text-center" id="usedItem"> Used Items </div>
					</div>
				</div>
			</div>
			<!-- /.row -->
			
			<div class="row">
				<div class="col-lg-7">
					<div style="border:1px solid #C0C0C0; width:100%; padding-bottom:5px; display:inline-block" id="comBox">
						<div class="text-center" id="commentHeader">Comments</div>
						
						<div class="col-lg-10" style="padding-top:15px; padding-right:0; padding-bottom:15px">
						<input type="text" id="comContent" style="width:100%; border:1px dashed #C0C0C0; height:30px; font-size:15px;" >
						</div>
						
						<div class="col-lg-2" style="padding-top:15px; padding-bottom:15px">
						<button type="button" class="btn btn-danger" style=" width:100%; height:30px;" id="commbtn">Submit</button>
						</div>
						
					</div>
				</div>				
			</div>
			<p>
			<div class="row">
				<div class="commList">
				</div>
			</div>
			
			<!-- /.row -->
			
			
     <hr>
		<!-- Footer -->
		<footer>
			<div class="row">
				<div class="col-lg-12">
					<p>Copyright &copy; TOP project 2014</p>
				</div>
			</div>
			<!-- /.row -->
		</footer>

	</div>


	
	</body>
</html>