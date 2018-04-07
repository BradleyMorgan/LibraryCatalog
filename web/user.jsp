<%-- 
    Document   : user
    Created on : Apr 5, 2018, 3:29:07 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Library Catalog :: User Registration</title>
        <link href="style.css" rel="stylesheet">
    </head>
    <body>
        <h3>New User Registration</h3>
        <form action="user.jsp" method="POST">
                <p>
                    <label for="un"><span>Username</span></label>
                    <input type="text" name="un">
                </p>
                <p>
                    <label for="un"><span>First Name</span></label>
                    <input type="text" name="fname">
                </p>
                <p>
                    <label for="un"><span>Last Name</span></label>
                    <input type="text" name="lname">
                </p>
                <p>
                    <label for="pw"><span>Password</span></label>
                    <input type="password" name="pw">
                </p>
                <p>
                    <label for="pw"><span>Confirm</span></label>
                    <input type="password" name="pwconf">
                </p>
                <span style="display: inline-block; width: 230px; text-align: right;">
                    <input type="submit" name="submit" value="Register">
                </span>
        </form>       
        
        <%
        
        if(request.getParameter("submit") != null) {
            
            
            java.sql.Connection conn;
            java.sql.ResultSet rs;
            java.sql.Statement st;

            Class.forName("com.mysql.jdbc.Driver");

            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/library_catalog", "comp6000", "comp6000");
                
            String un = request.getParameter("un");
            String pw = request.getParameter("pw");
            String pwconf = request.getParameter("pwconf");
            String fn = request.getParameter("fname");
            String ln = request.getParameter("lname");
            
            String query = "SELECT COUNT(*), users.* FROM users WHERE username = '" + un + "' and password = '" + pw + "' GROUP BY user_id;";

            //out.println(query);

            st = conn.createStatement();
            
            rs = st.executeQuery(query);
  
            if(un.isEmpty() || pw.isEmpty() || fn.isEmpty() || ln.isEmpty()) {
                
                out.println("All fields are required.");
                
            } else if(rs.next()) {
                
                out.println("Error, user exists.");
            
            } else if(!pwconf.equals(pw)) {
                
                out.println("Error, passwords do not match.");
                
            } else {
            
                st = conn.createStatement();

                query = "INSERT INTO users (fname, lname, username, password) VALUES('"+fn+"','"+ln+"','"+un+"','"+pw+"');";

                //out.println(query);
                try {

                    int resultCount = st.executeUpdate(query);

                    if(resultCount == 0 || resultCount > 1) {
                        
                        out.println("<p>Error: unexpected result from user add.</p>");
                        
                    } else {
                        
                        out.println("<p>User registration successful.</p>");
                        
                    }
                    
                } catch (Exception dbException) {

                    out.println("Error: update failed: " + dbException.getMessage());

                }
                
            }
             
        }

        %>
        
    </body>
</html>
