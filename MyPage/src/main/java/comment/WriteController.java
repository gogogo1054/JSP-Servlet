package comment;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/comment/write.do")
public class WriteController extends HttpServlet
{
	
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		CMBoardDAO dao = new CMBoardDAO();
		CMBoardDTO dto = new CMBoardDTO();
		
		// 파리미터 값을 가져온다.
		String board_idx = req.getParameter("idx");
		String reply = req.getParameter("reply");
		if(reply == "")
		{
			reply = "카카오";
		}
		String writer = req.getParameter("writer");
		String reply_content = req.getParameter("reply_content");
		
		System.out.println(board_idx);
		System.out.println(reply);
		System.out.println(writer);
		System.out.println(reply_content);
		
		dto.setIdx(dao.getSeq());
		dto.setBoard_idx(board_idx);
		dto.setReply(reply);
		dto.setWriter(writer);
		dto.setReply_content(reply_content);
		
		int result = dao.insertComment(dto);

		if(result != 0)
		{
			resp.sendRedirect("../community/view.do?idx=" + board_idx); 
		}
		else
		{
			resp.sendRedirect("../Error.jsp");
		}
	}
}
