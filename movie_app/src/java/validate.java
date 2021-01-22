/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Kostas
 */
import java.io.IOException;
import java.sql.Statement;
import java.io.PrintWriter;
import java.sql.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

    
@WebServlet("/validate")
public class validate extends HttpServlet{



        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        
        
        int row;
        @Override
        public void doPost(HttpServletRequest req,HttpServletResponse rsp)throws IOException,ServletException
        {
            rsp.setContentType("text/html");
            HttpSession session = req.getSession();
            PrintWriter out=rsp.getWriter();
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/productdb","root","konkon6789");
             
                Statement stmt=con.createStatement();
                String uname=req.getParameter("email");
                String password=req.getParameter("psw");
                ResultSet rs=stmt.executeQuery("select * from users where user_name='"+uname+"'");

               
                if(rs.next()){
                    if(rs.getString("user_pass").equals(password)){
                        session.setAttribute("username", uname);
                        session.setAttribute("password", password);
                        
                        rsp.sendRedirect("index.jsp");
                    }
                    else{
                        out.println("alert('User or password incorrect');");
                        rsp.sendRedirect("login.html");
                    }
                }
                else{
                    rsp.sendRedirect("login.html");
                }

            }
            catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(validate.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

}
