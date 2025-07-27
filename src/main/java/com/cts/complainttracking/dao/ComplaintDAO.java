package com.cts.complainttracking.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.cts.complainttracking.models.Complaint;
import com.cts.complainttracking.util.DBConnection;

public class ComplaintDAO {

    // File new complaint
    public boolean fileComplaint(int userId, String category, String description) {
        String sql = "INSERT INTO complaints (user_id, category, description, status, created_at, updated_at) "
                   + "VALUES (?, ?, ?, 'New', NOW(), NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, category);
            stmt.setString(3, description);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all complaints for a customer
    public List<Complaint> getComplaintsByUser(int userId) {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaint_id"));
                complaint.setUserId(rs.getInt("user_id"));
                complaint.setCategory(rs.getString("category"));
                complaint.setDescription(rs.getString("description"));
                complaint.setStatus(rs.getString("status"));
                complaint.setCreatedAt(rs.getTimestamp("created_at"));
                complaint.setUpdatedAt(rs.getTimestamp("updated_at"));
                complaints.add(complaint);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complaints;
    }

    // Get all complaints (Admin view)
    public List<Complaint> getAllComplaints() {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints where status not in ('Resolved')";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaint_id"));
                complaint.setUserId(rs.getInt("user_id"));
                complaint.setCategory(rs.getString("category"));
                complaint.setDescription(rs.getString("description"));
                complaint.setStatus(rs.getString("status"));
                complaint.setCreatedAt(rs.getTimestamp("created_at"));
                complaint.setUpdatedAt(rs.getTimestamp("updated_at"));
                complaints.add(complaint);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complaints;
    }

    // Update complaint status (Admin)
    public boolean updateComplaintStatus(int complaintId, String status, String remarks, int adminId) {
        String updateComplaint = "UPDATE complaints SET status = ?, updated_at = NOW() WHERE complaint_id = ?";
        String insertLog = "INSERT INTO complaint_logs (complaint_id, status, remarks, updated_by, updated_at) "
                         + "VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement stmt1 = conn.prepareStatement(updateComplaint);
                 PreparedStatement stmt2 = conn.prepareStatement(insertLog)) {

                stmt1.setString(1, status);
                stmt1.setInt(2, complaintId);
                stmt1.executeUpdate();

                stmt2.setInt(1, complaintId);
                stmt2.setString(2, status);
                stmt2.setString(3, remarks);
                stmt2.setInt(4, adminId);
                stmt2.executeUpdate();

                conn.commit();
                return true;

            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
