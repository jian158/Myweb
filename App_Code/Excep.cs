using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Excep 的摘要说明
/// </summary>

namespace Ado
{
[Serializable]
public class Excep
{
    public string status = "false";
    public string msg = "";
    public Excep()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    public Excep(string status, string msg)
    {
        this.status = status;
        this.msg = msg;
    }
}

}
