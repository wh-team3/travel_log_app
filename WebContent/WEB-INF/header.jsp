<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="css/style.css">
<style>
/* ヘッダー全体の色とスタイル */
body header {
	background-color: #8a7b6a !important; /* ヘッダーの色 */
	color: white;
}

/* ナビゲーションリンクのホバー効果 */
header .navbar a:hover {
	color: #8a7b6a /* ホバー時の色を黄色 */
}
</style>
<title>Header</title>
</head>
<body>
	<header>
		<div class="header">
			<nav class="navbar">
				<ul class="nav-list">
					<li><a href="map.jsp">地図</a></li>
					<li><a href="record.jsp">記録</a></li>
					<li><a href="mypage.jsp">マイページ</a></li>
					<li><a href="logout">ログアウト</a></li>
				</ul>
			</nav>
		</div>
	</header>
</body>
</html>
