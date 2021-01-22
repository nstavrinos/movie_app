
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/movie_save")
public class movie_save extends HttpServlet{
    
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
                String uname=(String)session.getAttribute("username");
                String password=(String)session.getAttribute("password");
                String movie=req.getParameter("movie");
                String sql = "DELETE FROM users " +
                   "WHERE user_name = '"+uname+"' AND movie_saved = '"+movie+"'";
                    
                
                
                if(st.executeUpdate(sql)==0){
                      pst = con.prepareStatement("insert into users(user_name,user_pass,movie_saved)values(?,?,?)");
                    pst.setString(1, uname);
                    pst.setString(2, password);
                    pst.setString(3, movie);
                    session.setAttribute("movie", movie);

                    pst.executeUpdate();   
               }
                
            }
            catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(validate_register.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
}