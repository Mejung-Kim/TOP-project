<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   

    <title>Fashion Scrapper</title>

    <!-- Bootstrap Core CSS -->
    <link href="lib/3-col-portfolio/css/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="lib/3-col-portfolio/css/3-col-portfolio.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<style type="text/css">
	footer{
		font-size:18px;
	}
	a{color:#515151; cursor:pointer;}
	
	.btn-danger, .btn-default{
			font-family:HY강M;	
			font-size:18px;
			height:34px;
	}
	
	.form-horizontal .control-label{
		font-family:HY강M;
		font-size:18px;
		margin-left:15px;
	}
	#imageEdit, #profileEdit{
	position:absolute;
	top:0px;;
	width:150px;
	height:50px;
	left:0px;;
	font-size:20px;
	}
	.friendProfile{
		width:100px;
		height:100px;
		display:inline-block;
	
	}
	
	.form-group{
		cursor:pointer;
	}
	
	.img-responsive {
	padding-top:15px;
	}
	
	#profileDiv{
	position:fixed;
	top:140px;
	width:180px;
	}

	#img-resize {   
    width: 100%;
    height: auto;
    padding:0;
    }
 
@media screen and (max-width: 1024px) {
    #img-resize {
        left: 50%;
        margin-left: -512px;  
            }
    }

	</style>
	
	 <!-- jQuery Version 1.11.0 -->
   <script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="lib/3-col-portfolio/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		$(function(){
			
			offLeft = $(".container").offset().left;
			document.getElementById('profileDiv').style.left = (offLeft+975)+"px";	
			
			$("#imageEdit").click(function(){
					$("#uploadImage").click();
						
			})//click끝
			
			//프로필 이미지 불러오기
			$("#uploadImage").change(function() {
					var profileForm = new FormData();
					profileForm.append("file", uploadImage.files[0]);
					$.ajax({
						url : 'uploadImage.do', //프로필변경
						data : profileForm,
						dataType : 'text',
						processData : false,
						contentType : false,
						type : 'POST',
						success : function(data) {
							$("#image").attr("src","http://localhost:8000//FassionScrapper/profileImage/${sessionScope.userNo}/"+data);
							//새로고침기능
						},
						error : function(data) {
							;
							alert("이미지 불러오기에 실패했습니다." + data);
						}
					});
				
			});
			
			$("#profileEdit").click(function(){
				$("#profileModal").modal();
			});//click끝
		
			$("#updateProfile").click(function(){			
				$.ajax({
					url:"updateIntro.do",
					type:"post",
					dataType:"json",
					data:"intro="+$("#intro").val(),
					success:function(result){
						if(result.data>0){
							$("#profile").html("<h4>${intro}</h4>");
							alert("자기소개 수정 성공");
							window.location.reload();
						}else{
							alert("자기소개 수정 실패");
						}
					},
					error:function(result){
						alert(result+"에러발생")
					}
					
				})//ajax끝			
			});//click끝
			
			//친구삭제
			$("#deleteBtn").click(function(){
				$.ajax({
					url:"deleteF.do",
					type:"post",
					dataType:"text",
					data:"fmemNo="+$("#hidno").val(),
					success:function(result){
						if(result>0){
							$('.btn-sm').parent().parent().fadeOut(400, function(){
								$('.btn-sm').parent().parent().remove();
							});
						}
					},
					error:function(result){
						alert(result+"에러발생")
					}
				});//ajax끝
				
			});//click끝
			
			//logout	
			$("#logoutbt").click(function(){
				alert("로그아웃되었습니다.")
				location.href="logout.do";
			}); //click끝	
			
			//검색
			$("#srchBtn").click(function(){
		 		//alert("hi");
				location.href="searchTag.do?tag="+$("#srch-term").val();
		 	});//click끝
		 	
		 	//logout	
			$("#logoutbt").click(function(){
				alert("로그아웃되었습니다.")
				location.href="logout.do";
			}); //click끝
			
		})
	</script>
</head>

<body>

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
						<input type="text" class="form-control" placeholder="Hashtag Search"
								name="srch-term" id="srch-term">
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
    <div class="container">

        <!-- Page Header -->
        <div class="row">
			<div class="col-lg-12">
				<ul class="nav nav-tabs" style="font-size:20px">
				<li><a href="myPage.do">My ScrapBook</a></li>
				<li><a href="myCloset.do">My Closet</a></li>
				<li><a href="basket.do">Magazine</a></li>
				<li><a href="updateInfo.do">Update information</a></li>
				<li class="active"><a href="friendList.do">My Favorite</a></li>
				</ul>
			</div>
		</div>


		<div class="row">
			<div class="col-lg-10">
				<h2 class="page-header">
					Favorite List
				</h2>
				<div class="row">

					<div class="col-lg-10">
						<form class="form-horizontal">
							<fieldset>
								<jsp:useBean id="friendVo" class="kdb.spring.vo.FriendVo" />
								<c:forEach items="${friendList}" var="vo">
									<div class="form-group" style="float:left">
										<div class="col-lg-6 col-md-6" style="display:inline-block; width:300px; height:auto;">
											<a href="goUserPage.do?userNo=${vo.fmemNo}&sessionUserNo=${sessionScope.userNo}">
											<img src="http://localhost:8000//FassionScrapper/profileImage//${vo.fmemNo}.jpg" class="friendProfile"> 
											<label class="control-label" style="padding-right:15px;">${vo.fmemName}</label></a>
											<button class="btn btn-danger btn-sm" type="button" id="deleteBtn" name="${vo.fmemNo}">X</button>
											<input type="hidden" value="${vo.fmemNo}" id="hidno">																					
										</div>									
									</div>
								</c:forEach>								
							</fieldset>
						</form>
					</div>					
				</div>

			</div>
			
			<div class="col-lg-2" align="center" id="profileDiv">
				<div id="img-resize" class="col-lg-12">
					<img class="img-responsive"
						src="http://localhost:8000//FassionScrapper/profileImage//${sessionScope.userNo}//profileImage.jpg"
						id="image" alt="">
				</div>

				<div class="col-lg-12"
					style="width: 150px; height: 50px;">
					<div class="row">
						<input type="file" name="uploadImage" id="uploadImage"
							accept="image/*" style="opacity: 0;">
						<button id="imageEdit" class="btn btn-image">Image
							Edit</button>
					</div>

				</div>
				<div class="col-lg-12" align="left" style="width: 150px; height: auto;" id="profile">
					<h4>${sessionScope.intro}</h4>
				</div>

				<div class="col-lg-12" style="width:150px; height:50px;">
					<div class="row">
					<button class="btn btn-image" id="profileEdit">Profile Edit</button>
					</div>		
				</div>
			</div>
					
				
			</div>
		
		

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
    <!-- /.container -->
		
	<!-- Profile Modal -->
	  	<div class="modal fade" id="profileModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" style="width: 400px">
					<div class="modal-content" style=" border-radius: 20px;">
	           <div class="modal-header text-center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Edit profile</h4>
					</div>
					<div class="modal-body" style="height:200px;">
						<div class="row">							
							<div class="col-lg-12">
								<div style="padding:5px;">
									<textarea style="border: #D9534F 1px solid; height:165px; width:100%;" id="intro" ></textarea>
								</div>													
							</div>
						</div>
						<!-- /.row -->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" id="updateProfile">Edit</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
	            </div><!-- /.modal-content -->	           
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
   

</body>

</html>