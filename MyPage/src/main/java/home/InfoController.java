package home;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import membership.myMemberDAO;
import membership.myMemberDTO;

@WebServlet("/home/info.do")
public class InfoController extends HttpServlet  
{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		myMemberDAO dao = new myMemberDAO();
		
		String nickname =  req.getParameter("nickname");
		
		System.out.println(nickname);
		
		myMemberDTO dto = dao.selectView(nickname);
		dao.close();

		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("../Info.jsp").forward(req, resp);
	}

}
