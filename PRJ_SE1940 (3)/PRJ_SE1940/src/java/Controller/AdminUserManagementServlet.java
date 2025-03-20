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

public class AdminUserManagementServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminUserManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminUserManagementServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        UserDAO udao = new UserDAO();
        DepartmentDAO ddao = new DepartmentDAO();
        RoleDAO rdao = new RoleDAO();

        List<User> ulist = udao.getAll();
        List<Department> dlist = ddao.getAll();
        List<Role> rlist = rdao.getAll();

        if (action != null && action.equalsIgnoreCase("add")) {
            request.setAttribute("dlist", dlist);
            request.setAttribute("rlist", rlist);
            System.out.println("ACTION: " + action);
            for (Role r : rlist) {
                System.out.println("ROLE LIST: " + r);
            }
            for (Department d : dlist) {
                System.out.println("DEPARTMENT LIST: " + d);
            }
            request.getRequestDispatcher("ADMIN_UserAdd.jsp").forward(request, response);
            return;
        } else if (action != null && action.equalsIgnoreCase("delete")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            udao.deleteUser(userId);
            response.sendRedirect("adminUserManagement");
            return;
        }

        request.setAttribute("ulist", ulist);
        request.setAttribute("dlist", dlist);
        request.setAttribute("rlist", rlist);
        request.getRequestDispatcher("ADMIN_UserManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        UserDAO udao = new UserDAO();
        System.out.println("ACTION: " + action);

        if (action.equalsIgnoreCase("addSave")) {
            String usernameStr = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int departmentId = Integer.parseInt(request.getParameter("departmentId"));
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            int status = Integer.parseInt(request.getParameter("status"));

            User userAdd = new User(0, usernameStr, password, name, email, phone, departmentId, roleId, status);
            udao.addUser(userAdd);
        } else if (action.equalsIgnoreCase("edit")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String usernameStr = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int departmentId = Integer.parseInt(request.getParameter("departmentId"));
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            int status = Integer.parseInt(request.getParameter("status"));
            
            User userEdit = new User(userId, usernameStr, password, name, email, phone, departmentId, roleId, status);
            System.out.println("USER EDIT: "+userEdit.toString());
            udao.updateUser(userEdit);
        } 

        response.sendRedirect("adminUserManagement");
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
