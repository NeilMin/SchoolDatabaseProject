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
                            "INSERT INTO committe VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("committe_id")));
                        pstmt.setBoolean(2, Boolean.parseBoolean(request.getParameter("PhD")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("student_id")));
                        pstmt.setString(4, request.getParameter("prof1"));
                        pstmt.setString(5, request.getParameter("prof2"));
                        pstmt.setString(6, request.getParameter("prof3"));
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
                            "UPDATE committe SET PhD = ?, student_id = ?, " +
                            "prof1 = ?, prof2 = ?, prof3 = ? WHERE committe_id = ?");

                        pstmt.setBoolean(1, Boolean.parseBoolean(request.getParameter("PhD")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("student_id")));
                        pstmt.setString(3, request.getParameter("prof1"));
                        pstmt.setString(4, request.getParameter("prof2"));
                        pstmt.setString(5, request.getParameter("prof3"));
                        pstmt.setInt(6, Integer.parseInt(request.getParameter("committe_id")));
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
                            "DELETE FROM committe WHERE committe_id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("committe_id")));
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
                        ("SELECT * FROM committe");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Committe_id</th>
                        <th>PhD</th>
                        <th>Student_id</th>
			            <th>Prof1</th>
                        <th>Prof2</th>
                        <th>Prof3</th>
                    </tr>
                    <tr>
                        <form action="student.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="committe_id" size="10"></th>
                            <th><input value="" name="PhD" size="10"></th>
                            <th><input value="" name="Student_id" size="15"></th>
			                <th><input value="" name="Prof1" size="15"></th>
                            <th><input value="" name="Prof2" size="15"></th>
                            <th><input value="" name="Prof3" size="15"></th>
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
                                <input value="<%= rs.getInt("committe_id") %>" 
                                    name="committe_id" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getInt("PhD") %>" 
                                    name="PhD" size="10">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("student_id") %>"
                                    name="student_id" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("prof1") %>" 
                                    name="prof1" size="15">
                            </td>
    
			                <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("prof2") %>" 
                                    name="prof2" size="15">
                            </td>

                            <%-- Get the Residency --%>
                            <td>
                                <input value="<%= rs.getString("prof3") %>" 
                                    name="prof3" size="15">
                            </td>
    
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="committe.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("committe_id") %>" name="committe_id">
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
