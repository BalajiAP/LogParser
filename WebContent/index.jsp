<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ResourceBundle" %>
<%@page import="java.util.HashMap" %>
<% ResourceBundle resource = ResourceBundle.getBundle("com.att.blackflag.json.resource.ApplicationProperties"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LogParser</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
$(document).ready(function(){
	
	
    $("#btnViewLog").click(function(){
		
		var environmentName=$("#envName").val();
		var userId=$("#userId").val();
		var passPhrase=$("#passPhrase").val();
		var searchKey=$("#searchKey").val();
		if(userId !="" && userId != null && passPhrase !="" && passPhrase != null &&  searchKey !="" && searchKey !=null && environmentName != "" && environmentName != null ){
			$.ajax({
		        type: "post",
		        url: "/LogParser/EnvironmentLog", //this is my servlet
		        dataType : 'text',
		        data:"environmentName="+environmentName+"&userId="+userId+"&passPhrase="+passPhrase+"&searchKey="+searchKey,
		     
		        success: function(response){
		        	console.log(response);
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
});
</script>
</head>
<body>
	
		<font size=4 face="verdana" color=#120292> 
		<marquee>Environment wise Log viewer</marquee> <br>
		<br>
			<table cellspacing=5 cellpadding=5 bgcolor=#959999 colspan=2
				rowspan=2 align="center">
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
			</table> <br>
			<table align="center">
				<tr>
					<button id="btnViewLog">View Log</button>
				</tr>
			</table>
		</font>
	

</body>
</html>