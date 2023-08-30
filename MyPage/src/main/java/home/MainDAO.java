package home;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import announcement.ACMBoardDTO;
import comment.CMBoardDTO;
import common.DBConnPool;
import community.CommunityDTO;

public class MainDAO extends DBConnPool
{
	public MainDAO()
	{
		super();
	}
	
	public int selectCount(Map<String, Object> map)
	{
		int totalCount = 0;

		String query = "SELECT COUNT(*) FROM acmboard";

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
	
	public int selectCount2(Map<String, Object> map2)
	{
		int totalCount = 0;

		String query = "SELECT COUNT(*) FROM community";

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
		
	public List<ACMBoardDTO> selectListPage(Map<String,Object> map)
	{
		List<ACMBoardDTO> board = new Vector<ACMBoardDTO>();
		
		String query = " "
				+ "SELECT * FROM ( "
				+ "		SELECT Tb.*, ROWNUM rNum FROM ( "
				+ " 		SELECT * FROM acmboard "
				+ " 			ORDER BY idx DESC "
				+ " 			) Tb "
				+ "		) "
				+ " WHERE rNum BETWEEN ? AND ?";
		
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
	
	public List<CommunityDTO> selectListPage2(Map<String,Object> map2)
	{
		List<CommunityDTO> board = new Vector<CommunityDTO>();
		
		String query = " "
				+ "SELECT * FROM ( "
				+ "		SELECT Tb.*, ROWNUM rNum FROM ( "
				+ " 		SELECT * FROM community "
				+ " 			ORDER BY idx DESC "
				+ " 			) Tb "
				+ "		) "
				+ " WHERE rNum BETWEEN ? AND ?";
		
		try
		{
			psmt = con.prepareStatement(query);
			psmt.setString(1, map2.get("start2").toString());
			psmt.setString(2, map2.get("end2").toString());
			rs = psmt.executeQuery();
			
			while (rs.next())
			{
				CommunityDTO dto = new CommunityDTO();
				
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
}
