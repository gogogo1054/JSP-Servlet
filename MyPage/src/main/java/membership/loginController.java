package membership;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/membership/login.do")
public class loginController extends HttpServlet
{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		
		myMemberDAO mdao = new myMemberDAO();
        int result = mdao.loginMember(id, pwd);
        
        HttpSession session = req.getSession();
        String nick = mdao.takeNick(id, pwd);
        
        if(result == 1)
        {
	        if(mdao.banChcek(id))
	        {
            	session.setAttribute("nick", nick);
            	System.out.println(nick);
            	System.out.println("로그인 성공");
            	resp.sendRedirect("../home/main.do"); 
            }
	        else
	        {
	        	System.out.println("로그인 실패(정지)");
	        	req.getRequestDispatcher("/banError.jsp").forward(req, resp);
	        }
        }
        else
        {
        	System.out.println("로그인 실패(중복)");
        	req.getRequestDispatcher("/withdrawError.jsp").forward(req, resp);
        }
	
        mdao.close();
	}
	
}
