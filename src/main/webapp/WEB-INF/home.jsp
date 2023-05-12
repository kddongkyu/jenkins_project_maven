<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
<h2><b>Jenkins Maver Project 배포 연습!</b></h2>
<h1>젠킨스 그거 마 쉽다 아입니꺼~</h1>
<h1>Web-Hook 그것도 마 껌 아입니까~</h1>

<div>
    <textarea style="width: 100%; height: 120px;" class="form-control" id="input">나는 오늘 6시가 되자마자 바로 학원에서 탈출 할 것이다.</textarea>
</div>
<div class="input-group" style="width: 250px; margin-left: 50px; margin-top: 10px;" >
    <select id="seltrans" class="form-select" >
        <option value="en">영어</option>
        <option value="ko">한국어</option>
        <option value="ja">일어</option>
        <option value="zh-CN">중국어</option>
        <option value="es">스페인어</option>
        <option value="de">독일어</option>
        <option value="ru">러시아어</option>
    </select>
    <button type="button" id="btntrans" class="btn btn-outline-success">번역하기</button>

    <i class="bi bi-megaphone speak voicespeak" style="font-size: 2em; margin-left: 10px;cursor: pointer"></i>
</div>
<div id="trans">

</div>
</body>
<script>
    $("#btntrans").click(function (){
        $.ajax({
            type : "post",
            url : "./trans",
            data : {"msg": $("#input").val(), "lang" : $("#seltrans").val()},
            dataType :"text",
            success : function (res){
                let j = JSON.parse(res);
                let s = j.message.result.translatedText;
                $("#trans").text(s);
            }
        })
    })

    $(".voicespeak").click(function (){
        if($("#seltrans").val() == 'en'|| $("#seltrans").val() == 'ja' || $("#seltrans").val()=='zh-CN'||$("#seltrans").val()=='es'|| $("#seltrans").val()=='ko') {
            $.ajax({
                type : "get",
                url : "./voice",
                data : {"msg":$("#trans").text(), "lang" : $("#seltrans").val()},
                dataType :"text",
                success : function (res){ // res : mp3 파일명.
                    let audio = new Audio(res);
                    audio.play();
                }
            })
        } else {
            $.ajax({
                type : "get",
                url : "./voice",
                data : {"msg":" 해당언어는 현재 지원하지 않습니다. 다른언어를 선택해주세요!", "lang" : "ko"},
                dataType :"text",
                success : function (res){ // res : mp3 파일명.
                    let audio = new Audio(res);
                    audio.play();
                }
            })
        }
    })
</script>
</html>
