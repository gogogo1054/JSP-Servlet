package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import membership.myMemberDAO;
import membership.myMemberDTO;

@WebServlet("/admin/banclear.do")
public class banClearController extends HttpServlet
{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		req.setCharacterEncoding("UTF-8");

		String id = req.getParameter("id");
		System.out.println(id);
		myMemberDAO dao = new myMemberDAO();
		 int result = dao.banClearMember(id);
	        dao.close();
	        
	        if(result == 1)
	        {
	        	System.out.println("정지해제성공");
	        	req.getRequestDispatcher("list.do").forward(req, resp);
	        }
	        else
	        {
	        	System.out.println("정지해제실패");
	        	req.getRequestDispatcher("../Error.jsp").forward(req, resp);
	        	
	        }
		
	}	
	
}
