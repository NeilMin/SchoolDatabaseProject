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
                            "INSERT INTO CLASS VALUES (?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("class_id")));
                        pstmt.setString(2, request.getParameter("quarter"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("year")));
                        pstmt.setString(4, request.getParameter("title"));
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
                            "UPDATE class SET quarter = ?, year = ?, title = ? WHERE class_id = ?");

                        pstmt.setString(1, request.getParameter("quarter"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("year")));
                        pstmt.setString(3, request.getParameter("title"));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("class_id")));
                        int rowCount = pstmt.executeUpdate();

                        PreparedStatement pstmt2 = conn.prepareStatement(
                            "UPDATE section SET enrollment_limit = ? WHERE section_id = ?");

                        pstmt2.setInt(1, Integer.parseInt(request.getParameter("enrollment_limit")));
                        pstmt2.setInt(2, Integer.parseInt(request.getParameter("section_id")));
                        int rowCount2 = pstmt2.executeUpdate();

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
                            "DELETE FROM class WHERE class_id = ?");

                        pstmt.setInt(
                            1, Integer.parseInt(request.getParameter("class_id")));
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
                        ("SELECT * FROM class");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>class_id</th>
                        <th>quarter</th>
                        <th>year</th>
			            <th>title</th>
                        <th>section_id</th>
			            <th>enrollment_limit</th>
                    </tr>
                    <tr>
                        <form action="class.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="class_id" size="10"></th>
                            <th><input value="" name="quarter" size="10"></th>
                            <th><input value="" name="year" size="15"></th>
			                <th><input value="" name="title" size="15"></th>
                            <th><input value="" name="section_id" size="15"></th>
			                <th><input value="" name="enrollment_limit" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
        
                    while ( rs.next() ) {
        
            %>

                    <tr>
                        <form action="class.jsp" method="get">
                            <input type="hidden" value="update" name="action">

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getInt("class_id") %>" 
                                    name="class_id" size="10">
                            </td>
    
                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("quarter") %>" 
                                    name="quarter" size="10">
                            </td>
    
                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getInt("year") %>"
                                    name="year" size="15">
                            </td>
    
                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("title") %>" 
                                    name="title" size="15">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getInt("section_id") %>"
                                    name="section_id" size="15">
                            </td>

                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getInt("enrollment_limit") %>"
                                    name="enrollment_limit" size="15">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="class.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" 
                                value="<%= rs.getInt("class_id") %>" name="class_id">
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
