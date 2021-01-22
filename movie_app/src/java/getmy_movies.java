/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Kostas
 */
import java.io.FileWriter;
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
import org.json.JSONArray;

    
@WebServlet("/getmy_movies")
public class getmy_movies extends HttpServlet{


            private static FileWriter file;

        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        JSONArray jarray;
        
        int row;
        @Override
        public void doGet(HttpServletRequest req,HttpServletResponse rsp)throws IOException,ServletException
        {
            
            rsp.setContentType("text/html");
            HttpSession session = req.getSession();
            PrintWriter out=rsp.getWriter();
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost/productdb","root","konkon6789");
             
                Statement stmt=con.createStatement();
                String uname=(String)session.getAttribute("username");
                String password=(String)session.getAttribute("password");
                ResultSet rs=stmt.executeQuery("select movie_saved from users where user_name='"+uname+"'"+"and movie_saved is not null");

               
                /*while(rs.next()){
                    if(rs.getString("movie_saved")!=null){
                        session.setAttribute("username", uname);
                        session.setAttribute("password", password);
                        
                        rsp.sendRedirect("index.jsp");
                    }
                }*/
                rsp.setContentType("application/json");
                rsp.setCharacterEncoding("UTF-8");

                    jarray = new ResultSetToJsonMapper().convertToJSON(rs);
            
           //file = new FileWriter("C:\\Users\\Kostas\\Desktopcrunchify.txt");
            //file.write(rs.toString());
                out.print(jarray);
                //out.flush();   

            }
            catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(validate.class.getName()).log(Level.SEVERE, null, ex);
            } catch (Exception ex) {
                Logger.getLogger(getmy_movies.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

}
