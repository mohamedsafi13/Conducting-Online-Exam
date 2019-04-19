
import java.sql.Connection;
import java.sql.DriverManager;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.*;
import com.csvreader.CsvReader;

import com.google.gson.Gson;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/StoreAnswers1")
public class StoreAnswers1 extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public StoreAnswers1()
    {
        super();
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String[] crctOptions= new String[5];
		String[] qes=new String[5];
		String mailid=request.getParameter("mailId");
		String qs=request.getParameter("questions");
		Gson gson=new Gson();
		String[] q=gson.fromJson(qs, String[].class);
		int i=0;
		int score=0;
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		HttpSession session = request.getSession(false);
		 if(session != null)
		 {
		try
		{ 
		CsvReader details= new CsvReader("D:\\Questions.csv");
		details.readHeaders();
		while (details.readRecord())
		{
			crctOptions[i]=details.get("Correct choice");
			qes[i]=details.get("Question");
			i=i+1;
	        }
		details.close();
		}
		catch (FileNotFoundException e)
		{
			e.printStackTrace();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		String[] temp=new String[5];
		for(int j=0;j<5;j++)
		{
			temp[j]=crctOptions[j];
		}
		for(int j=0;j<5;j++)
		{
			for(int k=0;k<5;k++)
			{
				if(q[k].equals(qes[j]))
				{
					crctOptions[k]=temp[j];
					break;
				}
			}
		}
		
		try 
		{
			Connection connection=DriverManager.getConnection("jdbc:postgresql://localhost:5432/PerformanceStat","postgres","safi");
			Statement statement=connection.createStatement();
			int qno=1;
			while(qno<=i)
			{
			String slctdOption=request.getParameter("answer"+qno);
			//s="\""+s+"\"";
			if(slctdOption.equals(crctOptions[qno-1]))
			{
				score=1;
			}
			String updateTable="INSERT INTO result(mailid,quesno,selectedoption,correctoption,score)"
					+"VALUES('"+mailid+"'::email,"+qno+",'"+slctdOption+"','"+crctOptions[qno-1]+"',"+score+");";
			statement.executeUpdate(updateTable);
			qno++;
			score=0;
			}
		}  
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		RequestDispatcher rq=request.getRequestDispatcher("/ValidateAnswers");
		request.setAttribute("mail", mailid);
		rq.include(request, response);
		session.invalidate();
	     }
		
		out.print("<html><body>");
		out.print("<H1>THANK YOU!!!</H1>");
		out.print("</body></html>");
	}

}
