<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<style>
        body { background: #f0f4f7; font-family: 'Segoe UI', Tahoma, sans-serif; }
        .container { max-width: 500px; background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,.1); margin-top: 100px; }
    </style>
</head>
<body>
<div class="container">
	<h2>HELLO RAHUL FROM DOCKER</h2>
    <h2 class="mb-4">Login</h2>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger">Invalid credentials!</div>
    <% } %>

    <form method="post" action="login">
        <div class="mb-3">
            <label>Email:</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Password:</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
        <a href="register.jsp" class="btn btn-link">Register</a>
    </form>
</div>
</body>
</html>
