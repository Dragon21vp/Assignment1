/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Application;
import Model.User;
import dal.ApplicationDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 *
 * @author ADMIN
 */
public class StatisticServlet extends HttpServlet {

    private UserDAO userDAO;
    private ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        applicationDAO = new ApplicationDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Statistic</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Statistic at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userDAO.getAll2();  // Lấy danh sách nhân viên từ DB
        List<Application> applications = applicationDAO.getAll();  // Lấy danh sách đơn nghỉ

        LocalDate today = LocalDate.now();
        int month = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : today.getMonthValue();
        int year = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : today.getYear();
        int daysInMonth = YearMonth.of(year, month).lengthOfMonth();

        // Tạo map để lưu danh sách ngày nghỉ của từng nhân viên
        Map<Integer, Set<Integer>> userAbsentDays = new HashMap<>();

        for (User user : users) {
            userAbsentDays.put(user.getUserId(), new HashSet<>());
        }

        for (Application app : applications) {

            if (app.getStatusId() != 2) {
                continue;
            }
            int userId = app.getUserId();
            System.out.println("StartDate class: " + app.getStartDate().getClass().getName());
            LocalDate start = ((java.sql.Date) app.getStartDate()).toLocalDate();
            LocalDate end = ((java.sql.Date) app.getEndDate()).toLocalDate();

            for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
                if (date.getMonthValue() == month && date.getYear() == year) {
                    userAbsentDays.get(userId).add(date.getDayOfMonth());
                }
            }
        }

        request.setAttribute("users", users);
        request.setAttribute("userAbsentDays", userAbsentDays);
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.setAttribute("daysInMonth", daysInMonth);

        request.getRequestDispatcher("USER_ApplicationStatistic.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public boolean isAbsent(int userId, int day, int month, int year, List<Application> applications) {
        LocalDate targetDate = LocalDate.of(year, month, day);
        for (Application app : applications) {
            if (app.getStatusId() != 2) {
            continue;
        }
            LocalDate start = app.getStartDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            LocalDate end = app.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            if (app.getUserId() == userId && !start.isAfter(targetDate) && !end.isBefore(targetDate)) {
                return true;
            }
        }
        return false;
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
