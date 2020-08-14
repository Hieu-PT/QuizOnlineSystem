<%-- 
    Document   : updateQuestion
    Created on : May 25, 2020, 10:09:01 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <div class="main">
            <section class="col-main" style="min-height: 625px">
                <h2 style=" font-size: 35px; margin: 40px;">Update Question</h2>
                <form action="MainController" method="POST">
                    <input type="hidden" name="txtID" value="${requestScope.DTO.id}"/>
                    Subject: <input type="text" name="txtSubject" value="${requestScope.DTO.subjectID}" style="margin: 15px 20px 20px 36px; width: 300px"/>
                    <font color="red" style="margin-left: 30px">
                    ${requestScope.INVALID.subjectError}
                    </font>
                    <br/>
                    <p style="float: left">Question:</p> <textarea name="txtQuestion" style="margin: 15px 20px 20px 30px; width: 300px; height: 100px">${requestScope.DTO.content}</textarea>
                    <font color="red" style="float: right; margin: 20px 110px 0px 0px">
                    ${requestScope.INVALID.questionError}
                    </font>
                    <br/>
                    <p style="float: left">Option 1:</p> <textarea name="txtOption1" style="margin: 15px 20px 20px 32px; width: 300px; height: 50px">${requestScope.DTO.option1}</textarea>
                    <font color="red" style="float: right; margin: 20px 80px 0px 0px">
                    ${requestScope.INVALID.option1Error}
                    </font>
                    <br/>
                    <p style="float: left">Option 2:</p> <textarea name="txtOption2" style="margin: 15px 20px 20px 32px; width: 300px; height: 50px">${requestScope.DTO.option2}</textarea>
                    <font color="red" style="float: right; margin: 20px 80px 0px 0px">
                    ${requestScope.INVALID.option2Error}
                    </font>
                    <br/>
                    <p style="float: left">Option 3:</p> <textarea name="txtOption3" style="margin: 15px 20px 20px 32px; width: 300px; height: 50px">${requestScope.DTO.option3}</textarea>
                    <font color="red" style="float: right; margin: 20px 80px 0px 0px">
                    ${requestScope.INVALID.option3Error}
                    </font>
                    <br/>
                    <p style="float: left">Option 4:</p> <textarea name="txtOption4" style="margin: 15px 20px 20px 32px; width: 300px; height: 50px">${requestScope.DTO.option4}</textarea>
                    <font color="red" style="float: right; margin: 20px 80px 0px 0px">
                    ${requestScope.INVALID.option4Error}
                    </font>
                    <br/>
                    Answer: <input type="radio" name="rdAnswer" value="option1" style="margin-left: 30px;" <c:if test="${requestScope.DTO.correctAnswer == "option1"}">checked=""</c:if>>Option 1
                    <input type="radio" name="rdAnswer" value="option2" style="margin-left: 10px;" <c:if test="${requestScope.DTO.correctAnswer == "option2"}">checked=""</c:if>>Option 2
                    <input type="radio" name="rdAnswer" value="option3" style="margin-left: 10px;" <c:if test="${requestScope.DTO.correctAnswer == "option3"}">checked=""</c:if>>Option 3
                    <input type="radio" name="rdAnswer" value="option4" style="margin-left: 10px;" <c:if test="${requestScope.DTO.correctAnswer == "option4"}">checked=""</c:if>>Option 4
                    <font color="red" style="margin-left: 35px">
                    ${requestScope.INVALID.answerError}
                    </font>
                    </br>
                    <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                    <input type="hidden" name="currentPage" value="${param.currentPage}"/>
                    <input type="submit" value="Update" name="action" style="margin:20px 20px 30px 170px; width: 100px"/>
                </form>
            </section>
            <%@include file="aside.jsp" %>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
