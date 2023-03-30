<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <title>게시물 내용보기</title>

    <!-- jQuery  -->
    <script src="/jquery/jquery-3.6.4.min.js"></script>

    <style type="text/css">
        * {
            font-size: 12px;
        }

        table {
            width: 100%;
            border: 1px solid;
            border-collapse: collapse;
            padding: 5px;
            line-height: 20px;
        }

        .btn_align {
            width: 100%;
            text-align: center;
        }

        table, th, td {
            padding: 10px;
            text-align: left;
        }

        th, td {
            border-bottom: 1px solid #ddd;
        }

        table tbody tr th {
            background-color: #05bcac;
        }
    </style>

</head>
<body>
<h1 style="text-align:center;">게시물 내용보기</h1>
<div style="text-align: right;">
</div>
<div>
    <table>
        <colgroup>
            <col width="100"/>
            <col width="500"/>
        </colgroup>
        <tbody>
        <tr>
            <th align="center">제목</th>
            <td><c:out value="${board.title}" escapeXml="false"/></td>
        </tr>
        <tr>
            <th align="center">작성자</th>
            <td><c:out value="${board.writer}"/></td>
        </tr>
        <tr>
            <th align="center">조회수</th>
            <td><c:out value="${board.hit}"/></td>
        </tr>

        <tr>
            <th align="center">등록 일시</th>
            <td><c:out value="${board.regDate}"/></td>
        </tr>
        <tr>
            <th align="center">내용</th>
            <td>
                <c:out value="${board.content}" escapeXml="false"/>
            </td>
        </tr>
        </tbody>
    </table>
    <p class="btn_align">
        <button data-oper='list' value="목록">목록</button>
        <button data-oper='modify' value="수정">수정</button>
        <button data-oper='delete' value="삭제">삭제</button>
    </p>

    <form id='operForm' action="${pageContext.request.contextPath}/boardModify" method="get">
        <input type='hidden' id='no' name='no' value='<c:out value="${board.no}"/>'>
        <%--        <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>--%>
        <%--        <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>--%>
        <%--        <input type='hidden' name='searchText' value='<c:out value="${cri.searchText}"/>'>--%>
    </form>
</div>


<script type="text/javascript">

    function goUrl(url) {
        location.href = url;
    }

    // 삭제 체크
    function deleteCheck(url) {
        if (confirm('정말 삭제하시겠어요?')) {
            location.href = url;
        }
    }

    $(document).ready(function () {

        var operForm = $("#operForm");

        //data-oper 정보 간결, 버튼 타입 받아오는 방식 핸들링
        $("button[data-oper='list']").on("click", function (e) {
            operForm.find("#no").remove();	//목록으로 가서 no 불필요
            operForm.attr("action", "/boardList.do");
            operForm.submit();
        });

        // 수정
        $("button[data-oper='modify']").on("click", function (e) {
            operForm.attr("action", "/board/boardModify?no=${board.no}");
            operForm.submit();
        });

        // 삭제
        $("button[data-oper='delete']").on("click", function (e) {
            operForm.attr("action", "/board/boardDelete");
            operForm.submit();
        });
    });
</script>
</body>
</html>