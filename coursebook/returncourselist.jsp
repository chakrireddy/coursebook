 <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
 <%@ page import="java.sql.*" %>
<%
String connectionURL = "jdbc:mysql://localhost/University";
Connection connection = null;
Statement statement = null;
ResultSet rs = null;
%>
<%
 String q =request.getParameter("courseid");
String studentId = request.getParameter("studentId");
String course = request.getParameter("course");
String drop = request.getParameter("drop");
%>
<!-- table border=1 bordercolor=lightblue cellspacing=0 cellpadding=2  colspan=1 rowspan=1 align="center" id="table" name="table"-->
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


<%
Class.forName("com.mysql.jdbc.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL, "root", "mysql");
statement = connection.createStatement();
if(studentId != null && course!=null){
	//insert into Enrolls(studentId,courseId,sectionId,semester,semYear) values('2021142313',6363,1,'Spring',2013);
	System.out.println("course: "+course);
	String[] courseArray = course.split(",");
	String query = null;
	int enrolled = 0;
	for(int i=0;i<courseArray.length;i++){
		/* 		//System.out.println("course: "+courseArray[i]);
		if(i==0){
			String[] courseinfo = courseArray[i].split(",");
			int courseNumber = Integer.parseInt(courseinfo[1].trim());
			int sectionNum = Integer.parseInt(courseinfo[2].trim());
			String sem = courseinfo[3].trim();
			int year = Integer.parseInt(courseinfo[4].trim());
			registerQuery = "insert into Enrolls(studentId,courseId,sectionId,semester,semYear) values('"+studentId+"',"+courseNumber+","+sectionNum+",'"+sem+"',"+year+")";
		}else { 
			String[] courseinfo = courseArray[i].split(",");
			int courseNumber = Integer.parseInt(courseinfo[0].trim());
			int sectionNum = Integer.parseInt(courseinfo[1].trim());
			String sem = courseinfo[2].trim();
			int year = Integer.parseInt(courseinfo[3].trim());
			registerQuery = "insert into Enrolls(studentId,courseId,sectionId,semester,semYear) values('"+studentId+"',"+courseNumber+","+sectionNum+",'"+sem+"',"+year+")";
		}*/		
		int courseNumber = Integer.parseInt(courseArray[0].trim());
		int sectionNum = Integer.parseInt(courseArray[1].trim());
		String sem = courseArray[2].trim();
		int year = Integer.parseInt(courseArray[3].trim());
		if(drop!=null){
			query = "delete from Enrolls where (studentId='"+studentId+"' and courseId="+courseNumber+" and sectionId="+sectionNum+" and semester='"+sem+"' and semYear="+year+")";
		}else {
			query = "insert into Enrolls(studentId,courseId,sectionId,semester,semYear) values('"+studentId+"',"+courseNumber+","+sectionNum+",'"+sem+"',"+year+")";
		}
		try{
		statement.executeUpdate(query);
		enrolled++;
			
		return;
		} catch(Exception e){
			e.printStackTrace();
		}
		
	}
}
else{
	if(drop != null){
		String qry = "select s.courseId,s.sectionId,s.semester,s.semYear,I.firstName, I.lastName, building,classroom,T.weekDay,T.startTime,T.endTime,s.enrolled from Section s, Instructor I,LectureTime T, Enrolls e where s.courseId = e.courseId and e.studentId='"+studentId+"' and e.sectionId=s.sectionId and e.semester=s.semester and e.semYear=s.semYear and s.instructorId = I.instructorId and s.timeId=T.timeId";
		System.out.println("drop qry: "+qry);
		rs = statement.executeQuery(qry);
	}else{
rs = statement.executeQuery("select s.courseId,s.sectionId,s.semester,s.semYear,I.firstName, I.lastName, building,classroom,T.weekDay,T.startTime,T.endTime,s.enrolled from Section s, Instructor I,LectureTime T  where courseId = '"+q+"' and s.instructorId = I.instructorId and s.timeId=T.timeId");
	}

while (rs.next()) {
%>
<tr name="row">
<td name="cell"><input id="ck" type="checkbox" />
</td>
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
}
rs.close();
%>

</tbody>
