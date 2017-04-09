<%@ WebHandler Language="C#" Class="Update" %>

using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using Ado;
using Newtonsoft.Json;
using System.Web.SessionState;
public class Update : IHttpHandler,IRequiresSessionState {
    public static JavaScriptSerializer js=new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        switch (context.Request["method"])
        {
            case "mdpassw"://修改密码，条件“id”，旧密码“passw”,新密码“newpassw”
                context.Response.Write(changPassd(context));
                break;
            case "login":
                context.Response.Write(confirm(context,"id","passd"));
                break;
            case "addpc":
                context.Response.Write(InsertPkc(context));
                break;
            case "addpr":
                context.Response.Write(InsertPkr(context));
                break;
            case "mdpc":
                context.Response.Write(changePkc(context));
                break;
            case "mdpr":
                context.Response.Write(changePkr(context));
                break;
            case "delpc":
                context.Response.Write(Delc(context));
                break;
            case "delpr":
                context.Response.Write(Delr(context));
                break;
            case "cklogin":
                context.Response.Write(check(context));
                break;
            case "exit":
                context.Response.Write(exit(context));
                break;
        }
    }

    private string exit(HttpContext context)
    {
        context.Session["IsConfirm"] = null;
        context.Session.Remove("IsConfirm");
        return "true";
    }
    private string check(HttpContext context)
    {
        if (context.Session["IsConfirm"]!=null)
        {
            return context.Session["IsConfirm"].ToString();
        }
        return "false";
    }
    public string confirm(HttpContext context,string id,string passd)
    {
        string AdminId = context.Request[id];
        string AdminPassd = context.Request[passd];

        using (var ado =new Adodata())
        {
            var admin = (from Admin in ado.Administrator
                         where Admin.UserName == AdminId
                         select Admin);
            if (admin.Count()==0)
            {
                return "not";
            }
            var p = admin.FirstOrDefault(n=>n.PWD==AdminPassd);
            if (p!=null)
            {
                context.Session["IsConfirm"] = "true";
                return "true";
            }
            return "false";
        }
    }

    public string changPassd(HttpContext context)
    {
        string AdminId = context.Request["id"];
        string AdminPassd = context.Request["passd"];
        string NewPassw = context.Request["newpassw"];
        string temp="";
        if ((temp=confirm(context,"id","passd"))== "true")
        {
            using (var ado = new Adodata())
            {
                var admin = (from Admin in ado.Administrator
                             where Admin.UserName == AdminId
                             select Admin).FirstOrDefault();
                if (admin != null)
                {
                    admin.PWD = NewPassw;
                    ado.SaveChanges();
                }

            }
        }
        return temp;
    }

    public string InsertPkc(HttpContext context)
    {
        string json = context.Request["data"];
        JsonSerializerSettings settings = new JsonSerializerSettings();
        settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
        PkcInfo p = JsonConvert.DeserializeObject<PkcInfo>(json,settings);
        using(var ado = new Adodata())
        {
            var k = ado.PkcInfo.FirstOrDefault(n=>n.PkcID==p.PkcID);
            if (k!=null)
            {
                return "exit";
            }
            ado.PkcInfo.Add(p);
            try
            {
                ado.SaveChanges();
            }
            catch (DbUpdateException e)
            {
                return "false";
            }

        }
        return "true";
    }

    public string InsertPkr(HttpContext context)
    {
        string json = context.Request["data"];
        JsonSerializerSettings settings = new JsonSerializerSettings();
        settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
        PkrInfo p = JsonConvert.DeserializeObject<PkrInfo>(json, settings);
        using (var ado = new Adodata())
        {
            ado.PkrInfo.Add(p);
            ado.SaveChanges();
        }
        return "true";

    }

    public string changePkc(HttpContext context)
    {
        string json = context.Request["data"];
        JsonSerializerSettings settings = new JsonSerializerSettings();
        settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
        PkcInfo c = JsonConvert.DeserializeObject<PkcInfo>(json, settings);
        using (var ado = new Adodata())
        {
            var pkcEntity = ado.PkcInfo.FirstOrDefault(p => p.PkcID == c.PkcID);
            pkcEntity.PkcName = c.PkcName;
            pkcEntity.PkcID = c.PkcID;
            pkcEntity.PkzID = c.PkzID;
            pkcEntity.PkcYear = pkcEntity.PkcYear;
            pkcEntity.PkcIndustry = c.PkcIndustry;
            pkcEntity.PkcMember = c.PkcMember;
            pkcEntity.TotalNumberH = c.TotalNumberH;
            pkcEntity.TotalNumberR = c.TotalNumberR;
            pkcEntity.PhotovoltaicIncome = c.PhotovoltaicIncome;
            pkcEntity.CultureIncome = c.CultureIncome;
            pkcEntity.BasicIncome = c.BasicIncome;
            pkcEntity.subsidyIncome = c.subsidyIncome;
            ado.SaveChanges();
            return "true";
        }
    }

    public string changePkr(HttpContext context)
    {
        string json = context.Request["data"];
        JsonSerializerSettings settings = new JsonSerializerSettings();
        settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
        PkrInfo p = JsonConvert.DeserializeObject<PkrInfo>(json, settings);
        using (var ado=new Adodata())
        {
            var pkr = ado.PkrInfo.FirstOrDefault(n => n.PkrID == p.PkrID);
            ado.PkrInfo.Remove(pkr);
            ado.SaveChanges();
            ado.PkrInfo.Add(p);
            ado.SaveChanges();
        }
        return "true";
    }

    public  string Delc(HttpContext context)
    {
        int[] cons =js.Deserialize<int[]>(context.Request["data"]);
        using (var ado = new Adodata())
        {
            int id;
            for(int i=0;i<cons.Length;i++)
            {
                id = cons[i];
                var p = ado.PkcInfo.FirstOrDefault(n=>n.PkcID==id);
                var prlist = ado.PkrInfo;
                foreach (var info in prlist)
                {
                    if (info.PkcID==p.PkcID)
                    {
                        prlist.Remove(info);
                    }
                }
                //ado.SaveChanges();
                ado.PkcInfo.Remove(p);
            }
            ado.SaveChanges();
            return "true";
        }
    }


    public string Delr(HttpContext context)
    {
        int[] cons =js.Deserialize<int[]>(context.Request["data"]);
        using (var ado = new Adodata())
        {
            int id;
            for(int i=0;i<cons.Length;i++)
            {
                id = cons[i];
                var p = ado.PkrInfo.FirstOrDefault(n=>n.PkrID==id);
                ado.PkrInfo.Remove(p);
            }
            ado.SaveChanges();
            return "true";
        }
    }




    public bool IsReusable {
        get {
            return false;
        }
    }

}