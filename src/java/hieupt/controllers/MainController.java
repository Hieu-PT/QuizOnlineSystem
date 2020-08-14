
package hieupt.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;



public class MainController extends HttpServlet {
    private static final String ERROR = "error.jsp";
    private static final String LOGIN = "LoginController";
    private static final String REGISTER = "RegisterController";
    private static final Logger LOGGER = Logger.getLogger(MainController.class);
    
    private static final String CREATE_QUESTION = "CreateQuestionController";
    private static final String SEARCH_QUESTION = "SearchQuestionController";
    private static final String EDIT_QUESTION = "EditQuestionController";
    private static final String UPDATE_QUESTION = "UpdateQuestionController";
    private static final String DELETE_QUESTION = "DeleteQuestionController";
    
    private static final String SEARCH_SUBJECT = "SearchSubjectController";
    private static final String TAKE_QUIZ = "TakeQuizController";
    private static final String NEXT = "NextQuestionController";
    private static final String SUBMIT = "SubmitController";
    
    private static final String SEARCH_HISTORY = "SearchHistoryController";
    private static final String REVIEW_QUIZ = "ReviewQuizController";
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            if (action.equals("Login")) {
                url = LOGIN;
            } else if (action.equals("Register")) {
                url = REGISTER;
            } else if (action.equals("Create")) {
                url = CREATE_QUESTION;
            } else if (action.equals("Search")){
                url = SEARCH_QUESTION;
            } else if (action.equals("Edit")) {
                url = EDIT_QUESTION;
            } else if (action.equals("Update")) {
                url = UPDATE_QUESTION;
            } else if (action.equals("Delete")) {
                url = DELETE_QUESTION;
            } else if (action.equals("Search ")) {
                url = SEARCH_SUBJECT;
            } else if (action.equals("Take Quiz")) {
                url = TAKE_QUIZ;
            } else if (action.equals("Next")) {
                url = NEXT;
            } else if (action.equals("Submit")) {
                url = SUBMIT;
            } else if (action.equals(" Search ")) {
                url = SEARCH_HISTORY;
            } else if (action.equals("Review")) {
                url = REVIEW_QUIZ;
            } else {
                request.setAttribute("ERROR", "Your action is invalid");
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at MainController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
