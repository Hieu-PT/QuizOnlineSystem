<%-- 
    Document   : admin
    Created on : May 22, 2020, 10:10:37 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="menuAdmin.jsp" %>
        <%@include file="body.jsp" %>   
            <aside class="col-right">
                <div class="box">
                    <a href="LogoutController" style="color: black; margin-left: 100px">Sign out</a>
                </div>

            </aside>
        </div>
        <%@include file="footer.jsp" %>
        
    </body>
</html>
