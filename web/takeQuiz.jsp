
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        #myProgress {
            width: 100%;
            height: 30px;
            background-color: #4caf50;
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            border-radius: 20px;
            
            border: solid 1px;
        }
        #myBar {
            float: left;
            width: 90%;
            height: 30px;
            background-color: #ddd;
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            border-radius: 20px;
        }
    </style>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="menuStudent.jsp" %>
        <div class="main">
            <section class="col-main" style="min-height: 450px;">
                <div style="width: 10%; background-color: #F4F4F4; float: right; height: 30px;">
                    <p id="clock" style="text-align: center; line-height: 0px;">00:00:00</p>
                </div>
                <div id="myBar">
                    <div id="myProgress"></div>
                </div>
                <br />
                <script>
                    move();
                    function move() {
                        var progress = document.getElementById("myProgress");
                        var time = document.getElementById("clock");
                        var i = ${(sessionScope.END_TIME - sessionScope.TIME)/1000}; // thời gian làm quiz
                        var percentage = ${sessionScope.PERCENTAGE}; // biến check 1% trong thời gian làm quiz là bao nhiêu s
                        var width = 100; // độ dài của thanh progress;
                        var totalQuizTime = ${sessionScope.TOTAL_QUIZ_TIME};
                        var timePassed = (totalQuizTime - i) / percentage;
                        width -= timePassed;
                        progress.style.width = width + "%";

                        
                        var count = 0; // biến đếm khi nào progress đạt dc 1%

                        var date = new Date(null);
                        date.setSeconds(i); // thời gian làm quiz dc format thành (giờ phút giây)

                        var id = setInterval(frame, 1000); // chạy hàm frame liên tục mỗi giây
                        function frame() {
                            if (i <= 0) {
                                // điều kiện kết thúc khi làm quiz là thời gian = 0
                                clearInterval(id); // kết thúc hàm frame;
                                alert("End Quiz");
                                var button = document.getElementById("btSubmit");
                                button.click();
                            } else {
                                i--; // giảm từng giây
                                count++;
                                if (count == percentage || (count > (percentage -1) && count < (percentage + 1))) {
                                    // điều kiện check khi nào đạt đủ 1% để trừ
                                    count = 0; // đếm lại từ đầu
                                    width--; // giảm độ dài
//                                    progress.innerHTML = width + "%"; // hiển thị lại tiến trình
                                    progress.style.width = width + "%"; // chỉnh lại độ dài của thanh progress
                                }
                                date = new Date(null);
                                date.setSeconds(i);
                                time.innerHTML = date.toISOString().substr(11, 8); // format giây thành (giờ phút giây)
                            }
                        }
                    }
                </script>
                <form action="MainController" method="POST">
                    <p style="margin: 20px; font-size: 18px">Question ${sessionScope.CURRENT_QUESTION + 1}:</p>
                    <p style="font-size: 18px; margin: 20px">${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).content}</p>
                    <input type="radio" name="answer" value="option1" style="margin: 20px"><a style="font-size: 18px; color: black" >${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).option1}</a>
                    </br>
                    <input type="radio" name="answer" value="option2" style="margin: 20px"><a style="font-size: 18px; color: black" >${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).option2}</a>
                    </br>
                    <input type="radio" name="answer" value="option3" style="margin: 20px"><a style="font-size: 18px; color: black" >${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).option3}</a>
                    </br>
                    <input type="radio" name="answer" value="option4" style="margin: 20px"><a style="font-size: 18px; color: black" >${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).option4}</a>
                    </br>
                    <input type="hidden" name="txtQuestion" value="${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).content}"/>
                    <input type="hidden" name="txtAnswer" value="${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).correctAnswer}"/>
                    <input type="hidden" name="txtOption1" value="${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).option1}"/>
                    <input type="hidden" name="txtOption2" value="${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).option2}"/>
                    <input type="hidden" name="txtOption3" value="${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).option3}"/>
                    <input type="hidden" name="txtOption4" value="${sessionScope.LIST_QUESTION.get(sessionScope.CURRENT_QUESTION).option4}"/>
                    <c:if test="${sessionScope.LIST_QUESTION.size() != (sessionScope.CURRENT_QUESTION + 1)}"><input type="submit" name="action" value="Next" style="margin: 20px"/></c:if>
                    <input type="submit" name="action" value="Submit" id="btSubmit" style="margin: 20px; float: right"/>
                </form>
            </section> 
            <%@include file="aside.jsp" %>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
