<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="WEB-INF/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ログイン</title>
    <style>
        @font-face {
            font-family: 'Noto Sans Japanese';
            src: url('fonts/NotoSansJP-VariableFont_wght.ttf'); /* フォントファイルのパスを指定 */
        }

        @font-face {
            font-family: 'Playfair Display';
            src: url('fonts/PlayfairDisplay-Italic-VariableFont_wght.ttf'); /* フォントファイルのパスを指定 */
        }

        body {
            font-family: 'Noto Sans Japanese', Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: url('images/login.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        /* 上下の茶色デザイン */
        .top-bar, .bottom-bar {
            position: absolute;
            width: 100%;
            height: 50px;
            background-color: #8a7b6a;
        }

        .top-bar {
            top: 0;
        }

        .bottom-bar {
            bottom: 0;
        }

        .login-box {
            background: rgba(255, 255, 255, 0.85);
            padding: 50px 3px;
            border-radius: 50px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 400px
        }

        .login-box h1 {
            margin-bottom: 20px;
            font-size: 1.8em;
            color: #3d3d3d;
            font-family: 'Noto Sans Japanese', Arial, sans-serif;
        }

        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 85%;
            padding: 12px;
            margin: 7px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1em;
            font-family: 'Noto Sans Japanese', Arial, sans-serif;
        }

        .login-box button {
            width: 60%;
            padding: 12px;
            margin-top: 25px;
            background-color: #9c927c;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            font-family: 'Noto Sans Japanese', Arial, sans-serif;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .login-box button:hover {
            background-color: #d19a5e;
        }

        /* TEAM.3のデザイン */
        .header {
            position: absolute;
            top: 10px;
            width: 100%;
            text-align: center;
            font-size: 1.5em;
            color: #ffffff;
            font-family: 'Playfair Display', 'Georgia', serif;
             /* 影を追加 */
        }
    </style>
</head>
<body>
    <div class="top-bar"></div> <!-- 上部の茶色デザイン -->
    <div class="header">TEAM.3</div> <!-- TEAM.3の特別デザイン -->
    <div class="login-box">
        <h1>ログイン</h1>
        <form action="LoginServlet" method="post">
            <input type="text" name="email" placeholder="メールアドレス" required>
            <input type="password" name="password" placeholder="パスワード" required>
            <button type="submit">ログイン</button>
            <div class="register-link">
    			<a href="register.jsp">新規登録</a>
			</div>
        </form>
    </div>
    <div class="bottom-bar"></div> <!-- 下部の茶色デザイン -->
</body>
</html>