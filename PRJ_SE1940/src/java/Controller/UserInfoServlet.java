/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Department;
import Model.Role;
import Model.User;
import dal.DepartmentDAO;
import dal.RoleDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

public class UserInfoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserInfoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserInfoServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login"); 
            return;
        }
        User u = (User) session.getAttribute("user");
        UserDAO udao = new UserDAO();
        DepartmentDAO ddao = new DepartmentDAO();
        RoleDAO rdao = new RoleDAO();
        
        User user = udao.getUserByUserID(u.getUserId());
        List<Department> dlist = ddao.getAll();
        List<Role> rlist = rdao.getAll();
        
        request.setAttribute("user", user);
        request.setAttribute("dlist", dlist);
        request.setAttribute("rlist", rlist);
        request.getRequestDispatcher("userInfo.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO udao = new UserDAO();
        System.out.println("ACTION: " + action);
        if (action.equalsIgnoreCase("edit")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int departmentId = Integer.parseInt(request.getParameter("departmentId"));
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            int status = Integer.parseInt(request.getParameter("status"));
            User userEdit = new User(userId, username, password, name, email, phone, departmentId, roleId, status);
            udao.updateUser(userEdit);
        } 

        response.sendRedirect("userInfo");
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
