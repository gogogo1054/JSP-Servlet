package membership;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/membership/join.do")
public class joinController extends HttpServlet
{

	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd = req.getRequestDispatcher("/membership.jsp");
		rd.forward(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		req.setCharacterEncoding("UTF-8");
        
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String pwd = req.getParameter("pwd");
        String nickname = req.getParameter("nickname");
        
        String p1 = req.getParameter("pnum1"); 
        String p2 = req.getParameter("pnum2"); 
        String p3 = req.getParameter("pnum3");
        // 전화번호에 - 추가
        String phone = p1 + "-" + p2 + "-" + p3;
        
        String email = req.getParameter("email");
        
        String postcode = req.getParameter("postcode");
        
        String h1 = req.getParameter("post1");
        String h2 = req.getParameter("post2");
        String h3 = req.getParameter("post3");
        String post =h1 + " " + h2 + " " + h3;
        
        String ban = "0";
        
        myMemberDTO mdto = new myMemberDTO
        (id, name, pwd, nickname, phone, email, postcode, post, ban);
        
        myMemberDAO mdao = new myMemberDAO();
        
        // 아이디 중복 체크
        int checkId = mdao.checkId(id);
        
        if(checkId == 1)
        {
        	System.out.println("이미 존재하는 아이디입니다.");
        	req.getRequestDispatcher("/joinError.jsp").forward(req, resp);
        }
        else
        {
        	// 닉네임 중복 체크
            int checkNick = mdao.checkNick(nickname);
        	
        	if(checkNick == 1)
        	{
        		System.out.println("이미 존재하는 닉네임입니다.");
            	req.getRequestDispatcher("/nickError.jsp").forward(req, resp);
        	}
        	else
        	{
        		int result = mdao.InsertMember(mdto);
        		
        		if(result == 1)
        		{
        			System.out.println("회원가입 성공");
        			req.getRequestDispatcher("/joinSuccess.jsp").forward(req, resp);
        		}
        		else
        		{
        			System.out.println("회원가입 실패");
        			req.getRequestDispatcher("/Error.jsp").forward(req, resp);
        		}
        	}
        }
        
        mdao.close();
	}
}
