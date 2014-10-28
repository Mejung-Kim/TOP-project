<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String list = request.getParameter("list");
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
	footer{font-size:18px}
	a{color:#BCBCBC}
	.btn-danger{
		font-family:HY강M;	
		font-size:18px;
		height:34px;
}
	.nav-pills>li{float:none; font-size:20px}

	</style>

    <!-- jQuery Version 1.11.0 -->
	<script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="lib/3-col-portfolio/js/bootstrap.min.js"></script>
	
	<!-- logout -->
    <script type="text/javascript">
    sessionRealPath = "http://localhost:8000//FassionScrapper/";
    
	$(function(){

		//logout	
		$("#logoutbt").click(function(){
			alert("로그아웃되었습니다.")
			location.href="logout.do";
		}); //click끝
		//검색
	 });//click끝
    
    	$(function(){
    		$("#outer").click(function(){
    			$("#outerUl").toggle();
    		})
    		
    		$("#top").click(function(){
    			$("#topUl").toggle();
    		})
    		
    		$("#bottom").click(function(){
    			$("#bottomUl").toggle();
    		})
    		
    		$("#dress").click(function(){
    			$("#dressUl").toggle();
    		})
    		
    		$("#acc").click(function(){
    			$("#accUl").toggle();
    		})
    		
    		$("#shoes").click(function(){
    			$("#shoesUl").toggle();
    		})
    		
    	})
	 
    	   //검색
		$("#srchBtn").click(function(){
			//alert("hi");
			location.href="searchTag.do?tag="+$("#srch-term").val();
		});//click끝
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
						<button type="button" class="btn btn-danger" id="favo">인기순</button>
						<button type="button" class="btn btn-danger" id="favo">최신순</button>
					</h3>		       				
       			</div>
       		</div>
       		
			
				<!-- /.row -->
			<div class="row">
				<div class="col-lg-10" align="center">
					<div class="reseltdiv">
						<jsp:useBean id="boardVo" class="kdb.spring.vo.BoardVo" />
							<c:forEach items="${list}" var="vo">
							<div class='row'>
								<div class='col-md-4 portfolio-item'>
									<a href='details.do?boardNo=${vo.boardNo}'><img class='img-responsive' src='http://localhost:8000//FassionScrapper/boardImage/${vo.boardNo}.png' alt=''></a>
								</div>
							</div>
							</c:forEach>
					</div>	
				</div>
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