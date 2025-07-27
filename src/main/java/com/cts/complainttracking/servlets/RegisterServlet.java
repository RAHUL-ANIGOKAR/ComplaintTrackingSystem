package com.cts.complainttracking.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.cts.complainttracking.dao.UserDAO;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();

        boolean success = dao.registerUser(name, email, password);

        if (success) {
            response.sendRedirect("login.jsp?register=success");
        } else {
            response.sendRedirect("register.jsp?error=1");
        }
    }
}
