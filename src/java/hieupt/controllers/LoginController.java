
package hieupt.controllers;

import hieupt.daos.RegistrationDAO;
import hieupt.dtos.RegistrationDTO;
import hieupt.dtos.RegistrationErrorObj;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

public class LoginController extends HttpServlet {
    private static final String ADMIN = "admin.jsp";
    private static final String STUDENT = "student.jsp";
    private static final String INVALID = "login.jsp";
    private static final Logger LOGGER = Logger.getLogger(LoginController.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = INVALID;
        try {
            String email = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
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
            if(password.length() == 0){
                errorObj.setPasswordError("Password can't be blank");
                valid = false;
            }
            if(valid){
                RegistrationDAO dao = new RegistrationDAO();
                RegistrationDTO dto = dao.checkLogin(email, password);
                if(dto == null){
                    request.setAttribute("ERROR", "Invalid Email or Password");
                }
                else if(dto.getRole().equalsIgnoreCase("Admin") == false && dto.getRole().equalsIgnoreCase("Student") == false){
                    request.setAttribute("ERROR", "Invalid Email or Password");
                } else {
                    String role = dto.getRole();
                    HttpSession session = request.getSession();
                    session.setAttribute("EMAIL", email);
                    session.setAttribute("ROLE", role);
                    session.setAttribute("NAME", dto.getName());
                    if(role.equalsIgnoreCase("admin"))
                        url = ADMIN;
                    else if(role.equalsIgnoreCase("student"))
                        if (dto.getStatus().equalsIgnoreCase("active"))
                            url = STUDENT;
                        else request.setAttribute("ERROR", "Your account is not yet activated");
                    else request.setAttribute("ERROR", "Your role is invalid");
                }
            } else {
                request.setAttribute("INVALID", errorObj);
            }     
        } catch (Exception e) {
            LOGGER.error("ERROR at LoginController: " + e.getMessage());
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
