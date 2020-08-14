
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="main">
            <section class="col-main" style="min-height: 490px">
                <h2 style=" font-size: 35px; margin: 30px;">Create New Account</h2>
                <form action="MainController" method="POST">
                    Email: <input type="text" name="txtEmail" style="margin: 20px 20px 20px 50px;" value="${param.txtEmail}" placeholder="example@email.com"/>
                    <font color="red">
                    ${requestScope.INVALID.emailError}
                    </font>
                    <br/>
                    Password: <input type="password" name="txtPassword" style="margin: 20px 20px 20px 23px;"/>
                    <font color="red">
                    ${requestScope.INVALID.passwordError}
                    </font>
                    <br/>
                    Confirm: <input type="password" name="txtConfirm" style="margin: 20px 20px 20px 37px;"/>
                    <font color="red">
                    ${requestScope.INVALID.confirmError}
                    </font>
                    <br/>
                    Fullname: <input type="text" name="txtName" style="margin: 20px 20px 20px 29px;" value="${param.txtName}"/>
                    <font color="red">
                    ${requestScope.INVALID.nameError}
                    </font>
                    <br/>
                    <input type="submit" value="Register" name="action" style="margin-left: 100px; margin-bottom: 20px"/>
                </form>
                    <a href="login.jsp">Already have account? Sign In.</a>
            </section>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
