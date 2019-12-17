package utill;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtill {

	public static Connection getConnection() {
		try {
			String dbURL ="jdbc:mysql://localhost:3306/letureevalutation";
			String dbID ="root";
			String dbPassword ="root";
			System.out.print(1);
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL,dbID,dbPassword);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		System.out.print("연결 실패 ");
		return null;
	}
	
	
	
}
