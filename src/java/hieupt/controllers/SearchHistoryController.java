
package hieupt.controllers;

import hieupt.daos.QuestionHistoryDAO;
import hieupt.dtos.QuizHistoryDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;


public class SearchHistoryController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SearchHistoryController.class);
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String search = request.getParameter("txtSearch");
            String currentPage = request.getParameter("currentPage");
            String email = (String) request.getSession().getAttribute("EMAIL");
            
            QuestionHistoryDAO dao = new QuestionHistoryDAO();
            List<QuizHistoryDTO> result = dao.findByLikeName(search, currentPage, email);
            request.setAttribute("INFO", result);
            
            int records = dao.countRecord(search, email);
            request.setAttribute("RECORDS", records);
            
            int pages = dao.countPage(search, email);
            List<Integer> pageList = new ArrayList<>();
            for (int i = 1; i <= pages; i++) {
                pageList.add(i);
            }
            request.setAttribute("PAGES", pageList);
            
            request.setAttribute("CURRENTPAGE", Integer.parseInt(currentPage));
        } catch (Exception e) {
            LOGGER.error("ERROR at SearchHistoryController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("viewHistory.jsp").forward(request, response);
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
