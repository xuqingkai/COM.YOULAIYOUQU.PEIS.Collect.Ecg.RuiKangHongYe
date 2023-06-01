<%@ Page Language="C#"%><%
string action = Request.QueryString["action"];
if(action == "ftp")
{
    string xml = "";
    xml += "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n";
    xml += "<root>\r\n";
    xml += "  <Monitor>\r\n";
    xml += "    <rencare enable=\"1\">\r\n";
    xml += "      <User>peis</User>\r\n";
    xml += "      <Password>peis</Password>\r\n";
    xml += "      <Directory>" + Server.MapPath("./") + "rencare</Directory>\r\n";
    xml += "    </rencare>\r\n";
    xml += "   </Monitor>\r\n";
    xml += "   <Common>\r\n";
    xml += "    <MonitorPort>21</MonitorPort>\r\n";
    xml += "   </Common>\r\n";
    xml += "</root>";
    System.IO.File.WriteAllText(Server.MapPath("./") + "FTPSetting.xml", xml, System.Text.Encoding.UTF8);
}
else{
    string xml = "";
    xml += "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n";
    xml += "<root>\r\n";
    xml += "  <FileMonitoring enable=\"1\">\r\n";
    xml += "    <RENCARE enable=\"1\">\r\n";
    xml += "      <Interval>1000</Interval>\r\n";
    xml += "      <Directory>" + Server.MapPath("./") + "dat\\</Directory>\r\n";
    xml += "      <FileSuffix>*.dat</FileSuffix>\r\n";
    xml += "    </RENCARE>\r\n";
    xml += "    <FdaXml enable=\"1\">\r\n";
    xml += "      <Interval>1000</Interval>\r\n";
    xml += "      <Directory>" + Server.MapPath("./") + "FdaXml\\</Directory>\r\n";
    xml += "      <FileSuffix>*.xml</FileSuffix>\r\n";
    xml += "    </FdaXml>\r\n";
    xml += "  </FileMonitoring>\r\n";
    xml += "  <Common>\r\n";
    xml += "    <TransferFolder>" + Server.MapPath("./") + "ECGFiles\\</TransferFolder>\r\n";
    xml += "    <AutoFileFolder>" + Server.MapPath("./") + "AutoECGFiles\\</AutoFileFolder>\r\n";
    xml += "    <JPGFileFolder>" + Server.MapPath("./") + "xdt\\</JPGFileFolder>\r\n";
    xml += "    <UseIDAsFileName>1</UseIDAsFileName>\r\n";
    xml += "  </Common>\r\n";
    xml += "</root>";
    System.IO.File.WriteAllText(Server.MapPath("./") + "ECGMonitorSetting.xml", xml, System.Text.Encoding.UTF8);
}

%><!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>心电-瑞康宏业-E1201</title>
</head>
<body>
    <form action="./Upload/" method="post" id="form" target="_blank" enctype="multipart/form-data">
        <input type="file" name="filename" >
        <input type="submit" value="上传" />
    </form>
    <h1><a href="?action=ftp">FTP配置文件初始化</a></h1>
    <h1>IP地址：<%=Request.Url.Host%></h1>
    <h1>端口号：<%=Request.Url.Port%></h1>
    <h1>预约信息接口路径：<%=Request.FilePath.Substring(0, Request.FilePath.LastIndexOf("/"))%>/Info/</h1>
    <h1>图片上传接口路径：<%=Request.FilePath.Substring(0, Request.FilePath.LastIndexOf("/"))%>/Upload/</h1>
    
</body>
</html>