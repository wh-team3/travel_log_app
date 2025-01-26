<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ include file="WEB-INF/header.jsp"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>旅行記録ページ</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background: url('images/record.png') no-repeat center center fixed;
	/* 画像のパスを指定 */
	background-size: cover;
	color: #333;
}

.container {
	position: fixed; /* 固定位置にする */
    top: 2.5%; /* 画面の縦方向中央 */
    left: 30%; /* 画面の横方向中央 */
	width: 600px;
	height: 600px;
	margin: 50px auto;
	padding: 20px;
	background: #ffffff;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.container h1 {
	text-align: center;
	margin-bottom: 20px;
	color: #9c927c;
	font-size: 2em;
	font-weight: bold;
	display: flex;
    align-items: center;
    justify-content: center;
}

.container h1 img {
    margin-right: 10px; /* テキストとの間隔 */
    filter: invert(72%) sepia(16%) saturate(375%) hue-rotate(18deg) brightness(85%) contrast(82%);
}

.form-group {
	margin-bottom: 5px;
}

.form-group label {
	display: block;
	font-weight: bold;
}

.form-group input, .form-group textarea, .form-group select {
	width: 80%;
	padding: 10px;
	margin: 5px 60px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

button {
	display: block;
	width: 20%;
	margin: 15px auto;
	padding: 15px;
	background-color: #ef8a41;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

button:hover {
	background-color: #9c927c;
}

.view-records-link {
	position: fixed; /* 固定位置にする */
	bottom: 40px; /* 下部からの距離 */
	right: 60px; /* 右側からの距離 */
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	padding: 40px 20px;
	font-size: 1em;
	text-align: center;
	display: flex;
	align-items: center;
	gap: 5px;
}

.view-records-link a {
	text-decoration: none;
	color: #ef8a41;
	font-weight: bold;
	font-size: 1.5em;
}

.view-records-link:after {
	content: '';
	position: absolute;
	bottom: -10px;
	right: 20px;
	width: 0;
	height: 0;
	border-style: solid;
	border-width: 20px 20px 0 20px;
	border-color: #fff transparent transparent transparent; /* 吹き出しの三角 */
}

.view-records-link a:hover {
	text-decoration: underline;
	color: #9c927c;
}

header {
	position: fixed; /* 固定する */
	top: 0; /* 上部に配置 */
	left: 0; /* 左端に配置 */
	width: 100%; /* ヘッダーを画面幅いっぱいに広げる */
	background-color: #fff; /* 背景色（任意） */
	z-index: 1000; /* 他の要素よりも前面に表示 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 軽い影を追加（オプション） */
}
</style>
</head>
<body>
	<div class="container">
		<h1>
			<img src="images/pin-icon.png" alt="ピンマーク" style=" width: 24px; height: 24px; margin-right: 8px;">
			旅行記録の追加
		</h1>
		<form action="SaveRecordServlet" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="prefecture">都道府県</label> <select id="prefecture"
					name="prefecture" required>
					<option value="" disabled selected>都道府県を選択</option>
					<option value="北海道">北海道</option>
					<option value="青森県">青森県</option>
					<option value="岩手県">岩手県</option>
					<option value="宮城県">宮城県</option>
					<option value="秋田県">秋田県</option>
					<option value="山形県">山形県</option>
					<option value="福島県">福島県</option>
					<option value="茨城県">茨城県</option>
					<option value="栃木県">栃木県</option>
					<option value="群馬県">群馬県</option>
					<option value="埼玉県">埼玉県</option>
					<option value="千葉県">千葉県</option>
					<option value="東京都">東京都</option>
					<option value="神奈川県">神奈川県</option>
					<option value="新潟県">新潟県</option>
					<option value="富山県">富山県</option>
					<option value="石川県">石川県</option>
					<option value="福井県">福井県</option>
					<option value="山梨県">山梨県</option>
					<option value="長野県">長野県</option>
					<option value="岐阜県">岐阜県</option>
					<option value="静岡県">静岡県</option>
					<option value="愛知県">愛知県</option>
					<option value="三重県">三重県</option>
					<option value="滋賀県">滋賀県</option>
					<option value="京都府">京都府</option>
					<option value="大阪府">大阪府</option>
					<option value="兵庫県">兵庫県</option>
					<option value="奈良県">奈良県</option>
					<option value="和歌山県">和歌山県</option>
					<option value="鳥取県">鳥取県</option>
					<option value="島根県">島根県</option>
					<option value="岡山県">岡山県</option>
					<option value="広島県">広島県</option>
					<option value="山口県">山口県</option>
					<option value="徳島県">徳島県</option>
					<option value="香川県">香川県</option>
					<option value="愛媛県">愛媛県</option>
					<option value="高知県">高知県</option>
					<option value="福岡県">福岡県</option>
					<option value="佐賀県">佐賀県</option>
					<option value="長崎県">長崎県</option>
					<option value="熊本県">熊本県</option>
					<option value="大分県">大分県</option>
					<option value="宮崎県">宮崎県</option>
					<option value="鹿児島県">鹿児島県</option>
					<option value="沖縄県">沖縄県</option>
				</select>
			</div>
			<div class="form-group">
				<label for="title">タイトル</label> <input type="text" id="title"
					name="title" required>
			</div>
			<div class="form-group">
				<label for="visitDate">訪問日</label> <input type="date" id="visitDate"
					name="visitDate" required>
			</div>
			<div class="form-group">
				<label for="note">記録内容</label>
				<textarea id="note" name="note" rows="5"></textarea>
			</div>
			<div class="form-group">
    			<label for="photos">写真:</label>
    			<input type="file" id="photos" name="photos[]" multiple>
			</div>
			<button type="submit">記録を保存</button>
		</form>
		<div class="view-records-link">
			<a href="allRecords.jsp">記録一覧を見る</a>
		</div>
	</div>
</body>
</html>