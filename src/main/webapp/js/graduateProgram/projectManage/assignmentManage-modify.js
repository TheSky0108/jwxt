$(function () {
    //初始化课题信息
    initTitleInfo();
});

//初始化课题基本信息
function initTitleInfo() {
    //获取参数：teacherTitleID、studentID
    var urlParam = getUrlParam2();

    $.ajax({
        url: contextPath + '/assignmentManage/getInitProjectInfo.do',
        data: {"teacherTitleID":urlParam[0],"studentID":urlParam[1]},
        type: 'POST',
        dataType: 'json',
        async: true,
        success: function (data) {
            $("#titleInfo").html("");
            var tbodyContent =
                '<tr>' +
                '    <td>课题名称</td>' +
                '    <td colspan="3">' + data.titlename + '</td>' +
                '    <td>专业</td>' +
                '    <td>' + data.majorName + '</td>' +
                '</tr>' +
                '<tr>' +
                '    <td>课题来源</td>' +
                '    <td>' + data.titleOrigin + '</td>' +
                '    <td>课题类别</td>' +
                '    <td>' + data.titleType + '</td>' +
                '    <td>成果形式</td>' +
                '    <td>' + data.resultType + '</td>' +
                '</tr>' +
                '<tr>' +
                '    <td>主要研究内容</td>' +
                '    <td colspan="5">' + data.researchContent + '</td>' +
                '</tr>' +
                '<tr>' +
                '    <td>设计目标要求</td>' +
                '    <td colspan="5">' + data.targetRequire + '</td>' +
                '</tr>';

            $("#titleInfo").append(tbodyContent);

            initAssignment(data);

            //填写对应的任务书
            $("#teacherTitleID").val(urlParam[0]);
            $("#studentID").val(urlParam[1]);
            $("#studenttitleresultid").val(data.studenttitleresultid);
            $("#studentName").val(data.studentName);
            $("#studentNum").val(data.studentNum);
            $("#className").val(data.className);
            $("#teamworkStudentName").val(data.teamworkStudentName);
        }
    });
}

//填写对应的任务书
function initAssignment(data) {

    $("#assignment").html("");
    var tbodyContent =
        '<tr>' +
        '    <td>学生姓名</td>' +
        '    <td>' + data.studentName + '</td>' +
        '    <td>学号</td>' +
        '    <td>' + data.studentID + '</td>' +
        '</tr>' +
        '<tr>' +
        '    <td>专业班级</td>' +
        '    <td>' + data.majorName + '</td>' +
        '    <td>同组人</td>' +
        '    <td>' + data.studentPartners + '</td>' +
        '</tr>' +
        '<tr>' +
        '    <td>任务下发时间</td>' +
        '    <td><input class="layui-input" name="tasksendtime" id="startDate" type="text" value="' + data.tasksendtime + '" lay-verify="required"></td>' +
        '    <td>任务完成时间</td>' +
        '    <td><input class="layui-input" name="taskcompletetime" id="endDate" type="text" value="' + data.taskcompletetime + '" lay-verify="required"></td>' +
        '</tr>' +
        '<tr>' +
        '    <td style="width:110px">设计（论文）题目</td>' +
        '    <td><input class="layui-input" name="thesistitle" type="text" value="' + data.thesistitle + '" lay-verify="required"></td>' +
        '    <td>毕设题目</td>' +
        '    <td><input class="layui-input" name="gdTitle" type="text" value="' + data.gdTitle + '" lay-verify="required"></td>' +
        '</tr>' +
        '<tr>' +
        '    <td>设计目的要求</td>' +
        '    <td colspan="3">' +
        '        <textarea name="designtargetrequire" class="layui-textarea" value="' + data.designtargetrequire + '" lay-verify="required"></textarea>' +
        '    </td>' +
        '</tr>' +
        '<tr>' +
        '    <td>设计主要内容</td>' +
        '    <td colspan="3">' +
        '        <textarea name="designcontent" class="layui-textarea" value="' + data.designcontent + '" lay-verify="required"></textarea>' +
        '    </td>' +
        '</tr>' +
        '<tr>' +
        '    <td>设计提交资料</td>' +
        '    <td colspan="3">' +
        '        <textarea name="designsubmitfile" class="layui-textarea" value="' + data.designsubmitfile + '" lay-verify="required"></textarea>' +
        '    </td>' +
        '</tr>';

    $("#assignment").append(tbodyContent);

}

//提交
function y_submit() {
    layer.confirm("提交之后将不能更改,确认提交?", function (index) {
        $("#taskEditTime").val(getCurrentTime());
        $("#fillStatus").val("1");

        $.ajax({
            url: contextPath + '/assignmentManage/modifyAssignment.do',
            data: $("#y_form").serialize(),
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                layer.alert(response,function(){
                    closePage();
                })
            }
        })
    });
}

/*
//照片上传
layui.use('upload', function () {
    var $ = layui.jquery, upload = layui.upload;
    var uploadInst = upload.render({
        elem: '#test1'
        , url: '/upload/'
        , before: function (obj) {
            //预读本地文件示例，不支持ie8
            obj.preview(function (index, file, result) {
                $('#demo1').attr('src', result); //图片链接（base64）
            });
        }
        , done: function (res) {
            //如果上传失败
            if (res.code > 0) {
                return layer.msg('上传失败');
            }
            //上传成功
        }
        , error: function () {
            //演示失败状态，并实现重传
            var demoText = $('#demoText');
            demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
            demoText.find('.demo-reload').on('click', function () {
                uploadInst.upload();
            });
        }
    });
});//end 照片上传
*/

/*时间*/
layui.use('laydate', function () {
    var laydate = layui.laydate;

    $("#startDate").click(function () {
        var edate = $("#endDate").val();
        laydate.render({
            elem: '#startDate',
            show: true,
            max: edate
        })
    });
    $("#endDate").click(function () {
        var sdate = $("#startDate").val();
        laydate.render({
            elem: '#endDate',
            show: true,
            min: sdate
        })
    })
})
