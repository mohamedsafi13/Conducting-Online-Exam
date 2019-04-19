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

//System.out.println(options2);
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

	document.getElementById("question3").innerHTML=ques[2];
	document.getElementById("choice1").innerHTML=opt1[2];
	document.getElementById("choice2").innerHTML=opt2[2];
	document.getElementById("choice3").innerHTML=opt3[2];
	document.getElementById("choice4").innerHTML=opt4[2];
	
	var ch=document.getElementById("answer3").value
	if(ch=='A')
		{
		 $('input[name="ans3"][value="A"]').prop('checked', true);
		}
	else if(ch=='B')
		{
		$('input[name="ans3"][value="B"]').prop('checked', true);
		}
	else if(ch=='C')
		{
		$('input[name="ans3"][value="C"]').prop('checked', true);
		}
	else if(ch=='D')
		{
		$('input[name="ans3"][value="D"]').prop('checked', true);
		}
});
</script>

<input type ="button" value="Previous" onclick="previous()"></input>
<input type ="button" value="Next" onclick="next()"></input>

<p>3.<span id="question3"></span></p>
<input type="radio" name="ans3" id="opt1" value="A" onclick="saveResponse()"><span id="choice1"></span></input><br>
<input type="radio" name="ans3" id="opt2" value="B" onclick="saveResponse()"><span id="choice2"></span></input><br>
<input type="radio" name="ans3" id="opt3" value="C" onclick="saveResponse()"><span id="choice3"></span></input><br>
<input type="radio" name="ans3" id="opt4" value="D" onclick="saveResponse()"><span id="choice4"></span></input><br>

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
//alert(a);
document.getElementById("answer3").value=a;
}

function previous()
{
	$.ajax({
        url:'2.jsp',
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
        url:'4.jsp',
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