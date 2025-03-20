/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Model.User;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class UserDAO extends DBcontext {

    //Login
    public User getUserByUsernameAndPassword(String username, String password) {
        User account = null;
        String query = "SELECT * FROM Users WHERE username = ? AND password=? AND status=1";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("UserID");
                String name = rs.getString("Name");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                int departmentId = rs.getInt("DepartmentID");
                int roleId = rs.getInt("RoleID");
                int status = rs.getInt("Status");
                account = new User(userId, username, password, name, email, phone, departmentId, roleId, status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return account;
    }

    //GetAll
    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("UserID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String name = rs.getString("Name");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                int departmentId = rs.getInt("DepartmentID");
                int roleId = rs.getInt("RoleID");
                int status = rs.getInt("Status");
                User user = new User(userId, username, password, name, email, phone, departmentId, roleId, status);
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //GetAll != admin
    public List<User> getAll2() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users where userId !=1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("UserID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String name = rs.getString("Name");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                int departmentId = rs.getInt("DepartmentID");
                int roleId = rs.getInt("RoleID");
                int status = rs.getInt("Status");
                User user = new User(userId, username, password, name, email, phone, departmentId, roleId, status);
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //Add
    public void addUser(User user) {
        String query = "INSERT INTO Users (username, password, name, email, phone, departmentId, roleId, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getName());
            st.setString(4, user.getEmail());
            st.setString(5, user.getPhone());
            st.setInt(6, user.getDepartmentId());
            st.setInt(7, user.getRoleId());
            st.setInt(8, user.getStatus());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
   //Edit
    public void updateUser(User user) {
        String query = "UPDATE Users SET username = ?, password = ?, name = ?, email = ?, phone = ?, departmentId = ?, roleId = ?, status = ? WHERE userID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getName());
            st.setString(4, user.getEmail());
            st.setString(5, user.getPhone());
            st.setInt(6, user.getDepartmentId());
            st.setInt(7, user.getRoleId());
            st.setInt(8, user.getStatus());
            st.setInt(9, user.getUserId());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
  
    //Delete (xóa mềm)
    public void deleteUser(int userId, int status) {

        String query = "UPDATE Users SET status = ? WHERE userID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, status);
            st.setInt(2, userId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    //Delete (xóa cứng)
    public void deleteUser(int userId) {

        String sql2 = "DELETE from Users where userID=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql2);
            st.setInt(1, userId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    //GetUserById
    public User getUserByUserID(int userId) {
        User user = null;
        String query = "SELECT * FROM Users WHERE userID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String name = rs.getString("Name");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                int departmentId = rs.getInt("DepartmentID");
                int roleId = rs.getInt("RoleID");
                int status = rs.getInt("Status");
                user = new User(userId, username, password, name, email, phone, departmentId, roleId, status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
   
    
    //Check usernmae
    public boolean isUsernameTaken(String username) {
        String query = "SELECT * FROM Users WHERE username = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Nếu tìm thấy username thì trả về true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //Check username
    public boolean isEmailTaken(String email) {
        String query = "SELECT * FROM Users WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Nếu tìm thấy username thì trả về true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    //Check phone
    public boolean isPhoneTaken(String phone) {
        String query = "SELECT * FROM Users WHERE phone = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Nếu tìm thấy username thì trả về true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
//Filter
    public List<User> filterByRole(int roleId) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE RoleID =?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            
            st.setInt(1,roleId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("UserID");
                String username = rs.getString("Username");
                String password = rs.getString("Password");
                String name = rs.getString("Name");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                int departmentId = rs.getInt("DepartmentID");
                int status = rs.getInt("Status");
                User user = new User(userId, username, password, name, email, phone, departmentId, roleId, status);
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
//Count 
    //Count Total Users
    public int countTotalUsers() {
        String sql = "SELECT COUNT(*) FROM Users";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; 
    }
    
    //Count DepartmentManager Users
    public int countDepartmentManagerUsers() {
        String sql = "SELECT COUNT(*) FROM Users WHERE RoleID=1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; 
    }
    
    //Count GroupLeader Users
    public int countGroupLeaderUsers() {
        String sql = "SELECT COUNT(*) FROM Users WHERE RoleID=2";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; 
    }
    
    //Count Staff Users
    public int countStaffUsers() {
        String sql = "SELECT COUNT(*) FROM Users WHERE RoleID=3";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; 
    }
}
