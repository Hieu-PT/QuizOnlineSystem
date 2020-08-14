<%-- 
    Document   : viewHistory
    Created on : May 30, 2020, 11:13:29 PM
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
            <section class="col-main" style="min-height: 450px">
                <h2 style="font-size: 25px">Search History</h2>
                <form action="MainController" method="POST">
                    Search:<input type="text" name="txtSearch" style="margin-left: 35px"/>
                    <input type="hidden" value="1" name="currentPage"/>
                    <input type="submit" value=" Search " name="action"/>
                </form>
                <c:if test="${requestScope.INFO != null}">
                    <c:if test="${not empty requestScope.INFO}" var="checkList">
                        Result: ${requestScope.RECORDS}
                        <br/>
                        <table border="1" style="margin: 30px; border: solid black;">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Subject</th>
                                    <th>Time</th>
                                    <th>Result</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.INFO}" var="dto" varStatus="counter">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>${dto.subject}</td>
                                        <td>${dto.time}</td>
                                        <td>${dto.result}</td>
                                        <td>
                                            <form action="MainController" method="POST">
                                                <input type="hidden" name="id" value="${dto.id}"/>
                                                <input type="submit" value="Review" name="action" style="width: 100%; height: 35px"/>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div style="margin-left: 250px;">
                            <c:if test="${requestScope.CURRENTPAGE >2}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value=" Search "/>
                                    <c:param name="currentPage" value="1"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px; margin-right: 20px">First</a>
                            </c:if>
                            <c:if test="${requestScope.CURRENTPAGE == requestScope.PAGES.size() && requestScope.PAGES.size() > 2}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value=" Search "/>
                                    <c:param name="currentPage" value="${requestScope.PAGES.size() - 2}"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px; margin-right: 10px">${requestScope.PAGES.size() - 2}</a>
                            </c:if>
                            <c:if test="${(requestScope.CURRENTPAGE - 1) > 0}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value=" Search "/>
                                    <c:param name="currentPage" value="${requestScope.CURRENTPAGE - 1}"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px;">${requestScope.CURRENTPAGE - 1}</a>
                            </c:if>
                            <c:if test="true"><a style="font-size: 14px; margin-left: 10px; color: black">${requestScope.CURRENTPAGE}</a></c:if>
                            <c:if test="${(requestScope.CURRENTPAGE + 1) <= requestScope.PAGES.size()}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value=" Search "/>
                                    <c:param name="currentPage" value="${requestScope.CURRENTPAGE + 1}"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px; margin-left: 10px;">${requestScope.CURRENTPAGE + 1}</a>
                            </c:if>
                            <c:if test="${requestScope.CURRENTPAGE == 1 && requestScope.PAGES.size() > 2}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value=" Search "/>
                                    <c:param name="currentPage" value="3"/>
                                    <c:param name="txtSearch" value="${param.txtSearch}"/>
                                </c:url>
                                <a href="${currentPage}" style="font-size: 14px; margin-left: 10px">3</a>
                            </c:if>
                            <c:if test="${requestScope.CURRENTPAGE < (requestScope.PAGES.size() - 1)}">
                                <c:url var="currentPage" value="MainController">
                                    <c:param name="action" value=" Search "/>
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
