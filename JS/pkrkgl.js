
    function dialogClose() {
        $("#example").dialog("close");
    }

    $("#example").dialog({
        modal: true,
        autoOpen: false,
        show: {
            effect: "blind",
            duration: 1000
        },
        hide: {
            effect: "explode",
            duration: 1000
        },
        width: 400
    });

        //单击，赋值，改样式
        $("#example tbody tr").click(function (e) {
            if ($(this).hasClass('row_selected')) {
                $(this).removeClass('row_selected');
                putNullValue()
            }
            else {
                editor.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
                var aData = editor.fnGetData(this);
                if (null != aData) {
                    putValue(aData);
                }
            }
        });
        //双击
        $("#example tbody tr").dblclick(function () {
            if ($(this).hasClass('row_selected')) {
                //$(this).removeClass('row_selected');
            }
            else {
                editor.$('tr.row_selected').removeClass('row_selected');
                $(this).addClass('row_selected');
            }

            var aData = editor.fnGetData(this);
            if (null != aData) {
                putValue(aData);
            }

            $("#hiddenValue").val("edit");
            $("#e_Attributes").dialog("open");

        });
        //添加
        $("#add").click(function () {
            alert("hello");
            window.editor.$('tr.row_selected').removeClass('row_selected');
            putNullValue();
            $("#hiddenValue").val("add");
            $("#dialog").toggle(500);
        });
        //编辑
        $("#edit").click(function () {
            var productAttributeID = $("#productAttributeID").val();
            if (productAttributeID != "" && productAttributeID != null) {
                $("#hiddenValue").val("edit");
                $("#e_Attributes").dialog("open");
            }

        });
        //删除
        $("#delete").click(function () {
            var productAttributeID = $("#productAttributeID").val();
            var productID = $("#productID").val();
        });

        //赋空值，并去除input-validation-error样式（此样式不管有无，均可去除，所以不用判断了）
        function putNullValue() {
           document.getElementById("name").value="";
           document.getElementById("value").value="";
           document.getElementById("displayOrder").value="";
       }
        function putValue(aData) {
             document.getElementById("name").value=aData[0];
           document.getElementById("value").value=aData[1];
           document.getElementById("displayOrder").value=aData[2];
        }