/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.User;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        //Login
        String u = request.getParameter("username");
        String p = request.getParameter("password");
        String r = request.getParameter("rem");

        System.out.println(u);
        System.out.println(p);
        Cookie cu = new Cookie("cuser", u);
        Cookie cp = new Cookie("cpass", p);
        Cookie cr = new Cookie("crem", r);

        if (r != null) {
            cu.setMaxAge(60 * 60 * 24 * 7);
            cp.setMaxAge(60 * 60 * 24 * 7);
            cr.setMaxAge(60 * 60 * 24 * 7);
        } else {
            cu.setMaxAge(0);
            cp.setMaxAge(0);
            cr.setMaxAge(0);
        }
        response.addCookie(cu);
        response.addCookie(cp);
        response.addCookie(cr);
        UserDAO d = new UserDAO();
        try {
            User a = d.getUserByUsernameAndPassword(u, p);
            if (a == null) {
                request.setAttribute("ms", "invalid pass or username!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                session.setAttribute("user", a);

                if (a.getRoleId() == 0) {
                    response.sendRedirect("adminDashboard");
                } else {
                    response.sendRedirect("userInfo");
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
   
}
