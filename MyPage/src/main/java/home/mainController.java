package home;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import announcement.ACMBoardDTO;
import comment.CMBoardDTO;
import community.CommunityDTO;
import utils.BoardPage;

@WebServlet("/home/main.do")
public class mainController extends HttpServlet 
{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		MainDAO dao = new MainDAO();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int totalCount = dao.selectCount(map);
		
		ServletContext application = getServletContext();
		
		int pageSize =
				Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE_MAIN"));
		int blockPage =
				Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		int pageNum = 1;

		String pageTemp = req.getParameter("pageNum");

		if(pageTemp != null && !pageTemp.equals(""))
		{
			pageNum = Integer.parseInt(pageTemp);
		}
		
		int start = (pageNum-1) * pageSize + 1;
		int end = pageNum*pageSize;

		map.put("start", start);
		map.put("end", end);
		
		List<ACMBoardDTO> boardLists = dao.selectListPage(map);
		
		dao.close();
		
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, 
				"../announcement/list.do");
		
		map.put("pagingImg", pagingImg);

		map.put("totalCount", totalCount);

		map.put("pageSize", pageSize);

		map.put("pageNum", pageNum);
		
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		
///////////////////////////////////////////////////////////////////////////////////////	
		
		MainDAO dao2 = new MainDAO();
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		
		int totalCount2 = dao2.selectCount2(map2);
		
		ServletContext application2 = getServletContext();
		
		int pageSize2 =
				Integer.parseInt(application2.getInitParameter("POSTS_PER_PAGE_MAIN"));
		int blockPage2 =
				Integer.parseInt(application2.getInitParameter("PAGES_PER_BLOCK"));
		
		int pageNum2 = 1;

		String pageTemp2 = req.getParameter("pageNum2");

		if(pageTemp2 != null && !pageTemp2.equals(""))
		{
			pageNum2 = Integer.parseInt(pageTemp2);
		}
		
		int start2 = (pageNum2-1) * pageSize2 + 1;
		int end2 = pageNum2*pageSize2;

		map2.put("start2", start2);
		map2.put("end2", end2);
		
		List<CommunityDTO> boardLists2 = dao2.selectListPage2(map2);

		dao2.close();
		
		String pagingImg2 = BoardPage.pagingStr(totalCount2, pageSize2, blockPage2, pageNum2, 
				"../community/list.do");
		
		map2.put("pagingImg2", pagingImg2);

		map2.put("totalCount2", totalCount2);

		map2.put("pageSize2", pageSize2);

		map2.put("pageNum2", pageNum2);
		
		req.setAttribute("boardLists2", boardLists2);
		req.setAttribute("map2", map2);
		
		
		RequestDispatcher rd = req.getRequestDispatcher("/main.jsp");
		rd.forward(req, resp);
		
		
		
	}

}
