import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.example.DatabaseConnection;

@WebServlet("/EditRecordServlet")
@MultipartConfig // ファイルアップロードを扱うための設定
public class EditRecordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// **エンコーディング設定**
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		// **リクエストパラメータを取得**
		String recordId = request.getParameter("record_id");
		String title = request.getParameter("title");
		String visitDate = request.getParameter("visitDate");
		String prefecture = request.getParameter("prefecture");
		String note = request.getParameter("note");

		// **必須フィールドのバリデーション**
		if (recordId == null || recordId.trim().isEmpty()) {
			response.getWriter().println("<h1>Error: Missing record ID</h1>");
			return;
		}

		if (title == null || title.trim().isEmpty()) {
			response.getWriter().println("<h1>Error: Title is required</h1>");
			return;
		}

		try (Connection connection = DatabaseConnection.initializeDatabase()) {
			// **SQL 更新文**
			String sql = "UPDATE records SET title = ?, visit_date = ?, prefecture = ?, note = ?, photo_path = ? WHERE record_id = ?";
			PreparedStatement stmt = connection.prepareStatement(sql);

			// **SQL パラメータを設定**
			stmt.setString(1, title); // タイトル
			stmt.setDate(2, java.sql.Date.valueOf(visitDate)); // 訪問日
			stmt.setString(3, prefecture); // 都道府県
			stmt.setString(4, note); // 記録内容

			// **写真アップロード処理**
			StringBuilder photoPaths = new StringBuilder();
			for (Part part : request.getParts()) {
				if (part.getName().equals("photos") && part.getSize() > 0) {
					String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
					File uploadDir = new File(uploadPath);
					if (!uploadDir.exists()) {
						uploadDir.mkdir(); // uploadsディレクトリがない場合は作成
					}
					String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
					String photoPath = "uploads/" + fileName;
					part.write(uploadPath + File.separator + fileName);
					if (photoPaths.length() > 0) {
						photoPaths.append(";"); // セミコロンで区切り
					}
					photoPaths.append(photoPath);
				}
			}

			stmt.setString(5, photoPaths.toString()); // 複数の写真パスを保存
			stmt.setInt(6, Integer.parseInt(recordId)); // レコードID

			// **SQL 実行**
			int rowsUpdated = stmt.executeUpdate();

			if (rowsUpdated > 0) {
				// **成功時の処理**
				response.sendRedirect("editRecord.jsp?success=true&id=" + recordId);
			} else {
				response.getWriter().println("<h1>Error: Record not found</h1>");
			}
		} catch (SQLException | ClassNotFoundException e) {
			// **エラー処理**
			e.printStackTrace();
			response.getWriter().println("<h1>記録の更新に失敗しました。</h1>");
		}
	}
}