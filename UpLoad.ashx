<%@ WebHandler Language="C#" Class="UpLoad" %>

using System;
using System.IO;
using System.Web;
using Ado;
using Newtonsoft.Json;

public class UpLoad : IHttpHandler {
    private static Excep excep=new Excep();
    private static JsonSerializerSettings settings = new JsonSerializerSettings();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        HttpServerUtility server = context.Server;
        HttpPostedFile file = context.Request.Files[0];
        string import = context.Request["import"];
        if (file.ContentLength > 0)
        {
            string extName = Path.GetExtension(file.FileName);
            //string fileName = Guid.NewGuid().ToString();
            //string fullName = fileName + extName;

            string imageFilter = ".csv|.xlsx";// 随便模拟几个类型
            if (imageFilter.Contains(extName.ToLower()))
            {
                string phyFilePath = server.MapPath("~/App_Data/") + "abc.xlsx";
                file.SaveAs(phyFilePath);
                if (import=="pkr")
                {
                    ImportPkr(context,phyFilePath);
                }
                else
                {
                    ImportPkc(context,phyFilePath);
                }
            }
        }
    }

    private void ImportPkc(HttpContext context, string path)
    {
             var excel=new LinkExcel(path);
            if (excel.IsOpen)
            {
                excep.status = "true";
                excep.msg = excel.readpkc();
                settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                context.Response.Write(JsonConvert.SerializeObject(excep));
            }
            else
            {
                excep.status = "false";
                excep.msg = "打开文件失败，可能文件损坏";
                context.Response.Write(JsonConvert.SerializeObject(excep));
            }
    }
    private void ImportPkr(HttpContext context,string path)
    {
        var excel=new LinkExcel(path);
        if (excel.IsOpen)
        {
            excep.status = "true";
            excep.msg = excel.readpkr();
            settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
            context.Response.Write(JsonConvert.SerializeObject(excep));
        }
        else
        {
            excep.status = "false";
            excep.msg = "打开文件失败，可能文件损坏";
            context.Response.Write(JsonConvert.SerializeObject(excep));
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}