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
                            "INSERT INTO course VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("course_id")));
                        pstmt.setString(2, request.getParameter("course_name"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("unit")));
                        pstmt.setString(4, request.getParameter("special_requirement"));
                        pstmt.setString(5, request.getParameter("grade_option"));
                        pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("lab_work")));
                        pstmt.setString(7, request.getParameter("department"));
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
                            "UPDATE course SET course_name = ?, " +
                            "unit = ?, special_requirement = ?, grade_option = ?, lab_work = ?, department=? WHERE course_id = ?");

                        pstmt.setString(1, request.getParameter("course_name"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("unit")));
                        pstmt.setString(3, request.getParameter("special_requirement"));
                        pstmt.setString(4, request.getParameter("grade_option"));
                        pstmt.setBoolean(5, Boolean.parseBoolean(request.getParameter("lab_work")));
                        pstmt.setString(6, request.getParameter("department"));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("course_id")));
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
                            "DELETE FROM course WHERE course_id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("course_id")));
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
                        ("SELECT * FROM course");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>course_id</th>
                        <th>course_name</th>
                        <th>unit</th>
			            <th>special_requirement</th>
                        <th>grade_option</th>
                        <th>lab_work</th>
                        <th>department</th>
                    </tr>
                    <tr>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="course_id" size="10"></th>
                            <th><input value="" name="course_name" size="10"></th>
                            <th><input value="" name="unit" size="10"></th>
			                <th><input value="" name="special_requirement" size="15"></th>
                            <th><input value="" name="grade_option" size="10"></th>
                            <th><input value="" name="lab_work" size="10"></th>
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
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            
                            <td>
                                <input value="<%= rs.getInt("course_id") %>" 
                                    name="course_id" size="10">
                            </td>
    
                            
                            <td>
                                <input value="<%= rs.getString("course_name") %>" 
                                    name="course_name" size="10">
                            </td>
    
                            
                            <td>
                                <input value="<%= rs.getInt("unit") %>"
                                    name="unit" size="15">
                            </td>
    
                            
                            <td>
                                <input value="<%= rs.getString("special_requirement") %>" 
                                    name="special_requirement" size="15">
                            </td>
    
			                
                            <td>
                                <input value="<%= rs.getString("grade_option") %>" 
                                    name="grade_option" size="15">
                            </td>

                            
                            <td>
                                <input value="<%= rs.getBoolean("lab_work") %>" 
                                    name="lab_work" size="15">
                            </td>
                            <td>
                                <input value="<%= rs.getString("department") %>" 
                                    name="department" size="15">
                            </td>
    
                            
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="course.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("course_id") %>" name="course_id">
                            
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
