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


        <form action="index.jsp" method="get">
  <pre>
        Please enter a word to translate:
        <INPUT name="wordToTranslate">
        <% String wtt=request.getParameter("wordToTranslate"); %>
        </INPUT>
        <BUTTON type="submit">Translate</BUTTON>
        </form>
        Word:         <b><% out.println(wtt); %></b>
        Translation:  <b><% out.println(Trainer.getTranslateEnUa(wtt)); %></b>
  </pre>
 </body>
</html>
