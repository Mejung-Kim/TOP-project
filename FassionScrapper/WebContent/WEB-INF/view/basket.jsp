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
	a{color:#515151}
	
	.btn-danger, .btn-default{
			font-family:HY강M;	
			font-size:18px;
			height:34px;
	}
	
	#imageEdit, #profileEdit{
	position:absolute;
	top:0px;;
	width:150px;
	height:50px;
	left:0px;;
	font-size:20px;
	
	}
	
	.img-responsive {
	padding-top:15px;
	}
	
	#profileDiv{
	position:fixed;
	top:140px;
	}

	#img-resize {
	     
	    max-width:150px;
	   
	    width: 100%;
	    height: auto;
	    padding:0;
	    margin:0;
	         
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
	
	selectedCategori = null;
	curPage = $('.pagination > li:first-child');
	numPage = 1;
	sessionRealPath = "http://localhost:8000//FassionScrapper/";
	
	
	 $(function(){
			offLeft = $(".container").offset().left;
			document.getElementById('profileDiv').style.left = (offLeft+975)+"px";	
		 
			//페이지 처리에 관한 부분
	/* 		$('.categori').click(function() {
				changeCategori(this);
			});
	*/
	
			//마이페이지 로딩 시 페이지 바(bar)를 만들어주는 부분
			//getNumOfMyMagazine();
			makePageBar();

			//myScrap 로딩
			loadMyMagazine();
			
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
			
			//logout	
			$("#logoutbt").click(function(){
				alert("로그아웃되었습니다.")
				location.href="logout.do";
			}); //click끝	
			
			//태그검색
			$("#srchBtn").click(function(){
		 		alert("hi");
				location.href="searchTag.do?tag="+$("#srch-term").val();
		 	});//click끝
		
		//페이지 처리에 관한 부분

		//필요한 페이지 수 구하기
		function getNumOfMyMagazine() {
			console.log('getNumOfMyMagazine');
			$.ajax({
				url : 'getNumOfMyMagazine.do', //데이터베이스에 아이템 저장
				data : "&curPage=" + curPage.attr('name')+ "&userNo=${sessionScope.userNo}",
				dataType : 'text',
				type : 'post',
				async : false,
				success : function(data) {
					numPage = parseInt(data / 13) + 1;
					alert(numPage);
				},
				error : function(err) {
					alert("페이지를 불러오지 못했습니다.");
				}
			});
		}
		
		

		//페이지 불러오기
		function loadMyMagazine() {
			console.log('loadMyMagazine::ENTER');
			$.ajax({
				url : 'loadMyMagazine.do', //데이터베이스에 아이템 저장
				data : "&curPage=" + curPage.attr('name') + "&userNo=${sessionScope.userNo}",
				dataType :'json',
				type : 'POST',
				async : false,
				success : function(data) {
					initMyScrapDiv(); //div height init
					$(data.resultMagazineVoList).each(function(index, vo){ 
						console.log('index='+index);
						//높이 작은 쪽에 붙이기
						var statement = "<div class='col-md-12 portfolio-item'>"+ 
										"<a href='details.do?boardNo="+vo.boardNo+"'>"+ 
										"<input type='checkbox' name='"+vo.boardNo+"' value='0'"+
										"style='display: none;'/> <a href='details.do?boardNo="+vo.boardNo+"'>"+ 
										"<img class='img-responsive' src='"+sessionRealPath+"boardImage/"+vo.boardNo+".png'>"+ 
										"</a></div>";
						if((index%3)==0)
							$('#area_1').append(statement);
						else if((index%3)==1)
							$('#area_2').append(statement);
						else
							$('#area_3').append(statement);
						
					});					
				},
				error : function(err) {
					alert("이미지 불러오기에 실패했습니다." + err);
				}
			});
		}
		
		function initMyScrapDiv() {
			$('#area_1').attr('h_total', 0);
			$('#area_2').attr('h_total', 0);
		}


		function makePageBar() {
			console.log('makePageBar:: numPage = ' + numPage);

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
 

		 //체크된 게시물 PDF 만들기
		 var list= new Array();		 		
			$("#makePdf").click(function(){
				 $("input[type='checkbox']:checked").each(function(i){
					  list.push($(this).attr('name'));
				}); 
				 $.ajaxSettings.traditional = true; 
				$.ajax({
					url:"makePdf.do",
					type:"post",
					dataType:"json",
					data:{"boardNoList2":list},
					success:function(data){
						alert(data);				
					},
					error:function(err){
						alert(err+ "성공");
					
					}
				})//ajax				
			})//click
		 
			
			 //체크된 게시물 삭제
			 var list2 = new Array();			 		
				$("#magDelete").click(function(){
					 $("input[type='checkbox']:checked").each(function(i){
						  list2.push($(this).attr('name'));
					}); 
					$.ajaxSettings.traditional = true; 
					$.ajax({
						url:"magazineDelete.do",
						type:"post",
						dataType:"json",
						data:{"boardNoList3":list2},
						success:function(result){
							alert(result);				
						},
						error:function(err){
							alert(err+ "성공");						
						}
					})//ajax				
				})//click
			

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

		 
		$("#chooseBtn").click(function(){
			if($(this).val()=="Option On"){
				$("input[type=checkbox]").attr("style","display:block; width:17px; height:17px");				
				$("#chooseBtn").attr("value","Option Off");
			}else{
				$("input[type=checkbox]").attr("style","display:none");
				$("#chooseBtn").attr("value","Option On");
			}
			
		});
	 });//jquery끝	 
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
				<ul class="nav nav-tabs" style="font-size:20px">
				<li><a href="myPage.do">My ScrapBook</a></li>
				<li><a href="myCloset.do">My Closet</a></li>
				<li class="active"><a href="basket.do">Magazine</a></li>
				<li><a href="updateInfo.do">Update information</a></li>
				<li><a href="goFriendListPage.do?owner=${sessionScope.userNo}">My Favorite</a></li>
				</ul>
			</div>
		</div>


		<div class="row">
			<div class="col-lg-10">
				<h2 class="page-header">
					Selected Scraps
				</h2>
				<!-- Projects Row -->
				<!-- 1구역 -->
				<div class="col-lg-4" id="area_1">
				
				</div>

				<!-- 2구역 -->
				<div class="col-lg-4" id="area_2">

				</div>

				<!-- 3구역 -->
				<div class="col-lg-4" id="area_3">
				
				</div>
				<!-- /.row -->

				<!-- Projects Row -->
			<!-- <div class="row">
					<div class="col-md-4 portfolio-item">
						<input type="checkbox" name="comment_status" value="0" style="display:none" />			
						<a href="details.do"> <img class="img-responsive"
							src="http://placehold.it/700x400" alt="">
						</a>
						<h3>
							<a href="details.do">Scrap Name</a>
						</h3>

					</div>
					<div class="col-md-4 portfolio-item">
						<input type="checkbox" name="comment_status" value="0" style="display:none" />			
						<a href="details.do"> <img class="img-responsive"
							src="http://placehold.it/700x400" alt="">
						</a>
						<h3>
							<a href="details.do">Scrap Name</a>
						</h3>

					</div>
					<div class="col-md-4 portfolio-item">
						<input type="checkbox" name="comment_status" value="0" style="display:none" />			
						<a href="details.do"> <img class="img-responsive"
							src="http://placehold.it/700x400" alt="">
						</a>
						<h3>
							<a href="details.do">Scrap Name</a>
						</h3>

					</div>

				</div>

				Projects Row
				<div class="row">
					<div class="col-md-4 portfolio-item">
						<input type="checkbox" name="comment_status" value="0" style="display:none" />			
						<a href="details.do"> <img class="img-responsive"
							src="http://placehold.it/700x400" alt="">
						</a>
						<h3>
							<a href="details.do">Scrap Name</a>
						</h3>

					</div>
					<div class="col-md-4 portfolio-item">
						<input type="checkbox" name="comment_status" value="0" style="display:none" />			
						<a href="details.do"> <img class="img-responsive"
							src="http://placehold.it/700x400" alt="">
						</a>
						<h3>
							<a href="details.do">Scrap Name</a>
						</h3>

					</div>
					<div class="col-md-4 portfolio-item">
						<input type="checkbox" name="comment_status" value="0" style="display:none" />			
						<a href="details.do"> <img class="img-responsive"
							src="http://placehold.it/700x400" alt="">
						</a>
						<h3>
							<a href="details.do">Scrap Name</a>
						</h3>
					</div>
				</div> -->
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



		

       <!-- Pagination -->
         <div class="row text-right">
            <div class="col-lg-2 text-left">               
            <input type="button" value="Option On" id="chooseBtn" class="btn btn-danger">
            </div>
            <div class="col-lg-4 text-center">
				<ul class="pagination">
					<li><a href="#" id="prevPage">&laquo;</a></li>
					<li><a href="#" id="nextPage">&raquo;</a></li>
				</ul>
			</div>
            <div class="col-lg-4 text-right">
            <a href=""><button class="btn btn-danger" id="makePdf" type="button">Make a PDF File</button></a>
            <a href=""><button class="btn btn-danger" id="magDelete" type="button">Delete Scraps</button></a>
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