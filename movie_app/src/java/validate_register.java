import java.io.IOException;
import java.sql.*;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/validate_register")
public class validate_register extends HttpServlet{
    
        Connection con;
        PreparedStatement pst;
        
        
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
                Statement st= con.createStatement();
                String uname=req.getParameter("email");
                String password=req.getParameter("psw");
                String password_2=req.getParameter("psw-repeat");
                

                ResultSet rs=st.executeQuery("select * from users where user_name='"+uname+"'");
                if(!rs.next()){
                                    
                    if(password_2.equals(password)){
                    pst = con.prepareStatement("insert into users(user_name,user_pass)values(?,?)");
                    pst.setString(1, uname);
                    pst.setString(2, password);
                    session.setAttribute("username", uname);
                    session.setAttribute("password", password);

                    pst.executeUpdate();
                    rsp.sendRedirect("index.jsp");
                    }
                    else{
                        rsp.sendRedirect("login.html");
                    }
                    
                }
                else{
                    req.setAttribute("message", "Hello "+uname+". User already exists!");
                    rsp.sendRedirect("login.html");
                }
            }
            catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(validate_register.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
}