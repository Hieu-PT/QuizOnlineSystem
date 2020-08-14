
package hieupt.controllers;

import hieupt.daos.QuestionDAO;
import hieupt.dtos.QuestionDTO;
import hieupt.dtos.QuestionErrorObj;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class UpdateQuestionController extends HttpServlet {
    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "SearchQuestionController";
    private static final String INVALID = "updateQuestion.jsp";
    private static final Logger LOGGER = Logger.getLogger(UpdateQuestionController.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String id = request.getParameter("txtID");
            String subject = request.getParameter("txtSubject");
            String question = request.getParameter("txtQuestion");
            String option1 = request.getParameter("txtOption1");
            String option2 = request.getParameter("txtOption2");
            String option3 = request.getParameter("txtOption3");
            String option4 = request.getParameter("txtOption4");
            String answer = request.getParameter("rdAnswer");
            QuestionDAO dao = new QuestionDAO();
            
            QuestionErrorObj errorObj = new QuestionErrorObj();
            boolean valid = true;
            if(subject.length() == 0){
                errorObj.setSubjectError("Please enter subject's ID");
                valid = false;
            }
            if(dao.checkSubject(subject) == false){
                errorObj.setSubjectError("This subject is not exist");
                valid = false;
            }
            if(question.length() == 0){
                errorObj.setQuestionError("Question can't be blank");
                valid = false;
            }
            if(option1.length() == 0){
                errorObj.setOption1Error("Answer option can't be blank");
                valid = false;
            }
            if(option2.length() == 0){
                errorObj.setOption2Error("Answer option can't be blank");
                valid = false;
            }
            if(option3.length() == 0){
                errorObj.setOption3Error("Answer option can't be blank");
                valid = false;
            }
            if(option4.length() == 0){
                errorObj.setOption4Error("Answer option can't be blank");
                valid = false;
            }
            if(answer == null){
                errorObj.setAnswerError("Please choose the answer");
                valid = false;
            }
            QuestionDTO dto = new QuestionDTO(question, option1, option2, option3, option4, answer, subject);
            dto.setId(id);
            if(valid){
                if(dao.updateQuestion(dto))
                    url = SUCCESS;
                else request.setAttribute("ERROR", "Update Failed");
            }else {
                url = INVALID;
                request.setAttribute("INVALID", errorObj);
                request.setAttribute("DTO", dto);
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at UpdateQuestionController: " + e.getMessage());
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
