import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // **エンコーディング設定**
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // **セッションを無効化**
        HttpSession session = request.getSession(false); // セッションが存在する場合のみ取得
        if (session != null) {
            session.invalidate(); // セッションを破棄
        }

        // **ログインページへリダイレクト**
        response.sendRedirect("login.jsp");
    }
}
