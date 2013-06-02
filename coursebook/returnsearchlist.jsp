  <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
 <%@ page import="java.sql.*" %>
<%
String connectionURL = "jdbc:mysql://localhost/University";
Connection connection = null;
Statement statement = null;
ResultSet rs = null;
%>
<%
 String cname =request.getParameter("cname");
String cnum = request.getParameter("cnum");
String instructor = request.getParameter("instructor");
String ctime = request.getParameter("ctime");


%>
<!-- table border=1 bordercolor=lightblue cellspacing=0 cellpadding=2  colspan=1 rowspan=1 align="center" id="table" name="table"-->
<thead>
<tr>

  <th>CourseID</th>
<th>SectionID</th>
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


<%
Class.forName("com.mysql.jdbc.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL, "root", "mysql");
statement = connection.createStatement();
String query = null;
if(cnum != ""){
query = "select s.courseId,s.sectionId,s.semester,s.semYear,I.firstName, I.lastName, building,classroom,T.weekDay,T.startTime,T.endTime,s.enrolled from Section s, Instructor I,LectureTime T  where courseId= '"+cnum+"' and s.instructorId = I.instructorId and s.timeId=T.timeId";
} else if(cname != "" && cnum=="" && instructor=="" && ctime==""){
//when courseName is given
query = "select s.courseId, c.title,s.sectionId,s.semester,s.semYear,I.firstName, I.lastName, building,classroom,T.weekDay,T.startTime,T.endTime,s.enrolled from Section s, Instructor I,LectureTime T, Course c where s.courseId = c.courseId and c.title = '"+cname+"' and s.instructorId = I.instructorId and s.timeId=T.timeId";
} else if(cname == "" && cnum=="" && instructor!="" && ctime==""){
//when  instructor name is given
query = "select s.courseId, c.title,s.sectionId,s.semester,s.semYear,I.firstName, I.lastName, building,classroom,T.weekDay,T.startTime,T.endTime,s.enrolled from Section s, Instructor I,LectureTime T, Course c where (I.firstName='"+instructor+"')  and s.courseId = c.courseId and s.instructorId = I.instructorId and s.timeId=T.timeId";
} else if(cname == "" && cnum=="" && instructor=="" && ctime!=""){
//when classtime is given
query = "select s.courseId, c.title,s.sectionId,s.semester,s.semYear,I.firstName, I.lastName, building,classroom,T.weekDay,T.startTime,T.endTime,s.enrolled from Section s, Instructor I,LectureTime T, Course c where T.startTime='"+ctime+"'  and s.courseId = c.courseId and s.instructorId = I.instructorId and s.timeId=T.timeId";
}
System.out.println("Query: "+query);
rs = statement.executeQuery(query);
while (rs.next()) {
%>
<tr name="row">

<td  name ="cell"> <%
out.println(rs.getString("courseId")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("sectionId")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("semester")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("semYear")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("firstName")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("lastName")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("building")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("classroom")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("weekDay")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("startTime")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("endTime")); %>
</td>
<td name ="cell"> <%
out.println(rs.getString("enrolled")); %>
</td>

</tr>

<%
}

rs.close();
%>

</tbody>
