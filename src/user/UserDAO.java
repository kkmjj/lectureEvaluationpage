package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import utill.DatabaseUtill;

// DAO 실질적으로 데이터에 접근하게 해주는 객체 

public class UserDAO {

	
	// 회원 가입에서 데이터를 사용할때 
	public int login(String userID, String userPassword)
	{
		String SQL = "SELECT userPassword FROM USER WHERE userID=?";
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		
		try {
			conn= DatabaseUtill.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			//쿼리 실행
			//System.out.print(rs.getString(0));
			if(rs.next())	// id가 존재하면
			{
				
				if(rs.getString(1).equals(userPassword))
				{
					return 1; // 비번 확인 
				}
				
				else
				{
					return 0;
				}
			}
			
			return -1; // 아이디가 존재 하지 않음 
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			try { if(conn!=null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return -2;
		
	}
	
	
	
	// 회원가입 함수 
	public int join(UserDTO user)
	{
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,false)";
		Connection conn =null;
		PreparedStatement pstmt =null;
		
		
		try {
			

			conn= DatabaseUtill.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			
			return pstmt.executeUpdate(); // 데이터에 저장 

			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			try { if(conn!=null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			
		}
		return -1;
		
	}
	
	// 이메일 반환
	public String getUserEmail(String userID)
	{
		String SQL = "SELECT userEmail FROM USER WHERE userID=? ";
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		
		
		try {
			conn= DatabaseUtill.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			
			if(rs.next())
			{
				return rs.getString(1);
			}
		
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			try { if(conn!=null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return null;
	}
	
	// 사용자 인증 
	public boolean setUserEmailChecked(String userID)
	{
		String SQL = "UPDATE USER SET userEmailChecked= true WHERE userID=?";
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		
		
		try {
			conn= DatabaseUtill.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			pstmt.executeUpdate();
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			try { if(conn!=null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return false;
		
	}
	
	
	
	
	
	
	
	
	// 이메일 검증 확인
	public boolean getUserEmailChecked(String userID)
	{
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID=?";
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		
		
		try {
			conn= DatabaseUtill.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			
			
			if(rs.next())
			{
				return rs.getBoolean(1);
			}
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			try { if(conn!=null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try { if(pstmt!=null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try { if(rs!=null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return false;
		
	}
	
	
	
	
	
}
