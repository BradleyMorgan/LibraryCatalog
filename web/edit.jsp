<%-- 
    Document   : edit
    Created on : Apr 5, 2018, 3:28:49 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Library Catalog :: Edit</title>
    </head>
    <body>
        
        <%
        
        java.sql.Connection conn;
        java.sql.ResultSet rs;
        java.sql.Statement st;

        Class.forName("com.mysql.jdbc.Driver");
    
        conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/library_catalog", "comp6000", "comp6000");
        
        if(request.getParameter("topic_submit") != null) {

            st = conn.createStatement();

            String topic = request.getParameter("topic");

            String query = "INSERT INTO topics (topic_name) VALUES('"+topic+"');";

            out.println(query);
            
            st.executeUpdate(query);

        }
        
        if(request.getParameter("author_submit") != null) {
           
            st = conn.createStatement();

            String author = request.getParameter("author");

            String query = "INSERT INTO authors (author_name) VALUES('"+author+"');";

            out.println(query);
            
            st.executeUpdate(query);

        }

        if(request.getParameter("book_submit") != null) {
           
            st = conn.createStatement();

            String author_id = request.getParameter("author_id");
            String topic_id = request.getParameter("topic_id");
            String book_name = request.getParameter("book_name");
            String book_avail = request.getParameter("book_avail");

            String query = "INSERT INTO books (topic_id, book_name, author_id, is_available) VALUES('"+topic_id+"','"+book_name+"','"+author_id+"','"+book_avail+"');";

            out.println(query);
            
            st.executeUpdate(query);

        }


        %>
        
        <h3>Add New Topic</h3>
        <form action="edit.jsp" method="POST">
                <p>
                    <label for="topic"><span>Topic</span></label>
                    <input type="text" name="topic">
                </p>          
                <span style="display: inline-block; width: 230px; text-align: right;">
                    <input type="submit" name="topic_submit" value="Add Topic">
                </span>
        </form>       
        
        <h3>Add New Author</h3>
        <form action="edit.jsp" method="POST">
                <p>
                    <label for="author"><span>Author Name</span></label>
                    <input type="text" name="author">
                </p>
                <span style="display: inline-block; width: 230px; text-align: right;">
                    <input type="submit" name="author_submit" value="Add Author">
                </span>
        </form>       
        
        <h3>Add New Book</h3>
        <form action="edit.jsp" method="POST">
                <p>
                    <label for="un"><span>Author</span></label>
                    <select name="author_id">
                        
                        <%

                            st = conn.createStatement();

                            String query = "SELECT * FROM authors;";

                            //out.println(query);

                            rs = st.executeQuery(query);

                            while(rs.next()) {

                                out.println("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");
                            
                            }

                        %>
                        
                    </select>
                </p>
                <p>
                    <label for="pw"><span>Topic</span></label>
                    
                    <select name="topic_id">
                            <%

                            st = conn.createStatement();

                            query = "SELECT * FROM topics;";

                            //out.println(query);

                            rs = st.executeQuery(query);

                            while(rs.next()) {

                                out.println("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");
                            
                            }

                        %>
                    </select>
                </p>
                <p>
                    <label for="book_name"><span>Book Name</span></label>
                    <input type="text" name="book_name">
                </p>
                <p>
                    <label for="book_avail"><span>Availability</span></label>
                    <input type="text" name="book_avail">
                </p>
                <span style="display: inline-block; width: 230px; text-align: right;">
                    <input type="submit" name="book_submit" value="Add Book">
                </span>
        </form>       
        
        
    </body>
</html>
