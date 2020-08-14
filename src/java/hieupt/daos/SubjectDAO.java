
package hieupt.daos;

import hieupt.conn.MyConnection;
import hieupt.dtos.SubjectDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {
    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public SubjectDAO() {
    }
    
    private void closeConnection() throws Exception{
        if(rs != null)
            rs.close();
        if(preStm != null)
            preStm.close();
        if(conn != null)
            conn.close();
    }
    
    public List<SubjectDTO> findByLikeName(String search) throws Exception {
        List<SubjectDTO> list = null;
        SubjectDTO dto;
        String id, name;
        int questions, minutes;
        try {
            String sql = "Select ID, Name, Questions, Minutes From Subject Where ID Like ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + search + "%");
            rs = preStm.executeQuery();
            list = new ArrayList<>();
            while(rs.next()){
                id = rs.getString("ID");
                name = rs.getString("Name");
                questions = rs.getInt("Questions");
                minutes = rs.getInt("Minutes");
                dto = new SubjectDTO(id, name, questions, minutes);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        return list;
    }
    
    public SubjectDTO findByPrimaryKey(String key) throws Exception {
        SubjectDTO dto = null;
        String name;
        int questions, minutes;
        try {
            String sql = "Select Name, Questions, Minutes From Subject Where ID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, key);
            rs = preStm.executeQuery();
            if(rs.next()){
                name = rs.getString("Name");
                questions = rs.getInt("Questions");
                minutes = rs.getInt("Minutes");
                dto = new SubjectDTO(key, name, questions, minutes);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
}
