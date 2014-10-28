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
   footer{font-size:13px}
   a{color:#D9534F}
   
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
   
    #favorite{
      position:absolute;
      top:0px;;
      width:150px;
      height:50px;
      left:0px;;
   }
   
   </style>
   
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
                <a class="navbar-brand" href="index.html">Home</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
               <li><a href="myPage.do">MyPage</a></li>
               <li class="dropdown"><a href="requestLogin.do"
                  class="dropdown-toggle" data-toggle="dropdown">Look Over <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                     <li><a href="requestLogin.do">Total Styling</a></li>
                     <li><a href="requestLogin.do">Favorite Styling</a></li>
                     <li class="divider"></li>
                     <li class="dropdown-header">category</li>
                     <li><a href="requestLogin.do">Another Things</a></li>
                  </ul>
               </li>
            </ul>

            <div class="col-sm-1 col-md-3 navbar-left">
               <form class="navbar-form" role="search">
               <div class="input-group">
                  <input type="text" class="form-control" placeholder="Search"
                        name="srch-term" id="srch-term">
               <div class="input-group-btn">
                  <a href="requestLogin.do">
                  <button class="btn btn-danger"   type="submit">
                     <i class="glyphicon glyphicon-search"></i>
                  </button>
                  </a>
               </div>
               </div>
               </form>
            </div>
            
             <form class="navbar-form navbar-right">
         <button class="btn btn-danger" type="button">TOP님 환영합니다</button>
            <a href="logout.do"><button class="btn btn-danger" type="button">Logout</button></a>
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
            <li class="active"><a href="myPage.do">ScrapBook</a></li>
            <li><a href="friendList.do">Favorite</a></li>
            </ul>
         </div>
      </div>
      


      <div class="row">
         <div class="col-lg-10">
            <h2 class="page-header">Scraps</h2>
            <!-- Projects Row -->
            <div class="row">
               <div class="col-md-4 portfolio-item">
                  <a href="#"> <img class="img-responsive"
                     src="http://placehold.it/700x400" alt="">
                  </a>
                  <h3>
                     <a href="#">Scrap Name</a>
                  </h3>
                  <p>간단한 스크랩 설명</p>
               </div>
               <div class="col-md-4 portfolio-item">
                  <a href="#"> <img class="img-responsive"
                     src="http://placehold.it/700x400" alt="">
                  </a>
                  <h3>
                     <a href="#">Scrap Name</a>
                  </h3>
                  <p>간단한 스크랩 설명</p>
               </div>
               <div class="col-md-4 portfolio-item">
                  <a href="#"> <img class="img-responsive"
                     src="http://placehold.it/700x400" alt="">
                  </a>
                  <h3>
                     <a href="#">Scrap Name</a>
                  </h3>
                  <p>간단한 스크랩 설명</p>
               </div>

            </div>
            <!-- /.row -->

            <!-- Projects Row -->
            <div class="row">
               <div class="col-md-4 portfolio-item">
                  <a href="#"> <img class="img-responsive"
                     src="http://placehold.it/700x400" alt="">
                  </a>
                  <h3>
                     <a href="#">Scrap Name</a>
                  </h3>
                  <p>간단한 스크랩 설명</p>
               </div>
               <div class="col-md-4 portfolio-item">
                  <a href="#"> <img class="img-responsive"
                     src="http://placehold.it/700x400" alt="">
                  </a>
                  <h3>
                     <a href="#">Scrap Name</a>
                  </h3>
                  <p>간단한 스크랩 설명</p>
               </div>
               <div class="col-md-4 portfolio-item">
                  <a href="#"> <img class="img-responsive"
                     src="http://placehold.it/700x400" alt="">
                  </a>
                  <h3>
                     <a href="#">Scrap Name</a>
                  </h3>
                  <p>간단한 스크랩 설명</p>
               </div>

            </div>

            <!-- Projects Row -->
            <div class="row">
               <div class="col-md-4 portfolio-item">
                  <a href="#"> <img class="img-responsive"
                     src="http://placehold.it/700x400" alt="">
                  </a>
                  <h3>
                     <a href="#">Scraps</a>
                  </h3>
                  <p>간단한 스크랩 설명</p>
               </div>
               <div class="col-md-4 portfolio-item">
                  <a href="#"> <img class="img-responsive"
                     src="http://placehold.it/700x400" alt="">
                  </a>
                  <h3>
                     <a href="#">Scrap Name</a>
                  </h3>
                  <p>간단한 스크랩 설명</p>
               </div>
               <div class="col-md-4 portfolio-item">
                  <a href="#"> <img class="img-responsive"
                     src="http://placehold.it/700x400" alt="">
                  </a>
                  <h3>
                     <a href="#">Scrap Name</a>
                  </h3>
                  <p>간단한 스크랩 설명</p>
               </div>
            </div>
            <!-- /.row -->

            <hr>
         </div>
         <div class="col-lg-2" align="center" style="position:fixed; right:60px">
            <div id="img-resize" class="col-lg-12" style="margin-top:40px;">
               <img class="img-responsive"  src="http://localhost:8000//FassionScrapper/profileImage//${sessionScope.userNo}//profileImage.jpg" alt="" id="image">
            </div>
            <div class="col-lg-12" align="left" style="width:150px; height:auto;" id="profile">
               <h4>친구페이지입니다^_^</h4>               
            </div>
      
            <div class="col-lg-12" style="width:150px; height:50px; background-color:#D9534F;">
               <button id="favorite" class="btn btn-danger">즐겨찾기 추가</button>
            </div>
               
         </div>
   
         
      </div>
      <!-- /.row -->





      <!-- Pagination -->
        <div class="row text-center">
            <div class="col-lg-10">
                <ul class="pagination">
                    <li>
                        <a href="#">&laquo;</a>
                    </li>
                    <li class="active">
                        <a href="#">1</a>
                    </li>
                    <li>
                        <a href="#">2</a>
                    </li>
                    <li>
                        <a href="#">3</a>
                    </li>
                    <li>
                        <a href="#">4</a>
                    </li>
                    <li>
                        <a href="#">5</a>
                    </li>
                    <li>
                        <a href="#">&raquo;</a>
                    </li>
                </ul>
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

    <!-- jQuery Version 1.11.0 -->
   <script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="lib/3-col-portfolio/js/bootstrap.min.js"></script>

</body>

</html>