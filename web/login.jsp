
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <body>
            <div class="main">
                <section class="col-main" style="min-height: 490px">
                    <h1 style="font-size: 35px; margin: 40px;">Login Page</h1>
                    <form action="MainController" method="POST">
                        Email:<input type="text" placeholder="example@email.com" name="txtEmail" style="margin: 20px 20px 20px 48px;"/>
                        <font color="red">
                        ${requestScope.INVALID.emailError}
                        </font>
                        </br>
                        Password:<input type="password" name="txtPassword" style="margin: 22px;"/>
                        <font color="red">
                        ${requestScope.INVALID.passwordError}
                        </font>
                        </br>
                        <font color="red">${requestScope.ERROR}</font></br>
                        <a href="register.jsp" style="margin-top: 80px;">Register account</a>
                        <a href="https://www.facebook.com/dialog/oauth?client_id=576728809652429&redirect_uri=https://localhost:8084/J3.L.P0007/login-facebook" target="_blank">Login With Facebook</a>
                        <input type="submit" value="Login" name="action" style="margin: 20px 0 0 100px;"/></br>
                    </form>
                </section>
            </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
