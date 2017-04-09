
var N=15;
var count=0;
var id;
var table;
var row;
function initable(tb) {
    table = document.getElementById(tb);
    row=table.insertRow();
}
function addcell(value,data,fun) {
    var cell = row.insertCell();
    cell.innerHTML = value;
    cell.onclick = function() {
        fun(data);
    }
        count++;
        if (count==N)
        {
            count=0;
            row=table.insertRow();
        }
}

function cleartable() {
    table.emptyCells();
    row = table.insertRow();
    count = 0;
}

function retable() {
    row = table.insertRow();
    count = 0;
}