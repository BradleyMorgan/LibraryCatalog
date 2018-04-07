<%-- 
    Document   : browse
    Created on : Apr 5, 2018, 4:21:14 PM
    Author     : bradley
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
        
        <form action="browse.jsp" method="POST">
        
            <select name="topic_id">
                
                <%

                    st = conn.createStatement();

                    String query = "SELECT * FROM topics;";

                    rs = st.executeQuery(query);

                    while(rs.next()) {

                        out.println("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");
                            
                     }

                %>
                
            </select>
            
            <input type="submit" name="search" value="search">
            
        </form>
        
        <table>
            
            <tr><th>Book ID</th><th>Book Name</th><th>Author</th><th>Topic</th><th>Availability</th></tr>
            
            <%

                if(request.getParameter("reserve").equals("1")) {
                
                    String book_id = request.getParameter("book_id");
                    
                    query = "UPDATE books SET is_available = 0 WHERE book_id = '" + book_id + "';";
                    
                    st = conn.createStatement();
                    
                    st.executeUpdate(book_id);

                    Object test = session.getAttribute("userId");
                    
                    query = "INSERT INTO reservations (user_id, book_id) VALUES ('" + test.toString() + "', '" + book_id + "');";
                    
                    
                }
                
                String clause = "";
                
                if(request.getParameter("topic_id") != null) {
                    
                    clause = " WHERE topics.topic_id = " + request.getParameter("topic_id");
                    
                }
               
                try {

                    st = conn.createStatement();

                    query = "SELECT book_id, book_name, author_name, topic_name, is_available FROM books JOIN authors ON books.author_id=authors.author_id JOIN topics ON books.topic_id = topics.topic_id" + clause + ";";

                    //out.println(query);

                    rs = st.executeQuery(query);

                    while(rs.next()) {
                        
                        out.println(rs.getString(5));
                        
                        if(rs.getString(5).equals("1")) {
                            out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td><a href='browse.jsp?reserve=1&book_id="+rs.getString(1)+"'>Reserve</a></td></tr>");
                        } else {
                            out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>Not Available</td></tr>");
                        }
                    }

                } catch (Exception dbException) {

                    out.println("Lookup Failed: " + dbException.getMessage());

                }



            %>

        </table>

    </body>
</html>
