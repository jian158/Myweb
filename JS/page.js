
var pageSize = 21;    //ÿҳ��ʾ�ļ�¼����
var curPage=1;        //��ǰҳ
var lastPage;        //���ҳ
var direct=0;        //����
var len;            //������
var page;            //��ҳ��
var begin;
var end;
var table=document.getElementById("mytable");
    $(document).ready(function display() {
    resetPage();

    $("#btn1").click(function firstPage(){    // ��ҳ
        curPage=1;
        direct = 0;
        displayPage();
    });
    $("#btn2").click(function frontPage(){    // ��һҳ
        direct=-1;
        displayPage();
    });
    $("#btn3").click(function nextPage(){    // ��һҳ
        direct=1;
        displayPage();
    });
    $("#btn4").click(function lastPage(){    // βҳ
        curPage=page;
        direct = 0;
        displayPage();
    });
    $("#btn5").click(function changePage(){    // תҳ
        curPage=document.getElementById("changePage").value * 1;
        if (!/^[1-9]\d*$/.test(curPage)) {
            alert("������������");
            return ;
        }
        if (curPage > page) {
            alert("��������ҳ��");
            return ;
        }
        direct = 0;
        displayPage();
    });


    $("#pageSizeSet").click(function setPageSize(){    // ����ÿҳ��ʾ��������¼
        pageSize = document.getElementById("pageSize").value;    //ÿҳ��ʾ�ļ�¼����
        if (!/^[1-9]\d*$/.test(pageSize)) {
            alert("������������");
            return ;
        }
        len =$("#mytable tr").length - 1;
        page=len % pageSize==0 ? len/pageSize : Math.floor(len/pageSize)+1;//���ݼ�¼����������ҳ��
        if (page == 0) {
            page = 1;
        }
        curPage = 1;        //��ǰҳ
        direct=0;        //����
        displayPage();
    });
});

function displayPage(){
    if(curPage <=1 && direct==-1){
        direct=0;
        alert("�Ѿ��ǵ�һҳ��");
        return;
    } else if (curPage >= page && direct==1) {
        direct=0;
        alert("�Ѿ������һҳ��");
        return ;
    }
    else if (direct==1)
        curPage++;
    else if (direct==-1)
        curPage--;

    lastPage = curPage;

    document.getElementById("btn0").innerHTML="��ǰ " + curPage + "/" + page + " ҳ    ÿҳ ";        // ��ʾ��ǰ����ҳ
    
    begin=(curPage-1)*pageSize ;// ��ʼ��¼��
    end = begin + 1*pageSize - 1;    // ĩβ��¼��

    if(end > len ) end=len;
    $("#mytable tr").hide();    // ���ȣ���������Ϊ����
    $("#mytable tr").each(function(i){    // Ȼ��ͨ�������жϾ��������Ƿ�ָ���ʾ
        if((i>=begin && i<=end) )//��ʾbegin<=x<=end�ļ�¼
            $(this).show();
    });
}

function resetPage() {
    len = $("#mytable tr").length;
    direct = 0;
    curPage = 1;
    page = len % pageSize == 0 ? len / pageSize : Math.floor(len / pageSize) + 1;//���ݼ�¼����������ҳ��
    // alert("page==="+page);
    // ���õ�ǰΪ��һҳ
    displayPage(1);//��ʾ��һҳ
    if (page == 0) {
        page = 1;
    }
    document.getElementById("btn0").innerHTML = "��ǰ " + curPage + "/" + page + " ҳ    ÿҳ ";    // ��ʾ��ǰ����ҳ
    document.getElementById("pageSize").value = pageSize;

}


// html:
//     <a id="btn0"></a>
//     <input id="pageSize" type="text" size="1" maxlength="2" value="getDefaultValue()"/><a> �� </a> <a href="#" id="pageSizeSet">����</a>
//     <a id="sjzl"></a>
//     <a  href="#" id="btn1">��ҳ</a>
//     <a  href="#" id="btn2">��һҳ</a>
//     <a  href="#" id="btn3">��һҳ</a>
//     <a  href="#" id="btn4">βҳ</a>
//     <a>ת�� </a>
//     <input id="changePage" type="text" size="1" maxlength="4"/>
//     <a>ҳ </a>
//     <a  href="#" id="btn5">��ת</a>
//     <table id="mytable" align="center" border="1px">
//     <!--<tr><td><a href="#">Row 1</a></td></tr>-->
// </table>
