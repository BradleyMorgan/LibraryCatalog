<%-- 
    Document   : login
    Created on : Apr 5, 2018, 3:21:07 PM
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
        <h3>User Login</h3>
        <form action="auth" method="POST">
                <p>
                    <label for="un"><span>Username</span></label>
                    <input type="text" name="un">
                </p>
                <p>
                    <label for="pw"><span>Password</span></label>
                    <input type="text" name="pw">
                </p>
                <span style="display: inline-block; width: 230px; text-align: right;">
                    <input type="submit" name="submit" value="Log In">
                </span>
        </form>       
        
        
<%

 if(request.getParameter("err") != null) {
    
     out.println("Login Failed.");
     
 }
 
if(request.getParameter("submit") != null) {

    java.sql.Connection conn;
    java.sql.ResultSet rs;
    java.sql.Statement st;

    Class.forName("com.mysql.jdbc.Driver");

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

        } else {

            out.println("Welcome, " + rs.getString(3));
                    
        }

    } catch (Exception dbException) {

        out.println("Login Failed: " + dbException.getMessage());

    }

}

%>
        
    </body>
</html>

