<%@ page import="java.util.List" %>
<%@ page import="com.cts.complainttracking.models.Complaint" %>
<%@ page import="com.cts.complainttracking.dao.ComplaintDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ComplaintDAO dao = new ComplaintDAO();
    List<Complaint> complaints = dao.getComplaintsByUser(userId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            background: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            position: relative;
            min-height: 100vh;
            padding-bottom: 70px; /* Space for logout button */
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
        .badge {
            font-size: 0.85rem;
            padding: 0.45em 0.75em;
            border-radius: 0.35rem;
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
        <h2 class="fw-bold">Welcome, Customer!</h2>
        <form action="fileComplaint.jsp" method="get" class="d-inline">
            <button type="submit" class="btn btn-primary">+ File Complaint</button>
        </form>
    </div>

    <h4 class="mb-3">Your Complaints</h4>

    <% if (complaints.isEmpty()) { %>
        <div class="alert alert-info">You have not filed any complaints yet.</div>
    <% } else { %>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Created</th>
                        <th>Last Updated</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Complaint c : complaints) { %>
                        <tr>
                            <td><%= c.getComplaintId() %></td>
                            <td><%= c.getCategory() %></td>
                            <td><%= c.getDescription() %></td>
                            <td>
                                <% if ("New".equals(c.getStatus())) { %>
                                    <span class="badge bg-secondary">New</span>
                                <% } else if ("In Progress".equals(c.getStatus())) { %>
                                    <span class="badge bg-warning text-dark">In Progress</span>
                                <% } else if ("Resolved".equals(c.getStatus())) { %>
                                    <span class="badge bg-success">Resolved</span>
                                <% } else { %>
                                    <span class="badge bg-light text-dark"><%= c.getStatus() %></span>
                                <% } %>
                            </td>
                            <td><%= c.getCreatedAt() %></td>
                            <td><%= c.getUpdatedAt() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    <% } %>
</div>

<!-- Logout button fixed at bottom right -->
<form action="logout.jsp" method="get" class="fixed-logout">
    <button type="submit" class="btn btn-outline-danger">Logout</button>
</form>

</body>
</html>
