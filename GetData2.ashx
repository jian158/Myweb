<%@ WebHandler Language="C#" Class="GetData2" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Script.Serialization;
using Ado;
using Newtonsoft.Json;
public class GetData2 : IHttpHandler {
    private static JsonSerializerSettings settings = new JsonSerializerSettings();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string method = context.Request["method"];
        if(method=="pkc")
            context.Response.Write(getCounties());
        else if (method=="pkr")
        {
            context.Response.Write(getPersons());
        }
        else if (method=="hzinfo")
        {
            context.Response.Write(getHouseInfo(context));
        }
        else if(method=="getc")
        {
            context.Response.Write(getCountry(context));
        }
    }

    string getCountry(HttpContext context)
    {
        int cid=Int32.Parse(context.Request["cid"]);
        using (Adodata ado=new Adodata())
        {
            var p = ado.PkcInfo.FirstOrDefault(n=>n.PkcID==cid);
            settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
            string json = JsonConvert.SerializeObject(p, settings);
            return json;
        }
    }
    public string getCounties()
    {
        Adodata ado=new Adodata();
        List<PkcInfo> list = ado.PkcInfo.ToList();
        settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
        string json = JsonConvert.SerializeObject(list, settings);
        return json;
    }

    private string getHouseInfo(HttpContext context)
    {
        int hzid =Int32.Parse(context.Request["hzid"]);
        IQueryable<PkrInfo> list;
        using (Adodata ado=new Adodata())
        {
            list=ado.PkrInfo.Where(n => n.HZID == hzid);
            settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
            string json = JsonConvert.SerializeObject(list, settings);
            return json;
        }
    }
    public string getPersons()
    {
        Adodata ado=new Adodata();
        List<PkrInfo> list = ado.PkrInfo.ToList();
        settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore; 
        string json = JsonConvert.SerializeObject(list, settings);
        return json;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}