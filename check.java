

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/check")
public class check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public check() {
        super();
        
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mailid=request.getParameter("mailId");
		int count=0;
		int i=0;
		
		try
		{
			Connection connection=DriverManager.getConnection("jdbc:postgresql://localhost:5432/PerformanceStat","postgres","safi");
			Statement statement=connection.createStatement();
			String query="SELECT * FROM loginlist;";
			ResultSet resultSet=statement.executeQuery(query);
			connection.close();
			while(resultSet.next())
			{
				if(mailid.equals(resultSet.getString("mail_id")))
				{
					RequestDispatcher rq=request.getRequestDispatcher("./TestPage1.jsp");
					request.setAttribute("mail_Id",mailid);
					//response.sendRedirect("./TestPage1.jsp");
					rq.include(request, response);
					i=i+1;
					break;
				}
				count=count+1;
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
	}

}
