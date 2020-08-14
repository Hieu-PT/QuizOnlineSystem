
package hieupt.daos;

import hieupt.conn.MyConnection;
import hieupt.dtos.QuestionDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;


public class QuestionDAO {
    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public QuestionDAO() {
    }
    
    private void closeConnection() throws Exception{
        if(rs != null)
            rs.close();
        if(preStm != null)
            preStm.close();
        if(conn != null)
            conn.close();
    }
    
    public boolean insert(QuestionDTO dto) throws Exception {
        boolean check = false;
        Calendar cal = Calendar.getInstance();
        Timestamp time = new Timestamp(cal.getTimeInMillis());
        String answer = dto.getCorrectAnswer();
        int answerInInt;
        switch (answer) {
            case "option1":
                answerInInt = 1;
                break;
            case "option2":
                answerInInt = 2;
                break;
            case "option3":
                answerInInt = 3;
                break;
            default:
                answerInInt = 4;
                break;
        }
        try{
            String sql = "Insert Into Questions(Content, Answer1, Answer2, Answer3, Answer4, CorrectAnswer, CreateDate, SubjectID, Status) Values(?,?,?,?,?,?,?,?,?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getContent());
            preStm.setString(2, dto.getOption1());
            preStm.setString(3, dto.getOption2());
            preStm.setString(4, dto.getOption3());
            preStm.setString(5, dto.getOption4());
            preStm.setInt(6, answerInInt);
            preStm.setTimestamp(7, time);
            preStm.setString(8, dto.getSubjectID());
            preStm.setString(9, "Active");
            check = preStm.executeUpdate() > 0;
        }finally{
            closeConnection();
        }
        return check;
    }
    
    public List<QuestionDTO> findByLikeName(String search, String currentPage) throws Exception {
        List<QuestionDTO> result = null;
        String id, content, answer1, answer2, answer3, answer4, answer, subjectID, status;
        Timestamp createDate;
        int answerInInt;
        QuestionDTO dto = null;
        int page = Integer.parseInt(currentPage);
        try{
            String sql = "Select ID, Content, Answer1, Answer2, Answer3, Answer4, CorrectAnswer, CreateDate, SubjectID, Status \n" +
                            "FROM (Select ROW_NUMBER() OVER (Order by ID) as Count, ID, Content, Answer1, Answer2, Answer3, Answer4, CorrectAnswer, CreateDate, SubjectID, Status\n" +
                            "	  From Questions\n" +
                            "	  Where Content Like ? OR Status Like ? OR SubjectID Like ?) a\n" +
                            "Where Count >= ? and Count <= ? ";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + search + "%");
            preStm.setString(2, "%" + search + "%");
            preStm.setString(3, "%" + search + "%");
            preStm.setInt(4, (page-1)*20+1);
            preStm.setInt(5, (page-1)*20+20);
//            preStm.setInt(4, (page-1)*10+1); //de test phan trang cho nhanh
//            preStm.setInt(5, (page-1)*10+10);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {  
                id = rs.getString("ID");
                content = rs.getString("Content");
                answer1 = rs.getString("Answer1");
                answer2 = rs.getString("Answer2");
                answer3 = rs.getString("Answer3");
                answer4 = rs.getString("Answer4");
                answerInInt = rs.getInt("CorrectAnswer");
                createDate = rs.getTimestamp("CreateDate");
                subjectID = rs.getString("SubjectID");
                status = rs.getString("Status");
                switch (answerInInt) {
                    case 1:
                        answer = answer1;
                        break;
                    case 2:
                        answer = answer2;
                        break;
                    case 3:
                        answer = answer3;
                        break;
                    default:
                        answer = answer4;
                        break;
                }
                dto = new QuestionDTO(content, answer1, answer2, answer3, answer4, answer, subjectID);
                dto.setId(id);
                dto.setStatus(status);
                dto.setCreateDate(createDate);
                result.add(dto);
            }
        }finally{
            closeConnection();
        }
        return result;
    }
    
    public int countRecord(String search) throws Exception{
        int records = 0;
        try {
            String sql = "Select COUNT(ID) as Record From Questions Where Content Like ? OR Status Like ? OR SubjectID Like ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + search + "%");
            preStm.setString(2, "%" + search + "%");
            preStm.setString(3, "%" + search + "%");
            rs = preStm.executeQuery();
            if(rs.next()){
                records = rs.getInt("Record");
            }
        } finally {
            closeConnection();
        }
        return records;
    }
    
    public int countPage(String search) throws Exception{
        int pages;
        int records = countRecord(search);
        if(records % 20 == 0)
            pages = records / 20;
        else pages = (records / 20) + 1;
        
        //code de test phan trang cho nhanh
//        if(records % 10 == 0)
//            pages = records / 10;
//        else pages = (records / 10) + 1;
        return pages;
    }
    
    public QuestionDTO findByPrimaryKey(String key) throws Exception {
        QuestionDTO dto = null;
        String content, answer1, answer2, answer3, answer4, correctAnswer, subjectID;
        int answerInInt;
        try {
            String sql = "Select Content, Answer1, Answer2, Answer3, Answer4, CorrectAnswer, SubjectID From Questions Where ID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, key);
            rs = preStm.executeQuery();
            if(rs.next()){
                content = rs.getString("Content");
                answer1 = rs.getString("Answer1");
                answer2 = rs.getString("Answer2");
                answer3 = rs.getString("Answer3");
                answer4 = rs.getString("Answer4");
                answerInInt = rs.getInt("CorrectAnswer");
                subjectID = rs.getString("SubjectID");
                switch (answerInInt) {
                    case 1:
                        correctAnswer = "option1";
                        break;
                    case 2:
                        correctAnswer = "option2";
                        break;
                    case 3:
                        correctAnswer = "option3";
                        break;
                    default:
                        correctAnswer = "option4";
                        break;
                }
                dto = new QuestionDTO(content, answer1, answer2, answer3, answer4, correctAnswer, subjectID);
                dto.setId(key);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public boolean checkSubject(String subject) throws Exception {
        boolean check = false;
        try {
            String sql = "Select Name From Subject Where ID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, subject);
            rs = preStm.executeQuery();
            if(rs.next()){
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean updateQuestion(QuestionDTO dto) throws Exception {
        boolean check = false;
        String answer = dto.getCorrectAnswer();
        int answerInInt;
        switch (answer) {
            case "option1":
                answerInInt = 1;
                break;
            case "option2":
                answerInInt = 2;
                break;
            case "option3":
                answerInInt = 3;
                break;
            default:
                answerInInt = 4;
                break;
        }
        try {
            String sql = "Update Questions Set Content = ?, Answer1 = ?, Answer2 = ?, Answer3 = ?, Answer4 = ?, CorrectAnswer = ?, SubjectID = ? Where ID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getContent());
            preStm.setString(2, dto.getOption1());
            preStm.setString(3, dto.getOption2());
            preStm.setString(4, dto.getOption3());
            preStm.setString(5, dto.getOption4());
            preStm.setInt(6, answerInInt);
            preStm.setString(7, dto.getSubjectID());
            preStm.setString(8, dto.getId());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean deActiveQuestion(String id) throws Exception {
        boolean check = false;
        try {
            String sql = "Update Questions Set Status = ? Where ID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "deActive");
            preStm.setString(2, id);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public List<QuestionDTO> takeRandomQuestion(String subjectID, int questions) throws Exception {
        List<QuestionDTO> list = null;
        QuestionDTO dto;
        String content, answer1, answer2, answer3, answer4, correctAnswer;
        int answerInInt;
        try {
            String sql = "Select Top(?) Content, Answer1, Answer2, Answer3, Answer4, CorrectAnswer From Questions "
                        + "Where SubjectID = ? and Status = ? "
                        + "Order by NEWID()";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, questions);
            preStm.setString(2, subjectID);
            preStm.setString(3, "Active");
            rs = preStm.executeQuery();
            list = new ArrayList<>();
            while(rs.next()){
                content = rs.getString("Content");
                answer1 = rs.getString("Answer1");
                answer2 = rs.getString("Answer2");
                answer3 = rs.getString("Answer3");
                answer4 = rs.getString("Answer4");
                answerInInt = rs.getInt("CorrectAnswer");
                switch (answerInInt) {
                    case 1:
                        correctAnswer = "option1";
                        break;
                    case 2:
                        correctAnswer = "option2";
                        break;
                    case 3:
                        correctAnswer = "option3";
                        break;
                    default:
                        correctAnswer = "option4";
                        break;
                }
                dto = new QuestionDTO(content, answer1, answer2, answer3, answer4, correctAnswer, subjectID);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        return list;
    }
}
