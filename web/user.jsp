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
        
        <div class="alert">
            
        <%
        
        if(request.getParameter("submit") != null) {
            
            session.invalidate();
            
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
                
                out.println("<p>All fields are required.</p>");
                
            } else if(rs.next()) {
                
                out.println("<p>Error, user exists.</p>");
            
            } else if(!pwconf.equals(pw)) {
                
                out.println("<p>Error, passwords do not match.</p>");
                
            } else {
            
                st = conn.createStatement();

                query = "INSERT INTO users (fname, lname, username, password) VALUES('"+fn+"','"+ln+"','"+un+"','"+pw+"');";

                //out.println(query);
                try {

                    int resultCount = st.executeUpdate(query);

                    if(resultCount == 0 || resultCount > 1) {
                        
                        out.println("<p>Error: unexpected result from user add.</p>");
                        
                    } else {
                        
                        RequestDispatcher rd = request.getRequestDispatcher("index.jsp?registered=1");
                    
                        rd.forward(request,response);
                        
                    }
                    
                } catch (Exception dbException) {

                    out.println("<p>Error: update failed: " + dbException.getMessage() + "</p>");

                }
                
            }
             
        }

        %>
        
        </div>
        
        <form action="user.jsp" method="POST">
            <fieldset>
                <legend>User Registration</legend>
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
                <span class="button">
                    <input type="submit" name="submit" value="Register">
                </span>
            </fieldset>
        </form>       
        
    </body>
</html>
