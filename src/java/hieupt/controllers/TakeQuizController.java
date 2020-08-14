
package hieupt.controllers;

import hieupt.daos.QuestionDAO;
import hieupt.daos.SubjectDAO;
import hieupt.dtos.QuestionDTO;
import hieupt.dtos.QuestionHistoryDTO;
import hieupt.dtos.SubjectDTO;
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

public class TakeQuizController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(TakeQuizController.class);
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            String id = request.getParameter("id");
            String endTime = String.valueOf(session.getAttribute("END_TIME"));
            
            SubjectDAO subDAO = new SubjectDAO();
            SubjectDTO subDTO = subDAO.findByPrimaryKey(id);
            QuestionDAO quesDAO = new QuestionDAO();
            List<QuestionDTO> listQuestion = quesDAO.takeRandomQuestion(id, subDTO.getQuestions());
            session.setAttribute("SUBJECT_ID", id);
            
            
            int totalQuizTime = subDTO.getMinutes() * 60;
            session.setAttribute("TOTAL_QUIZ_TIME", totalQuizTime);
            
            float percentage = totalQuizTime / 100;
            session.setAttribute("PERCENTAGE", percentage);
            
            session.setAttribute("LIST_QUESTION", listQuestion);
            session.setAttribute("CURRENT_QUESTION", 0);
            
            Calendar cal = Calendar.getInstance();
            Timestamp time = new Timestamp(cal.getTimeInMillis());
            session.setAttribute("TIME", time.getTime());
            
            
            if(endTime.equals("null")){
                Timestamp endQuiz = new Timestamp(time.getTime() + (subDTO.getMinutes() * 60 * 1000));
                session.setAttribute("END_TIME", endQuiz.getTime());
            }
            List<QuestionHistoryDTO> listAnswer = new ArrayList<>();
            session.setAttribute("LIST_ANSWER", listAnswer);
        } catch (Exception e) {
            LOGGER.error("ERROR at TakeQuizController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("takeQuiz.jsp").forward(request, response);
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
