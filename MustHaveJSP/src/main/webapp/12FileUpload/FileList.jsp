<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="fileupload.MyfileDTO"%>
<%@page import="fileupload.MyfileDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>FileUpload</title>
</head>
<body>
	<h2>DB�� ��ϵ� ���� ��� ����</h2>
	<a href="FileUploadMain.jsp">���� ����ϱ�</a>
	
	<%
	// DAO ������ ���� DBCP�� Ŀ�ؼ��Ѵ�.
	MyfileDAO dao = new MyfileDAO();
	// ��Ͽ� ����� ���ڵ带 ���´�.
	List<MyfileDTO> fileLists = dao.myFileList();
	// Ŀ�ؼ� ��ü�� �ݳ��Ѵ�.
	dao.close();
	%>
	<table border ="1">
		<tr>
			<th>No</th><th>����</th><th>ī�װ�</th>
			<th>���� ���ϸ�</th><th>����� ���ϸ�</th><th>�ۼ���</th>
		</tr>
		<% for(MyfileDTO f : fileLists) { %>
		<tr>
			<td><%= f.getIdx() %></td>
			<td><%= f.getName() %></td>
			<td>
				<img src="../Uploads/<%= f.getSfile() %>" width="100"/>
				<%= f.getTitle() %>
			</td>
			<td><%= f.getCate() %></td>
			<td><%= f.getOfile() %></td>
			<td><%= f.getSfile() %></td>
			<td><%= f.getPostdate() %></td>
			<td><a href="Download.jsp
				?oName=<%= URLEncoder.encode(f.getOfile(), "UTF-8") %>
				&sName=<%= URLEncoder.encode(f.getSfile(), "UTF-8") %> ">
				[�ٿ�ε�]</a>
			</td>
		</tr>
		<% } %>
	</table>
	
	<h2>���ε� �� ���� ����Ʈ ����</h2>
	<%
	// ������ ����� ���丮�� ������ ��θ� ���´�.
	String dir = application.getRealPath("/Uploads");
	// ������ ��θ� �μ��� File��ü�� �����Ѵ�.
	File file = new File(dir);
	// ���丮�� ���ϸ���� �о�ͼ� �迭���·� ��ȯ�Ѵ�.
	File[] fileArr = file.listFiles();
	int fileCnt = 1;
	// ������ ������ŭ �ݺ��Ѵ�.
	for(File f : fileArr)
	{
	%>
			<li>
				���ϸ� <%= fileCnt %> : <%= f.getName() %>
				����ũ�� : <%= (int)Math.ceil(f.length() / 1024.0) %> kb
			</li>
	<% 
			fileCnt++;
	}
	%>
	
	
	
	
	
	
	
	
	
</body>
</html>