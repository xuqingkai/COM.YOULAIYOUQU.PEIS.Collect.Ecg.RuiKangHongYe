<%@ Page Language="C#"%><%
string result = InputStream();
string filePath = FilePath("PatientInfo.aspx");
if(string.IsNullOrEmpty(filePath))
{
    Response.Write("<?xml version=\"1.0\" encoding=\"UTF-8\" ?><root><result><Code>0</Code><Message>找不到基础目录</Message></result></root>");
    Response.End();
}
//System.IO.File.AppendAllText(filePath + "/InputStream.txt", result + "", System.Text.Encoding.UTF8);
System.Xml.XmlNode xml = ParseXml(result);
if(xml != null)
{
    System.IO.File.AppendAllText(filePath + "/" + xml["PatientID"].InnerText + ".txt", result + "", System.Text.Encoding.UTF8);
}
%><?xml version="1.0" encoding="UTF-8" ?>
<root>
	<Code>1</Code>
	<Message>SUCCESS</Message>
	<records>
		<rows>
			<SerialNo>23052210002</SerialNo>
			<PatientID>23052210002</PatientID>
			<PatientName>测试2</PatientName>
			<PatientSex>F</PatientSex>
			<PatientAge>65</PatientAge>
			<PatientAgeUnit>Y</PatientAgeUnit>
			<PatientBirthDate>1955-05-05</PatientBirthDate>
			<RequestDepartment>心电科</RequestDepartment>
			<RequestID>23052210002</RequestID>
			<SickBedNo>0</SickBedNo>
			<Pacemaker>2</Pacemaker>
			<CustomName1></CustomName1>
			<CustomName2></CustomName2>
			<CustomContent1></CustomContent1>
			<CustomContent2></CustomContent2>
			<ExamItem>ECG</ExamItem>
			<ExamDepartment>心电科</ExamDepartment>
			<Priority>PPP</Priority>
			<fileGuid>23052210002</fileGuid>
			<RequestDate>2023-05-22</RequestDate>
		</rows>
	</records>
</root>
<script runat="server">
    public System.Xml.XmlNode ParseXml(string strXml, string root = null)
    {
        System.Xml.XmlNode xml = null;
        if(!string.IsNullOrEmpty(strXml.Trim())){
            System.Xml.XmlDocument xmlDocument = new System.Xml.XmlDocument();
            try
            {
                if(string.IsNullOrEmpty(root)){
                    root = strXml.Trim().Substring(strXml.LastIndexOf("/") + 1);
                    root = root.Substring(0, root.IndexOf(">"));
                }
                if(strXml.Contains("<" + root + ">"))
                {
                    xmlDocument.LoadXml(strXml.TrimEnd().ToString().EndsWith("</" + root + ">") ? strXml.ToString() : "<" + root + ">" + strXml + "</" + root + ">");
                    xml = xmlDocument[root];
                }
            }
            catch(System.Exception exception){
                //exception.Message;
                Response.Write(exception.Message);
            }
        }
        return xml;
    }
    public string InputStream(string charset = "UTF-8")
    {
        System.IO.Stream stream = System.Web.HttpContext.Current.Request.InputStream;
        stream.Position = 0;
        byte[] bytes = new byte[stream.Length];
        stream.Read(bytes, 0, bytes.Length);
        string result = System.Text.Encoding.GetEncoding(charset).GetString(bytes);
        return result;
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