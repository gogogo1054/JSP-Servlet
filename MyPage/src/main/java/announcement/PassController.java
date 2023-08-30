package announcement;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fileupload.FileUtil;
import membership.myMemberDAO;
import utils.JSFunction;

@WebServlet("/announcement/pass.do")
public class PassController extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		// 입력한 비밀번호와 hidden박스에서 전송된 파라미터 받기
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		
		// DAO 객체 생성 및 패스워드 검증
		ACMBoardDAO dao = new ACMBoardDAO();
		boolean confirm = dao.confirmIdx(idx);
		dao.close();
		
		System.out.print(confirm);
		// 패스워드 검증에 성공한 경우
		if(confirm == true)
		{
			if(mode.equals("edit"))
			{
				/*
				  	수정의 경우 검증이 완료된 패스워드를 session영역에 저장한다.
				  	session 영역은 페이지를 이동해도 데이터가 공유되므로 해당 게시물을
				  	수정완료할떄까지 유지하고, 수정이 완료되면 제거한다. 여기에서 저장한
				  	패스워드는 수정을 위한 update쿼리문의 where절에 사용한다.
				 */
				
				// getsession()메서드를 통해 session객체를 얻어온다.
				HttpSession session = req.getSession();
				// 검증에 사용된 패스워드를 session영역에 저장한다.
				session.setAttribute("idx", idx);
				/*
				 	수정페이지로 이동한다. 만약 아래 URL패턴을 이용해서 패스워드 검증 없이
				 	진입하였다면 세션에 저장된 패스워드가 없을것이므로 수정 처리가 되지 않도록
				 	처리한다.(보안)
				 */
				resp.sendRedirect("../announcement/edit.do?idx=" + idx);
			}
			else if(mode.equals("delete"))
			{
				// 게시물을 삭제하고 첨부파일이 있는 경우 같이 삭제한다.
				dao = new ACMBoardDAO();
				// 기존 게시물의 내용을 읽어온다.
				ACMBoardDTO dto = dao.selectView(idx);
				
				// 게시물을 삭제한다.
				int result = dao.deletePost(idx);
				dao.close();
				
				// 게시물 삭제에 성공했다면
				if(result == 1)
				{
					// 파일도 삭제한다.
					String saveFileName = dto.getSfile();
					FileUtil.deleteFile(req, "/Uploads", saveFileName);
				}
				// 삭제가 완료되면 리스트로 이동한다.
				JSFunction.alertLocation(resp, "삭제되었습니다.", "../announcement/list.do");
			}
		}
		else
		{
			// 검증에 실패할 경우
			JSFunction.alertBack(resp, "비밀번호 검증에 실패했습니다.");
		}

	}
	
	
	
}
