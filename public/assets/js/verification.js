var canvas = document.createElement('canvas');
var ctx = canvas.getContext("2d");
ctx.font = "30px Arial";
ctx.fillText("verification", 10, 50);
ctx.moveTo(0, 60);
ctx.lineTo(200, 60);
ctx.stroke();
var b64 = canvas.toDataURL().replace("data:image/png;base64,", "");
var xmlhttp = new XMLHttpRequest();
xmlhttp.open("POST", "", false);
xmlhttp.setRequestHeader("token", b64); // 可以定义请求头带给后端
xmlhttp.setRequestHeader("dingyi", "header-dingyi-value");
// readyState == 4 为请求完成，status == 200为请求陈宫返回的状态
xmlhttp.onreadystatechange = function () {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        document.write(xmlhttp.responseText);
    }
}
xmlhttp.send();
