<%-- 
    Document   : reserve
    Created on : Apr 11, 2018, 8:07:16 PM
    Author     : 8BiT
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Library Catalog :: Browse</title>
    </head>
    <body>
    
        <%
        
        java.sql.Connection conn;
        java.sql.ResultSet rs;
        java.sql.Statement st;

        Class.forName("com.mysql.jdbc.Driver");
    
        conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/library_catalog", "comp6000", "comp6000");
        
        %>
        
        <h1>Library Catalog</h1>
        
        <a href='user.jsp'>Register</a> |
        <a href='edit.jsp'>Edit</a> | 
        <a href='browse.jsp'>Browse</a>
        
        <h3>Reservations</h3>
        
        <table>
            
            <tr><th>Book Name</th><th>Author</th></tr>
            
            <%

                String query = "";
                
                if(request.getParameter("reserve") != null) {
                    
                    if(session.getAttribute("userAccess") != null) {
                
                        String book_id = request.getParameter("book_id");

                        java.sql.PreparedStatement dbst = null;

                        query = "UPDATE books SET is_available = 0 WHERE book_id = ?;";

                        dbst = conn.prepareStatement(query);
                        dbst.setString(1, book_id);
                        dbst.executeUpdate();

                        query = "INSERT INTO reservations (user_id, book_id) VALUES (?, ?);";

                        dbst = conn.prepareStatement(query);
                        dbst.setString(1, session.getAttribute("userId").toString());
                        dbst.setString(2, book_id);
                        dbst.executeUpdate();
                    
                    } else {
                        
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp?err=1");
                    
                        rd.forward(request,response);
                        
                    }
                    
                }
                

               
                try {

                    st = conn.createStatement();

                    query = "SELECT book_name, author_name FROM reservations JOIN books ON reservations.book_id = books.book_id JOIN authors ON books.author_id = authors.author_id WHERE reservations.user_id = " + session.getAttribute("userId").toString() + ";"; 

                    //out.println(query);

                    rs = st.executeQuery(query);

                    while(rs.next()) {
                        
                        out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td>");

                    }

                } catch (Exception dbException) {

                    out.println("Lookup Failed: " + dbException.getMessage());

                }



            %>

        </table>

    </body>
</html>
