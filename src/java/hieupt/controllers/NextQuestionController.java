/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieupt.controllers;

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

public class NextQuestionController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(NextQuestionController.class);
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            int currentQuestion = (int) session.getAttribute("CURRENT_QUESTION");
            
            currentQuestion += 1;
            
            session.setAttribute("CURRENT_QUESTION", currentQuestion);
            Calendar cal = Calendar.getInstance();
            Timestamp time = new Timestamp(cal.getTimeInMillis());
            session.setAttribute("TIME", time.getTime());
            
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
            QuestionHistoryDTO dto = new QuestionHistoryDTO(question, option1, option2, option3, option4, answer, userAnswer, email, result);
            String checkListAnswer = String.valueOf(session.getAttribute("LIST_ANSWER"));
            List<QuestionHistoryDTO> listAnswer;
            if("null".equals(checkListAnswer)){
                listAnswer = new ArrayList();
            } else {
                listAnswer = (List<QuestionHistoryDTO>) session.getAttribute("LIST_ANSWER");
            }
            listAnswer.add(dto);
            session.setAttribute("LIST_ANSWER", listAnswer);
        } catch (Exception e) {
            LOGGER.error("ERROR at NextQuestionController: " + e.getMessage());
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
