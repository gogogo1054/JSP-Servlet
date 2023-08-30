package admin;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import membership.myMemberDAO;
import membership.myMemberDTO;

/*
 	어노테이션을 통한 매핑은 요청명을 해당 컨트롤러 상단에 기술한다.
 	web.xml에 기술하는 것과 동일하게 입력이 잘못되는 경우 톰캣이
 	시작되지 않을 수 있어 주의해야 한다.
 */
@WebServlet("/admin/view.do")
public class ViewController extends HttpServlet
{
	/*
	 	service()는 서블릿의 수명주기 메서드 중 사용자의 요청을
	 	전송방식에 상관 없이 먼저 받아 doGet() 혹은 doPost()로 요청을
	 	전달하는 역할을 한다. 따라서 전송방식에 상관없이 요청을 처리할 수 있다.
	 */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		// DAO객체 생성을 통해 커넥션풀 객체를 얻어온다.
		myMemberDAO dao = new myMemberDAO();
		// 일련번호를 받아온다.
		String nickname = req.getParameter("nickname");
		// 게시물을 출력한다.
		myMemberDTO dto = dao.selectView(nickname);
		// 커넥션풀 자원 반납
		dao.close();

		// request 영역에 DTO객체를 저장한 후 View로 포워드한다.	
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/admin/View.jsp").forward(req, resp);
	}
}
