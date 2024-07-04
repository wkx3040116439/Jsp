<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>商城页面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
            overflow-x: hidden;
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

        .content {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            padding: 20px;
            flex: 1;
            overflow-y: auto;
        }

        .product {
            width: 300px;
            background-color: #fff;
            padding: 10px;
            margin: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .product img {
            width: 100%;
            height: 300px; /* 确保图片高度一致 */
            border-radius: 8px;
        }

        .product h3 {
            margin-top: 10px;
            font-size: 18px;
            height: 30px; /* 确保标题高度一致 */
            text-align: center;
        }

        .product p {
            color: #807a74;
            font-size: 14px;
            height: 20px; /* 确保描述高度一致 */
            text-align: left;
            width: 100%;
        }

        .product .price {
            margin-top: 10px;
            font-size: 16px;
            color: #e43b3e;
            height: 10px; /* 确保价格高度一致 */
            text-align: left;
            width: 100%;
        }

        .product .description {
            margin-top: 10px;
            font-size: 14px;
            height: 60px; /* 确保描述高度一致 */
            text-align: left;
            width: 100%;
        }

        .product button {
            margin-top: 10px;
            background-color: #df3033;
            color: white;
            padding: 10px;
            border: none;

            cursor: pointer;
            width: 100%;
            font-size: 16px;
            color: #ffffff;
            font-weight: bold;
        }

        .product button:hover {
            background-color: #45a049;
        }

        .footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: #fff;
            position: relative;
            width: 100%;
            flex-shrink: 0;
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

<div class="content">
    <div class="product">
        <img src="image/1.png">
        <h3>七彩虹（Colorful）iGame RTX 4080S</h3>
        <div class="price">￥10199.00</div>
        <div class="description">
            <p>火神水神UltraAD白色水冷电竞台式游戏直播AIPC显卡龙年礼盒 RTX 4080 SUPER Ultra W 16GB</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="Colorful iGame RTX 4080S">
            <input type="hidden" name="price" value="10199.00">
            <input type="hidden" name="description" value="火神水神UltraAD白色水冷电竞台式游戏直播AIPC显卡龙年礼盒 RTX 4080 SUPER Ultra W 16GB">
            <button type="submit">加入购物车</button>
        </form>
    </div>

    <div class="product">
        <img src="image/2.png">
        <h3>华硕RTX4090 24G白猛禽</h3>
        <div class="price">￥14759.00</div>
        <div class="description">
            <p>超龙台式机游戏显卡电竞4K败家之眼全新rog显卡 华硕TUF-RTX4090-OC-24G</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="华硕RTX4090 24G白猛禽">
            <input type="hidden" name="price" value="14759.00">
            <input type="hidden" name="description" value="超龙台式机游戏显卡电竞4K败家之眼全新rog显卡 华硕TUF-RTX4090-OC-24G">
            <button type="submit">加入购物车</button>
        </form>
    </div>

    <div class="product">
        <img src="image/3.png">
        <h3>华擎（ASRock）B560M PRO4</h3>
        <div class="price">￥799.00</div>
        <div class="description">
            <p>微ATX主板，支持Intel第10和第11代Core处理器，双通道DDR4 4800+(OC)</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="华擎（ASRock）B560M PRO4">
            <input type="hidden" name="price" value="799.00">
            <input type="hidden" name="description" value="微ATX主板，支持Intel第10和第11代Core处理器，双通道DDR4 4800+(OC)">
            <button type="submit">加入购物车</button>
        </form>
    </div>

    <div class="product">
        <img src="image/4.png">
        <h3>西部数据（Western Digital）WD Black SN850X 2TB NVMe SSD</h3>
        <div class="price">￥2999.00</div>
        <div class="description">
            <p>超高速M.2 2280 PCIe 4.0 x4内部游戏SSD，读写速度达7000MB/s</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="西部数据（Western Digital）WD Black SN850X 2TB NVMe SSD">
            <input type="hidden" name="price" value="2999.00">
            <input type="hidden" name="description" value="超高速M.2 2280 PCIe 4.0 x4内部游戏SSD，读写速度达7000MB/s">
            <button type="submit">加入购物车</button>
        </form>
    </div>

    <div class="product">
        <img src="image/5.png">
        <h3>技嘉（GIGABYTE）AORUS RTX 4060</h3>
        <div class="price">￥2599.00</div>
        <div class="description">
            <p>RGB风暴4K超频电竞游戏显卡AORUS RTX 4060 8G 机械鹰双球风扇固态</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="技嘉（GIGABYTE）AORUS RTX 4060">
            <input type="hidden" name="price" value="2599.00">
            <input type="hidden" name="description" value="RGB风暴4K超频电竞游戏显卡AORUS RTX 4060 8G 机械鹰双球风扇固态">
            <button type="submit">加入购物车</button>
        </form>
    </div>

    <div class="product">
        <img src="image/6.png">
        <h3>英特尔（Intel）Core i9-12900K</h3>
        <div class="price">￥5699.00</div>
        <div class="description">
            <p>桌面处理器，Alder Lake-S，16核32线程，3.2GHz至5.3GHz，LGA1700插槽</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="英特尔（Intel）Core i9-12900K">
            <input type="hidden" name="price" value="5699.00">
            <input type="hidden" name="description" value="桌面处理器，Alder Lake-S，16核32线程，3.2GHz至5.3GHz，LGA1700插槽">
            <button type="submit">加入购物车</button>
        </form>
    </div>

    <div class="product">
        <img src="image/7.png">
        <h3>Thermaltake（Tt）钢影 透S 海景房机箱</h3>
        <div class="price">￥229.00</div>
        <div class="description">
            <p>电脑主机 白色（ATX主板/支持360水冷/270°全景/9风扇位/4090显卡）</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="Thermaltake（Tt）钢影 透S 海景房机箱">
            <input type="hidden" name="price" value="229.00">
            <input type="hidden" name="description" value="电脑主机 白色（ATX主板/支持360水冷/270°全景/9风扇位/4090显卡）">
            <button type="submit">加入购物车</button>
        </form>
    </div>

    <div class="product">
        <img src="image/8.png">
        <h3>ROG枪神8</h3>
        <div class="price">￥899.00</div>
        <div class="description">
            <p>16英寸 14代酷睿i9 星云屏游戏本笔记本电脑(i9-14900HX 液金导热 16G 1T RTX4070 240Hz)</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="ROG枪神8">
            <input type="hidden" name="price" value="899.00">
            <input type="hidden" name="description" value="16英寸 14代酷睿i9 星云屏游戏本笔记本电脑(i9-14900HX 液金导热 16G 1T RTX4070 240Hz)">
            <button type="submit">加入购物车</button>
        </form>
    </div>

    <div class="product">
        <img src="image/9.png">
        <h3>芝奇戟RGB灯条(32G×2)套装</h3>
        <div class="price">￥8809.00</div>
        <div class="description">
            <p>台式机内存条3200频率 DDR4 F4-3200C14D-64GTRS银色 默认1</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="芝奇戟RGB灯条(32G×2)套装">
            <input type="hidden" name="price" value="8809.00">
            <input type="hidden" name="description" value="台式机内存条3200频率 DDR4 F4-3200C14D-64GTRS银色 默认1">
            <button type="submit">加入购物车</button>
        </form>
    </div>

    <div class="product">
        <img src="image/10.png">
        <h3>AMD Ryzen 7 5800X</h3>
        <div class="price">￥3999.00</div>
        <div class="description">
            <p>桌面处理器，Zen 3架构，8核16线程，3.8GHz至4.7GHz，AM4插槽</p>
        </div>
        <form action="cart.jsp" method="post">
            <input type="hidden" name="productName" value="AMD Ryzen 7 5800X">
            <input type="hidden" name="price" value="3999.00">
            <input type="hidden" name="description" value="桌面处理器，Zen 3架构，8核16线程，3.8GHz至4.7GHz，AM4插槽">
            <button type="submit">加入购物车</button>
        </form>
    </div>


</div>

<div class="footer">
    <p>版权所有 &copy; 西安拓未互联网科技有限责任公司</p>
</div>

</body>
</html>
