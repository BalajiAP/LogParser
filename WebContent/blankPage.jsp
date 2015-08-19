<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ResourceBundle" %>
<%@page import="java.util.HashMap" %>
<% ResourceBundle resource = ResourceBundle.getBundle("com.att.blackflag.json.resource.ApplicationProperties"); %>
<html>

<head>

<meta http-equiv="X-UA-Compatible" content="IE=7" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.min.js"></script>


<title>Gateway Web Portal</title>

<meta name="description" content="." />
<meta name="keywords" content="." />

<style type="text/css" media="all">
@import url("./css/style.css");

@import url("./css/visualize.css");

@import url("./css/date_input.css");

@import url("./css/jquery.wysiwyg.css");

@import url("./css/jquery.fancybox.css");
</style>



<!--[if lt IE 9]>
	<style type="text/css" media="all"> @import url("css/ie.css"); </style>
	<![endif]-->

<meta charset="UTF-8">
</head>
<script>
function logView(fileName){
	 alert(fileName);
	 window.open ("/LogParser/FileViewerServlet?fileName="+fileName,"mywindow","menubar=1,resizable=1,width=800,height=800");
	 
	/*  $.ajax({
	        type: "get",
	        url: "/LogParser/FileViewerServlet", //this is my servlet
	        dataType : 'text',
	        
	        data:"fileName="+fileName,
	        success: function(response){
	        	//alert("success get files");
	        	$('#loadingDiv').hide();
	        	
	        	$("#content_log_parser").show();
	        	
	        	$("#divFileViewer").html(response);
	        	console.log(response);
	        	 //sendMessage(response);
	        }, error: function(e){
	        	var error=JSON.stringify(e);
	        	   alert('Error: ' +error);
	        }
	  }); */
	 
}

	 

$(document).ready(function(){
	$("#content_apigee_applications").hide();
	$("#content_log_parser").hide();	
	$('#loadingDiv').hide();
	$('#content_file_viewer').hide();
	
	 $("#link_log_parser").click(function(){
	    	switchView("LOG_PARSER");
	 });
	 $("#link_apigee_apps").click(function(){
	    	switchView("APIGEE_APPS");
	 });

	 function logView(id){
		 alert(id);
		 window.open ("http://jsc.simfatic-solutions.com","mywindow","menubar=1,resizable=1,width=100%,height=100%");	 
	 }
	 
	 
	 function switchView(show){
			$("#content_apigee_applications").hide();
			$("#content_log_parser").hide();	
			
			
			if(show=="LOG_PARSER"){
				$("#content_log_parser").show();	
			}
			if(show=="APIGEE_APPS"){
				$("#content_apigee_applications").show();	
			}
			
		}
	 
	 
	 
	 //Other actions and methods
	 $("#btnViewLog").click(function(){
			
			var environmentName=$("#envName").val();
			var userId=$("#userId").val();
			var passPhrase=$("#passPhrase").val();
			var searchKey=$("#searchKey").val();
			if(userId !="" && userId != null && passPhrase !="" && passPhrase != null &&  searchKey !="" && searchKey !=null && environmentName != "" && environmentName != null ){
				$('#loadingDiv').show();				
				setTimeout(function() {$('#loadingDiv').hide()}, 120000);
				$("#content_log_parser").hide();	
				//getFiles();
				 $.ajax({
			        type: "post",
			        url: "/LogParser/EnvironmentLog", //this is my servlet
			        dataType : 'text',
			        data:"environmentName="+environmentName+"&userId="+userId+"&passPhrase="+passPhrase+"&searchKey="+searchKey,
			     
			        success: function(response){
			        	$('#loadingDiv').hide();
			        	$("#content_log_parser").show();	
			        	console.log(response);
			        	getFiles();
			        	 //sendMessage(response);
			        }, error: function(e){
			        	var error=JSON.stringify(e);
			        	   alert('Error: ' +error);
			        }
			  }); 
			}
			else if (environmentName == "" || environmentName == null){
				alert("Please select  environmentName");
			}
			else if (userId =="" || userId == null){
				alert("Please enter UserId");
			}
			else if (passPhrase =="" || passPhrase == null){
				alert("Please enter passPhrase");
			}
			else if (searchKey =="" || searchKey == null){
				alert("Please enter searchKey");
			}

	    });
	 
	 
	 //call fileview servlet
	 function getFiles(){
		 alert("test files");
		 $.ajax({
		        type: "post",
		        url: "/LogParser/FileViewerServlet", //this is my servlet
		        dataType : 'text',
		        
		        data:"test=test",
		        success: function(response){
		        	//alert("success get files");
		        	$('#loadingDiv').hide();
		        	$("#content_file_viewer").show();
		        	
		        	$("#divFileViewer").html(response);
		        	console.log(response);
		        	 //sendMessage(response);
		        }, error: function(e){
		        	var error=JSON.stringify(e);
		        	   alert('Error: ' +error);
		        }
		  });
	 }
	 
	 
});	

</script>



<body>


	<div id="header">

		<h1>
			<a href="#">Gateway App Creation</a>
		</h1>

		<form action="" method="post" class="searchform">
			<input type="text" class="text" value="Search..." /> <input
				type="submit" class="submit" value="" />
		</form>


		<div class="userprofile">
			<ul>
				<li><a href="#"><img src="./images/avatar.gif" alt="" />
						Welcome</a>
					<ul>
						<li><a href="#">Profile</a></li>
						<li><a href="#">Messages</a></li>
						<li><a href="./login.html">Logout</a></li>
					</ul></li>
			</ul>
		</div>
		<!-- .userprofile ends -->

	</div>
	<!-- #header ends -->






	<div id="sidebar">

		<ul id="nav">
			<li id="link_apigee_apps"><a href="#"><img
					src="./images/nav/dashboard.png" alt="" /> Apigee Applications</a></li>
			<li id="link_log_parser"><a href="#"><img
					src="./images/nav/pages.png" alt="" /> Log Parser</a></li>
		</ul>

	</div>
	<!-- #sidebar ends -->

	<!-- CONTENT View -->
	<div id="content">
	
	<!-- Loadin Screen pop up div  -->
	 <div id="loadingDiv"><img src="http://jimpunk.net/Loading/wp-content/uploads/loading1.gif"/></div>
	
		<!-- APP Creation View -->
		<div id="content_apigee_applications">
			<h1>App Creations</h1>
		</div>
	
	
	
		<!-- LOG PARSER View -->
		<div id="content_log_parser">
			<h1>Search Logs In MP Server</h1>
			
			<table cellspacing=20 cellpadding=20 bgcolor=#FFF colspan=2 rowspan=2 align="center">
				<tr>
					<td>Enter UserId</td>
					<td><input type=text id="userId" name="userId"></td>
				</tr>
				<tr>
					<td>Enter Passphrase</td>
					<td><input type=password id="passPhrase" name="passPhrase"></td>
				</tr>
				<tr>
					<td>Enter Environment</td>
					<!-- <td><input type=Environment name="Environment"></td> -->
					<td>
						<div class="styled-select">
							<select id="envName" name="envName">
								<option value="-1">--Please Select--</option>
								<%
											String[] envList = resource.getString("ENVIRONMENT-NAMES").split(",");
											for (String env : envList) {
										%>
								<option value='<%=env%>'><%=env%></option>
								<%
											}
										%>
							</select>
						</div>
				</tr>
				<tr>
					<td>Enter SearchKey</td>
					<td><input type=text id="searchKey" name="searchKey"></td>
				</tr>
				
				<tr>
				<td colspan="2">					
					<center><button id="btnViewLog">Search Logs in MP Servers</button></center>				
				</td>
				</tr>
			
			</table>
		</div>

	<!-- Log file viewer -->
<div id="content_file_viewer">
<h3>Search Results</h3>
<div id="divFileViewer"></div>

</div>

<!-- content div end -->
	</div>

	
	<script type="text/javascript" src="./js/excanvas.js"></script>
	<script type="text/javascript" src="./js/jquery.visualize.js"></script>
	<script type="text/javascript" src="./js/jquery.tablesorter.js"></script>
	<script type="text/javascript" src="./js/jquery.date_input.min.js"></script>
	<script type="text/javascript" src="./js/jquery.wysiwyg.js"></script>
	<script type="text/javascript" src="./js/jquery.fancybox.js"></script>
	<script type="text/javascript" src="./js/custom.js"></script>

</body>
</html>
