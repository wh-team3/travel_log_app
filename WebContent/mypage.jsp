<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.example.DatabaseConnection" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    // セッションからユーザーIDを取得
    String userId = (String) session.getAttribute("userId");

    // ログインしていない場合はログインページにリダイレクト
    if (session == null || userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // データベースからユーザー情報を取得
    String name = "";
    int age = 0;
    String profilePhoto = "images/default.jpg"; // プロフィール画像のデフォルトパス

    try {
        Connection connection = DatabaseConnection.initializeDatabase();
        PreparedStatement stmt = connection.prepareStatement("SELECT name, age, profile_photo FROM users WHERE user_id = ?");
        stmt.setString(1, userId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            age = rs.getInt("age");
            profilePhoto = rs.getString("profile_photo") != null ? rs.getString("profile_photo") : "images/default.jpg";
        }

        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>エラーが発生しました。管理者に連絡してください。</p>");
    }
%>
<%@ include file="WEB-INF/header.jsp" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>マイページ</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url('images/background1.jpg') no-repeat center center fixed;
            background-size: cover; /* 背景画像を全画面に適用 */
        }

        .profile {
            position: relative;
            max-width: 600px;
            margin: 0 auto;
            text-align: center;
            top: 50%; /* 背景内で適切に配置 */
            transform: translateY(50%);
        }

        .profile img {
            width: 170px;
            height: 170px;
            border-radius: 50%; /* アイコンを円形に */
            object-fit: cover; /* 画像を枠に合わせる */
            border: 2px solid #ddd; /* 薄い枠線 */
            margin-bottom: 20px; /* アイコンと名前の間の余白 */
        }

        .profile h1 {
            font-size: 1.8em;
            color: #333;
            margin: 5px 0;
        }

        .profile p {
            font-size: 1em;
            color: #666;
            margin: 5px 0;
        }

        .edit-profile {
            margin-top: 20px;
        }

        .edit-profile a {
            display: inline-block;
            padding: 15px 50px;
            background-color: #9c927c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }

        .edit-profile a:hover {
            background-color: #d19a5e;
        }
    </style>
</head>
<body>
    <div class="profile">
        <%-- プロフィール画像 --%>
        <% if (profilePhoto != null && !profilePhoto.isEmpty()) { %>
            <img src="<%= profilePhoto %>" alt="プロフィール写真">
        <% } %>
        <%-- 名前 --%>
        <h1><%= name %></h1>
        <%-- 年齢 --%>
        <p>年齢: <%= age %>歳</p>
        <%-- プロフィール編集ボタン --%>
        <div class="edit-profile">
            <a href="editProfile.jsp">プロフィール編集</a>
        </div>
    </div>
</body>
</html>