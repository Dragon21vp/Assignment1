/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Application;
import Model.Department;
import Model.Role;
import Model.Status;
import Model.User;
import dal.ApplicationDAO;
import dal.DepartmentDAO;
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
public class UserApplicationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserApplicationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserApplicationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ApplicationDAO adao = new ApplicationDAO();
        StatusDAO sdao = new StatusDAO();
        UserDAO udao = new UserDAO();
        RoleDAO rdao = new RoleDAO();
        DepartmentDAO ddao = new DepartmentDAO();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        User u = (User) session.getAttribute("user");
        List<Department> dlist = ddao.getAll();
        List<Role> rlist = rdao.getAll();

        String action = request.getParameter("action");
        if (action != null && action.equalsIgnoreCase("add")) {
            request.setAttribute("dlist", dlist);
            request.setAttribute("rlist", rlist);
            request.setAttribute("user", u);
            request.getRequestDispatcher("userApplicationAdd.jsp").forward(request, response);
            return;
        }else if (action != null && action.equalsIgnoreCase("delete")) {
            int applicationId = Integer.parseInt(request.getParameter("applicationId"));
            adao.deleteApplication(applicationId);
            response.sendRedirect("userApplication");
            return;
        }

        List<Application> alist = adao.getAllByUserId(u.getUserId());
        List<Status> slist = sdao.getAll();
        List<User> ulist = udao.getAll();

        request.setAttribute("alist", alist);
        request.setAttribute("user", u);
        request.setAttribute("slist", slist);
        request.setAttribute("ulist", ulist);
        request.setAttribute("rlist", rlist);
        request.getRequestDispatcher("userApplication.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO udao = new UserDAO();
        ApplicationDAO adao = new ApplicationDAO();
        System.out.println("ACTION: " + action);

        if (action.equalsIgnoreCase("addSave")) {
            System.out.println("USERID FROM ADD: "+ request.getParameter("userId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String title = request.getParameter("title");
            String reason = request.getParameter("reason");

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

            Application a = new Application(0, userId, startDate, endDate, title, reason, 1, null);
            adao.addApplication(a);
        }else if (action.equalsIgnoreCase("edit")) {
            int applicationId = Integer.parseInt(request.getParameter("applicationId"));
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String title = request.getParameter("title");
            String reason = request.getParameter("reason");

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

            Application a = new Application(applicationId, 0, startDate, endDate, title, reason, 1, null);
            System.out.println("APPLICATION: "+a.toString());
            adao.updateApplication(a);
        }
        response.sendRedirect("userApplication");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
