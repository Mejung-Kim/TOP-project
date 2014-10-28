<%@ page language="java" contentType="text/html; charset=UTF-8"	
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>Join Page</title>
<meta name="generator" content="Bootply" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">	
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
}
.form-horizontal .control-label {
	font-family:HY강M;
	font-size:18px;
}
.form-control{
	font-family:HY강M;
	
}

</style>
<script type="text/javascript" src="lib/facebooklogin.js"></script>
<script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>

<script type="text/javascript">
	$(function(){
		//login
		$("#loginbt").click(function(){
			$.ajax({
				url:"login.do",
				type:"post",
				dataType:"text",
				data:$("#loginform").serialize(),	
				success: function(result){
					if(result =="1" ){
						alert("로그인성공");
						location.href="clientMain.do";
					}else{
						alert("로그인실패-> 아이디와 비밀번호를 확인해주세요.");
						$("#pass").val("");
						$("#userId").focus();
					}
				},
				error: function(data){
					alert(data+'=>error 에러발생')
				}
			})
		}); //keyup끝
		
		//비밀번호 찾기 메일로보내기
		$(function(){
		$("#searchPwd").click(function(){
			$.ajax({
				url:"mail.do",
				type:"post",
				dataType:"text",
				data:"userId=" + $("#userIdSearch").val(),
				success:function(result){
					alert("발송 -> 입력하신 메일을 확인해주세요!");				
				},
				error:function(err){
					alert(err);
					
				}
			})
			
		})
	})
		
	})

</script>

</head>

<body>

	<!-- Wrap all page content here -->
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
					<li><a href="requestLogin.do">MyPage</a></li>					
				</ul>

				<div class="col-sm-1 col-md-3 navbar-left">
					<form class="navbar-form" role="search">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Search"
								name="srch-term" id="srch-term">
					<div class="input-group-btn">
						<a href="requestLogin.do">
						<button class="btn btn-nav"	type="submit">
							<i class="glyphicon glyphicon-search"></i>
						</button>
						</a>
					</div>
					</div>
					</form>
				</div>
				
				<form class="navbar-form navbar-right">
				<a href="requestLogin.do"><button class="btn btn-nav" type="button">Login</button></a>
				<a href="joinForm.do"><button class="btn btn-nav" type="button">Sign up</button></a>
				</form>
			</div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>


		<!-- Begin page content -->
		<div class="container">
			
		
		<form class="form-horizontal">
		<fieldset>
		<legend>Facebook account Login</legend>
		    
		    <div class="form-group">
		    
		      <div class="col-lg-5 col-lg-offset-2">
				<div id="fb-root"></div>
					<fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>
		      </div>
		    </div>
		   </fieldset>
		</form>	
		
		<form class="form-horizontal" id="loginform">
		<fieldset>
		<legend>Top Login</legend>
	    
		    <div class="form-group">
		      <label class="col-lg-2 control-label" for="inputEmail">Email</label>
		      <div class="col-lg-3 col-md-2">
		        <input class="form-control" id="userId" type="text" placeholder="Email address" name="userId">
		      </div>
		    </div>
		    
		    <div class="form-group">
		      <label class="col-lg-2 control-label" for="inputName">Password</label>
		      <div class="col-lg-3 col-md-2">
		        <input class="form-control" id="pass" type="password" placeholder="Password" name="pass">
		      </div>
		    </div>
		    
		    <div class="form-group">
		      <div class="col-lg-5 col-lg-offset-2">
		        <button class="btn btn-danger" type="button" id="loginbt" style="width:265px">Login</button>
		      </div>
		    </div>
		</fieldset>
		</form>
		
		
		<form class="form-horizontal" id="joinForm">
		  <fieldset>
		    <legend>Find a password</legend>
		    <div class="form-group">
		      <label class="col-lg-2 control-label" for="inputEmail">Email</label>
		      <div class="col-lg-3 col-md-2">
		        <input class="form-control" id="userIdSearch" type="text" placeholder="Email address" name="userId">
		      </div>
		    </div>
		    
		    
		    <div class="form-group">
		      <div class="col-lg-5 col-lg-offset-2">
		        <button class="btn btn-danger" type="button" style="width:265px" id="searchPwd">Send a password</button>
		      </div>
		    </div>
		    
		  </fieldset>
		</form>
		
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
	

    <!-- Bootstrap Core JavaScript -->
    <script src="lib/3-col-portfolio/js/bootstrap.min.js"></script>
</body>
</html>