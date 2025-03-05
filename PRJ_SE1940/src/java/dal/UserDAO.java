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
        String query = "SELECT * FROM Users WHERE username = ? AND password=?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("UserID");
                String name = rs.getString("Name");
                int role = rs.getInt("Role");
                account = new User(userId, username, password, name, role);
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
                int role = rs.getInt("Role");
                User user = new User(userId, username, password, name, role);
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //Add
    public void addUser(User user) {
        String query = "INSERT INTO Users (username, password, name, role) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getName());
            st.setInt(4, user.getRole());

            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Edit
    public void updateUser(User user) {
        String query = "UPDATE Users SET username = ?, password = ?, name = ?, role = ? WHERE userID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getName());
            st.setInt(4, user.getRole());
            st.setInt(5, user.getUserId());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Delete
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
                String username = rs.getString("username");
                String password = rs.getString("password");
                String name = rs.getString("name");
                int role = rs.getInt("role");

                user = new User(userId, username, password, name, role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    //Check username
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
}
