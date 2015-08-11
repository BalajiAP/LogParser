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
</head>
<body>
	<form name="f1" action="EnvironmentLog" method="post">
		<font size=4 face="verdana" color=#120292> 
		<marquee>Environment wise Log viewer</marquee> <br>
		<br>
			<table cellspacing=5 cellpadding=5 bgcolor=#959999 colspan=2
				rowspan=2 align="center">
				<tr>
					<td>Enter UserId</td>
					<td><input type=text name="uid"></td>
				</tr>
				<tr>
					<td>Enter Passphrase</td>
					<td><input type=password name="passphrase"></td>
				</tr>
				<tr>
					<td>Enter Environment</td>
					<!-- <td><input type=Environment name="Environment"></td> -->
					<td>
						<div class="styled-select">
							<select id="envName" name="envName">
								<option value="-1">--Please Select--</option>
								<%
											String[] envList = resource.getString("ENVIRONMENT-NAMES").split(
													",");
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
					<td><input type=SearchKey name="SearchKey"></td>
				</tr>
			</table> <br>
			<table align="center">
				<tr>
					<td><input type="Submit" value="ViewLog"></td>
				</tr>
			</table>
		</font>
	</form>

</body>
</html>