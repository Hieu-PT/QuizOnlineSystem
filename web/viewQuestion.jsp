<%-- 
    Document   : viewQuestion
    Created on : May 24, 2020, 1:58:44 PM
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
            <section class="col-main" style="min-height: 450px">
                <h2 style="font-size: 25px">Search Page</h2>
                <form action="MainController" method="POST">
                    Search:<input type="text" name="txtSearch" style="margin-left: 35px"/>
                    <input type="hidden" value="1" name="currentPage"/>
                    <input type="submit" value="Search" name="action"/>
                </form>
                <c:if test="${requestScope.INFO != null}">
                    <c:if test="${not empty requestScope.INFO}" var="checkList">
                        Result: ${requestScope.RECORDS}
                        <br/>
                        <table border="1" style="margin: 30px; border: solid black;">
                            <thead>
                                <tr>
                                    <th>Subject</th>
                                    <th>Question</th>
                                    <th>Option 1</th>
                                    <th>Option 2</th>
                                    <th>Option 3</th>
                                    <th>Option 4</th>
                                    <th>Answer</th>
                                    <th>Create Date</th>
                                    <th>Status</th>
                                    <th>Update</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.INFO}" var="dto" varStatus="counter">
                                    <tr>
                                        <td>${dto.subjectID}</td>
                                        <td>${dto.content}</td>
                                        <td>${dto.option1}</td>
                                        <td>${dto.option2}</td>
                                        <td>${dto.option3}</td>
                                        <td>${dto.option4}</td>
                                        <td>${dto.correctAnswer}</td>
                                        <td>${dto.createDate}</td>
                                        <td>${dto.status}</td>
                                        <td>
                                            <form action="MainController" method="POST">
                                                <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                                <input type="hidden" name="id" value="${dto.id}"/>
                                                <input type="hidden" name="currentPage" value="${param.currentPage}"/>
                                                <input type="submit" value="Edit" name="action" style="width: 100%; height: 35px"/>
                                            </form>
                                        </td>
                                        <td>
                                            <c:url var="deleteLink" value="MainController">
                                                <c:param name="action" value="Delete"/>
                                                <c:param name="id" value="${dto.id}"/>
                                                <c:param name="txtSearch" value="${param.txtSearch}"/>
                                                <c:param name="currentPage" value="${param.currentPage}"/>
                                            </c:url>
                                            <a href="${deleteLink}">Delete</a>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div style="margin-left: 250px;">
                            <c:if test="${requestScope.CURRENTPAGE >2}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value="Search"/>
                                    <c:param name="currentPage" value="1"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px; margin-right: 20px">First</a>
                            </c:if>
                            <c:if test="${requestScope.CURRENTPAGE == requestScope.PAGES.size() && requestScope.PAGES.size() > 2}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value="Search"/>
                                    <c:param name="currentPage" value="${requestScope.PAGES.size() - 2}"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px; margin-right: 10px">${requestScope.PAGES.size() - 2}</a>
                            </c:if>
                            <c:if test="${(requestScope.CURRENTPAGE - 1) > 0}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value="Search"/>
                                    <c:param name="currentPage" value="${requestScope.CURRENTPAGE - 1}"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px;">${requestScope.CURRENTPAGE - 1}</a>
                            </c:if>
                            <c:if test="true"><a style="font-size: 14px; margin-left: 10px; color: black">${requestScope.CURRENTPAGE}</a></c:if>
                            <c:if test="${(requestScope.CURRENTPAGE + 1) <= requestScope.PAGES.size()}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value="Search"/>
                                    <c:param name="currentPage" value="${requestScope.CURRENTPAGE + 1}"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px; margin-left: 10px;">${requestScope.CURRENTPAGE + 1}</a>
                            </c:if>
                            <c:if test="${requestScope.CURRENTPAGE == 1 && requestScope.PAGES.size() > 2}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value="Search"/>
                                    <c:param name="currentPage" value="3"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px; margin-left: 10px">3</a>
                            </c:if>
                            <c:if test="${requestScope.CURRENTPAGE < (requestScope.PAGES.size() - 1)}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value="Search"/>
                                    <c:param name="currentPage" value="${requestScope.PAGES.size()}"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px; margin-left: 20px">Last</a>
                            </c:if>
                        </div>
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
