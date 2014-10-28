function statusChangeCallback(response) {
  if (response.status === 'connected') {

    testAPI();
  } else if (response.status === 'not_authorized') {

    //document.getElementById('status').innerHTML = 'Please log ' +
      //'into this app.';
  } else {
    //document.getElementById('status').innerHTML = 'Please log ' +
      //'into Facebook.';
  }
}
function checkLoginState() {
  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });
}
window.fbAsyncInit = function() {
FB.init({
  appId      : '577303602380258',
  cookie     : true,  // enable cookies to allow the server to access 
                      // the session
  xfbml      : true,  // parse social plugins on this page
  version    : 'v2.0' // use version 2.0
});

FB.getLoginStatus(function(response) {
  statusChangeCallback(response);
});

};

(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function testAPI() {
  FB.api('/me', function(response) {
  	if(response&&!response.error){
  		$.ajax({
  			url:"insertFb.do",
  			type:"post",
  			data:"&userId="+response.email+"&userName="+response.name,
  			dataType:"json",
  			success:function(result){
  				alert("환영합니다. 별명을 설정해 주세요.");
  				location.href="clientMain.do";
  			},
  			error:function(err){
  				alert("페이스북 로그인 실패하였습니다."+err);
  			}
  		});//ajax끝
  	}
  });
}