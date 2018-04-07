/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author bradley
 */
public class auth extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Login</title>");            
            out.println("</head>");
            out.println("<body>");

            java.sql.Connection conn;
            java.sql.ResultSet rs;
            java.sql.Statement st;

            try {
                
                Class.forName("com.mysql.jdbc.Driver");
            
            } catch (ClassNotFoundException ex) {
            
                Logger.getLogger(auth.class.getName()).log(Level.SEVERE, null, ex);
            
            }
            
            try {

                conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/library_catalog", "comp6000", "comp6000");

                st = conn.createStatement();

                String un = request.getParameter("un");
                String pw = request.getParameter("pw");

                String query = "SELECT COUNT(*), users.* FROM users WHERE username = '" + un + "' and password = '" + pw + "' GROUP BY user_id;";

                //out.println(query);

                rs = st.executeQuery(query);

                rs.next();

                if(rs.getInt(1) != 1) {

                    out.println("Login Failed.");
                    
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp?err=1");
                    
                    rd.forward(request,response);
                    

                } else {

                    out.println("Welcome, " + rs.getString(3));
                    
                    HttpSession session = request.getSession();
                    
                    session.setAttribute("userAccess", un);
                    session.setAttribute("userId", rs.getString(1));
                    
                    RequestDispatcher rd = request.getRequestDispatcher("");
                    
                    rd.forward(request,response);
                    

                }

            } catch (SQLException dbException) {

                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    
                rd.forward(request,response);

            }            
            
            out.println("</body>");
            out.println("</html>");
            
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
