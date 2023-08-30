package comment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import membership.myMemberDAO;

@WebServlet("/comment/delete.do")
public class DeleteController extends HttpServlet
{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		req.setCharacterEncoding("UTF-8");
		
		String idx = req.getParameter("idx");
		String board_idx = req.getParameter("board_idx");
		
		System.out.println(idx + " " +  board_idx);
		
		CMBoardDAO dao = new CMBoardDAO();
        int result = dao.deleteComment(idx, board_idx);
        
        if(result == 1)
        {
            	System.out.println("삭제 성공");
            	resp.sendRedirect("../community/view.do?idx=" + board_idx); 
        }
        else
        {
        	System.out.println("삭제 실패");
        	resp.sendRedirect("../Error.jsp");
        }
	
        dao.close();
	}
	
}
