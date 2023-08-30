package community;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.BoardPage;

@WebServlet("/community/list.do")
public class ListController extends HttpServlet
{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		// DAO객체 생성을 통해 커넥션풀로 DB에 연결한다.
		CommunityDAO dao = new CommunityDAO();
		
		// Model(데이터베이스), View(JSP페이지)로 파라미터 및 데이터를 전달하기 위해 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -7); //7일간 보이도록 하기위해서.
        String nowday = format.format(cal.getTime());
        
        req.setAttribute("nowday",nowday);
		
		// request내장객체를 통해 파라미터를 받아온다.
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		
		if(searchWord != null)
		{
			// 검색어가 있는 경우 Map에 파라미터를 저장한다.
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		
		// 전체게시물의 개수를 카운트하여 반환한다. 게시물의 개수를 통해
		// 가상번호를 부여하거나 전체 페이지수를 계산한다.
		int totalCount = dao.selectCount(map);
		
		// 페이지 처리 start
		/*
		 	서블릿에서 application내장객체를 얻어온 후 web.xml에 설정한 컨텍스트
		 	초기화 파라미터를 읽어온다. 한 페이지에 출력할 게시물의 개수와 한 블럭당
		 	출력할 페이지번호의 개수이다.
		 */
		ServletContext application = getServletContext();
		
		int pageSize =
				Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage =
				Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		/*
		 	목록에 첫 진입시 무조건 1페이지로 가정한 후 게시물을 얻어온다.
		 	특정페이지로 진입한 경우에는 파라미터를 받아서 구간을 계산한다.
		 */
		int pageNum = 1;
		// 파라미터로 넘어오는 pageNum이 있다면 값을 얻어온다.
		String pageTemp = req.getParameter("pageNum");
		// 값이 잇다면 정수로 변환한 후 페이지 번호로 지정한다.
		if(pageTemp != null && !pageTemp.equals(""))
		{
			pageNum = Integer.parseInt(pageTemp);
		}
		
		// 게시물 구간을 계산한다.
		int start = (pageNum-1) * pageSize + 1;
		int end = pageNum*pageSize;
		// 계산된 값은 Model로 전달되기 위해 Map 컬렉션에 저장한다.
		map.put("start", start);
		map.put("end", end);
		// 페이지 처리 end
		
		// 현재 페이지에 출력할 게시물을 select 한다.
		List<CommunityDTO> boardLists = dao.selectListPage(map);
		// 커넥션 풀에 자원 반납
		dao.close();
		
		// 페이지 번호를 생성하기 위한 유틸리티 클래스의 메소드 호출
		// 모델1 방식의 게시판에서 사용했던 메소드를 그대로 사용한다.
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, 
				"../community/list.do");
		
		// View로 전달할 데이터를 Map에 저장한다.
		// 목록 하단에 출력할 페이지 번호
		map.put("pagingImg", pagingImg);
		// 전체 게시물의 개수
		map.put("totalCount", totalCount);
		// 한 페이지당 출력할 게시물의 개수(설정값)
		map.put("pageSize", pageSize);
		// 현재 페이지 번호
		map.put("pageNum", pageNum);
		
		// View로 전달할 객체들을 request 영역에 저장한다.
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		// View로 포워드를 걸어준다.
		req.getRequestDispatcher("/community/List.jsp").forward(req, resp);
		
	}

}
