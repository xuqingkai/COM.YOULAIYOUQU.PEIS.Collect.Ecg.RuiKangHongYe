<%@ Page Language="C#"%><%



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
    <h1>IP地址：<%=Request.Url.Host%></h1>
    <h1>端口号：<%=Request.Url.Port%></h1>
    <h1>预约信息接口路径：<%=Request.FilePath.Substring(0, Request.FilePath.LastIndexOf("/"))%>/Info/</h1>
    <h1>图片上传接口路径：<%=Request.FilePath.Substring(0, Request.FilePath.LastIndexOf("/"))%>/Upload/</h1>
    
</body>
</html>