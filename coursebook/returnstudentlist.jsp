  <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
 <%@ page import="java.sql.*" %>
<%
String connectionURL = "jdbc:mysql://localhost/University";
Connection connection = null;
Statement statement = null;
ResultSet rs = null;

 String courseId =request.getParameter("courseId");
String sectionId =request.getParameter("sectionId");
%>
<!-- table border=1 bordercolor=lightblue cellspacing=0 cellpadding=2  colspan=1 rowspan=1 align="center" id="table" name="table"-->
<thead>
<tr>
<th>FirstName</th>
<th>LastName</th>
</tr>
</thead>
<tbody style=" height:150px; overflow-x: hidden; overflow-y: scroll;"> 

<%
Class.forName("com.mysql.jdbc.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL, "root", "mysql");
statement = connection.createStatement();
if(courseId != null && sectionId != null && !sectionId.equals("Select One")){
	System.out.println("select s.firstName,s.lastName from Student s, Enrolls c where c.courseId="+courseId+" and c.sectionId="+sectionId+" and c.studentId=s.studentId");
rs = statement.executeQuery("select s.firstName,s.lastName from Student s, Enrolls c where c.courseId="+courseId+" and c.sectionId="+sectionId+" and c.studentId=s.studentId");

while (rs.next()) {
%>
<tr name="row">
<td  name ="cell"><%
out.println(rs.getString("firstName"));%>
</td>
<td name ="cell"> <%
out.println(rs.getString("lastName")); %>
</td>
</tr>

<%
}

rs.close();
%>

</tbody>
<!--  /table-->
<%
}else{

	try {
		statement=connection.createStatement();
		System.out.println("select s.sectionId from Section s where courseId="+courseId);
	ResultSet rssel=statement.executeQuery("select s.sectionId from Section s where courseId="+courseId);
	
	while(rssel.next())
	{
		System.out.println("rs"+rssel.getInt(1));
	%>
<option><%= rssel.getInt(1)%></option>
<% }

}
catch(Exception e){
e.printStackTrace();
}
	statement.close();

}
%>


<%

%> 