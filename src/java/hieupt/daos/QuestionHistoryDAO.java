
package hieupt.daos;

import hieupt.conn.MyConnection;
import hieupt.dtos.QuestionHistoryDTO;
import hieupt.dtos.QuizHistoryDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class QuestionHistoryDAO {
    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public QuestionHistoryDAO() {
    }

    private void closeConnection() throws Exception{
        if(rs != null)
            rs.close();
        if(preStm != null)
            preStm.close();
        if(conn != null)
            conn.close();
    }
    
    public boolean submitQuiz(String id, String email, Timestamp time, String subject, float result) throws Exception{
        boolean check = false;
        try {
            String sql = "INSERT INTO QuizHistory(ID, Email, Time, Subject, Result) Values(?,?,?,?,?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, id);
            preStm.setString(2, email);
            preStm.setTimestamp(3, time);
            preStm.setString(4, subject);
            preStm.setFloat(5, result);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean insertQuestionHistory(QuestionHistoryDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO QuizQuestionHistory(Question, Option1, Option2, Option3, Option4, CorrectAnswer, UserAnswer, Result, QuizID) Values(?,?,?,?,?,?,?,?,?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getQuestion());
            preStm.setString(2, dto.getOption1());
            preStm.setString(3, dto.getOption2());
            preStm.setString(4, dto.getOption3());
            preStm.setString(5, dto.getOption4());
            preStm.setString(6, dto.getCorrectAnswer());
            preStm.setString(7, dto.getUserAnswer());
            preStm.setBoolean(8, dto.getResult());
            preStm.setString(9, dto.getQuizID());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public List<QuizHistoryDTO> findByLikeName(String search, String currentPage, String email) throws Exception {
        List<QuizHistoryDTO> result = null;
        QuizHistoryDTO dto;
        String id,subject;
        Timestamp time;
        float mark;
        int page = Integer.parseInt(currentPage);
        try {
            String sql = "Select ID, Email, Time, Subject, Result\n" +
                        "From (Select ROW_NUMBER() OVER (Order by Time) as Count, ID, Email, Time, Subject, Result\n" +
                        "		From QuizHistory\n" +
                        "		Where Subject LIKE ? AND Email = ?) a\n" +
                        "Where Count >= ? AND Count <= ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + search + "%");
            preStm.setString(2, email);
            preStm.setInt(3, (page - 1) * 5 + 1);
            preStm.setInt(4, (page - 1) * 5 + 5);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while(rs.next()){
                id = rs.getString("ID");
                time = rs.getTimestamp("Time");
                subject = rs.getString("Subject");
                mark = rs.getFloat("Result");
                dto = new QuizHistoryDTO(email, subject, time, mark);
                dto.setId(id);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public int countRecord(String search, String email) throws Exception{
        int records = 0;
        try {
            String sql = "Select COUNT(ID) as Record From QuizHistory Where Subject LIKE ? And Email = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + search + "%");
            preStm.setString(2, email);
            rs = preStm.executeQuery();
            if(rs.next()){
                records = rs.getInt("Record");
            }
        } finally {
            closeConnection();
        }
        return records;
    }
    
    public int countPage(String search, String email) throws Exception{
        int pages;
        int records = countRecord(search, email);
        if(records % 5 == 0)
            pages = records / 5;
        else pages = (records / 5) + 1;
        
        return pages;
    }
    
    public QuizHistoryDTO findByPrimaryKey(String key) throws Exception {
        QuizHistoryDTO dto = null;
        String email, subject;
        Timestamp time;
        float result;        
        try {
            String sql = "Select Email, Time, Subject, Result From QuizHistory Where ID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, key);
            rs = preStm.executeQuery();
            if(rs.next()) {
                email = rs.getString("Email");
                time = rs.getTimestamp("Time");
                subject = rs.getString("Subject");
                result = rs.getFloat("Result");
                dto = new QuizHistoryDTO(email, subject, time, result);
                dto.setId(key);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public List<QuestionHistoryDTO> getQuizQuestions(String id) throws Exception {
        List<QuestionHistoryDTO> list = null;
        QuestionHistoryDTO dto;
        String question, option1, option2, option3, option4, correct, correctAnswer = null, userAns, userAnswer = null;
        boolean result;
        try {
            String sql = "Select Question, Option1, Option2, Option3, Option4, CorrectAnswer, UserAnswer, Result From QuizQuestionHistory Where QuizID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, id);
            rs = preStm.executeQuery();
            list = new ArrayList<>();
            while(rs.next()){
                question = rs.getString("Question");
                option1 = rs.getString("Option1");
                option2 = rs.getString("Option2");
                option3 = rs.getString("Option3");
                option4 = rs.getString("Option4");
                correct = rs.getString("CorrectAnswer");
                switch (correct) {
                    case "option1":
                        correctAnswer = option1;
                        break;
                    case "option2":
                        correctAnswer = option2;
                        break;
                    case "option3":
                        correctAnswer = option3;
                        break;
                    case "option4":
                        correctAnswer = option4;
                        break;
                }
                userAns = rs.getString("UserAnswer");
                switch (userAns) {
                    case "option1":
                        userAnswer = option1;
                        break;
                    case "option2":
                        userAnswer = option2;
                        break;
                    case "option3":
                        userAnswer = option3;
                        break;
                    case "option4":
                        userAnswer = option4;
                        break;
                }
                result = rs.getBoolean("Result");
                dto = new QuestionHistoryDTO(question, option1, option2, option3, option4, correctAnswer, userAnswer, id, result);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        return list;
    }
}
