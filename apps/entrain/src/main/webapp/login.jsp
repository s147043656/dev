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
  <pre>
        <h2>Hello, please log in:</h2>
        <form name="LoginForm" action="j_security_check" method="POST">
        <strong>Please type your user name: </strong>
        <input name="j_username" size="20">
        <% String juname=request.getParameter("j_username"); %>
        </input>
        <strong>Please type your password: </strong>
        <input name="j_password" size="20">
        <% String jpassword=request.getParameter("j_password"); %>
        </input>
        <input type="submit" value="Submit"/>
        <input type="reset" value="Reset"/>
        </form>
  </pre>
 </body>
</html>
