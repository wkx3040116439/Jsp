<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>购物车</title>
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

        .delete-btn {
            background-color: #ff6347;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
        }

        .delete-btn:hover {
            background-color: #e74c3c;
        }

        .continue-shopping {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }
        .footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: #fff;
            margin-top: auto;
        }
        .continue-shopping:hover {
            text-decoration: underline;
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
            <th>产品名称</th>
            <th>价格</th>
            <th>描述</th>
            <th>数量</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            // 设置请求的字符编码为UTF-8
            request.setCharacterEncoding("UTF-8");

            // 从会话中获取购物车商品和商品数量
            HashMap<String, ArrayList<String>> cartItems = (HashMap<String, ArrayList<String>>) session.getAttribute("cartItems");
            HashMap<String, Integer> cartItemQuantities = (HashMap<String, Integer>) session.getAttribute("cartItemQuantities");

            // 如果购物车商品为空，则初始化一个新的HashMap并存储在会话中
            if (cartItems == null) {
                cartItems = new HashMap<>();
                session.setAttribute("cartItems", cartItems);
            }

            // 如果购物车商品数量为空，则初始化一个新的HashMap并存储在会话中
            if (cartItemQuantities == null) {
                cartItemQuantities = new HashMap<>();
                session.setAttribute("cartItemQuantities", cartItemQuantities);
            }

            // 获取请求中的商品信息
            String productName = request.getParameter("productName");
            String price = request.getParameter("price");
            String description = request.getParameter("description");

            // 如果商品信息不为空，则将商品添加到购物车中
            if (productName != null && price != null && description != null) {
                ArrayList<String> productDetails = new ArrayList<>();
                productDetails.add(price);
                productDetails.add(description);

                // 如果购物车中已存在该商品，则增加商品数量；否则将商品添加到购物车中
                if (cartItems.containsKey(productName)) {
                    cartItemQuantities.put(productName, cartItemQuantities.get(productName) + 1);
                } else {
                    cartItems.put(productName, productDetails);
                    cartItemQuantities.put(productName, 1);
                }

                // 将更新后的购物车信息存储在会话中
                session.setAttribute("cartItems", cartItems);
                session.setAttribute("cartItemQuantities", cartItemQuantities);
            }

            // 获取请求中的删除商品名称
            String deleteProductName = request.getParameter("deleteProductName");
            // 如果删除商品名称不为空，则从购物车中移除该商品
            if (deleteProductName != null) {
                cartItems.remove(deleteProductName);
                cartItemQuantities.remove(deleteProductName);
                session.setAttribute("cartItems", cartItems);
                session.setAttribute("cartItemQuantities", cartItemQuantities);
            }

            // 计算购物车中商品的总价
            double totalPrice = 0.0;
            for (Map.Entry<String, ArrayList<String>> entry : cartItems.entrySet()) {
                String name = entry.getKey();
                ArrayList<String> details = entry.getValue();
                Integer quantity = cartItemQuantities.get(name);

                if (quantity != null) {
                    totalPrice += Double.parseDouble(details.get(0)) * quantity;
                }
            }

            // 获取请求中的提交订单参数
            String submitOrder = request.getParameter("submitOrder");
            // 如果提交订单参数为"true"，则处理订单提交
            if ("true".equals(submitOrder)) {
                // 数据库连接信息
                String jdbcUrl = "jdbc:mysql://localhost:3306/users";
                String dbUsername = "root";
                String dbPassword = "";
                Class.forName("com.mysql.jdbc.Driver");
                try {
                    // 加载MySQL JDBC驱动程序

                    // 连接到数据库
                    Connection conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

                    // 将购物车中的每个商品信息插入到数据库中
                    for (Map.Entry<String, ArrayList<String>> entry : cartItems.entrySet()) {
                        String productNameDB = entry.getKey();
                        ArrayList<String> productDetails = entry.getValue();
                        int quantity = cartItemQuantities.get(productNameDB);

                        // 生成唯一ID
                        long numericUuid = Math.abs(UUID.randomUUID().getMostSignificantBits());

                        // 插入订单信息到数据库
                        String sql = "INSERT INTO jsp_orders (id, productName, price, description, quantity, create_time,username) VALUES (?, ?, ?, ?, ?, NOW(),?)";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setLong(1, numericUuid);
                        pstmt.setString(2, productNameDB);
                        pstmt.setDouble(3, Double.parseDouble(productDetails.get(0)));
                        pstmt.setString(4, productDetails.get(1));
                        pstmt.setInt(5, quantity);
                        pstmt.setString(6, loggedInUser);

                        pstmt.executeUpdate();
                    }

                    // 关闭数据库连接
                    conn.close();

                    // 清空购物车
                    cartItems.clear();
                    cartItemQuantities.clear();
                    session.setAttribute("cartItems", cartItems);
                    session.setAttribute("cartItemQuantities", cartItemQuantities);

                    // 显示订单提交成功的提示信息，并重定向到购物车页面
                    out.println("<script>alert('订单提交成功'); window.location.href = 'cart.jsp';</script>");
                    return;
                } catch (Exception e) {
                    // 打印异常信息，并显示订单提交失败的提示信息
                    e.printStackTrace();
                    out.println("<script>alert('订单提交失败'); window.location.href = 'cart.jsp';</script>");
                }
            }

            // 在处理订单提交后显示购物车中的商品
            for (Map.Entry<String, ArrayList<String>> entry : cartItems.entrySet()) {
                String name = entry.getKey();
                ArrayList<String> details = entry.getValue();
                Integer quantity = cartItemQuantities.get(name);

                if (quantity != null) {
        %>
        <tr>
            <td><%= name %></td>
            <td>￥<%= details.get(0) %></td>
            <td><%= details.get(1) %></td>
            <td><%= quantity %></td>
            <td>
                <form action="cart.jsp" method="post">
                    <input type="hidden" name="deleteProductName" value="<%= name %>">
                    <button type="submit" class="delete-btn">删除</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
    <div style="text-align: center; margin-bottom: 20px;">
        <strong>总价: ￥<%= totalPrice %></strong>
    </div>
    <div>
        <form action="cart.jsp" method="post" style="display: flex; justify-content: center; align-items: center">
            <input type="hidden" name="submitOrder" value="true">
            <button type="submit" class="continue-shopping" style="height: 50px; background-color: #4CAF50; color: white; border: none; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; margin: 4px 2px; cursor: pointer; border-radius: 4px;">提交订单</button>

        </form>
    </div>
</div>

<div class="footer">
    <p>版权所有 &copy; 西安拓未互联网科技有限责任公司</p>
</div>

</body>
</html>
