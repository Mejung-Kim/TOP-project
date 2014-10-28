<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	.btn-danger{
			font-family:HY강M;	
			font-size:18px;
			height:34px;
			margin-top:auto;
			margin-bottom:auto;
	}
	a{color:#515151;}
	.nav-pills>li{float:none; font-size:15px; font-family:HY강M;}
	
	.carousel-indicators{
		bottom:10px;
	}
	.img-responsive, .thumbnail > img, .thumbnail a > img, .carousel-inner > .item > img, .carousel-inner > .item > a > img{
		display:block;
		width:100%;
		height:600px;
	}
	
	a > img{
		display:block;
		width:100%;
		height:auto;
	}
	h1, .h1, h2, .h2, h3, .h3{
		margin-bottom:20px;
		text-align:center;
	}
	
	body{
		padding-top:50px;
	}
	
	.portfolio-item{
		display:inline-block;		
		border:1px dashed #C0C0C0;
	}
	
	.img-responsive{
		width: 100%;
		height: auto;
		margin-top: 15px;
		margin-left: auto;
		margin-right: auto;
	}
	</style>

    <!-- jQuery Version 1.11.0 -->
  	<script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="lib/3-col-portfolio/js/bootstrap.min.js"></script>
    <script src="lib/3-col-portfolio/js/jquery.infinitescroll.js"></script>
	
	<!-- logout -->
    <script type="text/javascript">
    sessionRealPath = "http://localhost:8000//FassionScrapper/boardImage/";
    requestNum = 1;
    endVo = 0;
	flag = 0; // 0 - 인기, 1 - 등록일
	
    $(function(){
    	resetPage(0);
		
		$(window).scroll(function(){
			var scrollHeight = $(window).scrollTop() + $(window).height();
			var documentHeight = $(document).height();
			if(scrollHeight = documentHeight){
				for(var i=0; i<1; i++){
					getAllBoardByRecomm();
				}
			}
		});
		
		//logout	
		$("#logoutbt").click(function(){
			alert("로그아웃되었습니다.");
			location.href="logout.do";
		}); //click끝	
		
		//검색
		$("#srchBtn").click(function(){
	 		//alert("hi");
			location.href="searchTag.do?tag="+$("#srch-term").val();
	 	});//click끝
		
	});
	
	
	function getAllBoardByRecomm() {
		console.log('getAllBoard :: ENTER');
		$.ajax({
			url : 'getAllBoard.do', //데이터베이스에 아이템 저장
			data : "&requestNum=" + requestNum+"&flag="+flag,
			dataType : 'json',
			type : 'POST',
			async : false,
			success : function(data) {
				console.log('1. length = '+data.boardVoList.length);
				if(data.boardVoList.length < 3){
					endVo = 1;
					console.log('1.1 endVo = '+endVo);
				}
				$(data.boardVoList).each(function(index, vo){ 
					//높이 작은 쪽에 붙이기
					var statement = "<div class='col-md-12 portfolio-item'>";
					statement += "<a href='details.do?boardNo="+vo.boardNo+"'>";
					statement += "<img src='"+ sessionRealPath + vo.boardNo+".png' alt='' class='img-responsive'>";
					statement += "</a><hr><h3><a href='details.do?boardNo="+vo.boardNo+"'>"+vo.title+"</a></h3></div>";
					
					if((requestNum%3)==1)
						$('#area_1').append(statement);
					else if((requestNum%3)==2)
						$('#area_2').append(statement);
					else
						$('#area_3').append(statement);
					
					console.log('2. reNum = '+requestNum);
					requestNum += 1;
				});
			},
			error : function(err) {
				alert("이미지 불러오기에 실패했습니다." + err);
			},
		});
		console.log('3. getAllBoardByRecomm :: END');
		return true;
	}

	
	function resetPage(arg){
		$('.portfolio-item').remove();
		flag = arg;
	    requestNum = 1;
	    endVo = 0;
		for(var i=0; i<3; i++){
			if(endVo!=1){
				console.log('0. endVo = '+endVo+', i = '+i);
				getAllBoardByRecomm();
			}
		}
	}
	
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
						<input type="text" class="form-control" placeholder="Hashtag Search" name="srch-term" id="srch-term">
						<div class="input-group-btn">
							<button class="btn btn-nav" type="button" id="srchBtn">
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
    
					<div id="myCarousel" class="carousel slide" data-ride="carousel" style="width:100%; height:600px;">
					  <!-- Indicators -->
					  <ol class="carousel-indicators">
					    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					    <li data-target="#myCarousel" data-slide-to="1"></li>
					    <li data-target="#myCarousel" data-slide-to="2"></li>
					  </ol>
					
					  <!-- 회전광고판 항목 -->
					  <div class="carousel-inner" style="vertical-align:middle;">
					    <div class="item active">
					      <img src="img/top.png" alt="...">
					      <div class="carousel-caption">
						  </div>
					    </div>
					    <div class="item">
					      <img src="img/scrapbook.png" alt="...">
					      <div class="carousel-caption">
					      </div>
					    </div>
					    <div class="item">
					      <img src="img/q5.jpg" alt="...">
					      <div class="carousel-caption">
						  </div>
					    </div>
					  </div>
					
					  <!-- 회전광고판 탐색 -->
					  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
					    <span class="glyphicon glyphicon-chevron-left"></span>
					  </a>
					  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
					    <span class="glyphicon glyphicon-chevron-right"></span>
					  </a>
					</div>
				
				<!-- /.row -->
     
    <div class="container">
        <!-- Page Header -->       		  		
	     <div class="row">
			<div class="col-lg-12" align="center">
       			<h3 class="page-header text-right">
						<button type="button" class="btn btn-danger" id="favo" onclick="resetPage(0)">인기순</button>
						<button type="button" class="btn btn-danger" id="dat" onclick="resetPage(1)">최신순</button>
				</h3>		       				
       		</div>
       	</div>


				<!-- Projects Row -->
				<div class="row">
				<div class="col-lg-12" id="scrapPage">
				
				<!-- Projects Row -->
				<div class="col-lg-4" id="area_1" ></div>
				<!-- /.row -->

				<!-- Projects Row -->
				<div class="col-lg-4" id="area_2"></div>

				<!-- Projects Row -->
				<div class="col-lg-4" id="area_3"></div>
				<!-- /.row -->
		</div>
		
	</div>
	<!-- /.row -->
 </div>
 
	
	</body>
</html>