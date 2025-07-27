package com.cts.complainttracking.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://3.109.63.244:3306/lib_db";
    private static final String USER = "app_user";
    private static final String PASSWORD = "Dev@123";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // ✅ Load driver once!
            System.out.println("MySQL JDBC Driver loaded!");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
