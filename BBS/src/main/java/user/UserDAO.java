package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn; //Connection은 데이터베이스 접근하게 해주는 객체
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() { //데이터베이스 접근 객체
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "dkswldnd";
			String dbPassword = "fhRhcjfja911";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) { //로그인 처리
		String SQL = "SELECT userPassword FROM userdb WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); // sql구문에서 ?부분에 들어가게 해주는 메소드이며 userID를 서로 where문을 통해서 걸러진 데이터가 나옴
			rs = pstmt.executeQuery(); //resultset에 실행된 결과값을 담는다.
			if(rs.next()) { //결과가 존재한다면
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공으로 1을 반환 
				}
				else
					return 0; //비밀번호 불일치
			}
			return -1; //결과가 존재하지 않는다면 아이디가 없는 상태임
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터 베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USERDB VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
