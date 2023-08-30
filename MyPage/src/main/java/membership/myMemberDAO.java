package membership;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import announcement.ACMBoardDTO;
import common.JDBConnect;
import membership.myMemberDTO;
import model2.board.MVCBoardDTO;

public class myMemberDAO extends JDBConnect
{
	public myMemberDAO()
	{
		super();
	}
	
	public int selectCount(Map<String, Object> map)
	{
		int totalCount = 0;
		// 만약 검색어가 있다면 게시물을 카운트해야하므로
		// 조건부(where)로 쿼리문을 추가한다.
		String query = "SELECT COUNT(*) FROM member";
		
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
			System.out.println("멤버 수 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	public List<myMemberDTO> selectListPage(Map<String,Object> map)
	{
		List<myMemberDTO> board = new Vector<myMemberDTO>();
		String query = " "
				+ "SELECT * FROM ( "
				+ "		SELECT Tb.*, ROWNUM rNum FROM ( "
				+ " 		SELECT * FROM member ";
		
		if(map.get("searchWord") != null)
		{
			query += " WHERE " + map.get("searchField")
					+ " LIKE '%" + map.get("searchWord") + "%' "; 
		}
		query +=" 			) Tb "
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
				myMemberDTO dto = new myMemberDTO();
				
				dto.setId(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setPwd(rs.getString(3));
				dto.setNickname(rs.getString(4));
				dto.setPhone(rs.getString(5));
				dto.setEmail(rs.getString(6));
				dto.setPostcode(rs.getString(7));
				dto.setPost(rs.getString(8));
				dto.setBan(rs.getString(9));
				board.add(dto);
			}
		}
		catch(Exception e)
		{
			System.out.println("멤버 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
	}
	
	public myMemberDTO selectView(String nickname)
	{
		// 레코드 저장을 위해 DTO객체를 생성한다.
		myMemberDTO dto = new myMemberDTO();
		// 쿼리문 작성 후 인파라미터를 설정하고 실행한다.
		String query = "SELECT * FROM member WHERE nickname=?";
		
		try
		{
			psmt = con.prepareStatement(query);
			psmt.setString(1, nickname);
			rs = psmt.executeQuery();
		
			// 하나의 게시물이므로 if문을 통해 next함수를 실행한다.
			if(rs.next())
			{
				// 인출한 게시물이 있다면 
				dto.setId(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setPwd(rs.getString(3));
				dto.setNickname(rs.getString(4));
				dto.setPhone(rs.getString(5));
				dto.setEmail(rs.getString(6));
				dto.setPostcode(rs.getString(7));
				dto.setPost(rs.getString(8));
				dto.setBan(rs.getString(9));
			}
		}
		catch(Exception e)
		{
			System.out.println("멤버 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	
	// 회원가입
	public int InsertMember(myMemberDTO dto)
	{
		int result = 0;
		
		try
		{
			String query="INSERT INTO MEMBER VALUES (?,?,?,?,?,?,?,?,?)";
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getId());
            psmt.setString(2, dto.getName());
            psmt.setString(3, dto.getPwd());
            psmt.setString(4, dto.getNickname());
            psmt.setString(5, dto.getPhone());
            psmt.setString(6, dto.getEmail());
            psmt.setString(7, dto.getPostcode());
            psmt.setString(8, dto.getPost());
            psmt.setString(9, dto.getBan());
            
            result = psmt.executeUpdate();
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

			return result; 
	}
	
	// 회원탈퇴
	public int deleteMember(String id, String pwd, String name)
	{
		int result = 0;
		
		try
		{
			String query="DELETE FROM MEMBER WHERE id =? AND pwd =? AND name =?";
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, id);
			psmt.setString(2, pwd);
            psmt.setString(3, name);
            
            result = psmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

			return result; 
	}
	
	public int deleteMember(String id)
	{
		int result = 0;
		
		try
		{
			String query="DELETE FROM MEMBER WHERE id =?";
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, id);
            
            result = psmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

			return result; 
	}
	
	public int banMember(String id)
	{
		int result = 0;
		
		try
		{
			String query="UPDATE MEMBER SET ban = 1 where id = ?";
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, id);
			result = psmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

			return result;
	}
	
	public int banClearMember(String id)
	{
		int result = 0;
		
		try
		{
			String query="UPDATE MEMBER SET ban = 0 where id = ?";
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, id);
			result = psmt.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

			return result;
	}
	
	// 아이디 중복 체크
	public int checkId(String id)
	{
		int check = -1;
		
		try
		{
			String query="SELECT COUNT(*) FROM MEMBER WHERE id = ?";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			
			rs.next();
			
			System.out.println(rs.getInt(1));
			
			if(rs.getInt(1) == 0)
			{
				check = 0;
			}
			else
			{
				check = 1;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return check;
	}
	
		// 닉네임 중복 체크
		public int checkNick(String nickname)
		{
			int check = -1;
			
			try
			{
				String query="SELECT COUNT(*) FROM MEMBER WHERE nickname = ?";
				
				psmt = con.prepareStatement(query);
				
				psmt.setString(1, nickname);
				
				rs = psmt.executeQuery();
				
				rs.next();
				
				System.out.println(rs.getInt(1));
				
				if(rs.getInt(1) == 0)
				{
					check = 0;
				}
				else
				{
					check = 1;
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return check;
		}
	
	// 로그인
	public int loginMember(String id, String pwd)
	{
		int check = -1;
		
		try
		{
			String query="SELECT COUNT(*) FROM MEMBER WHERE id =? AND pwd =?";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			
			rs = psmt.executeQuery();
			
			rs.next();
			
			System.out.println(rs.getInt(1));
			
			if(rs.getInt(1) == 0)
			{
				check = 0;
			}
			else
			{
				check = 1;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return check;
	}
	
	public String takeNick(String id, String pwd)
	{
		String nick = "";
		
		try
		{
			String query="SELECT * FROM MEMBER WHERE id =? AND pwd =?";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			
			rs = psmt.executeQuery();
			
			
			while(rs.next())
			{
				nick = rs.getString("nickname");
			}
			System.out.println(nick);
			
			if(nick == null)
			{
				System.out.println("오류 발생");
			}
	
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return nick;
	}
	
	public boolean banChcek(String id)
	{
		boolean check = false;
		
		try
		{
			String query="SELECT ban FROM MEMBER WHERE id = ?";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, id);
			
			rs = psmt.executeQuery();
			
			rs.next();
			
			System.out.println(rs.getString(1));
			
			if(rs.getString(1).equals("0"))
			{
				check = true;
			}
			else
			{
				check = false;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return check;
	}
}
