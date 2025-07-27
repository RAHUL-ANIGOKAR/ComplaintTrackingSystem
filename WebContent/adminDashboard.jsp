<%@ page import="java.util.List" %>
<%@ page import="com.cts.complainttracking.models.Complaint" %>
<%@ page import="com.cts.complainttracking.dao.ComplaintDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"ADMIN".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
    ComplaintDAO dao = new ComplaintDAO();
    List<Complaint> complaints = dao.getAllComplaints();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            background: #f0f4f7;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            position: relative;
            min-height: 100vh;
            padding-bottom: 70px; /* Space for logout */
        }
        .container {
            max-width: 1100px;
            background: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,.1);
            margin: 50px auto 0 auto;
        }
        h2, h4 {
            color: #333;
        }
        .btn {
            border-radius: 20px;
        }
        .table {
            border-collapse: collapse !important;
            width: 100%;
        }
        .table th, .table td {
            border: 1px solid #dee2e6 !important;
            padding: 12px 15px;
            vertical-align: middle;
        }
        .table thead {
            background: #0d6efd;
            color: #fff;
        }
        .table tbody tr:nth-child(even) {
            background: #f8f9fa;
        }
        .fixed-logout {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 999;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Welcome, Admin!</h2>
        </div>

        <h4>All Complaints</h4>

        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User ID</th>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Complaint c : complaints) { %>
                        <tr>
                            <td><%= c.getComplaintId() %></td>
                            <td><%= c.getUserId() %></td>
                            <td><%= c.getCategory() %></td>
                            <td><%= c.getDescription() %></td>
                            <td><%= c.getStatus() %></td>
                            <td>
                                <form action="UpdateComplaintStatusServlet" method="post">
                                    <input type="hidden" name="complaint_id" value="<%= c.getComplaintId() %>">
                                    <select name="status" class="form-select mb-2">
                                        <option value="New" <%= "New".equals(c.getStatus()) ? "selected" : "" %>>New</option>
                                        <option value="In Progress" <%= "In Progress".equals(c.getStatus()) ? "selected" : "" %>>In Progress</option>
                                        <option value="Resolved" <%= "Resolved".equals(c.getStatus()) ? "selected" : "" %>>Resolved</option>
                                    </select>
                                    <textarea name="remarks" placeholder="Remarks" class="form-control mb-2"></textarea>
                                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Logout pinned bottom right -->
    <form action="logout.jsp" method="get" class="fixed-logout">
        <button type="submit" class="btn btn-outline-danger">Logout</button>
    </form>

</body>
</html>
