
package hieupt.daos;

import hieupt.conn.MyConnection;
import hieupt.dtos.RegistrationDTO;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RegistrationDAO {
    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public RegistrationDAO() {
    }
    
    private void closeConnection() throws Exception{
        if(rs != null)
            rs.close();
        if(preStm != null)
            preStm.close();
        if(conn != null)
            conn.close();
    }
    
    public RegistrationDTO checkLogin(String email, String password) throws Exception {
        RegistrationDTO dto = null;
        String role;
        String name, status;
        String passwordInSHA256 = sha256(password);
        String sql = "Select Role, Name, Status From [dbo].[User] Where Email = ? and Password = ?";
        try {
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            preStm.setString(2, passwordInSHA256);
            rs = preStm.executeQuery();
            if(rs.next()){
                name = rs.getString("Name");
                role = rs.getString("Role");
                status = rs.getString("Status");
                dto = new RegistrationDTO(name, role, status);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public RegistrationDTO findByPrimaryKey(String key) throws Exception {
        RegistrationDTO dto = null;
        try{
            String sql = "Select Name, Role From [dbo].[User] Where Email = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, key);
            rs = preStm.executeQuery();
            if(rs.next()){
                String name = rs.getString("Name");
                String role = rs.getString("Role");
                dto = new RegistrationDTO(name, role, "");
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public boolean register(RegistrationDTO dto) throws Exception {
        boolean check = false;
        String password = dto.getPassword();
        String passwordInSHA256 = sha256(password);
        try{
            String sql = "Insert Into [dbo].[User](Email, Password, Name, Role, Status) Values(?,?,?,?,?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getEmail());
            preStm.setString(2, passwordInSHA256);
            preStm.setString(3, dto.getName());
            preStm.setString(4, "Student");
            preStm.setString(5, "New");
            check = preStm.executeUpdate() > 0;
        }finally{
            closeConnection();
        }
        return check;
    }
    
    public static String sha256(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            String hexString = "";
            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if (hex.length() == 1) {
                    hexString += "0";
                }
                hexString += hex;
            }

            return hexString;
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }
}
