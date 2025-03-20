package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBcontext {

    protected Connection connection;

    public DBcontext() {
        //@Students: You are allowed to edit user, pass, url variables to fit
        //your system configuration
        //You can also add more methods for Database Interaction tasks.
        //But we recommend you to do it in another class
        // For example : StudentDBContext extends DBContext ,
        //where StudentDBContext is located in dal package,
        try {
            String user = "dat";
            String pass = "12345";
            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=SE1940_Prj";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBcontext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}