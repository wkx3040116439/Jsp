<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单查询</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background-color: #333;
            color: #fff;
            padding: 10px;
            text-align: center;
            height: 120px;
        }

        .cart {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        .footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: #fff;
            margin-top: auto;
        }

        .navbar {
            background-color: #4CAF50;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 50px;
        }

        .navbar a {
            color: #fff;
            text-align: center;
            width: 90px;
            text-decoration: none;
            margin: 0 10px;
            height: 100%;
            padding-top: 25px;
        }

        .navbar a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>欢迎来到ROG电脑汽配城</h1>
    <%
        // 获取登录用户信息
        String loggedInUser = (String) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
    %>
    <div style="color: #fff; text-align: left; display: flex; align-items: center;">
        <div>当前用户为: <%= loggedInUser %></div>
        <form action="index.jsp" method="post" style="margin-left: 10px;">
            <button type="submit">登出</button>
        </form>
    </div>
    <% } %>
    <%
        // 格式化并显示当前时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = sdf.format(new Date());
    %>
    <div style="color: #fff;text-align: right;"><%= currentTime %></div>
</div>

<div class="navbar">
    <a href="welcome.jsp">商品浏览</a>
    <a href="order.jsp">订单查询</a>
    <a href="cart.jsp">购物车</a>
</div>

<div class="cart">
    <table>
        <thead>
        <tr>
            <th>订单编号</th>
            <th>产品名称</th>
            <th>单价</th>
            <th>数量</th>
            <th>下单时间</th>
            <th>下单用户</th>
        </tr>
        </thead>
        <tbody>
        <%
            String jdbcUrl = "jdbc:mysql://localhost:3306/users";
            String dbUsername = "root";
            String dbPassword = "";
            Class.forName("com.mysql.jdbc.Driver");
            try {

                Connection conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

                String sql = "SELECT id,productName, price, description, quantity,create_time,username FROM jsp_orders";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    String orderId = rs.getString("id");
                    String productName = rs.getString("productName");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String create_time = rs.getString("create_time");
                    String username = rs.getString("username");
        %>
        <tr>
            <td><%= orderId %></td>
            <td><%= productName %></td>
            <td>￥<%= price %></td>
            <td><%= quantity %></td>
            <td><%= create_time %></td>
            <td><%= username %></td>
        </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('无法获取订单信息'); window.location.href = 'order.jsp';</script>");
            }
        %>
        </tbody>
    </table>
</div>

<div class="footer">
    <p>版权所有 &copy; 西安拓未互联网科技有限责任公司</p>
</div>

</body>
</html>
