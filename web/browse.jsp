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
        <link href="style.css" rel="stylesheet">
    </head>
    <body>
    
        <%
        
        java.sql.Connection conn;
        java.sql.ResultSet rs;
        java.sql.Statement st;

        Class.forName("com.mysql.jdbc.Driver");
    
        conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/library_catalog", "comp6000", "comp6000");
        
        %>
        
        <div class="banner">
        <h1>Library Catalog</h1>
        </div>
        
        <div class="menu">
        <a href='index.jsp'>Home</a> |    
        <a href='user.jsp'>Register</a> |
        <a href='edit.jsp'>Edit</a> | 
        <a href='browse.jsp'>Browse</a> | 
        <a href='reserve.jsp'>Reservations</a>
        </div>
     
        <form action="browse.jsp" method="POST" >
        
            <fieldset>
                
                <legend>Books</legend>

                 <div class="searchform">
                     
                    <select name="topic_id">

                        <option value="0">All</option>

                        <%

                        st = conn.createStatement();

                        String query = "SELECT * FROM topics;";

                        rs = st.executeQuery(query);

                        while(rs.next()) {

                            out.println("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");

                         }

                        %>

                    </select>

                    <input type="submit" name="search" value="Search">
                
                 </div>
                        
        </form>
                    
        
        
        <table>
            
            <tr><th>Book ID</th><th>Book Name</th><th>Author</th><th>Topic</th><th>Availability</th></tr>
            
            <%

                if(request.getParameter("reserve") != null) {
                    
                    if(session.getAttribute("userAccess") != null) {
                
                        String book_id = request.getParameter("book_id");
                        
                        RequestDispatcher rd = request.getRequestDispatcher("reserve.jsp?reserve=1&book_id="+book_id);
                    
                        rd.forward(request,response);
                    
                    } else {
                        
                        RequestDispatcher rd = request.getRequestDispatcher("index.jsp?err=4");
                    
                        rd.forward(request,response);
                        
                    }
                    
                }
                
                String clause = "";
                
                if(request.getParameter("topic_id") != null) {
                    
                    if(!request.getParameter("topic_id").equals("0")) {
                        
                        clause = " WHERE topics.topic_id = " + request.getParameter("topic_id");
                        
                    }
                    
                }
               
                try {

                    st = conn.createStatement();

                    query = "SELECT book_id, book_name, author_name, topic_name, is_available FROM books JOIN authors ON books.author_id=authors.author_id JOIN topics ON books.topic_id = topics.topic_id" + clause + ";";

                    //out.println(query);

                    rs = st.executeQuery(query);

                    while(rs.next()) {
                        
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
