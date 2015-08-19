package com.logviewer.java;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class FileViewerServlet
 */
@WebServlet("/FileViewerServlet")
public class FileViewerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FileViewerServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Get Received");
		
		
		String path = "D:\\Logs";
		FileInputStream fis = null;
		String fileName = request.getParameter("fileName");
		System.out.println("Received File name:"+fileName);
		String files="";
		StringBuilder tmp = new StringBuilder();
		
		PrintWriter outs=response.getWriter();

		System.out.println("********"+fileName);
		files="D:\\Logs\\"+fileName;
		try {
			fis = new FileInputStream(files);
			int content;
			while ((content = fis.read()) != -1) {
				tmp.append((char) content);
				System.out.print((char) content);
				//outs.println((char) content);

			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally {
			try {
				if (fis != null)
					fis.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		outs.print(tmp);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Post receieved");


		String path = "D:\\Logs";
		FileInputStream fis = null;

		String files;
		File file;
		File folder = new File(path);
		File[] listOfFiles = folder.listFiles();

		 
		 JSONArray jsonArr=new JSONArray();
		 String html="<table>";
		for (int i = 0; i < listOfFiles.length; i++)
		{
			if (listOfFiles[i].isFile())
			{
				files = listOfFiles[i].getName();
				System.out.println("********"+files);
				String serverName=getServerNameFromFile(files);
				//html+="<tr><td>"+serverName+"</td><td><a href=\"/LogParser/FileViewerServlet?file="+files+"\">"+files+"</a></td></tr>";
				html+="<tr><td>"+serverName+"</td><td><a href=\"#\" onclick=logView(\""+files+"\")>"+files+"</a></td></tr>";
				
				jsonArr.put(files);
				
			}
			
		}
		html+="</table>";
		PrintWriter outs=response.getWriter();
		outs.println(html);
	}
	private String getServerNameFromFile(String fileName){
		String serverName="";
		int len=fileName.length();
		
		serverName=fileName.substring(5,len-4);
		System.out.println("ser"+serverName);
		return serverName;
	}
	
	private void getFileContent(){
/*		String path = "D:\\Logs";
		FileInputStream fis = null;

		String files;
		File file;
		File folder = new File(path);
		File[] listOfFiles = folder.listFiles();

		for (int i = 0; i < listOfFiles.length; i++)
		{
			if (listOfFiles[i].isFile())
			{
				files = listOfFiles[i].getName();
				System.out.println("********"+files);
				files="D:\\Logs\\"+files;
				try {
					fis = new FileInputStream(files);
					int content;
					while ((content = fis.read()) != -1) {
						System.out.print((char) content);
					}

				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						if (fis != null)
							fis.close();
					} catch (IOException ex) {
						ex.printStackTrace();
					}
				}
			}
		}*/
	}

}
