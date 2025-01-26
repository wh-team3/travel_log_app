<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.example.DatabaseConnection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
String userId = (String) session.getAttribute("userId");

if (userId == null) {
	response.sendRedirect("login.jsp");
	return;
}

List<Map<String, String>> recordList = new ArrayList<>();
try (Connection connection = DatabaseConnection.initializeDatabase()) {
	String sql = "SELECT record_id, title, visit_date, note, photo_path, prefecture FROM records WHERE user_id = ? ORDER BY visit_date DESC";
	PreparedStatement stmt = connection.prepareStatement(sql);
	stmt.setString(1, userId);
	ResultSet rs = stmt.executeQuery();

	while (rs.next()) {
		Map<String, String> record = new HashMap<>();
		record.put("record_id", rs.getString("record_id"));
		record.put("title", rs.getString("title"));
		record.put("visit_date", rs.getString("visit_date"));
		record.put("note", rs.getString("note"));
		record.put("photo_path", rs.getString("photo_path"));
		record.put("prefecture", rs.getString("prefecture"));
		recordList.add(record);
	}
} catch (SQLException | ClassNotFoundException e) {
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>すべての記録</title>
<style>
/* 全体のスタイル */
body {
	background: url('images/allRecord.png') no-repeat center center fixed;
	background-size: cover;
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	min-width: 1024px;
}

h1 {
	font-size: 3em;
	text-align: center;
	margin-top: 20px;
	color: #9c927c;
}

/* 戻るボタンのスタイル */
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

/* 記録一覧のスタイル */
.record-list {
	display: grid; /* グリッドレイアウトを使用 */
	grid-template-columns: 1fr 1fr; /* 2列配置 */
	gap: 70px 10px; /* ボックス間のスペース */
	padding: 40px 20px;
	max-width: 50%; /* 画面の左半分に制限 */
	margin-left: 5%; /* 左側に配置 */
}

/* ボックスのスタイル */
.record-card {
	width: 250px; /* 指定された幅に固定 */
	background: white;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	position: relative;
	overflow: hidden;
	padding: 15px;
}

/* ✐アイコンのスタイル */
.edit-text {
	font-size: 25px; /* テキストのサイズ */
	color: #ef8a41; /* テキストの色（オレンジ系） */
	font-weight: bold; /* 太字にする */
	text-decoration: underline; /* テキストに下線を追加 */
	position: absolute; /* ボックス内で絶対位置を指定 */
	bottom: 15px; /* ボックスの下から15pxの位置 */
	right: 15px; /* ボックスの右から15pxの位置 */
	cursor: pointer; /* マウスカーソルをクリック可能な手の形にする */
	transition: color 0.3s; /* ホバー時の色変化をスムーズに */
}

.edit-text:hover {
	color: black; /* ホバー時に少し濃いオレンジ色に変化 */
}

/* ボックスの配置をランダムに回転 */
.record-card:nth-child(even) {
	transform: rotate(-3deg) translateY(200px); /* 上下にずらす（偶数） */
}

.record-card:nth-child(odd) {
	transform: rotate(3deg) translateY(-40px); /* 上下にずらす（奇数） */
}

.record-card img {
	width: 100%;
	border-radius: 5px;
}

.record-card h2 {
	font-size: 1.2em;
	margin: 10px 0;
	font-weight: bold;
	color: #333;
}

.record-card p {
	font-size: 0.9em;
	color: #555;
	line-height: 1.5;
}

.record-card .date {
	font-size: 1.2em;
	color: #ef8a41;
	font-weight: bold;
	position: absolute;
	top: 10px;
	left: 10px;
}

.record-card .prefecture {
	font-size: 0.8em;
	color: white;
	background: #007bff;
	border-radius: 5px;
	padding: 5px;
	position: absolute;
	top: 10px;
	right: 10px;
}
</style>

</head>
<body>
	<!-- 戻るボタン -->
	<a href="record.jsp" class="back-button">← 戻る</a>
	<div class="container">
		<h1>すべての記録</h1>
		<%
		if (recordList.isEmpty()) {
		%>
		<p style="text-align: center; width: 100%;">保存された記録はありません。</p>
		<%
} else {
%>
		<div class="record-list">
			<%
			for (Map<String, String> record : recordList) {
			%>
			<div class="record-card">
				<span class="date"><%=record.get("visit_date")%></span> <span
					class="prefecture"><%=record.get("prefecture")%></span>
				<%
				if (record.get("photo_path") != null && !record.get("photo_path").isEmpty()) {
				%>
				<img src="<%=record.get("photo_path")%>" alt="記録写真">
				<%
				} else {
				%>
				<p style="text-align: center;">写真なし</p>
				<%
				}
				%>
				<h2><%=record.get("title")%></h2>
				<p><%=record.get("note")%></p>
				<div class="edit-text"
					onclick="editRecord('<%=record.get("record_id")%>')">✐</div>
			</div>
			<%
			}
			%>
		</div>
		<%
}
%>
		<script>
			function editRecord(recordId) {
				if (recordId) {
					window.location.href = "editRecord.jsp?id="
							+ encodeURIComponent(recordId);
				} else {
					alert("記録IDが取得できませんでした。");
				}
			}
		</script>
</body>
</html>
