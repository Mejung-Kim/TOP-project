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
<link href="lib/3-col-portfolio/css/3-col-portfolio.css"
	rel="stylesheet">
<link href="lib/jquery-ui.css" rel="stylesheet">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<style type="text/css">
footer {
	font-size: 18px;
}

a {
	color: #515151
}

.btn-danger,.btn-default {
	font-family: HY강M;
	font-size: 18px;
	height: 34px;
}

.img-responsive {
	padding-top: 15px;
}

#imageEdit,#profileEdit {
	position: absolute;
	top: 0px;;
	width: 150px;
	height: 50px;
	left: 0px;
	font-size: 20px;
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
h4, .h4, h5, .h5, h6, .h6{
	margin-top:20px;
}
#canvasDiv {
	position: relative;
	margin: 0px;
	overflow: hidden;
}

#container {
	overflow-y: scroll;
	overflow-x: hidden;
}

.canvasItem {
	cursor: pointer;
}

.canvasItemDiv {
	position: absolute;
	border: none;
	z-index: 0;
	width: auto;
	height: auto;
}

.rotationIcon {
	position: absolute;
	border: solid 8px #FF007F;
	border-radius: 25px;
	left: 50%;
	width: 8px;
	height: 8px;
	background-color: #FF007F;
	opacity: 0.5;
	float: left;
	pointer: all-scroll;
}

.bring2FrontIcon {
	position: relative;
	border: solid 8px gray;
	border-radius: 25px;
	left: 50%;
	width: 8px;
	height: 8px;
	background-color: gray;
	opacity: 0.5;
	float: left;
	cursor: pointer;
}

.deleteDivIcon {
	position: relative;
	background-image: url('img/delete.png');
	background-size: auto auto;
	background-size: 100% 100%;
	display: inline-block;
	width: 30px;
	height: 30px;
	opacity: 0.6;
	float: left;
	cursor: pointer;
	margin-bottom:10px;
}

*::-moz-selection {
	background-color: transparent;
}

* {
	-webkit-user-select: none;
}

input[type="text"],textarea,[contenteditable] {
	-webkit-user-select: text;
}

canvas {
	position: relative;
	border: 1px solid #222;
	float: left;
	clear: both;
}


.portfolio-item{
	font-family:HY강M;
	font-size:20px;	
	border:1px dashed #C0C0C0;

}
</style>

<!-- jQuery Version 1.11.0 -->
<script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script type="text/javascript"
	src="lib/3-col-portfolio/js/bootstrap.min.js"></script>

<!-- for image -->

<script src="lib/jquery-ui.js"></script>

<script src="lib/html2canvas.js"></script>
<script src="lib/jquery.plugin.html2canvas.js"></script>

<script type="text/javascript">
	selectedCategori = null;
	curPage = $('.pagination > li:first-child');
	numPage = 1;
	sessionRealPath = "http://localhost:8000//FassionScrapper/";
	

	$(function() {

		offLeft = $(".container").offset().left;
		document.getElementById('profileDiv').style.left = (offLeft+975)+"px";	

		//마이페이지 로딩 시 페이지 바(bar)를 만들어주는 부분
		getNumOfMyScrap();
		makePageBar();
        //alert(111)
		//myScrap 로딩
		loadMyScrap();
		
		
		//magazine table에 checked된 것들insert
		var list= new Array();
	 		 
	 
		$("#addMag").click(function(){
			 $("input[type='checkbox']:checked").each(function(i){
				  list.push($(this).attr('name'));
				}); 
			 $.ajaxSettings.traditional = true; 
			 
				$.ajax({
					url:"magazineInsert.do",
					type:"post",
					dataType:"text",
					data:{"list":list},
					success:function(data2){
						//alert(data2 + "성공");				
					},
					error:function(err){
						//alert(err + "xx");						
					}
				})			
			})
			
			

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
					success : function(data) {
						loadItem(data, event); //재료창에 불러들이기
					},
					error : function(data) {
						;
						alert("이미지 불러오기에 실패했습니다." + data);
					}
				});//ajax끝
			}//for문 끝
		});//change끝

		$(document).mousemove(
				function(e) {
					if (curFunc == "rotate") {
						curAngle = getAngle(initCenter, [
								e.pageX - canvasDivParent.offsetLeft
										+ canvasDiv.offsetLeft,
								e.pageY - canvasDivParent.offsetTop - 42 ]);
						nextAngle = parseFloat(curAngle)
								- parseFloat(initAngle)
								+ parseFloat(selectedDiv
										.getAttribute("beforeAngle"));
						nextAngle = nextAngle % 360;
						if (nextAngle < 0) {
							nextAngle = nextAngle + 360;
						}
						$('#' + selectedDiv.id).css('-webkit-transform',
								'rotate(' + (nextAngle) + 'deg)');
					}//if문 끝
				});//mousemove 끝

		$(document).mouseup(function(e) {
			e.preventDefault();
			if (curFunc == "rotate") {
				curFunc = null;
				$("#" + selectedDiv.id).draggable();
				selectedDiv.setAttribute("beforeAngle", nextAngle);
			}//if문 끝
		});//mouseup끝

		$('#canvasDiv').click(function(e) {
			e.stopPropagation();

			if (selectedDiv != null) {
				selectedDiv.childNodes[0].style.border = "none";
				selectedDiv.childNodes[1].style.visibility = "hidden";
				selectedDiv.childNodes[2].style.visibility = "hidden";
				selectedDiv.childNodes[3].style.visibility = "hidden";
				selectedDiv = null;
			}//if문끝
		});//click끝

		//postScrap을 누르면 userPath를 설정해주는 부분, 초기환경설정
		$('#postScrap').click(function() {
			$.ajax({
				url : 'stylerConfiguration.do',
				data : 'text',
				type : 'POST',
				async : false,
				error : function(e) {
					alert("실패했습니다.");
				},
			});//ajax끝
			console.log("stylerConfiguration completed");
			$("#myModal").modal();
		});//click끝

		$('#saveChanges')
				.click(
						function() {

							if (!$('#subjectInput').val()) {
								alert("Please write your title");
								return;
							}

							//선택된 디브의 테두리 해제
							if (selectedDiv != null) {
								selectedDiv.childNodes[0].style.border = "none";
								selectedDiv.childNodes[1].style.visibility = "hidden";
								selectedDiv.childNodes[2].style.visibility = "hidden";
								selectedDiv.childNodes[3].style.visibility = "hidden";
							}

							//canvasDiv 크기 및 위치 변경
							var position = calMargin();
							canvasDiv.style.left = position[0] + "px";
							canvasDiv.style.top = position[2] + "px";
							canvasDiv.style.width = parseInt(position[1]
									- position[0])
									+ "px";
							canvasDiv.style.height = parseInt(position[3]
									- position[2])
									+ "px";

							var url = null;

							//이미지로 저장하기
							html2canvas([ canvasDiv ], {
								onrendered : function(canvas) {
									url = canvas.toDataURL();
									$.ajax({
										url : 'postScrap.do', //데이터베이스에 아이템 저장
										data : 'pic=' + url + '&subject='
												+ $('#subjectInput').val()
												+ '&tag='
												+ $('#tagInput').val(),
										type : 'POST',
										dataTye : 'text',
										async : false,
										success : function(data) {
											window.location.reload();
											resetCanvasDiv(); //캔버스 초기화
										},
										error : function(data) {
											alert("실패했습니다.");
										},
									});//ajax끝
								},//onrenedered끝
								proxy : false
							});//html2canvas끝

						});//click끝

		$("#profileEdit").click(function() {
			$("#profileModal").modal();
		});//click끝

		$("#updateProfile").click(function() {
			$.ajax({
				url : "updateIntro.do",
				type : "post",
				dataType : "json",
				data : "intro=" + $("#intro").val(),
				success : function(result) {
					if (result.data > 0) {
						$("#profile").html("<h4>${intro}</h4>");
						alert("자기소개 수정 성공");
						window.location.reload();
					} else {
						alert("자기소개 수정 실패");
					}
				},
				error : function(result) {
					alert(result + "에러발생")
				}

			})//ajax끝			
		});//click끝

		$("#chooseBtn")
				.click(
						function() {
							if ($(this).val() == "Option On") {
								$("input[type=checkbox]")
										.attr("style",
												"display:block; margin-top:10px; width:17px; height:17px");
								$("#chooseBtn").attr("value", "Option Off");
							} else {
								$("input[type=checkbox]").attr("style",
										"display:none");
								$("#chooseBtn").attr("value", "Option On");
							}
						});//click끝

		//logout	
		$("#logoutbt").click(function() {
			alert("로그아웃되었습니다.")
			location.href = "logout.do";
		}); //click끝	

		//모달안에 버튼 토글

		$("#imageEdit").click(function() {
			$("#uploadImage").click();

		});//click끝

		//프로필 이미지 불러오기
		$("#uploadImage")
				.change(
						function() {
							var profileForm = new FormData();
							profileForm.append("file", uploadImage.files[0]);
							$
									.ajax({
										url : 'uploadImage.do', //프로필변경
										data : profileForm,
										dataType : 'text',
										processData : false,
										contentType : false,
										type : 'POST',
										cache : false,
										success : function(data) {
											$("#image")
													.attr(
															"src",
															sessionRealPath
																	+ "profileImage/${sessionScope.userNo}/"
																	+ data
																	+ "?"
																	+ new Date()
																			.getMilliseconds());
											//새로고침기능
											window.location.reload(true);
										},
										error : function(data) {
											alert("이미지 불러오기에 실패했습니다." + data);
										}
									});//ajax끝			
						});//change끝

		//페이지 처리에 관한 부분
		$('.categori').click(function() {
			changeCategori(this);
		});

		$(document).on('click', '.pagination > li > .page', function() {
			curPage.parent().removeClass();
			$(this).parent().addClass("active");
			curPage = $(this);
			$('.portfolio-item').remove(); //remove loaded scrap
			loadMyScrap();
		});

		$('#prevPage').click(function() {
			if (curPage.attr('name') != '1') {
				curPage.parent().removeClass();
				curPage = curPage.parent().prev().find('.page');
				curPage.parent().addClass("active");
				$('.portfolio-item').remove(); //remove loaded scrap
				loadMyScrap();
			}
		});

		$('#nextPage').click(function() {
			if (curPage.attr('name') != numPage) {
				curPage.parent().removeClass();
				curPage = curPage.parent().next().find('.page');
				curPage.parent().addClass("active");
				$('.portfolio-item').remove(); //remove loaded scrap
				loadMyScrap();
			}
		});

		$("#srchBtn").click(function() {
			//alert("hi");
			location.href = "searchTag.do?tag=" + $("#srch-term").val();
		});//click끝
	});//jquery끝

	function changeCategori(obj) {
		console.log("changeCategori::ENTER");
		if (selectedCategori == null) {
			console.log("changeCategori::selectedCategori = null");
			selectedCategori = obj;
			selectedCategori.style.backgroundColor = "#EEEEEE";
			console.log(selectedCategori.id);
			$(".itemOnCloset").remove();
			loadCategori();
			$("#closet").show();
		} else if (selectedCategori == obj) {
			selectedCategori.style.background = "none";
			selectedCategori = null;
			$("#closet").hide();

		} else {
			selectedCategori.style.background = "none";
			selectedCategori = obj;
			selectedCategori.style.backgroundColor = "#EEEEEE";
			$(".itemOnCloset").remove();
			loadCategori();
		}
		console.log("changeCategori::END");
	}

	function loadCategori() {
		console.log("loadCategori::ENTER");
		$.ajax({
			url : 'loadItem2.do', //데이터베이스에 아이템 저장
			data : 'selectedCategoriNo=' + selectedCategori.id,
			dataType : 'json',
			type : 'POST',
			success : function(data) {
				if (data != null) {
					$(data.fileArrayList).each(function(index, item) {
						loadItem(item, event); //재료창에 불러들이기
					});
				}//if끝
				else {
					alert("저장된 이미지가 없습니다.");
				}
			},//success끝
			error : function(err) {
				alert("이미지 불러오기에 실패했습니다." + err);
			}
		});//ajax끝
		console.log("loadCategori::END");
	}

	//전역변수 초기화
	$(function() {
		container = document.getElementById("container");
		canvasDiv = document.getElementById("canvasDiv");
		canvasDivParent = document.getElementById("canvasDivParent");
		transData = new Image();
		selectedDiv = null;
		curFunc = null;
		initAngle = 0;
		curAngle = 0;
		nextAngle = 0;
		initCenter = null;
		max_zIndex = 0;
	});

	//재료창에 아이템 불러오기
	function loadItem(data, ev) {
		console.log("loadItem::ENTER");
		var itemOnCloset = new Image(100, 100);
		itemOnCloset.setAttribute("class", "itemOnCloset");
		itemOnCloset.style.visibility = "hidden";
		setMultipleAttribute(itemOnCloset, sessionRealPath
				+ "save/item2/${sessionScope.userNo}/" + selectedCategori.id
				+ "/" + data, "item2ID_" + new Date().getTime(), true);

		//이미지 사이즈 조정 후 보여주기
		itemOnCloset.onload = function() {
			reSizeImage(itemOnCloset, 100, 100);
			itemOnCloset.style.visibility = "visible";
		};

		//이벤트 핸들러 연결
		itemOnCloset.addEventListener('dragstart', function() {
			drag(itemOnCloset);
		});
		itemOnCloset.addEventListener('mouseover', function() {
			itemOnCloset.style.boxShadow = "2px 2px 2px gray";
		});
		itemOnCloset.addEventListener('mouseleave', function() {
			itemOnCloset.style.boxShadow = "none";
		});
		itemOnCloset.addEventListener('dblclick', function() {
			addItemToCanvas(itemOnCloset, 200, 100, ev);
		});

		//캔버스에 추가
		container.appendChild(itemOnCloset);
	}

	function allowDrop(ev) {
		ev.preventDefault();
	}
	function drag(arg_item) {
		transData = arg_item;
		curFunc = "add";
	}

	//캔버스에 Drop시 캔버스에 아이템 추가
	function drop(ev) {
		ev.preventDefault();
		if (curFunc == "add")
			addItemToCanvas(transData, ev.pageX - canvasDivParent.offsetLeft
					+ canvasDiv.offsetLeft, ev.pageY
					- canvasDivParent.offsetTop + canvasDiv.offsetTop, ev);
	}

	function setMultipleAttribute(item, src, id, draggable) {
		item.setAttribute("src", src);
		item.setAttribute("id", id);
		item.setAttribute("draggable", draggable);
	}

	//캔버스에 아이템 추가
	function addItemToCanvas(arg_item, arg_x, arg_y, ev) {
		//DIV에 들어갈 이미지 셋팅
		var cloneItem = new Image();
		setMultipleAttribute(cloneItem, arg_item.src, "canvasItem_"
				+ new Date().getMilliseconds(), false);
		cloneItem.setAttribute("class", "canvasItem");
		reSizeImage(cloneItem, 300, 300);

		console.log('cloneItem Size :: ' + cloneItem.width + ", "
				+ cloneItem.height);

		//회전아이콘
		var rotationIcon = document.createElement('DIV');
		rotationIcon.setAttribute("class", "rotationIcon");
		rotationIcon.style.visibility = "hidden";

		//맨앞으로 가져오기 아이콘
		var bring2FrontIcon = document.createElement('DIV');
		bring2FrontIcon.setAttribute("class", "bring2FrontIcon");
		bring2FrontIcon.style.visibility = "hidden";

		//삭제 아이콘
		var deleteDivIcon = document.createElement('DIV');
		deleteDivIcon.setAttribute("class", "deleteDivIcon");
		deleteDivIcon.style.visibility = "hidden";

		//DIV 셋팅
		var newDiv = document.createElement('DIV');
		newDiv.setAttribute("id", "canvasItemDiv_"
				+ new Date().getMilliseconds());
		newDiv.setAttribute("class", "canvasItemDiv");
		newDiv.style.left = (arg_x - 60) + "px";
		newDiv.style.top = (arg_y - 40) + "px";
		newDiv.setAttribute("beforeAngle", 0);
		newDiv.style.zIndex = max_zIndex++;
		newDiv.appendChild(cloneItem);
		canvasDiv.appendChild(newDiv);
		newDiv.appendChild(deleteDivIcon);
		newDiv.appendChild(rotationIcon);
		newDiv.appendChild(bring2FrontIcon);

		//이벤트 처리
		$("#" + cloneItem.id).resizable();
		$("#" + newDiv.id).draggable();

		rotationIcon.addEventListener('mousedown', function(e) {
			e.stopPropagation();
			$("#" + newDiv.id).draggable('destroy');
			changeSelectedDiv(newDiv);
			rotationSetting(event);
		});

		deleteDivIcon.addEventListener('click', function(e) {
			deleteDiv();
		});

		bring2FrontIcon.addEventListener('mousedown', function(e) {
			e.stopPropagation();
			newDiv.style.zIndex = max_zIndex++;
		});

		newDiv.addEventListener('mousedown', function(e) {
			changeSelectedDiv(newDiv);
		});

		newDiv.addEventListener('click', function(e) {
			e.stopPropagation();
			e.preventDefault();
			changeSelectedDiv(newDiv);
		});
	}

	function rotationSetting(e) {
		//회전
		initCenter = [
				parseInt(selectedDiv.style.left)
						+ (selectedDiv.getAttribute("width") / 2),
				parseInt(selectedDiv.style.top)
						+ (selectedDiv.getAttribute("height") / 2) ];
		initAngle = getAngle(initCenter, [
				e.pageX - canvasDivParent.offsetLeft + canvasDiv.offsetLeft,
				e.pageY - canvasDivParent.offsetTop + canvasDiv.offsetTop ]);
		curFunc = "rotate";
	}

	function deleteDiv() {
		$('#' + selectedDiv.id).fadeOut(400, function() {
			$('#' + selectedDiv.id).remove();
		});
	}

	function changeSelectedDiv(arg_div) {
		if (selectedDiv != arg_div) {
			if (selectedDiv != null) {
				selectedDiv.childNodes[0].style.border = "none";
				selectedDiv.childNodes[1].style.visibility = "hidden";
				selectedDiv.childNodes[2].style.visibility = "hidden";
				selectedDiv.childNodes[3].style.visibility = "hidden";

			}

			selectedDiv = arg_div;
			selectedDiv.childNodes[0].style.border = "3px dotted pink";
			selectedDiv.childNodes[1].style.visibility = "visible";
			selectedDiv.childNodes[2].style.visibility = "visible";
			selectedDiv.childNodes[3].style.visibility = "visible";
		}
	}

	//제한된 크기에 맞춰 이미지 배율 조정
	function reSizeImage(img, maxWidth, maxHeight) {
		var ratio;
		img.width = img.naturalWidth;
		img.height = img.naturalHeight;
		console.log('reSizeImage:: START width = ' + img.width + ", heihgt ="
				+ img.height);
		if (img.naturalWidth > maxWidth) {
			ratio = maxWidth / img.naturalWidth;
			img.width = img.naturalWidth * ratio;
			img.height = img.naturalHeight * ratio;
		}

		if (img.height > maxHeight) {
			ratio = maxHeight / img.height;
			img.width = img.width * ratio;
			img.height = img.height * ratio;
		}

		console.log('reSizeImage:: END width = ' + img.width + ", heihgt ="
				+ img.height);
	}

	function getAngle(origin, other) {
		dy = other[1] - origin[1];
		dx = other[0] - origin[0];

		var angle = Math.atan(dy / dx);

		if (dx < 0) {
			angle += Math.PI;
		} else if (dx > 0 && dy < 0) {
			angle += 2 * Math.PI;
		}

		return parseFloat(angle * 180 / Math.PI);
	}

	//페이지 처리에 관한 부분

	//필요한 페이지 수 구하기
	function getNumOfMyScrap() {
		console.log('getNumOfMyScrap');
		$.ajax({
			url : 'getNumOfMyScrap.do', //데이터베이스에 아이템 저장
			data : "&curPage=" + curPage.attr('name')
					+ "&userNo=${sessionScope.userNo}",
			dataType : 'json',
			type : 'POST',
			async : false,
			success : function(data) {
				numPage = parseInt(data / 13) + 1;
			},
			error : function(err) {
				alert("페이지를 불러오지 못했습니다.");
			}
		});
	}
	

	//페이지 불러오기
	function loadMyScrap() {

		$.ajax({
			url : 'loadMyScrap.do', //데이터베이스에 아이템 저장
			data : "&curPage=" + curPage.attr('name') + "&userNo=${sessionScope.userNo}",
			dataType : 'json',
			type : 'POST',
			async : false,
			success : function(data) {
				initMyScrapDiv(); //div height init
				$(data.resultBoardVoList).each(function(index, vo){ 
					console.log('index='+index);
				
		

											//디브 만들기
											var newScrapDiv = document
													.createElement('DIV');
											newScrapDiv.setAttribute('class',
													'col-md-12 portfolio-item');
											newScrapDiv.setAttribute('id',
													new Date()
															.getMilliseconds());
											var statement = "<h4 align='right' style='font-family:HY강M; font-size:20px;'>"
													+ vo.title
													+ "</h4><hr><a href='details.do?boardNo="
													+ vo.boardNo
													+ "'>"
													+ "<input type='checkbox' name='"+vo.boardNo+"' value='0'"+
									"style='display: none;'/> <a href='details.do?boardNo="
													+ vo.boardNo
													+ "'>"
													+ "<img class='img-responsive' src='"+sessionRealPath+"boardImage\\"+vo.boardNo+".png'>"
													+ "</a>";
											newScrapDiv.innerHTML = statement;

											//삭제아이콘
											var deleteDivIcon = document
													.createElement('DIV');
											deleteDivIcon.setAttribute("class",
													"deleteDivIcon");
											deleteDivIcon.style.visibility = "hidden";
											newScrapDiv
													.appendChild(deleteDivIcon);

											newScrapDiv
													.addEventListener(
															'mouseover',
															function(e) {
																deleteDivIcon.style.visibility = "visible";
															});

											newScrapDiv
													.addEventListener(
															'mouseleave',
															function(e) {
																deleteDivIcon.style.visibility = "hidden";
															});

											deleteDivIcon
													.addEventListener(
															'click',
															function(e) {
																$
																		.ajax({
																			url : "deleteMyScrap.do",
																			type : "post",
																			dataType : "json",
																			data : "boardNo="
																					+ vo.boardNo,
																			success : function(
																					data) {
																				if (data.result != 1) {
																					//alert(1);
																					alert("삭제에 실패했습니다.");
																					return 0;
																				}
																				$(
																						'#'
																								+ newScrapDiv
																										.getAttribute('id'))
																						.fadeOut(
																								400,
																								function() {
																									$(
																											'#'
																													+ newScrapDiv
																															.getAttribute('id'))
																											.remove();
																								});
																			},
																			error : function(
																					err) {
																				alert('삭제에 실패했습니다.');
																			}
																		});//ajax			
															});

											if ((index % 3) == 0)
												document.getElementById(
														'area_1').appendChild(
														newScrapDiv);
											else if ((index % 3) == 1)
												document.getElementById(
														'area_2').appendChild(
														newScrapDiv);
											else
												document.getElementById(
														'area_3').appendChild(
														newScrapDiv);

										});
					},
					error : function(err) {
						alert("이미지 불러오기에 실패했습니다." + err);
					}
				});
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

	function initMyScrapDiv() {
		$('#area_1').attr('h_total', 0);
		$('#area_2').attr('h_total', 0);
	}

	function findMinScrapDiv() {
		if ($('#area_1').attr('h_total') <= $('#area_2').attr('h_total'))
			return $('#area_1');
		else
			return $('#area_2');
	}

	function calMargin() {
		var position = [ 715, 0, 900, 0 ];
		var curDiv = $('.canvasItemDiv:first');

		while (curDiv.hasClass('canvasItemDiv')) {
			var temp_right = parseInt(curDiv.position().left)
					+ parseInt(curDiv.width());
			var temp_bottom = parseInt(curDiv.position().top)
					+ parseInt(curDiv.height());

			if (position[0] >= curDiv.position().left)
				position[0] = curDiv.position().left;
			if (position[1] <= temp_right)
				position[1] = temp_right;
			if (position[2] >= curDiv.position().top)
				position[2] = curDiv.position().top;
			if (position[3] <= temp_bottom)
				position[3] = temp_bottom;
			curDiv = curDiv.next();
		}

		curDiv = $('.canvasItemDiv:first');
		while (curDiv.hasClass('canvasItemDiv')) {
			var temp_left = parseInt(parseInt(curDiv.position().left)
					- parseInt(position[0]));
			var temp_top = parseInt(parseInt(curDiv.position().top)
					- parseInt(position[2]));
			curDiv.css('left', temp_left + "px");
			curDiv.css('top', temp_top + "px");
			curDiv = curDiv.next();
		}
		return position;
	}

	function resetCanvasDiv() {
		//캔버스 안 아이템 삭제
		$('.canvasItemDiv').remove();

		//크기 복구
		canvasDiv.style.width = "715px";
		canvasDiv.style.height = "900px";
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
							<input type="text" class="form-control"
								placeholder="Hashtag Search" name="srch-term" id="srch-term">
							<div class="input-group-btn">
								<button class="btn btn-nav" type="button" id="srchBtn">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
					</form>
				</div>

				<form class="navbar-form navbar-right">
					<button class="btn btn-nav" type="button">${sessionScope.nickname}님
						환영합니다</button>
					<a href="logout.do"><button class="btn btn-nav"
							type="button">Logout</button></a>
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
					<li class="active"><a href="myPage.do">My ScrapBook</a></li>
					<li><a href="myCloset.do">My Closet</a></li>
					<li><a href="basket.do">Magazine</a></li>
					<li><a href="updateInfo.do">Update information</a></li>
					<li><a href="goFriendListPage.do?owner=${sessionScope.userNo}">My
							Favorite</a></li>
				</ul>
			</div>
		</div>


		<div class="row">
			<div class="col-lg-10">
				<h2 class="page-header">&nbsp;My Scraps <small><a href="myGetScrapPage.do">&nbsp;Get it Scraps</a></small>
				</h2>

				<!-- Projects Row -->
				<!-- 1구역 -->
				<div class="col-lg-4" id="area_1"></div>

				<!-- 2구역 -->
				<div class="col-lg-4" id="area_2"></div>

				<!-- 3구역 -->
				<div class="col-lg-4" id="area_3"></div>
				<!-- /.row -->

				<hr>

			</div>

			<div class="col-lg-2" align="center" id="profileDiv">
				<div id="img-resize" class="col-lg-12">
					<img class="img-responsive"
						src="http://localhost:8000//FassionScrapper/profileImage//${sessionScope.userNo}//profileImage.jpg"
						id="image" alt="">
				</div>

				<div class="col-lg-12" style="width: 150px; height: 50px;">
					<div class="row">
						<input type="file" name="uploadImage" id="uploadImage"
							accept="image/*" style="opacity: 0;">
						<button id="imageEdit" class="btn btn-image">Image Edit</button>
					</div>

				</div>
				<div class="col-lg-12" align="left"
					style="width: 150px; height: auto;" id="profile">
					<h4>${sessionScope.intro}</h4>
				</div>

				<div class="col-lg-12" style="width: 150px; height: 50px;">
					<div class="row">
						<button class="btn btn-image" id="profileEdit">Profile
							Edit</button>
					</div>
				</div>
			</div>

		</div>
		<!-- /.row -->


		<!-- Pagination -->
		<div class="row">
			<div class="col-lg-2 text-left">
				<input type="button" value="Option On" id="chooseBtn"
					class="btn btn-danger">
			</div>
			<div class="col-lg-4 text-center">
				<ul class="pagination">
					<li><a href="#" id="prevPage">&laquo;</a></li>
					<li><a href="#" id="nextPage">&raquo;</a></li>
				</ul>
			</div>
			<div class="col-lg-4 text-right">
				<a href="#"><button class="btn btn-danger" id="addMag"
						type="button">Make a magazine</button></a>
				<button class="btn btn-danger" id="postScrap">Post Scrap</button>
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
			<div class="modal-content" style="border-radius: 20px;">
				<div class="modal-header text-center">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">Edit profile</h4>
				</div>
				<div class="modal-body" style="height: 200px;">
					<div class="row">
						<div class="col-lg-12">
							<div style="padding: 5px;">
								<textarea
									style="border: #D9534F 1px solid; height: 165px; width: 100%;"
									id="intro"></textarea>
							</div>
						</div>
					</div>
					<!-- /.row -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-nav" id="updateProfile">Edit</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
			  
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->


	<!-- Post Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width: 1100px">
			<div class="modal-content">
				<div class="modal-header text-center">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">Post a Scrap</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-4">
							<div style="border: #D9534F 1px solid; height: 480px">
								<ul class="nav nav-tabs nav-justified">
									<li><a href="#" id="1" class="categori">OUTER</a></li>
									<li><a href="#" id="2" class="categori">TOP</a></li>
									<li><a href="#" id="3" class="categori">BOTTOM</a></li>
								</ul>
								<ul class="nav nav-tabs nav-justified">
									<li><a href="#" id="4" class="categori">DRESS</a></li>
									<li><a href="#" id="5" class="categori">ETC</a></li>
								</ul>
								<div id="closet"
									style="width: 334px; height: 396px; position: relative; display: none;">
									<div class="row" id="container"
										style="width: 320px; position: absolute; left: 20px; height: 340px;">
									</div>
									<div class="row"
										style="width: 320px; position: absolute; left: 20px; top: 341px;">
										<input type="file" name="file" id="fileSelect"
											accept="image/*" class="btn btn-nav"
											style="position: absoulute; height: 30px; width: 300px;"
											multiple="">
									</div>
								</div>

							</div>
						</div>
						<div class="col-lg-8" id="canvasDivParent" style="padding: 0px">
							<div class="subjectDiv" style="width: 717px; height: 42px"
								id='subejctDiv'>
								<input class="text-center" type="text"
									style="border: #D9534F 1px solid; border-bottom: none; width: 717px; height: 42px"
									id="subjectInput" placeholder="Subject">
							</div>
							<div
								style="border: #D9534F 1px solid; width: 717px; height: 396px; overflow-y: scroll; overflow-x: hidden">
								<div style="padding: 0; width: 715px; height: 900px;"
									id="canvasDiv" ondrop="drop(event)"
									ondragover="allowDrop(event)"></div>
							</div>
							<div class="tagDiv" style="width: 717px; height: 42px">
								<input class="text-center" type="text"
									style="border: #D9534F 1px solid; border-top: none; width: 717px; height: 42px"
									id="tagInput" placeholder="#HashTag">
							</div>
						</div>
					</div>
					<!-- /.row -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-nav" id="saveChanges">Post</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->




</body>

</html>