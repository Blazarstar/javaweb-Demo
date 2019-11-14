<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>用户登录</title>
</head>
<body bgcolor="#e3e3e3">
<center>
<form action="check1.jsp" method="post">
<table>
  <caption>用户登录</caption>
  <tr><td>用户名:</td><td><input type="text" name="username" size="20"/></td></tr>
  <tr><td>密码:</td><td><input type="text" name="pwd" size="20"/></td></tr>
  <td>
        <label class="captchaCode"> 
 		验证码： <img src="img.jsp" style="cursor: pointer;" onclick="this.src=this.src + '?' + new Date().valueOf();" /> 
 </label> 
 </td>
 		<td><input style="width:200px;height:25px;" type="text" name="captchaImgCode" /></td>
  <tr><td><input type="submit" value="登录"/><td><input type="reset" value="重置"/>

  </table>
</form>
  如果您还没有注册，请单击<a href="Register.jsp">这里</a>注册！
</center>
</body>

</html>
