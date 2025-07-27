package com.cts.complainttracking.dao;

import java.sql.*;

import com.cts.complainttracking.models.User;
import com.cts.complainttracking.util.DBConnection;  // ✅ Use your util

public class UserDAO {

    private static final String INSERT_USER_SQL = 
        "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";

    private static final String VALIDATE_USER_SQL = 
        "SELECT user_id, role FROM users WHERE email = ? AND password = ?";

	/*
	 * public UserDAO() { // No JDBC URL here anymore — we use DBConnection! }
	 */

    public boolean registerUser(String name, String email, String password) {
        try (Connection conn = DBConnection.getConnection();  // ✅ Use util
             PreparedStatement stmt = conn.prepareStatement(INSERT_USER_SQL)) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, "CUSTOMER");
            stmt.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public User validateUser(String email, String password) {
        try (Connection conn = DBConnection.getConnection();  // ✅ Use util
             PreparedStatement stmt = conn.prepareStatement(VALIDATE_USER_SQL)) {

            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setRole(rs.getString("role"));
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
