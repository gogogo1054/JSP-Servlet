package announcement;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

public class ACMBoardDAO extends DBConnPool
{
	// 생성자에서 DBCP(커넥션풀)을 통해 오라클에 연결한다.
	public ACMBoardDAO()
	{
		super();
	}
	
	// 게시물의 개수를 카운트한다.
	public int selectCount(Map<String, Object> map)
	{
		int totalCount = 0;
		// 만약 검색어가 있다면 게시물을 카운트해야하므로
		// 조건부(where)로 쿼리문을 추가한다.
		String query = "SELECT COUNT(*) FROM acmboard";
		
		if(map.get("searchWord") != null)
		{
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try
		{
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch (Exception e)
		{
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	/*
	  	모델1 방식에서는 board 테이블 및 BoardDTO클래스를 사용했지만
	  	모델2 방식에서는 acmboard테이블 및 acmboardDTO를 사용하므로
	  	해당 코드만 수정하면 된다.
	 */
	
	
	public List<ACMBoardDTO> selectListPage(Map<String,Object> map)
	{
		List<ACMBoardDTO> board = new Vector<ACMBoardDTO>();
		String query = " "
				+ "SELECT * FROM ( "
				+ "		SELECT Tb.*, ROWNUM rNum FROM ( "
				+ " 		SELECT * FROM acmboard ";
		
		if(map.get("searchWord") != null)
		{
			query += " WHERE " + map.get("searchField")
					+ " LIKE '%" + map.get("searchWord") + "%' "; 
		}
		query += " 			ORDER BY idx DESC "
				+" 			) Tb "
				+"		) "
				+" WHERE rNum BETWEEN ? AND ?";
		
		try
		{
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			
			while (rs.next())
			{
				ACMBoardDTO dto = new ACMBoardDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setVisitcount(rs.getInt(9));
				
				board.add(dto);
			}
		}
		catch(Exception e)
		{
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}
	
	// 글쓰기 처리시 첨부파일까지 함께 입력한다.
	public int insertWrite(ACMBoardDTO dto)
	{
		int result = 0;
		try
		{
			/*
			 ofile : 원본 파일명
			 sfile : 서버에 저장된 파일명
			 */
			String query = "INSERT INTO acmboard ( "
						+ " idx, name, title, content, ofile, sfile) "
						+ " VALUES ( "
						+ " seq_acmboard_num.NEXTVAL,?,?,?,?,?)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			result = psmt.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 내용보기를 위해 일련번호를 인수로 받아 게시물을 인출한다.
	public ACMBoardDTO selectView(String idx)
	{
		// 레코드 저장을 위해 DTO객체를 생성한다.
		ACMBoardDTO dto = new ACMBoardDTO();
		// 쿼리문 작성 후 인파라미터를 설정하고 실행한다.
		String query = "SELECT * FROM acmboard WHERE idx=?";
		
		try
		{
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
		
			// 하나의 게시물이므로 if문을 통해 next함수를 실행한다.
			if(rs.next())
			{
				// 인출한 게시물이 있다면 
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setVisitcount(rs.getInt(9));
			}
		}
		catch(Exception e)
		{
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	// 게시물의 조회수를 1 증가시킨다.
	public void updateVisitCount(String idx)
	{
		String query = "UPDATE acmboard SET "
					+ " visitcount = visitcount + 1 "
					+ " WHERE idx = ?";
		
		try
		{
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	public void downCountPlus(String idx)
	{
		String sql = "UPDATE acmboard SET "
					+ " downcount = downcount + 1 "
					+ " WHERE idx = ? ";
		
		try
		
		{
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		}
		catch (Exception e) {}
	}
	
	// 패스워드 검증을 위한 메서드로 조건에 맞는 게시물을 카운트한다.
	public boolean confirmIdx(String idx)
	{
		boolean isCorr = true;
		
		try
		{
			String sql = "SELECT COUNT(*) FROM acmboard WHERE idx=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			// count()함수의 경우 조건에 맞는 레코드가 없으면 0을 반환하므로
			// 어떤 결과에도 결과값이 존재한다. 따라서 next()를 단독으로 실행한다.
			rs.next();
			
			if(rs.getInt(1) == 0)
			{
				isCorr = false;
			}
		}
		catch(Exception e)
		{
			isCorr = false;
			e.printStackTrace();
		}
		return isCorr;
	}
	
	// 지정한 일련번호의 게시물을 삭제한다.
	public int deletePost(String idx)
	{
		int result = 0;
		
		try
		{
			String query = "DELETE FROM acmboard WHERE idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("게시물 살제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 게시글 데이터를 받아 DB에 저장되어 있던 내용을 갱신한다.
	// (파일업로드 지원)
	public int updatePost(ACMBoardDTO dto)
	{
		int result = 0;
		
		try
		{
			String query = "UPDATE acmboard"
						+ " SET title=?, name=?, content=?, ofile=?, sfile=? "
						+ " WHERE idx=?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getIdx());
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
			
		}
		catch(Exception e)
		{
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
}