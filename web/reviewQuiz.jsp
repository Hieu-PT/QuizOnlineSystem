<%-- 
    Document   : reviewQuiz
    Created on : May 31, 2020, 2:04:06 PM
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
        <%@include file="menuStudent.jsp" %>
        <div class="main">
            <section class="col-main" style="min-height: 450px;">
                <h1>Review</h1>
                Email: ${requestScope.DTO.email}</br>
                Subject: ${requestScope.DTO.subject}</br>
                Result: ${requestScope.DTO.result}</br>
                Time: ${requestScope.DTO.time}</br>
                <c:if test="${requestScope.INFO != null}">
                    <c:if test="${not empty requestScope.INFO}" var="checkList">
                        <br/>
                        <c:forEach items="${requestScope.INFO}" var="dto" varStatus="counter">
                            <span style="font-size: 15px; font-weight: bold">Question ${counter.count}:
                            ${dto.question}<br/></span>
                            Option 1: ${dto.option1}<br/>
                            Option 2: ${dto.option2}<br/>
                            Option 3: ${dto.option3}<br/>
                            Option 4: ${dto.option4}<br/>
                            Correct answer: ${dto.correctAnswer}<br/>
                            User answer: ${dto.userAnswer}<br/>
                            Result: <c:if test="${dto.result == true}"><a style="color: green">${dto.result}</a></c:if>
                            <c:if test="${dto.result != true}"><a style="color: red">${dto.result}</a></c:if><br/><br/>
                        </c:forEach>
                    </c:if>
                    <c:if test="${!checkList}">
                        No record found
                    </c:if>
                </c:if>
            </section> 
            <%@include file="aside.jsp" %>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
