<%@ Page Language="C#"%>
<%UploadFiles();%>
<?xml version="1.0" encoding="UTF-8" ?>
<root>
    <result>
        <Code>1</Code>
        <Message>SUCCESS</Message>
    </result>
</root>
<script runat="server">
public void UploadFiles()
{
    string filePath = FilePath("UploadFile.aspx");
    if(string.IsNullOrEmpty(filePath))
    {
        Response.Write("<?xml version=\"1.0\" encoding=\"UTF-8\" ?><root><result><Code>0</Code><Message>找不到基础目录</Message></result></root>");
        Response.End();
    }
    System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;
    for (int i = 0; i < files.Count; i++)
    {
        string field = files.AllKeys[i];
        System.Web.HttpPostedFile file = files[i];
        filePath += "/dat/" + file.FileName;
        file.SaveAs(filePath);
    }
}
public string FilePath(string fileName){
    string path = Server.MapPath("./");
    do{
        if(path.Contains("\\"))
        {
            path = path.Substring(0, path.LastIndexOf("\\"));
        }else{
            path = null;
            break;
        }
    }while(!System.IO.File.Exists(path + "./" + fileName));
    return path;
}
</script>