import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Collection;

import com.example.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/RecordServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class RecordServlet extends HttpServlet {
	private static final String UPLOAD_DIR = "uploads";

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String title = request.getParameter("title");
		String visitDate = request.getParameter("visitDate");
		String prefecture = request.getParameter("prefecture");
		String note = request.getParameter("note");

		if (title == null || title.trim().isEmpty()) {
			response.getWriter().println("<h1>Error: Title is required</h1>");
			return;
		}

		// 写真を保存
		StringBuilder photoPaths = new StringBuilder();
		Collection<Part> parts = request.getParts();

		for (Part part : parts) {
			if (part.getSize() > 0) { // "photos"でフィルタリングを削除
				String fileName = part.getSubmittedFileName();
				if (fileName != null && !fileName.isEmpty()) {
					String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
					File uploadDir = new File(uploadPath);
					if (!uploadDir.exists()) {
						uploadDir.mkdir();
					}
					String filePath = uploadPath + File.separator + fileName;
					part.write(filePath);
					if (photoPaths.length() > 0) {
						photoPaths.append(";");
					}
					photoPaths.append(UPLOAD_DIR).append("/").append(fileName);

					// デバッグログ
					System.out.println("Uploaded file: " + fileName + " to " + filePath);
				}
			}
		}

		System.out.println("Photo Paths: " + photoPaths.toString());

		// データベースに保存
		try (Connection connection = DatabaseConnection.initializeDatabase()) {
			String sql = "INSERT INTO records (user_id, title, visit_date, prefecture, note, photo_path) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = connection.prepareStatement(sql);

			int userId = 1; // 仮のユーザーID

			stmt.setInt(1, userId);
			stmt.setString(2, title);
			stmt.setDate(3, java.sql.Date.valueOf(visitDate));
			stmt.setString(4, prefecture);
			stmt.setString(5, note);
			stmt.setString(6, photoPaths.toString());

			System.out.println("Saving to database: " + photoPaths.toString());

			stmt.executeUpdate();
			stmt.close();
			response.sendRedirect("map.jsp");
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			response.getWriter().println("<h1>記録の保存に失敗しました。</h1>");
		}
	}
}
