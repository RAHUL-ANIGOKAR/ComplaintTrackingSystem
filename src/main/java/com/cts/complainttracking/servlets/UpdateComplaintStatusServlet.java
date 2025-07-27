package com.cts.complainttracking.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.cts.complainttracking.dao.ComplaintDAO;

public class UpdateComplaintStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int adminId = (Integer) session.getAttribute("user_id");
     //   System.out.println("ID :"+adminId);
        int complaintId = Integer.parseInt(request.getParameter("complaint_id"));
        String status = request.getParameter("status");
        String remarks = request.getParameter("remarks");

        ComplaintDAO dao = new ComplaintDAO();
        boolean updated = dao.updateComplaintStatus(complaintId, status, remarks, adminId);

        if (updated) {
            response.sendRedirect("adminDashboard.jsp?updated=1");
        } else {
            response.sendRedirect("adminDashboard.jsp?error=1");
        }
    }
}
