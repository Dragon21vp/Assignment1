/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class Application {
    private int applicationId;
    private int userId;
    private Date startDate;
    private Date endDate;
    private String title;
    private String reason;
    private int statusId;
    private Integer approverId;

    public Application(int applicationId, int userId, Date startDate, Date endDate, String title, String reason, int statusId, Integer approverId) {
        this.applicationId = applicationId;
        this.userId = userId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.title = title;
        this.reason = reason;
        this.statusId = statusId;
        this.approverId = approverId;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public Integer getApproverId() {
        return approverId;
    }

    public void setApproverId(Integer approverId) {
        this.approverId = approverId;
    }


    @Override
    public String toString() {
        return "\nApplication{" + "applicationId=" + applicationId + ", userId=" + userId + ", startDate=" + startDate + ", endDate=" + endDate + ", title=" + title + ", reason=" + reason + ", statusId=" + statusId + ", approverId=" + approverId + '}';
    }
    
    
    
}
