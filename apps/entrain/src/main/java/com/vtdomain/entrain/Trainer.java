package com.vtdomain.entrain;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DriverManager;

public class Trainer
{

    public static int getSumDig(int var0)
    {
       int ress1 = var0 + var0;
       return (int) ress1;
    }

    public static int getMultiDig(int var0)
    {
       int ress2 = var0 * var0;
       return (int) ress2;
    }

    public static String getTranslateEnUa(String var0)
    {
       try
       {
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/entraindb", "master", "m") ;
          Statement stmt = conn.createStatement() ;
          String query = "select uaw from words where enw = '"+ var0+"';" ;
          ResultSet rs = stmt.executeQuery(query) ;
          while (rs.next()) {
             String ress3 = rs.getString("uaw");
//             System.out.println(ress3.charAt(1));
//             System.out.println(ress3);
               return (String) ress3;
          }
       }
       catch (Exception e)
       {
          System.err.println("Got an exception!");
          System.err.println(e.getMessage());
       }
       return (String) var0;
    }
}
