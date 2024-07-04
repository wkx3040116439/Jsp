<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>重置密码页面</title>
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
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div id="container">
    <h2 style="text-align: center;">重置密码</h2>
    <form action="reset_password.jsp" method="post">
        <input type="text" name="username" class="inputlogin" placeholder="请输入账号" required /><br>
        <input type="password" name="password" class="inputlogin" placeholder="请输入新密码" required /><br>
        <input type="password" name="confirmPassword" class="inputlogin" placeholder="请确认新密码" required /><br>
        <button type="submit" class="btn">提交重置</button>
    </form>
</div>

<%
    request.setCharacterEncoding("utf-8");
    response.setContentType("text/html;charset=utf-8");
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        if (!pass.equals(confirmPass)) {
            out.println("<script>alert('两次输入的密码不一致'); window.location.href = 'reset_password.jsp';</script>");
        } else {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/users", "root", "");
                 Statement stmt = conn.createStatement()) {
                String sql = "UPDATE jsp_user SET password='" + pass + "' WHERE account='" + user + "'";
                int result = stmt.executeUpdate(sql);

                if (result > 0) {
                    out.println("<script>alert('密码重置成功'); window.location.href = 'index.jsp';</script>");
                } else {
                    out.println("<script>alert('密码重置失败'); window.location.href = 'reset_password.jsp';</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('密码重置失败'); window.location.href = 'reset_password.jsp';</script>");
            }
        }
    }
%>
</body>
</html>
