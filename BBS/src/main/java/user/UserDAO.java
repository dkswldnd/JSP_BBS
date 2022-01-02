package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn; //Connection�� �����ͺ��̽� �����ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() { //�����ͺ��̽� ���� ��ü
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
	
	public int login(String userID, String userPassword) { //�α��� ó��
		String SQL = "SELECT userPassword FROM userdb WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); // sql�������� ?�κп� ���� ���ִ� �޼ҵ��̸� userID�� ���� where���� ���ؼ� �ɷ��� �����Ͱ� ����
			rs = pstmt.executeQuery(); //resultset�� ����� ������� ��´�.
			if(rs.next()) { //����� �����Ѵٸ�
				if(rs.getString(1).equals(userPassword)) {
					return 1; //�α��� �������� 1�� ��ȯ 
				}
				else
					return 0; //��й�ȣ ����ġ
			}
			return -1; //����� �������� �ʴ´ٸ� ���̵� ���� ������
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //������ ���̽� ����
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
