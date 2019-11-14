<%@page pageEncoding="UTF-8" import="java.io.IOException, java.awt.*, java.awt.image.BufferedImage, java.util.Random, javax.imageio.ImageIO"%> 
<%! 
 // 定义Captcha 类 
 public static class Captcha { 
 /** 
 * 默认宽度 60 
 */ 
 private int width = 60; 
  
 /** 
 * 默认高度 20 
 */ 
 private int height = 20; 
  
 /** 
 * 验证码 
 */ 
 private String code; 
  
 /** 
 * 生成验证码图片 
 * 
 * @return 图片对象 
 */ 
 public BufferedImage get() { 
 BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);// 在内存中创建图像 
 Graphics g; 
  
 g = image.getGraphics(); // 获取图形上下文 
 g.setColor(getRandColor(200, 250)); // 设定背景 
 g.fillRect(0, 0, width, height); 
 g.setFont(new Font("Times New Roman", Font.PLAIN, 18)); // 设定字体 
 g.setColor(getRandColor(160, 200)); 
  
 Random random = new Random();// 随机产生干扰线 
 for (int i = 0; i < 155; i++) { 
 int x = random.nextInt(width), y = random.nextInt(height); 
 int xl = random.nextInt(12), yl = random.nextInt(12); 
 g.drawLine(x, y, x + xl, y + yl); 
 } 
  
 String sRand = ""; // 随机产生4位验证码 
 for (int i = 0; i < 4; i++) { 
 String rand = String.valueOf(random.nextInt(10)); 
 sRand += rand; 
 g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110))); // 将认证码显示到图象中 
 g.drawString(rand, 13 * i + 6, 16);// 调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成 
 } 
  
 // 将认证码存入SESSION 
 // session.setAttribute("rand", sRand); 
 setCode(sRand); 
 g.dispose();// 图象生效 
  
 return image; 
 } 
  
 /** 
 * 生成随机颜色 
 * 
 * @param fc 
 * @param bc 
 * @return 
 */ 
 private Color getRandColor(int fc, int bc) { 
 if (fc > 255) 
 fc = 255; 
 if (bc > 255) 
 bc = 255; 
  
 Random random = new Random(); 
 int r = fc + random.nextInt(bc - fc); 
 int g = fc + random.nextInt(bc - fc); 
 int b = fc + random.nextInt(bc - fc); 
  
 return new Color(r, g, b); 
 } 
  
 /** 
 * 获取高度 
 * 
 * @return 
 */ 
 public int getHeight() { 
 return height; 
 } 
  
 /** 
 * 设置高度 
 * 
 * @param height 
 * 高度 
 */ 
 public void setHeight(int height) { 
 this.height = height; 
 } 
  
 /** 
 * 获取验证码 
 * 
 * @return 
 */ 
 public String getCode() { 
 return code; 
 } 
  
 /** 
 * 设置验证码 
 * 
 * @param code 
 * 验证码 
 */ 
 public void setCode(String code) { 
 this.code = code; 
 } 
  
 /** 
 * 获取宽度 
 * 
 * @return 
 */ 
 public int getWidth() { 
 return width; 
 } 
  
 /** 
 * 设置宽度 
 * 
 * @param width 
 * 宽度 
 */ 
 public void setWidth(int width) { 
 this.width = width; 
 } 
  
 } 
  
  
 /** 
 * SESSION 的键值 
 */ 
 public static final String SESSION_KEY = "rand"; 
  
 /** 
 * 显示验证码图片并将认证码存入 Session 
 * 
 * @param response 
 * 响应对象 
 * @param session 
 * 会话对象 
 */ 
 public static void init(HttpServletResponse response, HttpSession session) { 
 Captcha img = new Captcha(); 
  
 // 不用缓存 
 response.setHeader("Pragma", "No-cache"); 
 response.setHeader("Cache-Control", "no-cache"); 
 response.setDateHeader("Expires", 0); 
 response.setContentType("image/jpg"); 
  
 try { 
 ImageIO.write(img.get(), "JPEG", response.getOutputStream()); 
  
 /* 
 * 加上下面代码,运行时才不会出现java.lang.IllegalStateException: getOutputStream() has already been called ..........等异常 
 * response.getOutputStream().flush(); 
 * response.getOutputStream().close(); 
 * response.flushBuffer(); 
 */ 
  
 // JSP内置对象out和response.getWrite()的区别，两者的主要区别：1. 这两个对象的类型是完全不同的…… 
 // response.getWriter(); 
 // http://blog.sina.com.cn/s/blog_7217e4320101l8gq.html 
 // //www.jb51.net/kf/201109/103284.html 
  
 // pageContext.getOut().clear(); 
 } catch (IOException e) { 
 e.printStackTrace(); 
 } 
  
 session.setAttribute(SESSION_KEY, img.getCode()); // 将认证码存入 SESSION 
 System.out.println("生成验证码:" + img.getCode()); 
 } 
  
 /** 
 * 显示验证码图片并将认证码存入 Session（For JSP） 
 * 
 * @param pageContext 
 * 页面上下文对象 
 */ 
 public static void init(PageContext pageContext) { 
 init((HttpServletResponse) pageContext.getResponse(), pageContext.getSession()); 
 } 
  
  
 /** 
 * 判断用户输入的验证码是否通过 
 * 
 * @param pageContext 
 * 页面上下文对象 
 * @return true 表示通过 
 * @throws Throwable 
 */ 
 public static boolean isPass(PageContext pageContext, String code) throws Throwable { 
 boolean isCaptchaPass = false; 
  
 String rand = (String) pageContext.getSession().getAttribute(SESSION_KEY); 
  
 System.out.println("rand:" + rand); 
 System.out.println("CaptchaCode:" + code); 
  
 if (rand == null) 
 throw new UnsupportedOperationException("请刷新验证码。"); 
 else if (code == null || code.equals("")) { 
 throw new IllegalArgumentException("没提供验证码参数"); 
 } else { 
 isCaptchaPass = rand.equals(code); 
 if (!isCaptchaPass) 
 throw new IllegalAccessError("验证码不正确"); 
 } 
  
 return isCaptchaPass; 
 } 
%>