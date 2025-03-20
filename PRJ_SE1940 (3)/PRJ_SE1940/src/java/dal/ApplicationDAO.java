/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Model.Application;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.Types;

/**
 *
 * @author ADMIN
 */
public class ApplicationDAO extends DBcontext {

    //GetAll
    public List<Application> getAll() {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM Application";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int applicationId = rs.getInt("ApplicationID");
                int userId = rs.getInt("UserID");
                Date startDate = rs.getDate("StartDate");
                Date endDate = rs.getDate("EndDate");
                String title = rs.getString("Title");
                String reason = rs.getString("Reason");
                int statusId = rs.getInt("StatusID");
                Integer approverId = rs.getInt("ApproverID");
                Application a = new Application(applicationId, userId, startDate, endDate, title, reason, statusId, approverId);
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //Get Application by UserID
    public List<Application> getAllByUserId(int userId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM Application WHERE UserID =?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int applicationId = rs.getInt("ApplicationID");
                Date startDate = rs.getDate("StartDate");
                Date endDate = rs.getDate("EndDate");
                String title = rs.getString("Title");
                String reason = rs.getString("Reason");
                int statusId = rs.getInt("StatusID");
                Integer approverId = rs.getInt("ApproverID");
                Application a = new Application(applicationId, userId, startDate, endDate, title, reason, statusId, approverId);
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    //Add

    public void addApplication(Application application) {
        String query = "INSERT INTO Application ( userId, startDate, endDate, title, reason, statusId, approverId) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, application.getUserId());
            st.setDate(2, (java.sql.Date) application.getStartDate());
            st.setDate(3, (java.sql.Date) application.getEndDate());
            st.setString(4, application.getTitle());
            st.setString(5, application.getReason());
            st.setInt(6, application.getStatusId());
            if (application.getApproverId() == null) {
                st.setNull(7, Types.INTEGER);
            } else {
                st.setInt(7, application.getApproverId());
            }
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Update 
    public void updateApplication(Application application) {
        String query = "UPDATE Application SET startDate = ?, endDate = ?, title = ?, reason = ? WHERE applicationId=?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setDate(1, (java.sql.Date) application.getStartDate());
            st.setDate(2, (java.sql.Date) application.getEndDate());
            st.setString(3, application.getTitle());
            st.setString(4, application.getReason());
            st.setInt(5, application.getApplicationId());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Phe duyet don
    public void approveApplication(Application application) {
        String query = "UPDATE Application SET StatusID=?, approverID=? WHERE applicationId=?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, application.getStatusId());

            st.setInt(2, application.getApproverId());
            st.setInt(3, application.getApplicationId());

            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Delete
    public void deleteApplication(int applicationId) {
        String query = "UPDATE Application SET StatusId=4 WHERE applicationId=?";
        try {
            PreparedStatement st = connection.prepareStatement(query);
            st.setInt(1, applicationId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

//Filter
    //filter by status
    public List<Application> filterByStatusId(int statusId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM Application WHERE StatusID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, statusId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int applicationId = rs.getInt("ApplicationID");
                int userId = rs.getInt("UserID");
                Date startDate = rs.getDate("StartDate");
                Date endDate = rs.getDate("EndDate");
                String title = rs.getString("Title");
                String reason = rs.getString("Reason");
                Integer approverId = rs.getInt("ApproverID");
                Application a = new Application(applicationId, userId, startDate, endDate, title, reason, statusId, approverId);
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

//Count
    // Count total applications
    public int countTotalApplications() {
        String sql = "SELECT COUNT(*) FROM Application where StatusId != 4";
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

    // Count processed applications
    public int countProcessedApplications() {
        String sql = "SELECT COUNT(*) FROM Application WHERE StatusId !=1 and StatusId !=4";
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

    // Count inprogress applications
    public int countInProgressApplications() {
        String sql = "SELECT COUNT(*) FROM Application WHERE StatusId =1";
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

    public List<Application> getApplicationsForMonth(int month, int year) {
        List<Application> applications = new ArrayList<>();
        try {
            String sql = "SELECT userId, startDate, endDate FROM Application "
                    + "WHERE (MONTH(startDate) = ? AND YEAR(startDate) = ?) "
                    + "   OR (MONTH(endDate) = ? AND YEAR(endDate) = ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, month);
            ps.setInt(2, year);
            ps.setInt(3, month);
            ps.setInt(4, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                applications.add(new Application(
                        rs.getInt("applicationId"),
                        rs.getInt("userId"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getString("title"),
                        rs.getString("reason"),
                        rs.getInt("statusId"),
                        rs.getInt("approverId")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applications;
    }

}
