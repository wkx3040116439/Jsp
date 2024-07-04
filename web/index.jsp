<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>登录页面</title>
    <style>
        body {
            background-color: #F5F5F5;
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('image/aaaa.jpg');
        }

        #container {
            width: 300px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .inputlogin {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .btn:hover {
            background-color: #45a049;
        }

        .link-btn {
            width: 100%;
            text-align: center;
            display: inline-block;
            margin-top: 10px;
            font-size: 14px;
            color: #4CAF50;
            text-decoration: none;
        }

        .link-btn:hover {
            color: #45a049;
        }
    </style>
</head>
<body>
<div id="container">
    <h2 style="text-align: center;">登录</h2>
    <form action="index.jsp" method="post">
        <input type="text" name="username" id="username" class="inputlogin" placeholder="账号" required/><br>
        <input type="password" name="password" id="password" class="inputlogin" placeholder="密码" required/><br>
        <button type="submit" class="btn">登录</button>
    </form>
    <a href="register.jsp" class="link-btn">注册</a>
    <a href="reset_password.jsp" class="link-btn">忘记密码</a>
</div>

<%
    request.setCharacterEncoding("utf-8");
    response.setContentType("text/html;charset=utf-8");
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/users", "root", "");
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM jsp_user WHERE account='" + user + "' AND password='" + pass + "'")) {

            if (rs.next()) {
                session.setAttribute("loggedInUser", user);
                out.println("<script>alert('登录成功'); window.location.href = 'welcome.jsp';</script>");
            } else {
                out.println("<script>alert('账号或密码错误'); window.location.href = 'index.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
