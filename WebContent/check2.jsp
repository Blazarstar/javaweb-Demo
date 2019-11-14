<%@ page language="java" import="java.sql.*" contentType="text/html;charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>检验注册页面</title>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
 
  </head>
  
  <body>
    <br>
   <%
   request.setCharacterEncoding("utf-8");
   String users=request.getParameter("username");
   String pass=request.getParameter("pwd");
   String age=request.getParameter("age");
   String gender=request.getParameter("gender");
   String mail=request.getParameter("mail");
   
   %>
   <% 
    String driver = "com.mysql.jdbc.Driver";  
    String url = "jdbc:mysql://localhost:3306/login?serverTimezone=UTC";  
    String use = "root";   
    String password = "password";  
    Class.forName(driver);  
    Connection conn= DriverManager.getConnection(url,use,password);  
    PreparedStatement sql =conn.prepareStatement("insert into login(username,password,gender,age,mail)values(?,?,?,?,?)");
    sql.setString(1,users);
    sql.setString(2,pass); 
    sql.setString(3,gender); 
    sql.setString(4,age); 
    sql.setString(5,mail); 
    int rtn=sql.executeUpdate();
    sql.close();
    conn.close();
    %>
    
    <% out.println("注册成功！");%> 
    
  </body>
</html>
