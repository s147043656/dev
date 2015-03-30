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
   <b>Example1.</b> Current date and time:
   <%
    System.out.println( "Evaluating date now" );
    java.util.Date date3 = new java.util.Date();
   %>
   Hello! The time is now <%= date3 %><br><br>

   <b>Example2.</b> Sum of digit:
   <% int var1 = Trainer.getSumDig(17); %>
   <%= var1 %></br><br>

   <b>Example3.</b> Multiplication of digit:
   <% int var2 = Trainer.getMultiDig(17); %>
   <%= var2 %></br><br>

   <b>Example4.</b> Translation EN-UA of one hardcoded word:
   <% String var3 = Trainer.getTranslateEnUa("window"); %>
   <%= var3 %></br><br>

 </body>
</html>
