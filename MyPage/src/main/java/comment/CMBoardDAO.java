package comment;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;
import model2.board.MVCBoardDTO;

public class CMBoardDAO extends DBConnPool
{
	// 생성자에서 DBCP(커넥션풀)을 통해 오라클에 연결한다.
	public CMBoardDAO()
	{
		super();
	}

	public List<CMBoardDTO> getCommentList(String idx)
	{
		List<CMBoardDTO> list = new Vector<CMBoardDTO>();
		
		String query ="SELECT * FROM cmboard where board_idx=?";
		
		try 
		{
				psmt = con.prepareStatement(query);
				psmt.setString(1, idx);
				rs = psmt.executeQuery();
			
			while(rs.next())
			{
				CMBoardDTO comment = new CMBoardDTO();
				comment.setIdx(rs.getString(1));
				comment.setBoard_idx(rs.getString(2));
				comment.setReply(rs.getString(3));
				comment.setWriter(rs.getString(4));
				comment.setReply_date(rs.getDate(5));
				comment.setReply_content(rs.getString(6));
				list.add(comment);
			}
				
		} 
		catch (Exception e) 
		{
			System.out.println("댓글 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return list;
	}
	
	public String getSeq() 
	{
		String result = "";
		
		String query ="SELECT seq_cmboard_num.NEXTVAL FROM DUAL";
		
		try {
			
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();

			rs.next();
			result = rs.getString(1);

		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return result;
	}
	
	public int insertComment(CMBoardDTO dto)
	{
		int result = 0;
		
		try
		{
			String query = "INSERT INTO cmboard ( "
						+ " idx, board_idx, reply, writer, reply_date, reply_content) "
						+ " VALUES ( "
						+ " ?,?,?,?,sysdate,?)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getIdx());
			psmt.setString(2, dto.getBoard_idx());
			psmt.setString(3, dto.getReply());
			psmt.setString(4, dto.getWriter());
			psmt.setString(5, dto.getReply_content());
			result = psmt.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public int deleteComment(String idx, String board_idx)
	{
		int result = 0;
		
		try
		{
			String query="DELETE FROM cmboard WHERE idx =? AND board_idx=?";
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, idx);
			psmt.setString(2, board_idx);
            
            result = psmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

			return result; 
	}
	
}

