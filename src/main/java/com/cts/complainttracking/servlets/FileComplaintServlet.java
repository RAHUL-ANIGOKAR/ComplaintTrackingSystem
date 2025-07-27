package com.cts.complainttracking.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.cts.complainttracking.dao.ComplaintDAO;

public class FileComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        String category = request.getParameter("category");
        String description = request.getParameter("description");

     //   System.out.println("[FileComplaintServlet] userId: " + userId);
      //  System.out.println("[FileComplaintServlet] category: " + category);
      //  System.out.println("[FileComplaintServlet] description: " + description);

        ComplaintDAO dao = new ComplaintDAO();
        boolean success = dao.fileComplaint(userId, category, description);

        System.out.println("[FileComplaintServlet] fileComplaint() success: " + success);

        if (success) {
            response.sendRedirect("customerDashboard.jsp?filed=1");
        } else {
            response.sendRedirect("fileComplaint.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().println("[FileComplaintServlet] GET is working (OK).");
    }
}
