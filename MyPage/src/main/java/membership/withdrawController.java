package membership;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/membership/withdraw.do")
public class withdrawController extends HttpServlet
{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		RequestDispatcher rd = req.getRequestDispatcher("/withdraw.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		req.setCharacterEncoding("UTF-8");
		
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
        String name = req.getParameter("name");

        myMemberDAO mdao = new myMemberDAO();
        int result = mdao.deleteMember(id, pwd, name);
        mdao.close();
        
        if(result == 1)
        {
        	System.out.println("회원탈퇴성공");
        	req.getRequestDispatcher("/withdrawSuccess.jsp").forward(req, resp);
        }
        else
        {
        	System.out.println("회원탈퇴실패");
        	req.getRequestDispatcher("/withdrawError.jsp").forward(req, resp);
        	
        }
	}
}
