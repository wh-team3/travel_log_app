import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/EditProfileServlet")
@MultipartConfig
public class EditProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        // セッションからユーザーIDを取得
        String userId = (String) request.getSession().getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String age = request.getParameter("age");
        Part profilePhotoPart = request.getPart("profilePhoto");

        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            // 既存のプロフィール写真を取得
            String currentPhotoPath = null;
            PreparedStatement selectStmt = connection.prepareStatement(
                "SELECT profile_photo FROM users WHERE user_id = ?");
            selectStmt.setString(1, userId);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                currentPhotoPath = rs.getString("profile_photo");
            }

            // プロフィール写真の保存
            String photoPath = currentPhotoPath;
            if (profilePhotoPart != null && profilePhotoPart.getSize() > 0) {
                String fileName = profilePhotoPart.getSubmittedFileName();
                photoPath = "uploads/" + fileName; // 保存先のパスを指定
                String uploadPath = getServletContext().getRealPath("/") + photoPath;
                profilePhotoPart.write(uploadPath);
            }

            // データ更新クエリ
            String updateQuery = "UPDATE users SET name = ?, age = ?, profile_photo = ? WHERE user_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);

            // データの設定
            preparedStatement.setString(1, name);
            preparedStatement.setInt(2, Integer.parseInt(age));
            preparedStatement.setString(3, photoPath);
            preparedStatement.setString(4, userId);

            // データベース更新
            preparedStatement.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("<h1>プロフィールの更新に失敗しました。</h1>");
            return;
        }

        response.sendRedirect("mypage.jsp");
    }
}
