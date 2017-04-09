
var pageSize = 21;    //每页显示的记录条数
var curPage=1;        //当前页
var lastPage;        //最后页
var direct=0;        //方向
var len;            //总行数
var page;            //总页数
var begin;
var end;
var table=document.getElementById("mytable");
    $(document).ready(function display() {
    resetPage();

    $("#btn1").click(function firstPage(){    // 首页
        curPage=1;
        direct = 0;
        displayPage();
    });
    $("#btn2").click(function frontPage(){    // 上一页
        direct=-1;
        displayPage();
    });
    $("#btn3").click(function nextPage(){    // 下一页
        direct=1;
        displayPage();
    });
    $("#btn4").click(function lastPage(){    // 尾页
        curPage=page;
        direct = 0;
        displayPage();
    });
    $("#btn5").click(function changePage(){    // 转页
        curPage=document.getElementById("changePage").value * 1;
        if (!/^[1-9]\d*$/.test(curPage)) {
            alert("请输入正整数");
            return ;
        }
        if (curPage > page) {
            alert("超出数据页面");
            return ;
        }
        direct = 0;
        displayPage();
    });


    $("#pageSizeSet").click(function setPageSize(){    // 设置每页显示多少条记录
        pageSize = document.getElementById("pageSize").value;    //每页显示的记录条数
        if (!/^[1-9]\d*$/.test(pageSize)) {
            alert("请输入正整数");
            return ;
        }
        len =$("#mytable tr").length - 1;
        page=len % pageSize==0 ? len/pageSize : Math.floor(len/pageSize)+1;//根据记录条数，计算页数
        if (page == 0) {
            page = 1;
        }
        curPage = 1;        //当前页
        direct=0;        //方向
        displayPage();
    });
});

function displayPage(){
    if(curPage <=1 && direct==-1){
        direct=0;
        alert("已经是第一页了");
        return;
    } else if (curPage >= page && direct==1) {
        direct=0;
        alert("已经是最后一页了");
        return ;
    }
    else if (direct==1)
        curPage++;
    else if (direct==-1)
        curPage--;

    lastPage = curPage;

    document.getElementById("btn0").innerHTML="当前 " + curPage + "/" + page + " 页    每页 ";        // 显示当前多少页
    
    begin=(curPage-1)*pageSize ;// 起始记录号
    end = begin + 1*pageSize - 1;    // 末尾记录号

    if(end > len ) end=len;
    $("#mytable tr").hide();    // 首先，设置这行为隐藏
    $("#mytable tr").each(function(i){    // 然后，通过条件判断决定本行是否恢复显示
        if((i>=begin && i<=end) )//显示begin<=x<=end的记录
            $(this).show();
    });
}

function resetPage() {
    len = $("#mytable tr").length;
    direct = 0;
    curPage = 1;
    page = len % pageSize == 0 ? len / pageSize : Math.floor(len / pageSize) + 1;//根据记录条数，计算页数
    // alert("page==="+page);
    // 设置当前为第一页
    displayPage(1);//显示第一页
    if (page == 0) {
        page = 1;
    }
    document.getElementById("btn0").innerHTML = "当前 " + curPage + "/" + page + " 页    每页 ";    // 显示当前多少页
    document.getElementById("pageSize").value = pageSize;

}


// html:
//     <a id="btn0"></a>
//     <input id="pageSize" type="text" size="1" maxlength="2" value="getDefaultValue()"/><a> 条 </a> <a href="#" id="pageSizeSet">设置</a>
//     <a id="sjzl"></a>
//     <a  href="#" id="btn1">首页</a>
//     <a  href="#" id="btn2">上一页</a>
//     <a  href="#" id="btn3">下一页</a>
//     <a  href="#" id="btn4">尾页</a>
//     <a>转到 </a>
//     <input id="changePage" type="text" size="1" maxlength="4"/>
//     <a>页 </a>
//     <a  href="#" id="btn5">跳转</a>
//     <table id="mytable" align="center" border="1px">
//     <!--<tr><td><a href="#">Row 1</a></td></tr>-->
// </table>
