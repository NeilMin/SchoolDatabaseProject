<html>

<body>
    <table border="1">
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    String dbURL = "jdbc:postgresql://127.0.0.1/postgres";
                    Connection conn = DriverManager.getConnection(dbURL, "postgres", "admin");

            %>

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO student VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("student_id")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("ssn")));
                        pstmt.setString(3, request.getParameter("first_name"));
                        pstmt.setString(4, request.getParameter("middle_name"));
                        pstmt.setString(5, request.getParameter("last_name"));
                        pstmt.setString(6, request.getParameter("residency"));
                        pstmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("enroll_admin")));
                        pstmt.setString(8, request.getParameter("prev_degree"));
                        pstmt.setInt(9, Integer.parseInt(request.getParameter("student_type")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Student SET ID = ?, FIRSTNAME = ?, " +
                            "MIDDLENAME = ?, LASTNAME = ?, RESIDENCY = ? WHERE SSN = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ID")));
                        pstmt.setString(2, request.getParameter("FIRSTNAME"));
                        pstmt.setString(3, request.getParameter("MIDDLENAME"));
                        pstmt.setString(4, request.getParameter("LASTNAME"));
                        pstmt.setString(5, request.getParameter("RESIDENCY"));
                        pstmt.setInt(
                            6, Integer.parseInt(request.getParameter("SSN")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM student WHERE SSN = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("SSN")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                         conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    // Use the created statement to SELECT
                    // the student attributes FROM the Student table.
                    ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student_ID</th>
                        <th>SSN</th>
                        <th>First</th>
			            <th>Middle</th>
                        <th>Last</th>
                        <th>Residency</th>
                        <th>Enroll_Admin</th>
                        <th>Prev_Degree</th>
                        <th>Student_Type</th>
                    </tr>
                    <tr>
                        <form action="student.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="student_id" size="10"></th>
                            <th><input value="" name="ssn" size="10"></th>
                            <th><input value="" name="first_name" size="15"></th>
			                <th><input value="" name="middle_name" size="15"></th>
                            <th><input value="" name="last_name" size="15"></th>
                            <th><input value="" name="residency" size="15"></th>
                            <th><input value="" name="enroll_admin" size="15"></th>
                            <th><input value="" name="prev_degree" size="15"></th>
                            <th><input value="" name="student_type" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="student.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("student_id") %>" 
                                    name="student_id" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getInt("ssn") %>" 
                                    name="ssn" size="10">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("first_name") %>"
                                    name="first_name" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("middle_name") %>" 
                                    name="middle_name" size="15">
                            </td>
    
			                <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("last_name") %>" 
                                    name="last_name" size="15">
                            </td>

                            <%-- Get the Residency --%>
                            <td>
                                <input value="<%= rs.getString("residency") %>" 
                                    name="residency" size="15">
                            </td>

                            <%-- Get the Enroll Admin --%>
                            <td>
                                <input value="<%= rs.getBoolean("enroll_admin") %>" 
                                    name="enroll_admin" size="15">
                            </td>

                            <%-- Get the Previous Degree --%>
                            <td>
                                <input value="<%= rs.getString("prev_degree") %>" 
                                    name="prev_degree" size="15">
                            </td>

                            <%-- Get the Student type --%>
                            <td>
                                <input value="<%= rs.getInt("student_type") %>" 
                                    name="student_type" size="15">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <!--<form action="student.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("ssn") %>" name="ssn">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form> -->
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
