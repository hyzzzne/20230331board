<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>

    <!-- Bootstrap Core CSS -->
    <link href='<c:url value="/bootstrap/css/bootstrap.min.css" />' rel="stlesheet">
    <!-- jQuery  -->
    <script src="/jquery/jquery-3.6.4.min.jss"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src='<c:url value="/bootstrap/js/bootstrap.min.js" />'></script>

    <style type="text/css">
        * {
            font-size: 12px;
        }

        a {
            text-decoration: none;
        }

        p {
            width: 600px;
            text-align: right;
        }

        table {
            width: 100%;
            border: 1px solid;
            border-collapse: collapse;
            padding: 5px;
        }

        table, th, td {
            padding: 10px;
            text-align: left;
        }

        th, td {
            border-bottom: 1px solid #ddd;
        }

        table thead tr th {
            background-color: #05bcac;
        }

        tr:hover {
            background-color: #dce7e6;
        }
    </style>

    <script type="text/javascript">

        $(document).ready(function () {
            $('body').addClass('backColor');

            // 검색 버튼 클릭 이벤트 핸들러(리스너)
            $('#btnSearch').on('click', function () {

                // 검색 키워드 널 체크
                let searchText = $('#searchText').val();
                if (searchText == "" || searchText == null || searchText == undefined || searchText.length < 1) {
                    alert('검색어를 입력하세요.');
                    $("#searchText").focus();
                    return false;
                }
                $('#searchForm').submit();
            });
        });
    </script>

</head>
<body>
<h1 style="text-align:center;">게시물 목록</h1>
<div style="text-align: center; margin-bottom:5px;">
    제목/내용 :
    <input type="text" name="searchText" id="searchText" value="${pageMaker.cri.searchText }"/>
    <input type="button" id="btnSearch" value="검색"/>
    <input type="button" value="게시물 작성" onclick="showPopup()"/>

    </form>
</div>
<div>
    <table>
        <colgroup>
            <col width="60s"/>
            <col width="50"/>
            <col width="200"/>
            <col width="200"/>
            <col width="200"/>
            <col width="200"/>
        </colgroup>
        <thead>
        <tr>
            <th><input type="checkbox" class="allCheck"></th>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>등록 일시</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${boardList.size() <= 0}">
                <tr>
                    <td align="center" colspan="5">등록된 게시물이 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="board" items="${boardList}" varStatus="i">
                    <tr>
                        <td>
                            <input type="checkbox" class="check">
                        </td>
                        <td align="center">
                            <c:out value="${i.count}"/>
                        </td>
                        <td>
                            <a class="move" href='<c:out value="/board/boardView?no=${board.no}"/>'>
                                <c:out value="${board.title}"/>
                            </a>
                        </td>
                        <td align="center">
                            <c:out value="${board.writer}"/>
                        </td>
                        <td align="center">
                            <c:out value="${board.hit}"/>
                        </td>
                        <td align="center">
                            <c:out value="${board.regDate}"/>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
<!-- 페이징 or 페이지네이션 시작 -->
<div style="text-align: center;">
    <ul class="pagination">
        <c:if test="${pageMaker.prev}">
            <li class="paginate_button previous">
                <a href="${pageMaker.startPage -1}">Previous</a></li>
        </c:if>
        <!-- 페이지 버튼 시작번호 ~ 끝번호 반복문 -->
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
                <a href="${num}">${num}</a>
            </li>
        </c:forEach>

        <c:if test="${pageMaker.next}">
            <li class="paginate_button next"><a
                    href="${pageMaker.endPage +1 }">Next</a></li>
        </c:if>
    </ul>
</div>
<!-- 페이징 or 페이지네이션 종료 -->
<
<form id='actionForm' action="/board" method='get'>
    <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
    <input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
    <input type='hidden' name='searchText' value='<c:out value="${ pageMaker.cri.searchText}"/>'>
</form>

<script type="text/javascript">

    function showPopup() {
        var windowOpen = window.open('/board/insertPopup', "팝업 테스트",
            "width=700, height=500, top=10, left=10");
    }

    $(document).ready(function () {
        var result = '<c:out value="${result}"/>';

        //alert('result값 세팅 :' + result);

        checkModal(result);

        history.replaceState({}, null, null);

        function checkModal(result) {
            if (result === '' || history.state) {
                return;
            }
            if (parseInt(result) > 0) {
                $(".modal-body").html(
                    "게시글 " + parseInt(result)
                    + " 번이 등록되었습니다.");
            }
            $("#myModal").modal("show");
        } // end checkModal

        /*
        $("#regBtn").on("click", function() {
            self.location = "
        ${pageContext.request.contextPath}/board/boardWrite.do";
		});
		*/

        var actionForm = $("#actionForm");

        // 게시물 제목 클릭 이벤트 처리기
        // 게시물 제목에 href=${board.no}를 걸어놓음. 그리고 그 값을 no라는 name 태그로 서버에 전송
        $(".move").on("click", function (e) {
            e.preventDefault();	// 안막으면 원래 걸려있는 링크로 submit()이 되버림.
            actionForm.append("<input type='hidden' name='no' value='"
                + $(this).attr(
                    "href")
                + "'>");
            actionForm.attr("action", "${pageContext.request.contextPath}/board/boardView");
            actionForm.submit();
        });
    });
</script>
</body>
</html>