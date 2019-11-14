# javaweb-Demo

#### 一、实验内容

​         设计一个带有验证码的登录注册系统，实现在数据库中查找用户和增加注册用户信息的功能，

​         以及对于已经在数据库中存在的用户，登录后能得到登录成功的反馈。

#### 二、实验环境

- Eclipse ee
- MySQL 8.0.18
- JDBC : mysql-connector-java-8.0.16
- Navicat120_premium_cs_x64

#### 三、 实验过程

- 确定登录注册系统的逻辑关系

  - 分为一个登录页面login.html，一个注册页面Register.jsp，然后分别再用两个数据库查询页面check1.jsp，check2.jsp分别对应登录与注册页面，进行相关数据库操作。并建立成功/失败登录、成功注册页面与之关联，为了方便报错检查，也设置注册失败页面。

  - Login.html与check1.jsp页面的关系就像实验一中，实现登录用户查询（也是对数据库的查询）；

    Register.jsp与check2.jsp页面的关系是对数据库进行“增加”的操作，以完成未注册用户的登录。

    细节的设计上，首先在check2.jsp的代码中要写入从注册页面接收的值，这里收到的值是用户名、密码、年龄、性别、邮箱。

    ```mysql
    <%
       request.setCharacterEncoding("utf-8");
       String users=request.getParameter("username");
       String pass=request.getParameter("pwd");
       String age=request.getParameter("age");
       String gender=request.getParameter("gender");
       String mail=request.getParameter("mail");
       
       %>
    ```

  - 在check2.jsp中写入数据库“插入”的语句，方便将新注册用户信息录入，同时传给数据库。

  ```mysql
     <% 
      PreparedStatement sql =conn.prepareStatement("insert into     login(username,password,gender,age,mail)values(?,?,?,?,?)");
      sql.setString(1,users);
      sql.setString(2,pass); 
      sql.setString(3,gender); 
      sql.setString(4,age); 
      sql.setString(5,mail); 
      int rtn=sql.executeUpdate();
      sql.close();
      conn.close();
      %>
  ```

- 分别验证两个页面与数据库的传输功能

  - 登陆验证
  - 注册验证

- 增加验证码功能

  - 完成生成随机验证码的Servlet

  - 完成刷新更换验证码的功能

  - 完成验证验证码是否正确是Servlet

  ![1573611974847](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1573611974847.png)



#### 四、实验结果

- 数据库部分

  ![1573612516545](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1573612516545.png)

- 登陆页面验证

  - 用户在数据库中的成功登录

    ![1573612998275](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1573612998275.png)

  - 用户不在数据库中的失败登录

    ![1573613206098](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1573613206098.png)

- 注册页面验证

  ![1573613345301](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1573613345301.png)

- 注册后数据库验证

  ![1573613443781](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1573613443781.png)

#### 五、实验反思与总结

- 在这个登陆验证注册的小demo中，通过百度学会了怎么写验证码，我觉得这是我在这个实验中最大的收获。

​       我以前一直以为验证码由运营商区生成的，做完这个实验才觉得想法很天真。但也真真学习到了。

- 另外一个方面的收获是在进行注册的时候，往数据库里插入数据总是会有各种问题，什么中文乱码之类的，也是来回查资料看别人怎么解决的，在过程里学习了很多以前不知道的方法，收获也很多，还复习了数据库的一些插入语句之类的知识。让我觉得做项目类型的实验是很考验综合能力的，但也正是因为它的综合性，所以才觉得充实，收获丰富。
- 最后一点在这个过程里的反思，通过查资料的时候有看到别人的登陆注册系统的设计，很漂亮，很完整。尤其是作为网络专业安全方向的我来说很惭愧。出于安全性，开发者往往会在用户注册登陆时设置很多的过滤条件，以防止有SQL注入，文件上传木马之类的安全隐患。但我并没有这个能力，在查阅资料的时候看到别人把这个考虑写进去会觉得自己差太多了。但是，还有时间，还有机会，嗯，要好好努力。



#### 六、附录

- 逻辑页面

![1573607780051](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1573607780051.png)

- 生产验证码

  

  ![1573610532325](C:\Users\lenovo\AppData\Roaming\Typora\typora-user-images\1573610532325.png)



- 
