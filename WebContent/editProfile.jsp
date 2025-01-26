<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>プロフィール編集</title>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background: #f0f0f0;
}

.container {
	display: flex;
	width: 100vw;
	height: 100vh;
}

.left-panel {
	width: 45%;
	padding: 50px;
	background: #ffffff;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.left-panel h1 {
	font-size: 2.5em;
	color: #333;
	margin-bottom: 45px;
}

.left-panel label {
	display: block;
	margin-bottom: 0px;
	color: #666;
	font-weight: bold;
	font-size: 1.5em
}

.left-panel input[type="text"], .left-panel input[type="number"] {
	width: 90%;
	padding: 10px 0; /* 下線の位置を調整 */
	margin-bottom: 20px;
	border: none;
	border-bottom: 2px solid #ddd;
	box-sizing: border-box;
	outline: none;
	transition: border-color 0.3s ease;
}

.left-panel input[type="text"]:focus, .left-panel input[type="number"]:focus
	{
	border-bottom: 2px solid #9c927c;
}

.icon-upload-wrapper {
	display: flex;
	align-items: stretch;
	justify-content: flex-start; /* 左寄せ */
	margin-bottom: 20px; /* 下にスペース */
}

.icon {
	width: 160px;
	height: 160px;
	border-radius: 50%;
	background-size: cover;
	background-position: center;
	border: 2px solid #ddd;
	background-image: url('images/default-profile.png'); /* デフォルト画像を設定 */
	cursor: pointer;
	display: block;
	overflow: hidden;
}

.icon:hover {
	border-color: #9c927c;
}

input[type="file"] {
	display: none; /* ファイル選択ボタンを隠す */
}

.button-wrapper {
	display: flex;
	justify-content: center; /* ボタンを中央に配置 */
	margin-top: 30px; /* 上部にスペースを追加 */
}

button {
	background-color: #9c927c;
	color: white;
	border: none;
	padding: 15px 40px;
	font-size: 1.5em;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

button:hover {
	background-color: #d19a5e;
}

.right-panel {
	width: 55%;
	background: url('images/editProfile.png') no-repeat center center;
	background-size: cover;
}

.back-button {
	position: absolute;
	top: 20px;
	left: 20px;
	font-size: 1em;
	text-decoration: none;
	color: #555;
	padding: 10px 15px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
}

.back-button:hover {
	background-color: #f5f5f5;
}
</style>
</head>
<body>
	<div class="container">
		<div class="left-panel">
			<a href="mypage.jsp" class="back-button">← 戻る</a>
			<h1>プロフィール編集</h1>
			<form action="EditProfileServlet" method="post"
				enctype="multipart/form-data">
				<label for="name">名前</label> <input type="text" id="name"
					name="name" required> <label for="age">年齢</label> <input
					type="number" id="age" name="age" required>

				<div class="icon-upload-wrapper">
					<label for="profilePhoto" class="icon" id="photoPreview"></label> <input
						type="file" id="profilePhoto" name="profilePhoto" accept="image/*"
						onchange="keepDefaultImage(event)">
				</div>
				<div class="button-wrapper">
					<button type="submit">保存</button>
				</div>
			</form>
		</div>
		<div class="right-panel"></div>
	</div>

	<script>
		function keepDefaultImage(event) {
			// 選択された画像はアップロードされますが、表示は変更しません
			const file = event.target.files[0];
			if (file) {
				// 選択されたファイル名をログに出力（デバッグ用）
				console.log("Selected file:", file.name);
			}
		}
	</script>
</body>
</html>
