<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>File Complaint</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body { background: #f0f4f7; font-family: 'Segoe UI', Tahoma, sans-serif; }
        .container { max-width: 600px; background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,.1); margin-top: 50px; }
    </style>
</head>
<body>
<div class="container">
    <h2>File New Complaint</h2>

    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger">Something went wrong. Please try again.</div>
    <% } %>

    <form method="post" action="file-complaint">
        <div class="mb-3">
            <label for="category" class="form-label">Category:</label>
            <input type="text" id="category" name="category" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description:</label>
            <textarea id="description" name="description" class="form-control" rows="4" required></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Submit Complaint</button>
        <a href="customerDashboard.jsp" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>
