<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>企业年审车辆报表</title>
<style type="text/css">
body, ul, li {
	margin: 0;
	padding: 0;
}

.content .advantage {
	position: relative;
	z-index: 99;
	width: 780px;
	height: 40px;
	padding: 15px 0 0 20px;
	border-bottom: 0;
}

.advantage .search_suggest {
	position: absolute;
	z-index: 999;
	right: 250px;
	top: 50px;
	width: 200px;
	border: 1px solid #999999;
	display: none;
}

.advantage .search_suggest li {
	height: 24px;
	overflow: hidden;
	padding-left: 3px;
	line-height: 24px;
	background: #FFFFFF;
	cursor: default;
}

.advantage .search_suggest li.hover {
	background: #DDDDDD;
}

* {
	padding: 0;
	margin: 0;
}

.container {
	width: 100%;
}

.container .content {
	width: 800px;
	margin: 0 auto;
	margin-top: 20px;
	border: 1px solid #aed0ea;
}

.advantage .list select {
	width: 150px;
	height: 24px;
	margin-top: 8px;
}

.content .title {
	width: 780px;
	height: 40px;
}

.content .title h1 {
	line-height: 40px;
	text-align: center;
	font-size: 16px;
}

.advantage .list {
	width: 780px;
	height: 40px;
	margin-left: 50px;
}

.advantage .list p {
	float: left;
	height: 40px;
	line-height: 40px;
	margin-right: 20px;
}

.advantage .list input.time {
	width: 150px;
	height: 20px;
}

.advantage .list input.button {
	width: 80px;
	height: 24px;
	vertical-align: middle;
	border: 1px solid #aed0ea;
	border-radius: 4px;
	color: #2779aa;
	background: linear-gradient(#f0f4f7, #daecf8);
	cursor: pointer;
	margin-top: 8px;
}

table {
	margin-top: 10px;
	margin-left: 10px;
}

table tr {
	height: 40px;
}

table tr th {
	font-weight: normal;
	background: #f7f7f7;
}

table tr td {
	background: #f9fdff;
}

.content .data_show {
	width: 660px;
	height: 700px;
	background: #f2f5f7;
	margin-top: 20px;
	margin-left: 10px;
	margin-bottom: 20px;
	padding-left: 120px;
	padding-top: 30px;
}

.dropDiv {
	position: absolute;
	z-index: 10;
	display: none;
	cursor: hand;
	border: 1px solid #7F9DB9;
}

.dropDiv .jhover {
	background-color: #D5E2FF;
}

.dropDiv .list {
	float: left;
	width: 100%;
}

.dropDiv .word {
	float: left;
}

.dropDiv .view {
	float: right;
	color: gray;
	text-align: right;
	font-size: 10pt;
}
</style>
<link href="${pageContext.request.contextPath }/js/plugins/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/js/plugins/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/css/caraudit.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/js/jquery-2.1.4.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/js/plugins/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/swfobject.js"></script>

<script type="text/javascript">
	$(function() {
		if($('#isCity').val()=='全市'&&$('#graph-type').val() == 'pie'){
			
			var params = {menu : "false",scale : "noScale",wmode : "opaque"};
			swfobject.embedSWF(
							"${pageContext.request.contextPath }/Corp/open-flash-chart.swf",
							"audit-pie",
							"500",
							"300",
							"9.0.0",
							"expressInstall.swf",
							{
								"data-file" : encodeURI(encodeURI('numState_getCityCarAuditPie.action'))
							}, params);
		}
		
		$('#search').click(function() {
					if ($('#graph-type').val() == 'pie') {
						$('#audit-line').hide();
						var insertDate = $(":input[name='insertDate']").val();
						var corpName = $(":input[name='corpName']").val();
						var param = insertDate + "," + corpName;
						var url ="";
						//查询全市
						if($('#isCity').val()=='全市'){
							var insertDate = $(":input[name='insertDate']").val();
							url="numState_getCityCarAuditPie.action?insertDate="+insertDate;
							$.ajax({
								url : 'numState_getCityCarAuditPie.action',
								type : 'post',
								data : {
									insertDate : $(":input[name='insertDate']").val(),
									flag : 'grid'
								},
								dataType : 'json',
								success : function(result) {
									$("#grid tbody").empty();
									$("<tr></tr>").append("<td>" + result.insertDate+ "</td>")
												  .append("<td>" + result.totalCar+ "</td>")
												  .append("<td>" + result.auditCar+ "</td>")
												  .append("<td>" + result.unAudit+ "</td>")
												  .append("<td>" + result.rate + "</td>")
											      .appendTo($('#grid tbody'));
								},
								error : function() {
									$.messager
											.alert("提示", "请求出错了！", "info");
								}
							});
						}
						else{
							
							url = "numState_getCarAuditPie.action?param="+ param;
							$.ajax({
								url : 'numState_getCarAuditPie.action',
								type : 'post',
								data : {
									insertDate : $(":input[name='insertDate']").val(),
									corpName : $(":input[name='corpName']").val(),
									flag : 'grid'
								},
								dataType : 'json',
								success : function(result) {
									$("#grid tbody").empty();
									$("<tr></tr>").append("<td>" + result.insertDate+ "</td>")
												  .append("<td>" + result.totalCar+ "</td>")
												  .append("<td>" + result.auditCar+ "</td>")
												  .append("<td>" + result.unAudit+ "</td>")
												  .append("<td>" + result.rate + "</td>")
											      .appendTo($('#grid tbody'));
								},
								error : function() {
									$.messager
											.alert("提示", "请求出错了！", "info");
								}
							});
						}
						//车辆信息饼图
						swfobject.embedSWF(
										"${pageContext.request.contextPath }/Corp/open-flash-chart.swf",
										"audit-pie",
										"500",
										"300",
										"9.0.0",
										"expressInstall.swf",
										{
											"data-file" : encodeURI(encodeURI(url))
										}, params);
					} else {
						var corpName="";
						var reportType = $('#reportType').val();
						var insertDate = $(":input[name='insertDate']").val();
						var endDate = $(":input[name='endDate']").val();
						if($('#isCity').val()=='全市'){
							$(":input[name='corpName']").val("");
						}
						
						corpName= $(":input[name='corpName']").val();
						
						if(insertDate==null||insertDate==""||endDate==null||endDate==""){
							$.messager.alert("提示","开始时间和结束时间都要选择！","info");
						}
						else{
							var param = reportType + "," + corpName + ","+ insertDate + "," + endDate;
							var url = "numState_getLineChart.action?param="+ param;
							//车辆信息折线图
							$.ajax({
										url : 'numState_getLineChart.action',
										type : 'post',
										data : {
											 insertDate : $(":input[name='insertDate']").val(),
											 corpName : $(":input[name='corpName']").val(),
											 reportType : $('#reportType').val(),
											 endDate : $(":input[name='endDate']").val(),
											 flag : 'grid'
										},
										dataType : 'json',
										success : function(result) {
											$("#grid tbody").empty();
											console.log(result);
											for (var i = 0; i < result.length; i++) {
												$("<tr></tr>").append("<td>" + result[i].insertDate+ "</td>")
															  .append("<td>" + result[i].totalCar+ "</td>")
															  .append("<td>" + result[i].auditCar+ "</td>")
															  .append("<td>" + result[i].unAudit+ "</td>")
															  .append("<td>" + result[i].rate + "</td>")
														      .appendTo($('#grid tbody'));
											}

										},
										error : function() {
											$.messager.alert("提示",
													"请求出错了！", "info");
										}
									});
							swfobject.embedSWF(
											"${pageContext.request.contextPath }/Corp/open-flash-chart.swf",
											"audit-line",
											"500",
											"300",
											"9.0.0",
											"expressInstall.swf",
											{
												"data-file" : encodeURI(encodeURI(url))
											}, params);
							
							param=endDate+","+corpName;
							if(corpName==null||corpName==""){
								url="numState_getCityCarAuditPie.action?insertDate="+endDate;
							}
							else{
								url="numState_getCarAuditPie.action?param="+ param;
							}
							swfobject.embedSWF(
									"${pageContext.request.contextPath }/Corp/open-flash-chart.swf",
									"audit-pie",
									"500",
									"300",
									"9.0.0",
									"expressInstall.swf",
									{
										"data-file" : encodeURI(encodeURI(url))
									}, params);
						}
						
					}
				});
		
		$('#graph-type').change(function() {
			if ($(this).val() == "line") {
				$('#report').show();
			} else {
				$('#report').hide();
			}
		});
		if($('#isCity').val()=='全市'){
			$('#compName').hide();
			$('#compName').val('');
		}
		$('#isCity').change(function(){
			if($(this).val()=='全市'){
				$('#compName').hide();
				$('#compName').val('');
			}
			else{
				$('#compName').show();
			}
		});

	});
</script>
</head>
<body>
	<div class="container">
		<div class="content">
			<div class="title">
				<h1>企业车辆年审统计明细表</h1>
			</div>
			<div class="advantage">
				<div class="list">
					<p>
						<span>显示形式：</span> 
						<select id="graph-type" name="graph" style="width:70px;">
							<option value="pie">饼图</option>
							<option value="line">折线图</option>
						</select>
						<select name="isCity" id="isCity" style="width:60px;">
							<option>全市</option>
							<option>企业</option>
						</select>
					</p>
					<p id="compName">
						<span>企业名称:</span> 
						<input type="text" name="corpName" id="name"  required="required">
					</p>
					<p style="display: none" id="report">
						<span>报表类型：</span> 
						<select id="reportType" name="reportType">
							<option value="d">日报</option>
							<option value="w">周报</option>
							<option value="m">月报</option>
							<option value="y">年报</option>
						</select>
					</p>
				</div>
				<div class="list">
					<p>
						<span>开始时间:</span> <input type="text" class="easyui-datebox" required="required"
							name="insertDate" id="date">
					</p>
					<p>
						<span>结束时间:</span> <input type="text" name="endDate" id="endDate" required="required"
							class="easyui-datebox">
					</p>
					<p>
						<input type="button" class="button" value="查询" id="search" />
					</p>
				</div>

				<div class="search_suggest" id="gov_search_suggest">
					<ul>
					</ul>
				</div>
				<script type="text/javascript">
					//实现搜索输入框的输入提示js类  
					function oSearchSuggest(searchFuc) {
						var input = $('#name');
						var suggestWrap = $('#gov_search_suggest');
						var key = "";
						var init = function() {
							input.bind('keyup', sendKeyWord);
							input.bind('blur', function() {
								//setTimeout(hideSuggest, 100);
							})
						}
						var hideSuggest = function() {
							suggestWrap.hide();
						}

						//发送请求，根据关键字到后台查询  
						var sendKeyWord = function(event) {

							//键盘选择下拉项  
							if (suggestWrap.css('display') == 'block'
									&& event.keyCode == 38
									|| event.keyCode == 40) {
								var current = suggestWrap.find('li.hover');
								if (event.keyCode == 38) {
									if (current.length > 0) {
										var prevLi = current.removeClass(
												'hover').prev();
										if (prevLi.length > 0) {
											prevLi.addClass('hover');
											input.val(prevLi.html());
										}
									} else {
										var last = suggestWrap.find('li:last');
										last.addClass('hover');
										input.val(last.html());
									}

								} else if (event.keyCode == 40) {
									if (current.length > 0) {
										var nextLi = current.removeClass(
												'hover').next();
										if (nextLi.length > 0) {
											nextLi.addClass('hover');
											input.val(nextLi.html());
										}
									} else {
										var first = suggestWrap
												.find('li:first');
										first.addClass('hover');
										input.val(first.html());
									}
								}

								//输入字符  
							} else {
								var valText = $.trim(input.val());
								if (valText == '' || valText == key) {
									return;
								}
								searchFuc(valText);
								key = valText;
							}

						}
						//请求返回后，执行数据展示  
						this.dataDisplay = function(data) {
							if (data.length <= 0) {
								suggestWrap.hide();
								return;
							}

							//往搜索框下拉建议显示栏中添加条目并显示  
							
							suggestWrap.find('ul').html('');
							for (var i = 0; i < data.length; i++) {
								suggestWrap.find('ul').append("<li>"+data[i]+"</li>");
							}
							
							suggestWrap.show();
							
							//为下拉选项绑定鼠标事件  
							suggestWrap.find('li').hover(function() {
								suggestWrap.find('li').removeClass('hover');
								$(this).addClass('hover');

							}, function() {
								$(this).removeClass('hover');
							}).click(function() {
								input.val(this.innerHTML);
								suggestWrap.hide();
							});
						}
						init();
					};

					//实例化输入提示的JS,参数为进行查询操作时要调用的函数名  
					var searchSuggest = new oSearchSuggest(sendKeyWordToBack);

					//这是一个模似函数，实现向后台发送ajax查询请求，并返回一个查询结果数据，传递给前台的JS,再由前台JS来展示数据。本函数由程序员进行修改实现查询的请求  
					//参数为一个字符串，是搜索输入框中当前的内容  
					function sendKeyWordToBack(keyword) {
						var obj = {
							"corpName" : $('#name').val()
						};
						$.ajax({
							type : "POST",
							url : "numState_searchBoxTip.action",
							async : false,
							data : obj,
							dataType : "json",
							success : function(data) {
								var aData = [];
								for (var i = 0; i < data.length; i++) {
									//以下为根据输入返回搜索结果的模拟效果代码,实际数据由后台返回  
									if (data[i] != "") {
										aData.push(data[i]);
									}
								}
								//将返回的数据传递给实现搜索输入框的输入提示js类  
								searchSuggest.dataDisplay(aData);
							}
						});
					}
				</script>
			</div>
			<script type="text/javascript">
				$.ajax({
					url : 'numState_getCityCarAuditPie.action',
					type : 'post',
					dataType : 'json',
					data : {
						flag : 'grid'
					},
					success : function(result) {
						$("#grid tbody").empty();
						$("<tr></tr>").append("<td>" + result.insertDate+ "</td>")
									  .append("<td>" + result.totalCar+ "</td>")
									  .append("<td>" + result.auditCar+ "</td>")
									  .append("<td>" + result.unAudit+ "</td>")
									  .append("<td>" + result.rate + "</td>")
								      .appendTo($('#grid tbody'));
					},
					error : function() {
						$.messager.alert("提示", "请求出错了！", "info");
					}
				});
			</script>
			<table cellpadding="0" cellspacing="0" width="780" border="1"
				bordercolor="#aed0ea"
				style="border-collapse: collapse; text-align: center;" id="grid">
				<thead>
					<tr>
						<th>时间</th>
						<th>车辆数量</th>
						<th>已年审数量</th>
						<th>待年审数量</th>
						<th>已注册比率</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td id="corpName"></td>
						<td id="totalCar"></td>
						<td id="auditCar"></td>
						<td id="unAudit"></td>
						<td id="rate"></td>
					</tr>
				</tbody>
			</table>
			<div class="data_show">
				<div class="data" id="audit-line" style="margin-left: 10px;"></div>
				<br>
				<br>
				<br>
				<br>
				<div class="data" id="audit-pie" style="margin-left: 10px;"></div>
			</div>
		</div>
	</div>
</body>
</html>
