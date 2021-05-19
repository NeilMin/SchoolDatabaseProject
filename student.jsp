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
                    String dbURL = "jdbc:postgresql://127.0.0.1/cse132";
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
                            "INSERT INTO student VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("student_id")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("ssn")));
                        pstmt.setString(3, request.getParameter("first_name"));
                        pstmt.setString(4, request.getParameter("middle_name"));
                        pstmt.setString(5, request.getParameter("last_name"));
                        pstmt.setString(6, request.getParameter("residency"));
                        pstmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("enroll_admin")));
                        pstmt.setString(10, request.getParameter("pre_degree"));
                        pstmt.setString(11, request.getParameter("student_type"));
                        pstmt.setString(12, request.getParameter("college"));
                        pstmt.setString(8, request.getParameter("major"));
                        pstmt.setString(9, request.getParameter("minor"));
                        pstmt.setString(13, request.getParameter("department"));
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
                            "UPDATE student SET ssn=?, firstname=?, middlename=?, lastname=?, residency=?, enrolled=?, major=?, minor=?, pre_degree=?, student_type=?, college=?, department=? WHERE student_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ssn")));
                        pstmt.setString(2, request.getParameter("firstname"));
                        pstmt.setString(3, request.getParameter("middlename"));
                        pstmt.setString(4, request.getParameter("lastname"));
                        pstmt.setString(5, request.getParameter("residency"));
                        pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("enrolled")));
                        pstmt.setString(7, request.getParameter("major"));
                        pstmt.setString(8, request.getParameter("minor"));
                        pstmt.setString(9, request.getParameter("pre_degree"));
                        pstmt.setString(10, request.getParameter("student_type"));
                        pstmt.setString(11, request.getParameter("college"));
                        pstmt.setString(12, request.getParameter("department"));
                        pstmt.setInt(13, Integer.parseInt(request.getParameter("student_id")));

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
                            "DELETE FROM student WHERE Student_ID = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("Student_ID")));
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
                        <th>Enrolled</th>
                        <th>Pre_Degree</th>
                        <th>Student_Type</th>
                        <th>College</th>
                        <th>Major</th>
                        <th>Minor</th>
                        <th>Department</th>
                    </tr>
                    <tr>
                        <form action="student.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="student_id" size="10"></th>
                            <th><input value="" name="ssn" size="10"></th>
                            <th><input value="" name="first_name" size="10"></th>
			                <th><input value="" name="middle_name" size="10"></th>
                            <th><input value="" name="last_name" size="10"></th>
                            <th><input value="" name="residency" size="10"></th>
                            <th><input value="" name="enrolled" size="10"></th>
                            <th><input value="" name="pre_degree" size="10"></th>
                            <th><input value="" name="student_type" size="10"></th>
                            <th><input value="" name="college" size="10"></th>
                            <th><input value="" name="major" size="10"></th>
                            <th><input value="" name="minor" size="10"></th>
                            <th><input value="" name="department" size="10"></th>
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
                                <input value="<%= rs.getString("firstname") %>"
                                    name="firstname" size="10">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("middlename") %>" 
                                    name="middlename" size="10">
                            </td>
    
			                <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("lastname") %>" 
                                    name="lastname" size="10">
                            </td>

                            <%-- Get the Residency --%>
                            <td>
                                <input value="<%= rs.getString("residency") %>" 
                                    name="residency" size="10">
                            </td>

                            <%-- Get the Enroll Admin --%>
                            <td>
                                <input value="<%= rs.getBoolean("enrolled") %>" 
                                    name="enrolled" size="10">
                            </td>

                            <%-- Get the Previous Degree --%>
                            <td>
                                <input value="<%= rs.getString("pre_degree") %>" 
                                    name="pre_degree" size="10">
                            </td>

                            <%-- Get the Student type --%>
                            <td>
                                <input value="<%= rs.getString("student_type") %>" 
                                    name="student_type" size="10">
                            </td>

                            <%-- Get the Student type --%>
                            <td>
                                <input value="<%= rs.getString("college") %>" 
                                    name="college" size="10">
                            </td>

                            <%-- Get the Student type --%>
                            <td>
                                <input value="<%= rs.getString("major") %>" 
                                    name="major" size="10">
                            </td>

                            <%-- Get the Student type --%>
                            <td>
                                <input value="<%= rs.getString("minor") %>" 
                                    name="minor" size="10">
                            </td>

                            <td>
                                <input value="<%= rs.getString("department") %>" 
                                    name="department" size="10">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="student.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("Student_ID") %>" name="Student_ID">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form> 
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
