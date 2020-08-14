
package hieupt.dtos;

import java.sql.Timestamp;

public class QuizHistoryDTO {
    private String id, email, subject;
    private Timestamp time;
    private float result;

    public QuizHistoryDTO(String email, String subject, Timestamp time, float result) {
        this.email = email;
        this.subject = subject;
        this.time = time;
        this.result = result;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public float getResult() {
        return result;
    }

    public void setResult(float result) {
        this.result = result;
    }
    
    
}
