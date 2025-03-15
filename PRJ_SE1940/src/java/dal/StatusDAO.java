/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.Department;
import Model.Status;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class StatusDAO extends DBcontext{
    
    //GetAll
    public List<Status> getAll() {
        List<Status> list = new ArrayList<>();
        String sql = "SELECT * FROM Status";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int statusId = rs.getInt("StatusID");
                String statusName = rs.getString("StatusName");
                Status s = new Status(statusId, statusName);
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //GetAll
    public List<Status> getAll2() {
        List<Status> list = new ArrayList<>();
        String sql = "SELECT * FROM Status where StatusID !=4 and StatusID!=1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int statusId = rs.getInt("StatusID");
                String statusName = rs.getString("StatusName");
                Status s = new Status(statusId, statusName);
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
}
