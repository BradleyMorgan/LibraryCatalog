/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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

            java.sql.Connection conn;
            java.sql.ResultSet rs;
            java.sql.Statement st;

            try {
                
                Class.forName("com.mysql.jdbc.Driver");
            
            } catch (ClassNotFoundException ex) {
            
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp?err=3");
                    
                rd.forward(request,response);
            
            }
            
            try {

                conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/library_catalog", "comp6000", "comp6000");

                java.sql.PreparedStatement dbst = null;

                String un = request.getParameter("un");
                String pw = request.getParameter("pw");

                String query = "SELECT COUNT(*), users.* FROM users WHERE username = ? and password = ? GROUP BY user_id;";

                dbst = conn.prepareStatement(query);
                dbst.setString(1, un);
                dbst.setString(2, pw);
                
                rs = dbst.executeQuery();

                if(rs.next()) {
                    
                    if(rs.getInt(1) != 1) {

                        RequestDispatcher rd = request.getRequestDispatcher("index.jsp?err=1");

                        rd.forward(request,response);
                        
                        
                    } else {

                        HttpSession session = request.getSession();

                        session.setAttribute("userId", rs.getString(2));
                        session.setAttribute("userAccess", rs.getString(4));
                        session.setAttribute("userName", rs.getString(3));

                        RequestDispatcher rd = request.getRequestDispatcher("index.jsp?success=1");

                        rd.forward(request, response);

                    }
                
                } else {
                    
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp?err=1");

                    rd.forward(request,response);
                        
                }

            } catch (SQLException dbException) {

                RequestDispatcher rd = request.getRequestDispatcher("index.jsp?err=2");
                    
                rd.forward(request,response);

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
