
package hieupt.controllers;

import hieupt.daos.RegistrationDAO;
import hieupt.dtos.RegistrationDTO;
import hieupt.dtos.RegistrationErrorObj;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;


public class RegisterController extends HttpServlet {
    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "login.jsp";
    private static final String INVALID = "register.jsp";
    private static final Logger LOGGER = Logger.getLogger(RegisterController.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String email = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
            String confirm = request.getParameter("txtConfirm");
            String name = request.getParameter("txtName");
            RegistrationDAO dao = new RegistrationDAO();
            String validEmail = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
            
            RegistrationErrorObj errorObj = new RegistrationErrorObj();
            boolean valid = true;
            if(!(email.matches(validEmail))){
                errorObj.setEmailError("Email is invalid");
                valid = false;
            }
            if(email.length() == 0){
                errorObj.setEmailError("Email can't be blank");
                valid = false;
            }
            if(dao.findByPrimaryKey(email)!= null){
                errorObj.setEmailError("This Email is already registered");
                valid = false;
            }
            if(password.length() == 0 ){
                errorObj.setPasswordError("Password can't be blank");
                valid = false;
            }
            if(confirm.equals(password)==false){
                errorObj.setConfirmError("Confirm must match Password");
                valid = false;
            }
            if(name.length() == 0){
                errorObj.setNameError("Name can't be blank");
                valid = false;
            }
            if(valid){
                if(dao.register(new RegistrationDTO(email, password, name, "", ""))){
                    url = SUCCESS;
                } else{
                    request.setAttribute("ERROR", "Insert Failed");
                }
            }else {
                url = INVALID;
                request.setAttribute("INVALID", errorObj);
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at RegisterController: " + e.getMessage());
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
