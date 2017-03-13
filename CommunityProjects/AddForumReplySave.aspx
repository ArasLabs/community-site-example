<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<%
SaveForumReply()
Response.ContentType = "text/xml"
Response.Write(Reviews)
Response.Flush()
%>
