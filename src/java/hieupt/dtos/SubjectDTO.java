
package hieupt.dtos;

public class SubjectDTO {
    private String id, name;
    private int questions, minutes;

    public SubjectDTO(String id, String name, int questions, int minutes) {
        this.id = id;
        this.name = name;
        this.questions = questions;
        this.minutes = minutes;
    }

    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuestions() {
        return questions;
    }

    public void setQuestions(int questions) {
        this.questions = questions;
    }

    public int getMinutes() {
        return minutes;
    }

    public void setMinutes(int minutes) {
        this.minutes = minutes;
    }
    
    
}
