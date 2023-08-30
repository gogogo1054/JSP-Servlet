package servlet;

import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 어노테이션을 통한 매핑 처리
@WebServlet("/13Servlet/LifeCycle.do")
public class LifeCycle extends HttpServlet 
{
	/*
	 * 	서블릿 수명주기 에서 최초로 호출되는 메서드로 어노테이션을 통해 생성한다.
	 * 따라서 메서드명은 개발자가 결정하면 된다. init()메서드가 호출되기 전 전처리를 위해 주로 사용된다.
	 * */
	
	@PostConstruct
	public void myPostConstruct()
	{
		System.out.println("myPostConstruct 호출");
	}
	
	/*
	 * 서블릿 객체 생성 후 딱 한번만 호출되는 메서드로 보통 서블릿을 초기화 하는 역할을 한다,
	 * 먼저 호출된 후 doGet()이나 doPost()를 호출한다.
	 * */
	@Override
	public void init() throws ServletException 
	{
		System.out.println("init() 호출");
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		/*
		 * service()메서드에서 요청방식을 분석한 후 각 메서드를 호출할때 뱔도의 호출문장을
		 * 기술하지 않는다. 단지 아래 문장이면 된다.
		 * */
		System.out.println("service() 호출");
		super.service(req, resp);
	}

	/*
	 * 	클라릴ㅇ
	 * */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		System.out.println("doGet() 호출");
		req.getRequestDispatcher("/13Servlet/LifeCycle.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException 
	{
		System.out.println("doPost() 호출");
		req.getRequestDispatcher("/13Servlet/LifeCycle.jsp").forward(req, resp);
	}

	/*
	 * 서블릿이 새롭게 컴파일 되거나, 서버가 종료될때 호출된다.
	 * 이때 서블릿 객체는 메모리에서 소멸된다.
	 * 이클립스에서는 server탭에서 서버를 종료하면 아래 메서드가 출력된다.
	 * */
	@Override
	public void destroy() {
		System.out.println("destory() 호출");
	}

	/*
	 * destory() 메서드 호출 후 후처리를 위해 사용된다. 어노테이션을 사용하므로
	 * 메서드명은 우리가 정해주면 된다.
	 * */
	@PreDestroy
	public void myPreDestroy() {
		System.out.println("myPreDestory() 호출");
	}
}
