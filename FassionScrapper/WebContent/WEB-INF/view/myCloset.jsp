<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="lib/3-col-portfolio/css/3-col-portfolio.css"
	rel="stylesheet">

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

a {
	color: #515151;
}
.btn-danger, .btn-default{
			font-family:HY강M;	
			font-size:18px;
			height:34px;
	}
	
li:active {
	color: #D9534F
}


.page-header {
	margin: 10px 0;
}

#imageEdit, #profileEdit {
	position: absolute;
	top: 0px;;
	width: 150px;
	height: 50px;
	left: 0px;
	font-size:20px;
}
#profileDiv{
	position:fixed;
	top:140px;
}

#img-resize {
	max-width: 150px;
	width: 100%;
	height: auto;
	padding: 0;
	margin: 0;
}

@media screen and (max-width: 1024px) {
	#img-resize {
		left: 50%;
		margin-left: -512px;
	}
}

.page-header {
	margin: 10px 0;
}

.portfolio-item {
	overflow: hidden;
	height: 120px;
	display: inline-block;
}

.img-responsive, .img-responsive-2 {
	width: auth;
	width: 100%;
	height: auto;
	height: 100%;
}

.img-responsive {
	padding-top:15px;
}
</style>
<!-- jQuery Version 1.11.0 -->
<script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="lib/3-col-portfolio/js/bootstrap.min.js"></script>

<script type="text/javascript">
	selectedCategori = null;
	lastAddedItemId = 0;
	curPage = $('.pagination > li:first-child'); //현재 페이지 위치
	numPage = 0; //전체 페이지 갯수

	$(function() {
		
		offLeft = $(".container").offset().left;
		document.getElementById('profileDiv').style.left = (offLeft+975)+"px";	
		
		//유저패스=item2/userno/ 설정하는 부분
		$.ajax({
			url : 'stylerConfiguration.do', //데이터베이스에 아이템 저장
			data : 'text',
			type : 'POST',
			success : function(data) {
			},
			error : function(err) {
				alert("환경설정에 실패했습니다." + err);
			}
		});//ajax끝
		
		$("#imageEdit").click(function() {
			$("#uploadImage").click();
		});//click끝

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
						$("#image").attr(
								"src",
								"http://localhost:8000//FassionScrapper/profileImage/${sessionScope.userNo}/"
										+ data);
						//새로고침기능
					},
					error : function(data) {
						;
						alert("이미지 불러오기에 실패했습니다." + data);
					}
				});//ajax끝

			});//change끝
			
			
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
		
		//logout	
		$("#logoutbt").click(function() {
			alert("로그아웃되었습니다.");
			location.href = "logout.do";
		}); //click끝	
		
		   //검색
		$("#srchBtn").click(function(){
			alert("hi");
			location.href="searchTag.do?tag="+$("#srch-term").val();
		});//click끝

		$('.categori').click(function() {
			changeCategori(this);
		});

		$(document).on('click', '.pagination > li > .page', function() {
			curPage.parent().removeClass();
			$(this).parent().addClass("active");
			curPage = $(this);
			removeItem();
			loadPage();
		});

		$('#prevPage').click(function() {
			if (curPage.attr('name') != '1') {
				curPage.parent().removeClass();
				curPage = curPage.parent().prev().find('.page');
				curPage.parent().addClass("active");
				removeItem();
				loadPage();
			}
		});

		$('#nextPage').click(function() {
			if (curPage.attr('name') != numPage) {
				curPage.parent().removeClass();
				curPage = curPage.parent().next().find('.page');
				curPage.parent().addClass("active");
				removeItem();
				loadPage();
			}
		});
		
		$("#addFile").click(function(){
			$("#fileSelect").click();
		});
		
		$("#fileSelect").change(function() {
			for (var i = 0; i < fileSelect.files.length; i++) {
				var oMyForm = new FormData();
				oMyForm.append("file", fileSelect.files[i]);
				$.ajax({
					url : 'insertItemToUSerCloset.do', //데이터베이스에 아이템 저장
					data : oMyForm,
					dataType : 'text',
					processData : false,
					contentType : false,
					type : 'POST',
					async : false,
					success : function(data) {
					},
					error : function(data) {
						alert("이미지 불러오기에 실패했습니다." + data);
					}
				});
			}

			//카테고리 다시 로드하기
			loadCategori();
			removePageBar();
			makePageBar();
			curPage.parent().removeClass();
			removeItem();

			curPage = $('#nextPage').parent().prev().find('.page');
			curPage.parent().addClass("active");
			loadPage();
			
		});//change끝
	});//jquery끝

	//카테고리 변경하면 해당 아이템 로딩하는 부분
	function changeCategori(obj) {
		if (selectedCategori == null) {
			selectedCategori = obj;
			selectedCategori.style.backgroundColor = "#EEEEEE";
			removeItem();
			loadCategori();
			removePageBar();
			makePageBar();
			loadPage();
		} else {
			selectedCategori.style.background = "none";
			selectedCategori = obj;
			selectedCategori.style.backgroundColor = "#EEEEEE";
			removeItem();
			loadCategori();
			removePageBar();
			makePageBar();
			loadPage();
		}
	}

	//카테고리에 필요한 페이지 수 구하기
	function loadCategori() {
		$.ajax({
			url : 'loadCategori.do', //데이터베이스에 아이템 저장
			data : 'selectedCategoriNo=' + selectedCategori.id,
			dataType : 'text',
			type : 'POST',
			async : false,
			success : function(numFile) {
				if (numFile != null) {
					numPage = parseInt(parseInt(numFile) / 13) + 1; //필요한 페이지 갯수 구하기
				}
			},
			error : function(err) {
				alert("이미지 불러오기에 실패했습니다." + err);
			}
		});
	}

	//페이지 불러오기
	function loadPage() {
		$.ajax({
			url : 'loadPage.do', //데이터베이스에 아이템 저장
			data : "&curPage=" + curPage.attr('name'),
			dataType : 'json',
			type : 'POST',
			success : function(data) {
				if (data != null) {
					$(data.fileArrayList).each(function(index, item) {
						loadItem(item, event); //재료창에 불러들이기
					});
				} else {
					alert("저장된 이미지가 없습니다.");
				}
			},
			error : function(err) {
				alert("이미지 불러오기에 실패했습니다." + err);
			}
		});
	}

	function makePageBar() {
		for (var i = 0; i < numPage; i++) {
			$('.pagination > li:last-child').before(
					"<li><a href='#' class='page' name='" + (i + 1) + "'>"
							+ (i + 1) + "</a></li>");
		}
		$('.pagination > li:nth-child(2)').addClass('active');
		curPage = $('.pagination > li:nth-child(2) > a');
	}

	function removePageBar() {
		$('.page').parent().remove();
	}

	//아이템 불러오기
	function loadItem(data, ev) {
		lastAddedItemId += 10;
		$('#' + lastAddedItemId).attr(
				"src",
				"http://localhost:8000//FassionScrapper/save/item2/${sessionScope.userNo}/"
						+ selectedCategori.id + "/" + data);
	}

	function removeItem() {
		$('.img-responsive').attr('src', '');
		lastAddedItemId = 0;
	}
</script>
</head>

<body>

	<!-- Navigation -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="clientMain.do">Home</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
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
					<button class="btn btn-nav" type="button">${sessionScope.nickname}님	환영합니다</button>
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
				<ul class="nav nav-tabs" style="font-size: 20px">
					<li><a href="myPage.do">My ScrapBook</a></li>
					<li class="active"><a href="myCloset.do">My Closet</a></li>
					<li><a href="basket.do">Magazine</a></li>
					<li><a href="updateInfo.do">Update information</a></li>
					<li><a href="goFriendListPage.do?owner=${sessionScope.userNo}">My Favorite</a></li>
				</ul>
			</div>
		</div>


		<div class="row">
			<div class="col-lg-10">
				<h3 class="page-header">
					<ul class="nav nav-pills nav-justified" style="color: #555555">
						<li><a href="#" id="1" class="categori">OUTER</a></li>
						<li><a href="#" id="2" class="categori">TOP</a></li>
						<li><a href="#" id="3" class="categori">BOTTOM</a></li>
						<li><a href="#" id="4" class="categori">DRESS</a></li>
						<li><a href="#" id="5" class="categori">ETC</a></li>
					</ul>
				</h3>

				<div class="row">

					<div class="col-md-3 portfolio-item"> <a href="#"> <img
							class="img-responsive" src="" alt="" id="10">
						</a>

					</div>

					<div class="col-md-3 portfolio-item">
						 <a href="#"> <img
							class="img-responsive" src="" alt="" id="20">
						</a>
					</div>

					<div class="col-md-3 portfolio-item">
						 <a href="#"> <img
							class="img-responsive" src="" alt="" id="30">
						</a>
					</div>

					<div class="col-md-3 portfolio-item">
						 <a href="#"> <img
							class="img-responsive" src="" alt="" id="40">
						</a>
					</div>
				</div>
				<!-- /.row -->

				<div class="row">
					<div class="col-md-3 portfolio-item">
					 <a href="#"> <img
							class="img-responsive" src="" alt="" id="50">
						</a>

					</div>

					<div class="col-md-3 portfolio-item">
						<a href="#"> <img
							class="img-responsive" src="" alt="" id="60">
						</a>
					</div>

					<div class="col-md-3 portfolio-item">
					<a href="#"> <img
							class="img-responsive" src="" alt="" id="70">
						</a>
					</div>

					<div class="col-md-3 portfolio-item">
						 <a href="#"> <img
							class="img-responsive" src="" alt="" id="80">
						</a>
					</div>
				</div>
				<!-- /.row -->

				<div class="row">
					<div class="col-md-3 portfolio-item">
						 <a href="#"> <img
							class="img-responsive" src="" alt="" id="90">
						</a>

					</div>

					<div class="col-md-3 portfolio-item">
						<a href="#"> <img
							class="img-responsive" src="" alt="" id="100">
						</a>
					</div>

					<div class="col-md-3 portfolio-item">
						 <a href="#"> <img
							class="img-responsive" src="" alt="" id="110">
						</a>
					</div>

					<div class="col-md-3 portfolio-item">
						 <a href="#"> <img
							class="img-responsive" src="" alt="" id="120">
						</a>
					</div>
				</div>
				<!-- /.row -->




				<hr>

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
				<div class="col-lg-12" align="left"
					style="width: 150px; height: auto;" id="profile">
					<h4>${sessionScope.intro}</h4>
				</div>

				<div class="col-lg-12" style="width:150px; height:50px;">
					<div class="row">
					<button class="btn btn-image" id="profileEdit">Profile Edit</button>
					</div>		
				</div>
			</div>
		</div>
		<!-- /.row -->


		<!-- Projects Row -->



		<!-- Pagination -->
		<div class="row text-right">			

			<div class="col-lg-6 text-center">
				<ul class="pagination">
					<li><a href="#" id="prevPage">&laquo;</a></li>
					<li><a href="#" id="nextPage">&raquo;</a></li>
				</ul>
			</div>

			<div class="col-lg-4 text-right" style="height:79px;">
				<button id="addFile" class="btn btn-danger">Add Clothes</button>
				<button class="btn btn-danger" type="button" >Delete Clothes</button>
				<input class="btn btn-danger" type="file" id='fileSelect' multiple="" style="position:absolute; opacity:0; top:0px; width:120px;">
			
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