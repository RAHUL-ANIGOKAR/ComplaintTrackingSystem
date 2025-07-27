<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Logging Out</title>
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
        }
        .message {
            text-align: center;
            background: #fff;
            padding: 40px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .message h2 {
            color: #333;
            margin-bottom: 10px;
        }
        .message p {
            color: #666;
        }
    </style>
    <meta http-equiv="refresh" content="2; URL=login.jsp">
</head>
<body>
    <div class="message">
        <h2>You have been logged out.</h2>
        <p>Redirecting to login page...</p>
    </div>
</body>
</html>
