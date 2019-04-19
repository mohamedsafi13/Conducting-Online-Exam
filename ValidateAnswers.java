

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ValidateAnswers")
public class ValidateAnswers extends HttpServlet
{
	private static final long serialVersionUID = 1L;
       
    public ValidateAnswers() 
    {
        super();

    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String mailid=(String)request.getAttribute("mail");
		try 
		{
			int finalScore=0;
			Connection connection=DriverManager.getConnection("jdbc:postgresql://localhost:5432/PerformanceStat","postgres","safi");
			Statement statement=connection.createStatement();
			String query="SELECT * FROM result;";
			ResultSet resultSet=statement.executeQuery(query);
			while(resultSet.next())
			{
				String mail=resultSet.getString("mailid");
				if(mail.equals(mailid))
				{
					finalScore=finalScore+resultSet.getInt("score");
				}
			}
			String updateTable="INSERT INTO finalscore(mailid,obtainedscore) VALUES('"+mailid+"'::email,"+finalScore+");";
			statement.executeUpdate(updateTable);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}

}
