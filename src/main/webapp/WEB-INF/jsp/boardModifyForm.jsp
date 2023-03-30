<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta content="text/html; charset=UTF-8"></meta>
    <title>글수정</title>

    <!-- Bootstrap Core CSS -->
    <link href='<c:url value="/bootstrap/css/bootstrap.min.css" />' rel="stlesheet">
    <!-- jQuery  -->
    <script src="/jquery/jquery-3.6.4.min.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src='<c:url value="/bootstrap/js/bootstrap.min.js" />'></script>

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
<h1 style="text-align:center;">게시물 수정</h1>
<div style="text-align: right;">

</div>
<div>
    <form id="modifyForm"
          action="<c:out value="/board/boardModify" />"
          method="post"
          onsubmit="return boardModifyCheck();">

        <!-- 페이징 + 검색을 위해서 관련  정보를 저장해서 저장시 컨트롤러에게 전달 -->
        <input type="hidden" name="no" value="<c:out value="${board.no}" />"/>
        <input type='hidden' name='pageNum' value='${cri.pageNum}'>
        <input type='hidden' name='amount' value='${cri.amount}'>
        <input type='hidden' name='searchText' value='<c:out value="${cri.searchText}"/>'>

        <table border="1" style="width:100%">
            <colgroup>
                <col width="100"/>
                <col width="500"/>
            </colgroup>
            <tbody>
            <tr>
                <th align="center">제목</th>
                <td><input type="text" name="title" size="80"
                           maxlength="100" value="<c:out value="${board.title}" />"/></td>
            </tr>
            <tr>
                <th align="center">작성자</th>
                <td><input type="text" name="writer" maxlength="20"
                           value="<c:out value="${board.writer}" />"/></td>
            </tr>
            <tr>
                <th align="center">조회수</th>
                <td><c:out value="${board.hit}"/></td>
            </tr>

            <tr>
                <th align="center">내용</th>
                <td>
							<textarea name="content" cols="80" rows="10">
								<c:out value="${board.content}" escapeXml="false"/>
							</textarea>
                    <script>CKEDITOR.replace('content');</script>
                </td>
            </tr>
            </tbody>
        </table>
        <p class="btn_align">
            <%-- <input type="button" value="목록" onclick="goUrl('<c:url value="/board/boardList.do" />');" /> --%>
            <button data-oper='list' value="목록">목록</button>
            <input type="submit" value="저장"/>
        </p>
    </form>
</div>

<script type="text/javascript">

    function showPopup() {
        var windowOpen = window.open('/board/boardView', "팝업 테스트",
            "width=700, height=500, top=10, left=10");
    }
    function goUrl(url) {
        location.href = url;
    }

    // 수정 폼 체크
    function boardModifyCheck() {
        var form = document.modifyForm;
        if (form.title.value == '') {
            alert('제목을 입력하세요.');
            form.title.focus();
            return false;
        }
        if (form.writer.value == '') {
            alert('작성자를 입력하세요');
            form.writer.focus();
            return false;
        }
        return true;
    }

    $(document).ready(function () {
        var operForm = $("#modifyForm");
        // 목록
        $("button[data-oper='list']").on("click", function (e) {
            operForm.find("#no").remove();	//  목록으로 가기 때문에 no 불필요
            operForm.attr("method", "get");
            operForm.attr("action", "/board/boardList.do");
            operForm.submit();
        });
    });
</script>
</body>
</html>