Imports System
Imports System.Collections.Specialized
Imports System.Diagnostics
Imports System.IO
Imports System.Net
Imports System.Runtime.CompilerServices
Imports System.Text
Imports System.Web
Imports System.Web.UI
Imports System.Xml
Public Class TOC
    Inherits System.Web.UI.Page

    Public Categories As String
    Public Projects As String
    Public Reviews As String
    Public Forums As String
    Public ForumEntry As String
    Public Builds As String
    Public FileURL As String


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
    Public Sub SaveReview()
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        Dim rating As String = Request.Form("rating")
        Dim review As String = Request.Form("review")
        Dim project As String = Request.Form("project")
        Dim login As String = Request.Form("user")
        AML = "<Item type='CP_Reviews' action='add'><source_id>" & project & "</source_id><rating>" & rating & "</rating><review>" & review & "</review><author>" & login & "</author></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Reviews = Result.outerxml

    End Sub
    Public Sub SaveForumEntry()
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        Dim topic As String = Request.Form("topic")
        Dim message As String = Request.Form("message")
        Dim project As String = Request.Form("project")
        Dim login As String = Request.Form("author")
        AML = "<Item type='CP_Forum' action='add'><source_id>" & project & "</source_id><topic>" & topic & "</topic><message>" & message & "</message><author>" & login & "</author></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Reviews = Result.outerxml

    End Sub
    Public Sub SaveForumReply()
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        Dim message As String = Request.Form("message")
        Dim entry As String = Request.Form("entry")
        Dim login As String = Request.Form("author")
        AML = "<Item type='CP_Forum_Reply' action='add'><source_id>" & entry & "</source_id><message>" & message & "</message><author>" & login & "</author></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Reviews = Result.outerxml

    End Sub
    Public Sub LoadProjectBrief(ByVal id As String)
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='CP_CommunityProject' action='get' select='license,name' id='" & id & "'></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Projects = Result.OuterXML

    End Sub
    Public Sub LoadProjectList(ByVal cat As String)
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='CP_CommunityProject' action='get' select='license,name,rating,description,downloads' order_by='name'><state>Active</state><cp_category>" & cat & "</cp_category></Item>"

        If cat = "Recent" Then
            Dim now As Date = Today()
            now = now.AddDays(-15)
            AML = "<Item type=""CP_CommunityProject"" action=""get"" select=""license,name,rating,description,downloads"" order_by=""name"" where=""cp_communityproject.modified_on > '" & now.Date & "'""><state>Active</state></Item>"
        End If

        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Projects = Result.OuterXML

    End Sub
    Public Sub LoadProjectListSearch(ByVal search As String)
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='CP_CommunityProject' action='get' select='license,name,rating,description,downloads' order_by='name'><state>Active</state><or><description condition='like'>%" + search + "%</description><name condition='like'>%" + search + "%</name></or></Item>"

        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Projects = Result.OuterXML

    End Sub
    Public Sub LoadProjectDetail(ByVal id As String)
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='CP_CommunityProject' action='get' select='name,author(keyed_name,email),description,downloads,url,rating,cp_type,cp_level,cp_category,license,versions,dev_status,screenshot(filename),thumbnail(filename)' id='" & id & "'></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        'Result.Save("C:\inetpub\wwwroot\CommunityProjects\logs\ProjectDetailResult.xml")
        ' need to massage and/or set default values for the Thumbnail and the Screenshot
        Dim Project As XmlNode = Result.selectSingleNode("//Item[@type='CP_CommunityProject']")
        If Not Project Is Nothing Then
            Dim Thumbnail As XmlNode = Project.SelectSingleNode("thumbnail")
            If Thumbnail Is Nothing Then
                Thumbnail = Result.createElement("thumbnail")
                Project.AppendChild(Thumbnail)
            End If
            Dim thumbnailStr As String = Thumbnail.InnerText
            If thumbnailStr = "" Then
                Thumbnail.InnerText = "icons/DefaultThumbnail.gif"
            Else
                Dim fileNode As XmlElement = Thumbnail.SelectSingleNode("Item")
                Dim FileID As String = fileNode.getAttribute("id")
                Dim FileName As String = fileNode.SelectSingleNode("filename").innerText
                Thumbnail.InnerText = "http://myinnovator.com/vault/vaultserver.aspx?dbname=MyInnovator&fileid=" & FileID & "&filename=" & FileName
            End If

            Dim ScreenShot As XmlNode = Project.SelectSingleNode("screenshot")
            If ScreenShot Is Nothing Then
                ScreenShot = Result.createElement("screenshot")
                Project.AppendChild(ScreenShot)
            End If
            Dim ScreenShotStr As String = ScreenShot.InnerText
            If ScreenShotStr = "" Then
                ScreenShot.InnerText = "icons/DefaultScreenShot.gif"
            Else
                Dim fileNode As XmlElement = ScreenShot.SelectSingleNode("Item")
                Dim FileID As String = fileNode.getAttribute("id")
                Dim FileName As String = fileNode.SelectSingleNode("filename").innerText
                ScreenShot.InnerText = "http://myinnovator.com/vault/vaultserver.aspx?dbname=MyInnovator&fileid=" & FileID & "&filename=" & FileName
            End If
        End If
        Projects = Result.OuterXML

    End Sub

    Public Sub GETFILE(ByVal pid As String, ByVal fid As String)
        ' runs one method to increment the downloads counter on the project,  and a 2nd to get the file name to build a url
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='CP_CommunityProject' action='CP DOWNLOAD INCREMENT' id='" & pid & "'></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        'Result.Save("C:\inetpub\wwwroot\CommunityProjects\logs\GETFILE_result1.xml")

        AML = "<Item type='File' action='get' id='" & fid & "' select='filename'></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        'Result.Save("C:\inetpub\wwwroot\CommunityProjects\logs\GETFILE_result2.xml")

        Dim FileItem As XmlNode = Result.selectSingleNode("//Item[@type='File']")
        If Not FileItem Is Nothing Then
            Dim filenameNode As XmlNode = FileItem.SelectSingleNode("filename")
            If Not filenameNode Is Nothing Then
                Dim filename As String = filenameNode.InnerText
                FileURL = "http://myinnovator.com/vault/vaultserver.aspx?dbname=MyInnovator&fileid=" & fid & "&filename=" & filename
                Return
            End If
        End If
        FileURL = "HTTP:/www.aras.com/communityprojects/fileNoteFound.html"
    End Sub

    Public Sub LoadReviews(ByVal id As String)
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='CP_Reviews' action='get' select='rating,author(keyed_name),created_on,review' order_by='created_on'><source_id>" & id & "</source_id></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Reviews = Result.OuterXML

    End Sub
    Public Sub LoadForums(ByVal id As String)
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='CP_Forum' action='get' select='author(keyed_name),topic,replies,modified_on,last_post' order_by='modified_on'><source_id>" & id & "</source_id></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Forums = Result.OuterXML

    End Sub
    Public Sub LoadForumEntry(ByVal id As String)
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='CP_Forum' action='get' select='author(keyed_name),created_on,topic,message,replies,modified_on,last_post'  id='" & id & "'><Relationships><Item type='CP_Forum_Reply' action='get' select='author,created_on,message' order_by='created_on'></Item></Relationships></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        ForumEntry = Result.OuterXML

    End Sub
    Public Sub LoadProjectFiles(ByVal id As String)
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='CP_Builds' action='get' select='version,notes' ><source_id>" & id & "</source_id><Relationships><Item type='CP_Builds File' action='get' select='license_required,related_id(filename,file_size)'></Item></Relationships></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Builds = Result.OuterXML

    End Sub
    Public Sub LoadTOC()
        Dim ConfigPath As String = Server.MapPath("CommunityProjects.config")
        Dim ConfigDom = New XmlDocument

        ConfigDom.Load(ConfigPath)
        Dim LogNode As XmlNode
        Dim LogName As String = ""
        LogNode = ConfigDom.selectSingleNode("//LogFile")
        LogName = Server.MapPath(LogNode.InnerXml)

        Dim AML As String = ""
        Dim Result As Object = New XmlDocument

        AML = "<Item type='Value' action='get' select='value' order_by='sort_order'><source_id>33485F1B49784DC1A501B15CF02C7467</source_id></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Categories = Result.OuterXML

        AML = "<Item type='CP_CommunityProject' action='get' select='license,name' orderBy='name'><state>Active</state><cp_category condition='ne'>Hot Fixes</cp_category></Item>"
        Result.loadXML(SendAML("ApplyItem", AML, ConfigDom, LogName, False))
        Projects = Result.OuterXML


    End Sub

    Public Function SendAML(ByVal Action As String, ByVal AML As String, ByVal Config As XmlDocument, ByVal LogName As String, ByVal doLog As Boolean) As String
        If doLog Then
            WriteLog(LogName, "Transaction: " & AML)
        End If

        Dim Result As String = ""
        Dim httpWebRequest1 As HttpWebRequest = CType(WebRequest.Create(Config.SelectSingleNode("//InnovatorServer").InnerXml), HttpWebRequest)
        Dim bs As Byte() = Text.Encoding.UTF8.GetBytes(AML)
        httpWebRequest1.Method = "POST"
        httpWebRequest1.ContentLength = CLng(bs.Length)
        httpWebRequest1.ContentType = "text/xml"
        httpWebRequest1.Headers.Add("SOAPAction", Action)
        httpWebRequest1.Headers.Add("AUTHUSER", Config.SelectSingleNode("//LoginName").InnerXml)
        httpWebRequest1.Headers.Add("AUTHPASSWORD", Config.SelectSingleNode("//Password").InnerXml)
        httpWebRequest1.Headers.Add("DATABASE", Config.SelectSingleNode("//Database").InnerXml)
        httpWebRequest1.CookieContainer = New CookieContainer
        Dim stream2 As Stream = httpWebRequest1.GetRequestStream()
        stream2.Write(bs, 0, bs.Length)
        stream2.Close()
        Dim httpWebResponse1 As HttpWebResponse = CType(httpWebRequest1.GetResponse(), HttpWebResponse)
        Dim stream1 As Stream = httpWebResponse1.GetResponseStream()
        Dim encoding As Encoding = encoding.GetEncoding("utf-8")
        Dim streamReader2 As StreamReader = New StreamReader(stream1, encoding)
        Result = streamReader2.ReadToEnd()
        streamReader2.Close()
        stream1.Close()
        If doLog Then
            WriteLog(LogName, "Result: " & Result)
        End If
        Dim cookieCollection As CookieCollection = httpWebResponse1.Cookies
        Dim httpWebRequest2 As HttpWebRequest = CType(WebRequest.Create(Config.SelectSingleNode("//InnovatorServer").InnerXml), HttpWebRequest)
        bs = encoding.UTF8.GetBytes("")
        httpWebRequest2.Method = "POST"
        httpWebRequest2.ContentLength = CLng(bs.Length)
        httpWebRequest2.ContentType = "text/xml"
        httpWebRequest2.Headers.Add("SOAPAction", "LogOff")
        httpWebRequest2.Headers.Add("AUTHUSER", Config.SelectSingleNode("//LoginName").InnerXml)
        httpWebRequest2.Headers.Add("AUTHPASSWORD", Config.SelectSingleNode("//Password").InnerXml)
        httpWebRequest2.Headers.Add("DATABASE", Config.SelectSingleNode("//Database").InnerXml)
        httpWebRequest2.CookieContainer = New CookieContainer
        httpWebRequest2.CookieContainer.Add(cookieCollection)
        If doLog Then
            WriteLog(LogName, "Transaction: LogOff")
        End If
        stream2 = httpWebRequest2.GetRequestStream()
        stream2.Write(bs, 0, bs.Length)
        stream2.Close()
        Dim httpWebResponse2 As HttpWebResponse = CType(httpWebRequest2.GetResponse(), HttpWebResponse)
        If httpWebRequest2.HaveResponse Then
            Dim stream3 As Stream = httpWebResponse2.GetResponseStream()
            Dim streamReader1 As StreamReader = New StreamReader(stream3, encoding.UTF8)
            AML = streamReader1.ReadToEnd()
            streamReader1.Close()
            stream3.Close()
            httpWebResponse2.Close()
        End If
        If doLog Then
            WriteLog(LogName, "Done")
        End If
        httpWebResponse1.Close()
        Return Result
    End Function

    Public Sub WriteLog(ByRef fileName As String, ByRef text2Write As String)
        Dim streamWriter As StreamWriter = New StreamWriter(fileName, True)
        streamWriter.Write(DateAndTime.Now & ": " & text2Write & Chr(13) & Chr(10))
        streamWriter.Close()
        streamWriter = Nothing
    End Sub
End Class
