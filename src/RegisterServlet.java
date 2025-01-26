import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.example.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/RegisterServlet") // URLマッピング
@MultipartConfig // ファイルアップロードを扱うための設定
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Part profilePhotoPart = request.getPart("profilePhoto");

        String photoPath = "uploads/" + profilePhotoPart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/") + photoPath;
        profilePhotoPart.write(uploadPath);

        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            String sql = "INSERT INTO users (name, age, email, password, profile_photo) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setInt(2, age);
            stmt.setString(3, email);
            stmt.setString(4, password);
            stmt.setString(5, photoPath);
            stmt.executeUpdate();
            response.sendRedirect("login.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("<h1>登録に失敗しました。</h1>");
        }
    }
}

