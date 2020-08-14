<%-- 
    Document   : student
    Created on : May 28, 2020, 10:07:11 AM
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
                <h2 style="font-size: 25px">Search Subject</h2>
                <form action="MainController" method="POST">
                    Search:<input type="text" name="txtSearch" style="margin-left: 35px"/>
                    <input type="submit" value="Search " name="action"/>
                </form>
                <c:if test="${requestScope.INFO != null}">
                    <c:if test="${not empty requestScope.INFO}" var="checkList">
                        <table border="1" style="margin: 30px; border: solid black;">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Subject ID</th>
                                    <th>Name</th>
                                    <th>Questions</th>
                                    <th>Minutes</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.INFO}" var="dto" varStatus="counter">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>${dto.id}</td>
                                        <td>${dto.name}</td>
                                        <td>${dto.questions}</td>
                                        <td>${dto.minutes}</td>
                                        <td>
                                            <form action="MainController" method="POST">
                                                <input type="hidden" name="id" value="${dto.id}"/>
                                                <input type="submit" value="Take Quiz" name="action" style="width: 100%; height: 35px"/>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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
