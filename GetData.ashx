<%@ WebHandler Language="C#" Class="GetData" %>

using System;
using System.Activities.Expressions;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Security.Policy;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using Ado;
using Newtonsoft.Json;

public class GetData : IHttpHandler
{
    //都要转化为json格式
    public static JavaScriptSerializer js = new JavaScriptSerializer();
    public static HttpContext mcontext;
    public static ArrayList arrayList=new ArrayList();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "json/plain";
        mcontext = context;
        string method = context.Request["method"];
        string[] cons = null;
        //string[] cons = {"fld"};
        //发送过来一律是“cons”，用js.Deserialize<string[]>(context.Request["cons"])
        //获得筛选条件数组,登录除外
        //  if (method == null)
        //     return;
        if (method.Equals("gett"))
        {//获取符合条件的镇
            context.Response.Write(getTown());
        }
        else if (method.Equals("getc"))
        {//获取符合条件的村名

            context.Response.Write(getCounties(cons));
        }
        else if (method.Equals("geth"))
        {//获取符合条件的户名
            context.Response.Write(getHouse());
        }
        else if (method.Equals("getp"))
        {//获取符合条件的人名
            cons=js.Deserialize<string[]>(context.Request["cons"]);
            context.Response.Write(getPersons(cons));
        }
        else if (method.Equals("gety"))
        {//获取符合条件的年限
            context.Response.Write(getYear());
        }
        else if (method.Equals("getcinfo"))
        {//获取符合条件的村的详细信息
            context.Response.Write(getCinfo(null));
        }
        else if (method.Equals("gethinfo"))
        {//获取符合条件的户的详细信息

        }
        else if (method.Equals("getpinfo"))
        {//获取符合条件的人的详细信息

        }
        else if (method.Equals("login"))
        {//验证登录，条件“id”，“passd”
            context.Response.Write("hello");
        }
        else if (method=="getcount")
        {
            context.Response.Write(getCount());
        }


    }

    public string getCinfo(string cname)
    {
        arrayList.Clear();
        string cons = mcontext.Request["cons"];
        string josn="";
        string req_name;
        using (var ado = new Adodata())
        {
            req_name = cons;
            var pks = ado.PkcInfo.FirstOrDefault(info => info.PkcName == req_name);
            Random random=new Random();
            arrayList.Add("无详细样例的信息");
            for (int i = 0; i < 4; i++)
            {
                arrayList.Add(random.Next(1, 100));
            }
        }
        josn = js.Serialize(arrayList);
        return josn;
    }


    public static string getHouse()
    {
        string[] cons = null;
        cons = js.Deserialize<string[]>(mcontext.Request["cons"]);
        string judge;
        IQueryable<PkrInfo> list = null;
        string json = "";
        using (var ado = new Adodata())
        {
            if (cons[0] == "不限")
            {
                list = (from n in ado.PkrInfo
                        where n.IsHuzhu=="是"
                        select n);
                if (list!=null&&cons[2]!="不限")
                {
                    judge = cons[2];
                    list = list.Where(info => String.Compare(info.TpYear, judge, StringComparison.Ordinal) <= 0);
                }
            }
            else
            {
                judge = cons[0];
                var p = ado.PkcInfo.FirstOrDefault(n => n.PkcName == judge);
                if (p == null)
                    return "false";
                list = ado.PkrInfo.Where(n => n.IsHuzhu == "是" && n.PkcID == p.PkcID);
                //list = (from n in ado.PkrInfo
                //        where n.IsHuzhu == 1&&n.PkcID==p.PkcID
                //        select n);
                if (list!=null&&cons[2]!="不限")
                {
                    judge = cons[2];
                    list = list.Where(info => String.Compare(info.TpYear,judge, StringComparison.Ordinal) <= 0);
                }
            }

            if (list!=null)
            {
                JsonSerializerSettings settings = new JsonSerializerSettings();
                settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                json = JsonConvert.SerializeObject(list, settings);

            }
        }
        return json;
    }

    public string getCounties(string[] cons)
    {
        cons = js.Deserialize<string[]>(mcontext.Request["cons"]);
        string json="";
        string req_name;
        IQueryable<PkcInfo> list;
        using (var ado = new Adodata())
        {
            if (cons[0] == "不限")
            {
                list = ado.PkcInfo;
            }
            else if (cons.Length>1&&cons[1]=="ID")
            {
                int zid=Int32.Parse(cons[0]);
                list = ado.PkcInfo.Where(n => n.PkzID == zid);
            }
            else
            {
                req_name = cons[0];
                var pks = ado.PkzInfo.FirstOrDefault(info=>info.PkzName==req_name);
                list = ado.PkcInfo.Where(info => info.PkzID == pks.PkzID);
            }
            JsonSerializerSettings settings = new JsonSerializerSettings();
            settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
            json = JsonConvert.SerializeObject(list, settings);
        }

        return json;
    }

    public static string getTown()
    {
        string json="";
        using (var ado = new Adodata())
        {
            var list = ado.PkzInfo;
            JsonSerializerSettings settings = new JsonSerializerSettings();
            settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
            json = JsonConvert.SerializeObject(list, settings);
        }
        return json;
    }

    public string getYear()
    {
        string json="";
        using (var ado = new Adodata())
        {

            //var list = (from n in ado.PkzInfo
            //            select n).ToList();
            var list = ado.PkrInfo.Select(info => info.TpYear);
            Dictionary<string,string> dic=new Dictionary<string, string>();
            foreach (string s in list)
            {
                if(!dic.ContainsValue(s))
                    dic.Add(s,s);
            }
            string[] arr = dic.Values.ToArray();
            json = js.Serialize(arr);
        }
        return json;
    }

    public static string getPersons(string[] cons)//贫困人
    {
        string josn="";
        string req_namez;
        string req_namec;
        int PkzID;
        int PkcID;
        IQueryable<PkrInfo> list = null;
        using (var ado = new Adodata())
        {

            if (cons[0] == "不限")
            {
                list = ado.PkrInfo.Where(n=>n.IsHuzhu!="是");
            }
            else
            {
                req_namez = cons[0];
                var list1 = (from n in ado.PkzInfo
                             where n.PkzName == req_namez
                             select n);
                PkzID = list1.FirstOrDefault().PkzID;
                list = (from n in ado.PkrInfo
                        where n.PkzID == PkzID&&n.IsHuzhu!="是"
                        select n);
            }
            if (cons[1] != "不限")
            {
                req_namec = cons[1];
                var list2 = (from n in ado.PkcInfo
                             where n.PkcName == req_namec
                             select n);
                PkcID = list2.FirstOrDefault().PkcID;
                list2 = null;
                list = (from n in list
                        where n.PkcID == PkcID
                        select n);
            }
            if (cons[2] != "不限")
            {
                string req2 = cons[2];
                list = (from n in list
                        where n.TpYear == req2
                        select n);
            }
            if (cons[3] != "不限")
            {
                string req4 = cons[3];
                list = (from n in list
                        where n.IsTp ==req4
                        select n);
            }

            JsonSerializerSettings settings = new JsonSerializerSettings();
            settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
            josn = JsonConvert.SerializeObject(list, settings);
        }
        return josn;
    }


    public string getCount()
    {
        Adodata ado=new Adodata();
        int[] arr=new int[4];
        arr[0] = ado.PkzInfo.Count();
        arr[1] = ado.PkcInfo.Count();
        arr[2] = ado.PkrInfo.Where(n => n.IsHuzhu == "是").Count();
        arr[3] = ado.PkrInfo.Count();
        return js.Serialize(arr);

    }



    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}