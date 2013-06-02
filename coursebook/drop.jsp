<%@ page import="java.sql.*" %>
<%
String connectionURL = "jdbc:mysql://localhost/University";
Connection connection = null;
Statement statement = null;
ResultSet rs = null;
Statement stmt=null;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/template62.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Company Name</title>
<!-- InstanceEndEditable -->
<!-- InstanceBeginEditable name="head" -->
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<!-- InstanceEndEditable -->
<link href="styles/base.css" rel="stylesheet" type="text/css" />


<script type="text/javascript">
var listOfCourses = new Array();
var bxs;
function checkAll(){
    bxs = document.getElementsByName("row");
listOfCourses = new Array();
    for(i = 0; i < bxs.length; i++){
    var course = bxs[i].getElementsByTagName("td");
    var crs = new Array();
    if(course[0].getElementsByTagName("input")[0].checked==true){
    for(j = 1; j < course.length; j++){		
	crs[j-1] = course[j].innerHTML;
    }
    listOfCourses[i]=crs;
    registerCourses(crs);
  }
    }
//    registerCourses(listOfCourses);
}
//ajax

var xmlhttp

function registerCourses(str)
{

xmlhttp=GetXmlHttpObject();

if (xmlhttp==null)
{
alert ("Your browser does not support Ajax HTTP");
return;
}

 var url="returncourselist.jsp";
 url=url+"?course="+str+"&studentId="+document.getElementById("sid").value+"&drop=true";
 xmlhttp.onreadystatechange=getCourseRegisterOutput;
 xmlhttp.open("PUT",url,true);
 xmlhttp.send(null);
}

 function getCourseRegisterOutput()
 {
   if (xmlhttp.readyState==4)
   {
	   loadContent();
   //document.getElementById("table").innerHTML=xmlhttp.responseText;
   }
 }

function loadContent()
{
 xmlhttp=GetXmlHttpObject();

  if (xmlhttp==null)
  {
   alert ("Your browser does not support Ajax HTTP");
   return;
  }
    var url="returncourselist.jsp";
    url=url+"?studentId="+document.getElementById("sid").value+"&drop=true";
    xmlhttp.onreadystatechange=getOutput;
    xmlhttp.open("GET",url,true);
    xmlhttp.send(null);
}

function getOutput()
{
  if (xmlhttp.readyState==4)
  {
  document.getElementById("table").innerHTML=xmlhttp.responseText;
  }
}

function GetXmlHttpObject()
{
    if (window.XMLHttpRequest)
    {
       return new XMLHttpRequest();
    }
    if (window.ActiveXObject)
    {
      return new ActiveXObject("Microsoft.XMLHTTP");
    }
 return null;
}
//eof ajax
</script>


</head>
<body>
<!-- Main Layout Table -->
<table width="868" border="0" cellpadding="0" cellspacing="0" id="maintable">
  <tr>
    <td width="868"><img src="images/top.gif" alt="" name="top" width="868" height="14" id="top" /></td>
  </tr>
  <tr>
    <td class="basebg"><a href="index.html"><img src="images/company-name-blank.png" alt="" name="header" width="840" height="100" border="0" id="header" /></a></td>
  </tr>
  <tr>
    <td class="basebg">
	<!-- Main Content Table -->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="contenttable">
      <tr>
        <td><img src="images/nav-top.gif" alt="" name="navtop" width="170" height="11" id="navtop" /></td>
        <td></td>
      </tr>
      <tr>
	  <!-- Navigation Table Cell -->
        <td class="navtd">
		<div class="buttonscontainer">
			<div class="buttons">
			<a href="search.jsp">Course Search</a>			
			<a href="list.jsp">Students in a Section</a>
			<a href="register.jsp">Add Section</a>
			<a href="drop.jsp">Drop Section</a>
			<a href="contact.jsp">Contact Us</a>			</div>
		</div>
		</td>
		<!-- Content Table Cell -->
        <td class="contenttd"><!-- InstanceBeginEditable name="text" -->

<!-- code starts here -->
          <table rowspan=1 colspan=1 align="center">
<H4> <td> <b><u><LABLE > <h4>DROP SECTION </h4></LABLE> </u></B></td> </H4>
</table>
<div style=" ">
<%
Class.forName("com.mysql.jdbc.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL, "root", "mysql");
%>
<!-- code to get the list of course into dropdown -->
<table><!-- tr><td><label>  Course Number:</label></td><td>
<select name="courseId" onchange="loadContent(this.options[this.selectedIndex].text)"> <option>Select One</option>
	<%--
	String rec = "select courseId from Course order  by courseId";
	try {
	stmt=connection.createStatement();
	ResultSet rssel=stmt.executeQuery(rec);
	
	while(rssel.next())
	{
	%>
<option><%= rssel.getInt(1)%></option>
<% }

}
catch(Exception e){
System.out.println(e);
}
stmt.close();


--%>
</select>
</td></tr-->
<tr><td><label>  StudentID:</label></td><td><input type="text" ID="sid" name="sid"></input></td></tr>
<tr><td><button onclick="loadContent()">Show Sections</button></td></tr>
</table>
<!-- code ends here -->
<table border=1 bordercolor=lightblue cellspacing=0 cellpadding=2  colspan=1 rowspan=1 align="center" id="table" name="table">
<thead>
<tr>
<th></th>
  <th>CourseID</th>
<th>Sec</th>
<th>Semester</th>
<th>Year</th>
<th>FirstName</th>
<th>LastName</th>
<th>Building</th>
<th>Room</th>
<th>Day</th>
<th>StartTime</th>
<th>EndTime</th>
<th>Enrolled</th>
</tr>
</thead>
<tbody style=" height:150px; overflow-x: hidden; overflow-y: scroll;"> 


<%--

statement = connection.createStatement();
rs = statement.executeQuery("select s.courseId,s.sectionId,s.semester,s.semYear,I.firstName, I.lastName, building,classroom,T.weekDay,T.startTime,T.endTime,s.enrolled from Section s, Instructor I,LectureTime T  where s.instructorId = I.instructorId and s.timeId=T.timeId");

while (rs.next()) {
--%>
<tr name="row">
<td name="cell"><!-- input id="ck" type="checkbox" /-->
</td>
<td  name ="cell"> <%--
out.println(rs.getString("courseId")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("sectionId")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("semester")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("semYear")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("firstName")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("lastName")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("building")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("classroom")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("weekDay")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("startTime")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("endTime")); --%>
</td>
<td name ="cell"> <%--
out.println(rs.getString("enrolled")); --%>
</td>
</tr>

<%--
}

rs.close();
--%>

</tbody>
</table>
<button type="button" onClick="checkAll()">Drop</button>
</div>
<!-- code ends here -->

      </tr>
      <tr>
        <td><img src="images/nav-base.gif" alt="" name="navbase" width="170" height="11" id="navbase" /></td>
        <td></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><img src="images/base.gif" alt="" name="base" width="868" height="17" id="base" /></td>
  </tr>

</table>
</body>
<!-- InstanceEnd --></html> 
