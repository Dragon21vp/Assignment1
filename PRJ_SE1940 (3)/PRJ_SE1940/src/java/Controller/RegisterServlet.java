/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.Department;
import Model.User;
import dal.DepartmentDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        DepartmentDAO ddao = new DepartmentDAO();
        List<Department> dlist = ddao.getAll();
        request.setAttribute("dlist", dlist);

        request.getRequestDispatcher("register.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        UserDAO udao = new UserDAO();
        DepartmentDAO ddao = new DepartmentDAO();
        List<Department> dlist = ddao.getAll();
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String departmentIdstr = request.getParameter("departmentId");
        int departmentId = Integer.parseInt(departmentIdstr);

        if (udao.isUsernameTaken(username)) {
            request.setAttribute("message", "Username already exists!");
            request.setAttribute("dlist", dlist);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }else if (udao.isEmailTaken(email)) {
            request.setAttribute("message", "Email already exists!");
            request.setAttribute("dlist", dlist);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }else if (udao.isPhoneTaken(phone)) {
            request.setAttribute("message", "Phone already exists!");
            request.setAttribute("dlist", dlist);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }else {
            request.setAttribute("successMessage", "Register successful!");
            request.setAttribute("dlist", dlist);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            User newUser = new User(0, username, password, name, email, phone, departmentId, 3, 1 ); // 3 là role User
            udao.addUser(newUser);
            response.sendRedirect("login");
        }
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
