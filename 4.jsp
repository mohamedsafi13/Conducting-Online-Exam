<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String q=request.getParameter("questions");
String options1=request.getParameter("options1");
String options2=request.getParameter("options2");
String options3=request.getParameter("options3");
String options4=request.getParameter("options4");
%>

<script>
$(document).ready(function () {
	var ques=new Array();
	var opt1=new Array();
	var opt2=new Array();
	var opt3=new Array();
	var opt4=new Array();
	ques=JSON.parse('<%=q%>');
	opt1=JSON.parse('<%=options1%>');
	opt2=JSON.parse('<%=options2%>');
	opt3=JSON.parse('<%=options3%>');
	opt4=JSON.parse('<%=options4%>');

	document.getElementById("question4").innerHTML=ques[3];
	document.getElementById("choice1").innerHTML=opt1[3];
	document.getElementById("choice2").innerHTML=opt2[3];
	document.getElementById("choice3").innerHTML=opt3[3];
	document.getElementById("choice4").innerHTML=opt4[3];
	
	var ch=document.getElementById("answer4").value
	if(ch=='A')
		{
		 $('input[name="ans4"][value="A"]').prop('checked', true);
		}
	else if(ch=='B')
		{
		$('input[name="ans4"][value="B"]').prop('checked', true);
		}
	else if(ch=='C')
		{
		$('input[name="ans4"][value="C"]').prop('checked', true);
		}
	else if(ch=='D')
		{
		$('input[name="ans4"][value="D"]').prop('checked', true);
		}
});
</script>

<input type ="button" value="Previous" onclick="previous()"></input>
<input type ="button" value="Next" onclick="next()"></input>

<p>4.<span id="question4"></span></p>
<input type="radio" name="ans4" id="opt1" value="A" onclick="saveResponse()"><span id="choice1"></span></input><br>
<input type="radio" name="ans4" id="opt2" value="B" onclick="saveResponse()"><span id="choice2"></span></input><br>
<input type="radio" name="ans4" id="opt3" value="C" onclick="saveResponse()"><span id="choice3"></span></input><br>
<input type="radio" name="ans4" id="opt4" value="D" onclick="saveResponse()"><span id="choice4"></span></input><br>

<script>
function saveResponse()
{
var a;
if(document.getElementById("opt1").checked)
	{
	a=document.getElementById("opt1").value;
	}
else if(document.getElementById("opt2").checked)
	{
	a=document.getElementById("opt2").value;
	}
else if(document.getElementById("opt3").checked)
	{
	a=document.getElementById("opt3").value;
	}
else if(document.getElementById("opt4").checked)
	{
	a=document.getElementById("opt4").value;
	}
document.getElementById("answer4").value=a;
}

function previous()
{
	$.ajax({
        url:'3.jsp',
        data:"questions="+'<%=q%>'+"&options1="+'<%=options1%>'+"&options2="+'<%=options2%>'+
        "&options3="+'<%=options3%>'+"&options4="+'<%=options4%>',
        type:'post',
        success : function(data)
        {
            $("#questionSpace").html(data);
         }
       	})
}

function next()
{
	$.ajax({
        url:'5.jsp',
        data:"questions="+'<%=q%>'+"&options1="+'<%=options1%>'+"&options2="+'<%=options2%>'+
        "&options3="+'<%=options3%>'+"&options4="+'<%=options4%>',
        type:'post',
        success : function(data)
        {
            $("#questionSpace").html(data);
         }
	})
}
</script>
</body>
</html>
