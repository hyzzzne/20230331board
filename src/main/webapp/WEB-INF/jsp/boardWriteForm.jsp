<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta content="text/html; charset=UTF-8"></meta>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <title>게시물 작성</title>
    <style type="text/css">
        * {
            font-size: 12px;
        }

        table {
            width: 100%;
            border: 1px solid;
            border-collapse: collapse; /* 테이블 border 한줄로 나오게 */
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
<h1 style="text-align:center;">게시물 작성</h1>
<div>
    <form name="boardForm" action="/board/boardWrite" ;
          method="post"
          enctype="multipart/form-data">
        <table>
            <colgroup>
                <col width="10%"/>
                <col width="90%"/>
            </colgroup>
            <tbody>
            <tr>
                <th align="center">제목</th>
                <td><input type="text" name="title" size="80" maxlength="100"/></td>
            </tr>
            <tr>
                <th align="center">작성자</th>
                <td>
                    <input type="text" name="writer" maxlength="20"/>
                </td>
            </tr>
            <tr>
                <th align="center">내용</th>
                <td>
                    <textarea name="content" cols="500" rows="10"></textarea>
                    <script>CKEDITOR.replace('content');</script>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
    <div style="text-align: center">
        <button id="send">저장</button>
    </div>
</div>

<script type="text/javascript">
    function goUrl(url) {
        location.href = url;
    }

    document.getElementById("send").addEventListener("click", function () {


        const formData = {
            writer: $("input[name=writer]").val(),
            content: $("textarea[name=content]").val(),
            title: $("input[name=title]").val()
        }

        console.log(formData)

        $.ajax({
            type: 'post',
            url: '/board/boardWrite',
            data: JSON.stringify(formData),
            contentType: "application/json; charset=utf-8;",
            success: function () {
                window.opener.renderingDiv();
                window.close();
            },
            error: function (xhr, status, error) {
                console.log(error);
                // window.opener.reloadDiv();
                // window.close();
            }

        });

    })

    // 등록 폼 체크
    function boardWriteCheck() {
        var form = document.boardForm;
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
</script>
</body>
</html>