<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.vtdomain.entrain.*" %>

<html>
 <body>
  <table width="640">
   <td align="right"><a href="login.jsp">Log in</a></td>
  </table>

  <table bgcolor="#F5F5DC">
   <td width="100"><a href="index.jsp">Home</a></td>
   <td width="100"><a href="trainer.jsp">Trainer</a></td>
   <td width="440"><a href="examples.jsp">Examples</a></td>
  </table>
  </br></br>
  <pre>
        <strong>Please log in using your username and password.</strong>
        <form name="LoginForm" action="login.jsp" method="POST">
        User name: <input name="j_username" size="20">
        <% String juname=request.getParameter("j_username"); %>
        </input>
        Password:  <input name="j_password" size="20">
        <% String jpassword=request.getParameter("j_password"); %>
        </input>
                   <input type="submit" value="Submit"/>
        </form>

        <%
         System.out.println( "Evaluating date now" );
         java.util.Date date3 = new java.util.Date();
        %>
        The time is now <%= date3 %><br><br>
  </pre>
 </body>
</html>
