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

@WebServlet("/SaveRecordServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class SaveRecordServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            if (part.getSize() > 0) { // 条件を緩める
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
            String sql = "INSERT INTO records (title, visit_date, prefecture, note, photo_path, user_id) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, title);
            stmt.setString(2, visitDate);
            stmt.setString(3, prefecture);
            stmt.setString(4, note);
            stmt.setString(5, photoPaths.toString());
            stmt.setInt(6, 1);

            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("<h1>記録の保存に失敗しました。</h1>");
        }

        response.sendRedirect("map.jsp");
    }
}
