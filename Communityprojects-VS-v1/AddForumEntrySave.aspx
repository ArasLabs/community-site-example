<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TOC.aspx.vb" Inherits="CommunityProjects.TOC" %>
<%

SaveForumEntry()
Response.ContentType = "text/xml"
Response.Write(Reviews)
Response.Flush()
%>

