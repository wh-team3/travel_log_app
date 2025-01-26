import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import com.example.DatabaseConnection;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

@WebServlet("/GetVisitCountsServlet")
public class GetVisitCountsServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		try (Connection connection = DatabaseConnection.initializeDatabase()) {
			String sql = "SELECT prefecture, COUNT(*) AS visit_count FROM records GROUP BY prefecture";
			PreparedStatement stmt = connection.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();

			Map<String, Integer> visitCounts = new HashMap<>();
			while (rs.next()) {
				visitCounts.put(rs.getString("prefecture"), rs.getInt("visit_count"));
			}
			rs.close();
			stmt.close();

			// JSONに変換して返す
			response.getWriter().write(new Gson().toJson(visitCounts));
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}
