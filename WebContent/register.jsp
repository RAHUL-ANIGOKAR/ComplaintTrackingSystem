<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body { background: #f0f4f7; font-family: 'Segoe UI', Tahoma, sans-serif; }
        .container { max-width: 500px; background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,.1); margin-top: 100px; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mb-4">Register</h2>

    <form method="post" action="register">
        <div class="mb-3">
            <label>Name:</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Email:</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Password:</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-success">Register</button>
        <a href="login.jsp" class="btn btn-link">Back to Login</a>
    </form>
</div>
</body>
</html>
