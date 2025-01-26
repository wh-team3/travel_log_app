<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.example.DatabaseConnection"%>
<%@ page import="java.sql.*"%>
<%
String recordId = request.getParameter("id");

// 記録IDがない場合、エラーを表示して終了
if (recordId == null || recordId.trim().isEmpty()) {
    out.println("<h1>エラー: 記録IDが指定されていません。</h1>");
    return;
}

String title = "";
String visitDate = "";
String prefecture = "";
String note = "";
String photoPath = null; // 初期値を null に設定

try (Connection connection = DatabaseConnection.initializeDatabase()) {
    String sql = "SELECT title, visit_date, prefecture, note, photo_path FROM records WHERE record_id = ?";
    PreparedStatement stmt = connection.prepareStatement(sql);
    stmt.setInt(1, Integer.parseInt(recordId));
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        title = rs.getString("title");
        visitDate = rs.getString("visit_date");
        prefecture = rs.getString("prefecture");
        note = rs.getString("note");
        photoPath = rs.getString("photo_path"); // ここで photoPath を取得
    } else {
        out.println("<h1>エラー: 指定された記録が見つかりません。</h1>");
        return;
    }
} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>記録の編集</title>
<style>
/* 戻るボタンのスタイル */
.back-button {
	position: absolute;
	top: 13px;
	left: 20px;
	font-size: 1em;
	text-decoration: none;
	color: #555;
	padding: 10px 15px;
	border: 1px solid #ddd;
	background-color: #fff;
	border-radius: 5px;
}

.back-button:hover {
	background-color: #f5f5f5;
}

/* ページ全体のスタイル */
body {
	background: url('images/editRecord.png') no-repeat center center fixed;
	background-size: cover;
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 800px;
	margin: 70px auto 0;
	padding: 20px;
	background: #ffffff;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.container h1 {
	margin-bottom: 20px;
	font-size: 30px;
	color: #9c927c;
	text-align: center;
}

.container form {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.container form label {
	font-weight: bold;
	color: #333;
}

.container form input, .container form textarea, .container form select,
	.container form button {
	width: 85%;
	padding: 13px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin: 0 auto;
}

.container form button {
	width: 30%;
	background-color: #ef8a41;
	color: white;
	cursor: pointer;
	font-size: 18px;
	margin: 0 auto;
}

.container form button:hover {
	background-color: #9c927c;
}

img {
	max-width: 200px;
	border-radius: 5px;
}
</style>
</head>
<body>
	<!-- 戻るボタン -->
	<a href="map.jsp" class="back-button">← 戻る</a>

	<div class="container">
		<h1>記録の編集</h1>
		<%
        if ("true".equals(request.getParameter("success"))) {
        %>
		<div
			style="color: green; font-weight: bold; text-align: center; margin: 10px 0;">
			記録が更新されました！</div>
		<script>
            setTimeout(() => {
                window.location.href = "map.jsp";
            }, 2000);
        </script>
		<%
        }
        %>
		<form action="<%=request.getContextPath()%>/EditRecordServlet"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="record_id" value="<%=recordId%>">

			<label for="title">タイトル:</label> <input type="text" id="title"
				name="title" value="<%=title%>" required> <label
				for="visitDate">訪問日:</label> <input type="date" id="visitDate"
				name="visitDate" value="<%=visitDate%>" required> <label
				for="prefecture">訪問した県:</label> <select id="prefecture"
				name="prefecture" required>
				<option value="" disabled selected>都道府県を選択</option>
				<%
                String[] prefectures = {"北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県", "泊越県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳩取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"};
                for (String p : prefectures) {
                    if (p.equals(prefecture)) {
                %>
				<option value="<%=p%>" selected><%=p%></option>
				<%
                    } else {
                %>
				<option value="<%=p%>"><%=p%></option>
				<%
                    }
                }
                %>
			</select> <label for="note">記録内容:</label>
			<textarea id="note" name="note" rows="5"><%=note%></textarea>

			<label for="photo">写真:</label> <input type="file" id="photo"
				name="photos" multiple>
			<%
            if (photoPath != null && !photoPath.isEmpty()) {
                String[] photoPaths = photoPath.split(";");
                for (String path : photoPaths) {
            %>
			<img src="<%=path%>" alt="現在の写真" style="margin-right: 10px;">
			<%
                }
            } else {
            %>
			<p>写真が登録されていません。</p>
			<%
            }
            %>

			<button type="submit">保存</button>
		</form>
	</div>
</body>
</html>