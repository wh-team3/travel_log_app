<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>新規登録</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: url('images/login.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .register-box {
            background: rgba(255, 255, 255, 0.85);
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 400px;
            color: #3d3d3d;
        }
        .register-box input {
            width: 85%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }
        .register-box button {
            width: 60%;
            padding: 12px;
            background-color: #9c927c;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
        }
        .register-box button:hover {
            background-color: #d19a5e;
        }
    </style>
</head>
<body>
    <div class="register-box">
        <h1>新規登録</h1>
        <form action="RegisterServlet" method="post" enctype="multipart/form-data">
            <input type="text" name="name" placeholder="名前" required>
            <input type="number" name="age" placeholder="年齢" required>
            <input type="email" name="email" placeholder="メールアドレス" required>
            <input type="password" name="password" placeholder="パスワード" required>
            <input type="file" name="profilePhoto" required>
            <button type="submit">登録</button>
        </form>
    </div>
</body>
</html>