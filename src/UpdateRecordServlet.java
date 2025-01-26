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

@WebServlet("/UpdateRecordServlet")
public class UpdateRecordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String recordId = request.getParameter("recordId");
        String title = request.getParameter("title");
        String visitDate = request.getParameter("visitDate");
        String prefecture = request.getParameter("prefecture");
        String note = request.getParameter("note");

        if (recordId == null || recordId.isEmpty() || title == null || title.isEmpty() || visitDate == null || visitDate.isEmpty()) {
            response.sendRedirect("editRecord.jsp?error=missing_data");
            return;
        }

        try (Connection connection = DatabaseConnection.initializeDatabase()) {
            String sql = "UPDATE records SET title = ?, visit_date = ?, prefecture = ?, note = ? WHERE record_id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setDate(2, java.sql.Date.valueOf(visitDate));
            stmt.setString(3, prefecture);
            stmt.setString(4, note);
            stmt.setInt(5, Integer.parseInt(recordId));

            stmt.executeUpdate();
            response.sendRedirect("viewRecords.jsp?success=true");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("editRecord.jsp?error=database_error");
        }
    }
}