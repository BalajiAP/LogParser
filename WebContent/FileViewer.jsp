 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URL"%>
 <!-- @page contentType="text/html" pageEncoding="UTF-8" --> <!--When I use this line has conflict error -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FileViewer</title>
</head>
<body>
<header>
<h1 align="center">Search Logs</h1></header>
<h3>MP_Server_1</h3>
<p>   
 <%
        String filePath = "D:\\Logs\\Logs_MPServer1.txt";
        BufferedReader reader = new BufferedReader(new FileReader(filePath));
        String bufferedOutput="";
        String line = reader.readLine();
        
        while(line!=null){
        	//bufferedOutput=bufferedOutput+line;
        	
        	 line = reader.readLine();
        	 out.println(line+"<br>");
        	}
   //	 out.println(bufferedOutput+);
    %>
</p>
</body>
</html>