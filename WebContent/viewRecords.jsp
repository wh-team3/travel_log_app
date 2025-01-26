<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.sql.*, java.util.*"%>
<%@ include file="WEB-INF/header.jsp"%>
<%@ page import="com.example.DatabaseConnection"%>
<%
String userId = (String) session.getAttribute("userId");

if (userId == null) {
	response.sendRedirect("login.jsp");
	return;
}

String selectedPrefecture = request.getParameter("prefecture");
if (selectedPrefecture == null || selectedPrefecture.isEmpty()) {
	selectedPrefecture = "未設定";
}

List<Map<String, String>> recordList = new ArrayList<>();
try (Connection connection = DatabaseConnection.initializeDatabase()) {
	String sql = "SELECT record_id, title, visit_date, note, photo_path FROM records WHERE user_id = ? AND prefecture = ?";
	PreparedStatement stmt = connection.prepareStatement(sql);
	stmt.setString(1, userId);
	stmt.setString(2, selectedPrefecture);
	ResultSet rs = stmt.executeQuery();

	while (rs.next()) {
		Map<String, String> record = new HashMap<>();
		record.put("record_id", rs.getString("record_id"));
		record.put("title", rs.getString("title"));
		record.put("visit_date", rs.getString("visit_date"));
		record.put("note", rs.getString("note"));
		record.put("photo_path", rs.getString("photo_path"));
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
<title><%=selectedPrefecture%>の記録一覧</title>
<style>
/* 全体のスタイル */
body {
	background: url('images/viewRecord.jpg') no-repeat center center fixed;
	background-size: cover;
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

/* タイトル */
h1 {
	font-size: 2em;
	text-align: center;
	margin-top: 20px;
	color: #333;
}

/* 戻るボタンのスタイル */
.back-button {
	position: absolute;
	top: 20px;
	left: 20px;
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	border-radius: 5px;
	text-decoration: none;
	font-size: 14px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.back-button:hover {
	background-color: #0056b3;
}

/* 記録一覧のスタイル */
.record-list {
	display: grid;
	grid-template-columns: repeat(4, 1fr); /* 4列配置 */
	gap: 20px; /* ボックス間のスペース */
	padding: 40px;
	max-width: 83%; /* 幅の制限 */
	margin: 0 auto; /* 中央揃え */
}

/* ボックスのスタイル */
.record-card {
	background: white;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	position: relative;
	overflow: hidden;
	padding: 15px;
	transition: transform 0.3s;
}

.record-card:hover {
	transform: scale(1.05); /* ホバー時に少し拡大 */
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

/* 日付 */
.record-card .date {
	font-size: 1.5em;
	color: #ef8a41;
	font-weight: bold;
	position: absolute;
	top: 10px;
	left: 10px;
}

/* 都道府県タグ */
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

/* 編集リンク */
.record-card .edit-text {
	font-size: 25px;
	color: #ef8a41;
	font-weight: bold;
	text-decoration: underline;
	cursor: pointer;
	position: absolute;
	bottom: 15px;
	right: 15px;
}

.record-card .edit-text:hover {
	color: black;
}
</style>

<div class="record-list">
	<%
	if (recordList.isEmpty()) {
	%>
	<p style="text-align: center; width: 100%;">保存された記録はありません。</p>
	<%
	} else {
	%>
	<%
	for (Map<String, String> record : recordList) {
	%>
	<div class="record-card">
		<span class="date"><%=record.get("visit_date")%></span> <span
			class="prefecture"><%=selectedPrefecture%></span>
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
	<%
	}
	%>
</div>
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