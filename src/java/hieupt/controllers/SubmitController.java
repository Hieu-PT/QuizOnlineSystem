
package hieupt.controllers;

import hieupt.daos.QuestionHistoryDAO;
import hieupt.dtos.QuestionDTO;
import hieupt.dtos.QuestionHistoryDTO;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;


public class SubmitController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SubmitController.class);
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            
            String question = request.getParameter("txtQuestion");
            String answer = request.getParameter("txtAnswer");
            String option1 = request.getParameter("txtOption1");
            String option2 = request.getParameter("txtOption2");
            String option3 = request.getParameter("txtOption3");
            String option4 = request.getParameter("txtOption4");
            String userAnswer = request.getParameter("answer");
            String email = (String) session.getAttribute("EMAIL");
            boolean result = false;
            if (userAnswer != null) {
                if (userAnswer.equalsIgnoreCase(answer)) {
                    result = true;
                }
            }
            QuestionHistoryDTO dto = new QuestionHistoryDTO(question, option1, option2, option3, option4, answer, userAnswer, "", result);
            String checkListAnswer = String.valueOf(session.getAttribute("LIST_ANSWER"));
            List<QuestionHistoryDTO> listAnswer;
            if("null".equals(checkListAnswer)){
                listAnswer = new ArrayList();
            } else {
                listAnswer = (List<QuestionHistoryDTO>) session.getAttribute("LIST_ANSWER");
            }
            listAnswer.add(dto);
            
            //Submit bai quiz
            Calendar cal = Calendar.getInstance();
            Timestamp time = new Timestamp(cal.getTimeInMillis());
            String subject = (String) session.getAttribute("SUBJECT_ID");
            String tmp = subject + time;
            String[] quizID = tmp.split("[.]");
            float trueAnswer = 0;
            for (QuestionHistoryDTO questionHistoryDTO : listAnswer) {
                if(questionHistoryDTO.getResult() == true){
                    trueAnswer += 1;
                }
            }
            List<QuestionDTO> listQuestion = (List<QuestionDTO>) session.getAttribute("LIST_QUESTION");
            float mark = (trueAnswer * 10) / (float)listQuestion.size();
            QuestionHistoryDAO quesHisDAO = new QuestionHistoryDAO();
            if(quesHisDAO.submitQuiz(quizID[0], email, time, subject, mark)){
                for (QuestionHistoryDTO questionHistoryDTO : listAnswer) {
                    questionHistoryDTO.setQuizID(quizID[0]);
                    boolean insert = quesHisDAO.insertQuestionHistory(questionHistoryDTO);
                }
            }
            request.setAttribute("id", quizID[0]);
            request.setAttribute("EMAIL", email);
            
            //remove het cac session
            session.removeAttribute("SUBJECT_ID");
            session.removeAttribute("TOTAL_QUIZ_TIME");
            session.removeAttribute("PERCENTAGE");
            session.removeAttribute("LIST_QUESTION");
            session.removeAttribute("CURRENT_QUESTION");
            session.removeAttribute("TIME");
            session.removeAttribute("END_TIME");
            session.removeAttribute("LIST_ANSWER");
        } catch (Exception e) {
            LOGGER.error("ERROR at SubmitController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("ReviewQuizController").forward(request, response);
//            response.sendRedirect("ReviewQuizController");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
