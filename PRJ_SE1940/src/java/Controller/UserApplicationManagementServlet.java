/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.Application;
import Model.Role;
import Model.Status;
import Model.User;
import dal.ApplicationDAO;
import dal.RoleDAO;
import dal.StatusDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class UserApplicationManagementServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserApplicationManagementServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserApplicationManagementServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ApplicationDAO adao = new ApplicationDAO();
        StatusDAO sdao = new StatusDAO();
        UserDAO udao = new UserDAO();
        RoleDAO rdao = new RoleDAO();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        User u = (User) session.getAttribute("user");
        List<Application> alist = adao.getAll();
        List<Status> slist = sdao.getAll();
        List<Status> slist2 = sdao.getAll2();
        List<User> ulist = udao.getAll();
        List<Role> rlist = rdao.getAll();

        request.setAttribute("alist", alist);
        request.setAttribute("user", u);
        request.setAttribute("slist", slist);
        request.setAttribute("slist2", slist2);
        request.setAttribute("ulist", ulist);
        request.setAttribute("rlist", rlist);
        request.getRequestDispatcher("userApplicationManagement.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO udao = new UserDAO();
        ApplicationDAO adao = new ApplicationDAO();
        System.out.println("ACTION: " + action);

         if (action.equalsIgnoreCase("edit")) {
             System.out.println("APPLICATION ID: "+request.getParameter("applicationId"));
             System.out.println("STATUS ID: "+request.getParameter("statusId"));
             System.out.println("APPROVER ID: "+request.getParameter("approverId"));
             System.out.println("USER ID: "+request.getParameter("userId"));
            int applicationId = Integer.parseInt(request.getParameter("applicationId"));
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String title = request.getParameter("title");
            String reason = request.getParameter("reason");
            int statusId = Integer.parseInt(request.getParameter("statusId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int approverId = Integer.parseInt(request.getParameter("approverId"));

            Date startDates = null;
            Date endDates = null;
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                startDates = sdf.parse(startDateStr);
                endDates = sdf.parse(endDateStr);
            } catch (Exception e) {
                e.printStackTrace();
            }
            java.sql.Date startDate = new java.sql.Date(startDates.getTime());
            java.sql.Date endDate = new java.sql.Date(endDates.getTime());

            Application a = new Application(applicationId,userId , startDate, endDate, title, reason, statusId, approverId);
            System.out.println("APPLICATION: "+a.toString());
            adao.approveApplication(a);
        }
        response.sendRedirect("userApplicationManagement");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
