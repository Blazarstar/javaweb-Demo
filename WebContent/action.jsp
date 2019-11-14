<%@page pageEncoding="UTF-8"%> 
<%@include file="captcha.jsp"%> 
<% 
 String captchaImgCode = request.getParameter("captchaImgCode"); 
 try { 
 if (isPass(pageContext, captchaImgCode)) { 
 out.println("验证码通过！"); 
 } 
 } catch (Throwable e) { 
 out.println(e); 
 } 
%>