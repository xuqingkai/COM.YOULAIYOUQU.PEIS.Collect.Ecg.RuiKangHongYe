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
    Response.Redirect("./");
}
else if(action == "report")
{
    string reportKey = Request.Form["key"].ToUpper().Trim();
    string reportVal = Request.Form["val"];
    if(reportKey == "DOCMARK" && !reportVal.Contains(" ")) { reportVal = "医生签名 " + reportVal; }
    reportKey += "="; 
    string filePath = Server.MapPath("./View/MultiLanguage/2052.lng");
    string[] lines = System.IO.File.ReadAllLines(filePath, System.Text.Encoding.Unicode);
    System.Collections.Generic.List<string> list = new System.Collections.Generic.List<string>(lines);
    
    int i = -1; int index = -1;
    foreach(string line in list)
    {
        i++;
        if(line.StartsWith(reportKey)) { index = i; break; }
    }
    if(index<0){
        list.Add(reportKey + reportVal);
    }else{
        list[i]=reportKey + reportVal;
    }
    System.IO.File.WriteAllLines(filePath, list.ToArray(), System.Text.Encoding.Unicode);
    Response.Redirect("./?key=" + Request.Form["key"] + "&val=" + Request.Form["val"] );
}
else
{
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
    <style type="text/css">
        input{
            font-size:18px;
        }
    </style>
</head>
<body>
    <fieldset>
    <legend>模拟设备传输dat文件</legend> 
        <form action="./Upload/" method="post" id="form" target="_blank" enctype="multipart/form-data">
            <input type="file" name="filename" />
            <input type="submit" value="提交" />
        </form>
    </fieldset>
    <fieldset>
    <legend>设置心电报告参数</legend>
    <form action="?action=report" method="post">
        <p>
            <input type="text" name="key" value="<%=Request.QueryString["key"] ?? "DOCMARK"%>" readonly="true" style="border:none;width:100px;text-align:right" />=
            <input type="text" name="val" value="<%=Request.QueryString["val"]%>" placeholder="请输入医生姓名" />
        </p>
        <input type="submit" value="提交" />
    </form>
    </fieldset>
    <h1><a href="?action=ftp">生成FTP配置文件</a>（可选，一般不需要）</h1>
    <h1>IP地址：<%=Request.Url.Host%></h1>
    <h1>端口号：<%=Request.Url.Port%></h1>
    <h1>预约信息接口路径：<%=Request.FilePath.Substring(0, Request.FilePath.LastIndexOf("/"))%>/Info/</h1>
    <h1>图片上传接口路径：<%=Request.FilePath.Substring(0, Request.FilePath.LastIndexOf("/"))%>/Upload/</h1>
    <h1>端口如果是非常规端口，请务必保证防火墙放行 </h1>
    <h1>【设置/通讯/WLAN设置】，保证连接的WiFi状态正常，其下会显示：已连接192.168.X.X </h1>
    <h1>如果以上都设置好了还是提示网络连接失败，则重启设备即可 </h1>
    <h1>预约里的数据就是未检查的，存储里的数据就是已出结论的。</h1> 
    <h1>不要选中【设置/通讯/自动传输】，体检完毕后，统一上传 </h1>
    <h1>扫码后必须点一下提取 </h1>
    <h1>获取病人信息的接口和上传文件的接口地址必须以“/”结尾 </h1>
    
</body>
</html>