<%@ page import = "java.io.*,com.csvreader.CsvReader,java.util.Arrays,java.util.Collections,java.util.*,java.util.concurrent.ThreadLocalRandom" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
   function preventBack(){window.history.forward();}
    setTimeout("preventBack()", 0);
    window.onunload=function(){null};
</script>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div id="timer" align="right">
Time Remaining is <input id="minutes" type="text" style="width: 14px; border: none; background-color:none; font-size: 16px; font-weight: bold;">:<input id="seconds" type="text" style="width: 26px; border: none; background-color:none; font-size: 16px; font-weight: bold;">
</div>
<input type="button" value="1" onclick="ques1()" />
<input type="button" value="2" onclick="ques2()" />
<input type="button" value="3" onclick="ques3()" />
<input type="button" value="4" onclick="ques4()" />
<input type="button" value="5" onclick="ques5()" />
 <%--@include file="Buttons.jsp" --%>
<%

String[] number=new String[5];
String[] question=new String[5];
String[] opt1=new String[5];
String[] opt2=new String[5];
String[] opt3=new String[5];
String[] opt4=new String[5];
String mailid=(String)request.getAttribute("mail_Id");
int i=0;
try
{ 
CsvReader details= new CsvReader("D:\\Questions.csv");
details.readHeaders();
while (details.readRecord())
{
	number[i] = details.get("No");
	question[i] = details.get("Question");
	opt1[i]=details.get("A");
	opt2[i]=details.get("B");
	opt3[i]=details.get("C");
	opt4[i]=details.get("D");
	//System.out.println(number[i] + ":" + question[i]);
	i=i+1;
}
details.close();
}
catch (FileNotFoundException e) {
	e.printStackTrace();
} catch (IOException e) {
	e.printStackTrace();
}

Random rnd = ThreadLocalRandom.current();
for (int k = question.length - 1; k > 0; k--)
{
  int index = rnd.nextInt(k + 1);
  String q = question[index];
  String ch1=opt1[index];
  String ch2=opt2[index];
  String ch3=opt3[index];
  String ch4=opt4[index];
  question[index] = question[k];
  opt1[index]=opt1[k];
  opt2[index]=opt2[k];
  opt3[index]=opt3[k];
  opt4[index]=opt4[k];
  question[k] = q;
  opt1[k]=ch1;
  opt2[k]=ch2;
  opt3[k]=ch3;
  opt4[k]=ch4;
}

/*List<String> list = Arrays.asList(question);
Collections.shuffle(list);
Object[] randomArray = list.toArray();
System.out.println(randomArray[0]);
System.out.println(randomArray[1]);*/

%>

<script>
var mins = 1;
var secs = mins * 60;
function countdown() 
{
	setTimeout('Decrement()',1000);
}
function Decrement() 
{
	if (document.getElementById) 
	{
		minutes = document.getElementById("minutes");
		seconds = document.getElementById("seconds");
		
		if (seconds < 59) 
		{
			seconds.value = secs;
		} 
		else 
		{
			minutes.value = getminutes();
			seconds.value = getseconds();
		}
		secs--;
		setTimeout('Decrement()',1000);
	}
}
function getminutes() 
{
	mins = Math.floor(secs / 60);
	if(mins<0)
		{
		alert("Test Time Has Ended");
		document.getElementById("answers").submit();
		window.close();
		}
	return mins;
}
function getseconds() 
{
	return secs-Math.round(mins *60);
}
</script>

<script>
var qjson;
var opt1json;
var opt2json;
var opt3json;
var opt4json;
window.onload=function()
{
	var ques=new Array();
	var opt1=new Array();
	var opt2=new Array();
	var opt3=new Array();
	var opt4=new Array();
<%
for(int j=0;j<i;j++){
%>
ques['<%=j%>']='<%=question[j]%>';
opt1['<%=j%>']='<%=opt1[j]%>';
opt2['<%=j%>']='<%=opt2[j]%>';
opt3['<%=j%>']='<%=opt3[j]%>';
opt4['<%=j%>']='<%=opt4[j]%>';
<%}%>

qjson=JSON.stringify(ques);
opt1json=JSON.stringify(opt1);
opt2json=JSON.stringify(opt2);
opt3json=JSON.stringify(opt3);
opt4json=JSON.stringify(opt4);

	$.ajax({
        url:'1.jsp',
        data:"questions="+qjson+"&options1="+opt1json+"&options2="+opt2json+
        "&options3="+opt3json+"&options4="+opt4json,
        type:'post',
        success : function(data)
        {
            $("#questionSpace").html(data);
         }
	})
document.getElementById("mailId").value='<%=mailid%>';
document.getElementById("questions").value=qjson;	

}
</script>

<p id="questionSpace"></p>

<form id="answers" action="StoreAnswers1" method="post">

<input type="hidden" id="questions" name="questions"></input>
<input type="hidden" id="answer1" name="answer1"></input>
<input type="hidden" id="answer2" name="answer2"></input>
<input type="hidden" id="answer3" name="answer3"></input>
<input type="hidden" id="answer4" name="answer4"></input>
<input type="hidden" id="answer5" name="answer5"></input>
<input type="hidden" id="mailId" name="mailId"></input>
 <br><input type="submit" value="Submit" onclick="return GetConfirmation();">
</form>
<script>
countdown();
</script>

<script>
function GetConfirmation()
{
	var decision=confirm("Do You Want to Submit?");
	if(decision==true)
		{
		return true;
		}
	else
		{
		return false;
		}
}
</script>

<script>
function ques1()
{
	$.ajax({
        url:'1.jsp',
        data:"questions="+qjson+"&options1="+opt1json+"&options2="+opt2json+
        "&options3="+opt3json+"&options4="+opt4json ,
        type:'post',
        success : function(data)
        {
            $("#questionSpace").html(data);
         }
	})
}

function ques2()
{
	$.ajax({
        url:'2.jsp',
        data:"questions="+qjson+"&options1="+opt1json+"&options2="+opt2json+
        "&options3="+opt3json+"&options4="+opt4json,
        type:'post',
        success : function(data)
        {
            $("#questionSpace").html(data);
         }
	})
}

function ques3()
{
	$.ajax({
        url:'3.jsp',
        data:"questions="+qjson+"&options1="+opt1json+"&options2="+opt2json+
        "&options3="+opt3json+"&options4="+opt4json,
        type:'post',
        success : function(data)
        {
            $("#questionSpace").html(data);
         }
	})
}
	
function ques4()
{
	$.ajax({
        url:'4.jsp',
        data:"questions="+qjson+"&options1="+opt1json+"&options2="+opt2json+
        "&options3="+opt3json+"&options4="+opt4json,
        type:'post',
        success : function(data)
        {
            $("#questionSpace").html(data);
         }
	})
}
	
function ques5()
{
	$.ajax({
        url:'5.jsp',
        data:"questions="+qjson+"&options1="+opt1json+"&options2="+opt2json+
        "&options3="+opt3json+"&options4="+opt4json,
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