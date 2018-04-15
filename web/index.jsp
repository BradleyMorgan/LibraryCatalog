<%-- 
    Document   : index
    Created on : Apr 5, 2018, 3:20:42 PM
    Author     : bradley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>LibraryCatalog :: Home</title>
        
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
        
         if(request.getParameter("err") != null) {
             
             if(request.getParameter("err").equals("4")) {
                 
                 out.println("<p>Log in to continue.</p>");
                 
             } else {
                
                 out.println("<p>Invalid username or password.</p>");
             
             }
             
         } else if(request.getParameter("registered") != null) {
             
             out.println("<p>Registration successful. Log in to continue.</p>");
             
         } else if(session.getAttribute("userName") != null) {
             
             out.println("<p>Welcome, " + session.getAttribute("userName").toString() + "!</p>");
             
         }
            
        %>
        </div>

        <form action="auth" method="POST">
            <fieldset>
                <legend>User Login</legend>
                <p>
                    <label for="un"><span>Username</span></label>
                    <input type="text" name="un">
                </p>

                <p>
                    <label for="pw"><span>Password</span></label>
                    <input type="password" name="pw">
                </p>

                <span class="button">
                    <input type="submit" name="submit" value="Log In">
                </span>
            </fieldset>    
        </form>   
        
    </body>
    
</html>
