package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import utill.DatabaseUtill;

public class EvaluationDAO {

	
	public int Write(EvaluationDTO evaluationDTO)
	{
		//처음 db auto increment 으로 자동으로 1씩 증가  
		String SQL = "INSERT INTO EVALUATION VALUES(null,?,?,?,?,?,?,?,?,?,?,?,?,0)";
		Connection conn =null;
		PreparedStatement pstmt =null;
	
		
		try {
			conn= DatabaseUtill.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID());
			pstmt.setString(2, evaluationDTO.getLectureName());
			pstmt.setString(3, evaluationDTO.getProfessorName());
			pstmt.setInt(4, evaluationDTO.getLectureYear());
			pstmt.setString(5, evaluationDTO.getSemesterDivide());
			pstmt.setString(6, evaluationDTO.getLectureDivide());
			pstmt.setString(7, evaluationDTO.getEvaluationTitle());
			pstmt.setString(8, evaluationDTO.getEvaluationContent());
			pstmt.setString(9, evaluationDTO.getTotalScore());
			pstmt.setString(10, evaluationDTO.getCreditScore());
			pstmt.setString(11, evaluationDTO.getComfortableScore());
			pstmt.setString(12, evaluationDTO.getLectureScore());
		return pstmt.executeUpdate(); // 등록이 되면 1 이 반환
			//쿼리 실행
			//System.out.print(rs.getString(0));
		
			
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
	
	
	// 강의내용 저장 
	public ArrayList<EvaluationDTO> getlist(String lectureDivide,String search, String searchType,int pageNumber){
		System.out.println("getlist접근");
		System.out.println("강의구분"+lectureDivide+" " +search + searchType + pageNumber);
		if(lectureDivide.equals("전체"))
		{
			lectureDivide="";
		}
		ArrayList<EvaluationDTO> evaluationList =null;
		
		String SQL = "";
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		
		try {
			if(searchType.equals("최신순")) 
			{// LIKE 특정 문자가 포함되어있는지 물어봄 
				System.out.println("최신순접근");
			SQL="select * from evaluation where lectureDivde like ? AND concat(professorName,lectureName,evaluationContent, evaluationTitle) LIKE "
				+ "	? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 +", " + pageNumber * 5 +6;
			}
			else if(searchType.equals("추천순"))
			{
				SQL="SELECT * FROM EVALUATION WHERE lectureDivde LIKE ? AND CONCAT(professorName,lectureName,evaluationContent, evaluationTitle) LIKE"
						+"? ORDER BY likeCount DESC  LIMIT " + pageNumber * 5 +", " + pageNumber * 5 +6;
			}
			conn= DatabaseUtill.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, "%"+lectureDivide+"%"); // like %문자 % 문자를 포함하는지 물어봄 
			pstmt.setString(2, "%"+search+"%"); // like %문자 % 문자를 포함하는지 물어봄 
			rs= pstmt.executeQuery();
			evaluationList= new ArrayList<EvaluationDTO>();
			//쿼리 실행
			
			
			while(rs.next())
			{
			
				EvaluationDTO evaluation = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14)
						
						);
				
				evaluationList.add(evaluation);
				
			}
			
			System.out.println("리스트 완성"+evaluationList);
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
		
		return evaluationList;
		
	}
	
	
	public int likey(String evaluationID) {
		String SQL = "UPDATE EVALUATION SET likeCount = likeCount+1 where evaluationID=?";
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		
		
		try {
			conn= DatabaseUtill.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			
			return pstmt.executeUpdate();
			
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
		return -1;
	}
	
	public int delete(String userID) {
		String SQL = "delete  from EVALUATION where evaluationID=?";
		Connection conn =null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		
		
		try {
			conn= DatabaseUtill.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(userID));
			
			return pstmt.executeUpdate();
			
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
		return -1;
	}
	
	
}
