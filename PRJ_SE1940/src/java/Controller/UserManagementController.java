/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.User;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class UserManagementController extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserListController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserListController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO udao = new UserDAO();
        List<User> ulist = new ArrayList<>();
        ulist = udao.getAll();
        System.out.println("User List: " + ulist.toString());
        request.setAttribute("ulist", ulist);
        request.getRequestDispatcher("userList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String role1 = request.getParameter("role");
        
        UserDAO udao = new UserDAO();
        
        if(action.equalsIgnoreCase("add")){
            String usernameStr = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String roleStr = request.getParameter("role");
            int role = Integer.parseInt(roleStr);
            
            User userAdd = new User(0,usernameStr, password, name, role);
            udao.addUser(userAdd);
        }else if(action.equalsIgnoreCase("edit")){
            String Id = request.getParameter("userId");
            int userId = Integer.parseInt(Id);
            User user = udao.getUserByUserID(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("userEdit.jsp").forward(request, response);
        }else if(action.equalsIgnoreCase("saveEditUser")){
            String Id = request.getParameter("userId");
            String usernameStr = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String roleStr = request.getParameter("role");
            
            int userId = Integer.parseInt(Id);
            int role = Integer.parseInt(roleStr);
            
            User userUpdate = new User(userId,usernameStr, password, name, role);
            udao.updateUser(userUpdate);
        }else if(action.equalsIgnoreCase("delete")){
            String Id = request.getParameter("userId");
            int userId = Integer.parseInt(Id);
            udao.deleteUser(userId);
        }
        
        response.sendRedirect("userManagement");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
