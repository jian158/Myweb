
var dom = document.getElementById("div_cinfo");
var myChart = echarts.init(dom);
var app = {};
option = null;
app.title = '坐标轴刻度与标签对齐';

function draw(arr) {
    option = {
    color: ['#3398DB'],
    tooltip: {
        trigger: 'axis',
        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis: [
        {
            type: 'category',
            data: ['光伏发电收入', '基本养殖收入', '基本收入', '其他补贴收入'],
            axisTick: {
                alignWithLabel: true
            }
        }
    ],
    yAxis: [
        {
            type: 'value'
        }
    ],
    series: [
        {
            name: '收入：',
            type: 'bar',
            barWidth: '60%',
            data: [arr[0], arr[1], arr[2], arr[3]]
        }
    ]
    };
if (option && typeof option === "object") {
    myChart.setOption(option, true);
}
}
