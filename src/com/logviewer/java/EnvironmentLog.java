package com.logviewer.java;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

/**
 * Servlet implementation class EnvironmentLog
 */
@WebServlet("/EnvironmentLog")
public class EnvironmentLog extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String rsaLocation = "C:/Users/ba0087036/.ssh/id_rsa";
	private static Session jumpHostSession;
	private static JSch jsch;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EnvironmentLog() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("GET");
		// TODO Auto-generated method stub
				
	}
	static int checkAck(InputStream in) throws IOException{
	    int b=in.read();
	    // b may be 0 for success,
	    //          1 for error,
	    //          2 for fatal error,
	    //          -1
	    if(b==0) return b;
	    if(b==-1) return b;

	    if(b==1 || b==2){
	      StringBuffer sb=new StringBuffer();
	      int c;
	      do {
		c=in.read();
		sb.append((char)c);
	      }
	      while(c!='\n');
	      if(b==1){ // error
		System.out.print(sb.toString());
	      }
	      if(b==2){ // fatal error
		System.out.print(sb.toString());
	      }
	    }
	    return b;
	  }
	private static void fetchfile(Session targetServerSession, int j) {
		// TODO Auto-generated method stub
		 FileOutputStream fos=null;
		try {
	         String prefix=null;
			String lfile = "D:\\Logs\\logs"+Integer.toString(j)+".txt";
		      if(new File(lfile).isDirectory()){
		        prefix=lfile+File.separator;
		      }
			String rfile="output.txt";
			String command="scp -f "+rfile;
			Channel execChannel=targetServerSession.openChannel("exec");
			((ChannelExec)execChannel).setCommand(command);
			 // get I/O streams for remote scp
		      OutputStream out=execChannel.getOutputStream();
		      InputStream in=execChannel.getInputStream();
		      execChannel.connect();
		      byte[] buf=new byte[1024];

		      // send '\0'
		      buf[0]=0; out.write(buf, 0, 1); out.flush();

		      while(true){
			int c=checkAck(in);
		        if(c!='C'){
			  break;
			}

		        // read '0644 '
		        in.read(buf, 0, 5);

		        long filesize=0L;
		        while(true){
		          if(in.read(buf, 0, 1)<0){
		            // error
		            break; 
		          }
		          if(buf[0]==' ')break;
		          filesize=filesize*10L+(long)(buf[0]-'0');
		        }

		        String file=null;
		        for(int i=0;;i++){
		          in.read(buf, i, 1);
		          if(buf[i]==(byte)0x0a){
		            file=new String(buf, 0, i);
		            break;
		  	  }
		        }

			//System.out.println("filesize="+filesize+", file="+file);

		        // send '\0'
		        buf[0]=0; out.write(buf, 0, 1); out.flush();

		        // read a content of lfile
		        fos=new FileOutputStream(prefix==null ? lfile : prefix+file);
		        int foo;
		        while(true){
		          if(buf.length<filesize) foo=buf.length;
			  else foo=(int)filesize;
		          foo=in.read(buf, 0, foo);
		          if(foo<0){
		            // error 
		            break;
		          }
		          fos.write(buf, 0, foo);
		          filesize-=foo;
		          if(filesize==0L) break;
		        }
		        fos.close();
		        fos=null;

			if(checkAck(in)!=0){
			  System.exit(0);
			}

		        // send '\0'
		        buf[0]=0; out.write(buf, 0, 1); out.flush();
		      }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void createJumpHostSession(String user,String passPhrase,String jumpHostServerIP,int port){
		try{
			jsch = new JSch();

			jsch.addIdentity(rsaLocation,passPhrase);
			System.out.println("Private Key added ");

			jumpHostSession = jsch.getSession(user,jumpHostServerIP,port);
			System.out.println("JumpHost session created.");

			java.util.Properties jumpHostConfig = new java.util.Properties();
			jumpHostConfig.put("StrictHostKeyChecking","no");
			jumpHostSession.setConfig(jumpHostConfig);
			jumpHostSession.connect();
			System.out.println("JumpHost connected.....");
		}
		catch (Exception e){
			System.out.println(e);
		}

	}
	/**
	 * Creates session on Target Server and searches for the given key word in logs and stores in output.txt
	 * @param user
	 * @param jumpHostSession
	 * @param targetServerIP
	 * @param port
	 * @param searchKey
	 * @return 
	 */
	@SuppressWarnings("resource")
	private static Session executeSearch(String user,String targetServerIP,int port,String searchKey){
		Session targetServerSession = null;
		try{
			//Target Session Creation
			int assinged_port = jumpHostSession.setPortForwardingL(0, targetServerIP, port);
			targetServerSession = jumpHostSession  =   jsch.getSession(user, "127.0.0.1", assinged_port);
			java.util.Properties targetServerConfig = new java.util.Properties();
			targetServerConfig.put("StrictHostKeyChecking","no");
			targetServerSession.setConfig(targetServerConfig);
			targetServerSession.connect();
			System.out.println("TargetServer connected.....");
			
			//Shell Channel for Target Server Creation
			Channel shellChannel=targetServerSession.openChannel("shell");
			shellChannel.setOutputStream(System.out);
		     
			//Create a Shell Script
	        File shellScript = createShellScript(searchKey);
	        
	        //Convert the shell script to byte stream
	        FileInputStream fin = new FileInputStream(shellScript);
	        byte fileContent[] = new byte[(int)shellScript.length()];
	        fin.read(fileContent);
	        InputStream in = new ByteArrayInputStream(fileContent);
	          
	        //Set the shell script to the channel as input stream and connect
	        shellChannel.setInputStream(in);
	        shellChannel.connect(); 
	        System.out.println("Channel Connected");
		}catch(Exception e){
			e.printStackTrace();
		}
		return targetServerSession;
	}
	/**
	 * Creates a shell script and adds the commands to the file
	 * @param searchKey
	 * @return Filestream to shell script
	 */
	public static File createShellScript(String searchKey) {
		String filename = "shellscript.sh";
		File fstream = new File(filename);

		try{
			// Create file 
			PrintStream out = new PrintStream(new FileOutputStream(fstream));
			out.println("#!/bin/sh");
			out.println("grep -r -A 1 \""+searchKey+"\" /mnt/apigee4/var/log/apigee/message-processor/logs > output.txt ");
			//Close the output stream
			out.close();
		}catch (Exception e){//Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
		return fstream;
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("POST");
		try {
			/* Variable Initializations */
			String user = "bp9640";
			String jumpHostServerIP = "76.198.14.170";
			String[] targetServerIPArray = {"10.13.5.31","10.13.5.32","10.13.5.33","10.13.5.34","10.13.5.35","10.13.5.36"};
			//String[] targetServerIPArray = {"10.13.5.31"};
			int port = 22;
			String passphrase = "techmahindra";
			String searchKey="RaiseFault";
			Session targetServerSession = null;
			//JumpHost Session Creation
			createJumpHostSession(user,passphrase,jumpHostServerIP,port);
			int j=1;
			//TargetServerSearch
			for (String targetServerIP : targetServerIPArray ){
				targetServerSession = executeSearch(user,targetServerIP,port,searchKey);
				fetchfile(targetServerSession,j);
				j=j+1;
			}
			
			System.out.println("Completed");

		} catch (Exception e) {
			System.err.println(e);
			e.printStackTrace(System.out);
		}	
	}

}
