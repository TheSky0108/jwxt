<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>中期检查小组管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>

    <%--引入公共的标签--%>
    <%@ include file="/tag.jsp" %>
</head>
<body>
<!--面包屑-->
<%--<div class="x-nav">--%>
      <%--<span class="layui-breadcrumb">--%>
        <%--<a href="../../../welcome.html">首页</a>--%>
        <%--<a href="javascript:void(0)">毕业设计管理</a>--%>
        <%--<a href="javascript:void(0)">中期检查管理</a>--%>
        <%--<a>--%>
          <%--<cite>中期检查小组管理</cite>--%>
        <%--</a>--%>
      <%--</span>--%>
    <%--<a class="layui-btn layui-btn-small" style="margin-top:3px;float:right"--%>
       <%--href="javascript:location.replace(location.href);" title="刷新">--%>
        <%--<i class="iconfont" style="line-height:30px">&#xe6aa;</i>--%>
    <%--</a>--%>
    <%--<a class="layui-btn layui-btn-warm layui-btn-small" style="margin-top:3px;float:right;margin-right:3px;"--%>
       <%--onclick="closeOther()" title="关闭其他">--%>
        <%--<i class="iconfont" style="line-height:30px">&#xe6b7;</i>--%>
    <%--</a>--%>
<%--</div>--%>
<!--主体-->

<div class="layui-tab">
    <ul class="layui-tab-title">
        <li class="layui-this">小组互审分配</li>
        <li>成员互审分配</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <!--查询-->
            <div class="x-body">
                <div class="demoTable" style="text-align: center;">
                    <div class="layui-inline">
                        <input class="layui-input" name="searchTeachername" placeholder="教师名称" id="searchTeachername" autocomplete="off">
                    </div>
                    <div class="layui-inline">
                        <input class="layui-input" name="searchGroupname" placeholder="小组名称" id="searchGroupname" autocomplete="off">
                    </div>
                    <div class="layui-inline">
                        <select class="layui-input" name="groupidIsNull" id="groupidIsNull">
                            <option value="2">是否分配答辩小组</option>
                            <option value="0">已分配</option>
                            <option value="1">未分配</option>
                        </select>
                    </div>
                    <button class="layui-btn" data-type="searchCheckgrouppersonInfo"><i class="layui-icon">&#xe615;</i></button>
                </div>
            </div>
            <!--end查询-->

            <!--操作区域-->
            <xblock>
                <div class="layui-btn-group demoTable">
                    <!--把所选择的行，做为一组， 同时选择组长-->
                    <button class="layui-btn" data-type="addGradesigngroupInfo">添加答辩小组</button>
                    <!--点击前，需要需要判断该教师是否分组，若没分组，提示。-->
                    <button class="layui-btn" data-type="changeGradesigngroupInfo">修改小组基本信息</button>
                    <button class="layui-btn" onclick="x_admin_show('修改小组成员','./middleReportGroup-modifystudent.html')">修改小组成员</button>
                    <button class="layui-btn layui-btn-normal" onclick="download();">导出数据</button>
                </div>
            </xblock>
            <!--end 操作区域-->

            <!--展示数据的表格-->
            <table class="layui-hide" id="checkgrouppersonInfo" lay-filter="checkgrouppersonInfo"></table>


        </div>
        <div class="layui-tab-item">

            <!--操作区域-->
            <xblock>
                <div class="layui-btn-group demoTable">
                    <!--把所选择的行，做为一组， 同时选择组长-->
                    <button class="layui-btn" data-type="hushenanpai">互审安排</button>
                </div>
            </xblock>
            <!--end 操作区域-->

            <!--展示数据的表格-->
            <table class="layui-hide" id="gradesigncheckgroupInfo" lay-filter="gradesigncheckgroupInfo"></table>
        </div>
    </div>
</div>



<!--操作数据的图标-->
<script type="text/html" id="operColumn">
    <a lay-event="detail">
        <i class="layui-icon">&#xe63c;</i>
    </a>
    <%--<a lay-event="edit">--%>
        <%--<i class="layui-icon">&#xe642;</i>--%>
    <%--</a>--%>
    <a lay-event="del">
        <i class="layui-icon">&#xe640;</i>
    </a>
</script>

<script>
    layui.use('table', function(){
        var table = layui.table
            ,$ = layui.$;

        //渲染小组详细信息表格，初始化数据
        var checkgrouppersonInfoTable = table.render({
            elem: '#checkgrouppersonInfo'
            ,url: '${pageContext.request.contextPath}/checkgroupperson/selectPage.action'
            ,width: 1140
            ,height: 470
            ,cols:[[
                {checkbox:true, fixed: true}
                ,{field:'teacherid', width:90, sort: true, fixed: true, title: '老师ID'}
                ,{field:'groupid', width:100, sort: true, fixed: true, title: '答辩小组ID'}
                ,{field:'teachername', width:100, sort: true, title: '老师名称'}
                ,{field:'groupname', width:140, sort: true, title: '答辩小组名称'}
                ,{field:'groupleader', width:80, sort: true, title: '组长'}
                ,{field:'studentcount', width:120, sort: true, title: '负责学生人数'}
                ,{field:'replyaddress', width:150, sort: true, title: '答辩地点'}
                ,{field:'arrangetime', width:160, sort: true, title: '检查时间'}
                ,{fixed: 'right', width:123, align:'center', toolbar: '#operColumn', title: '操作'}
            ]]
            ,id:'checkgrouppersonInfo'
            ,page: true
        })

        //渲染小组及其成员表格，初始化数据
        var gradesigncheckgroupInfoTable = table.render({
            elem: '#gradesigncheckgroupInfo'
            ,url: '${pageContext.request.contextPath}/gradesigncheckgroup/selectList.action'
            ,width: 1140
            ,height: 470
            ,cols:[[
                {checkbox:true, fixed: true}
                ,{field:'groupid', width:100, title: '答辩小组ID'}
                ,{field:'groupname', width:150, title: '答辩小组名称'}
                ,{field:'teachernameSum', width:550, title: '老师名称'}
                ,{field:'studentCountInGroup', width:150, sort: true, title: '小组内学生总人数'}
            ]]
            ,id:'gradesigncheckgroupInfo'
            ,page: true
        })


        //监听上面表格复选框选择
        table.on('checkbox(checkgrouppersonInfo)', function(obj){
            console.log(obj)
        });

        //监听下面表格复选框选择
        table.on('checkbox(gradesigncheckgroupInfo)', function(obj){
            console.log(obj)
        });

        //layui的方法
        active = {
            //条件查询
            searchCheckgrouppersonInfo:function () {
                var searchTeachername = $('#searchTeachername').val();
                var searchGroupname = $("#searchGroupname").val();
                var groupidIsNull = $("#groupidIsNull").val();
                //执行重载
                checkgrouppersonInfoTable.reload({
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {   //查询的条件
                        teachername: searchTeachername,
                        groupname: searchGroupname,
                        groupidIsNull:groupidIsNull
                    }
                });
            },
            //修改小组信息
            changeGradesigngroupInfo: function () {
                var checkStatus = table.checkStatus('checkgrouppersonInfo')
                    ,data = checkStatus.data;
                if(data.length != 1){
                    layer.msg('请选择一个教师！');
                }else if(data[0].groupid == null){
                    layer.msg('请选择一个已经分组的教师！');
                }else {
                    layer.open({
                        type:2,
                        title:'修改小组基本信息',
                        area:[$(window).width()*0.90,($(window).height()-50)],
                        shade: 0.4,
                        fix: false, //不固定
                        shadeClose: true,
                        maxmin: true,
                        content:'${pageContext.request.contextPath}/gradesigncheckgroup/selectBeforeUpdate.action?groupid='+data[0].groupid
                    })
                }
            },
            //添加答辩小组信息
            addGradesigngroupInfo:function () {
                //获取选中行数据
                var checkStatus = table.checkStatus('checkgrouppersonInfo')
                    ,data = checkStatus.data;
                for(var i=0;i< data.length;i++){
                    if(data[i].groupid != null){
                        layer.msg("包含已分配的教师，请重新选择！");
                        return;
                    }
                }
                if(data.length < 3){
                    layer.msg('至少选择三个指导教师！');
                }else {
                    //参数解码
                    var param = encodeURIComponent(JSON.stringify(data));
                    var url = "${pageContext.request.contextPath}/gradesigncheckgroup/selectBeforeAddGradesigncheckgroup.action?checkgrouppersonVoList="+param;
                    //发送请求
                    layer.open({
                        type: 2,
                        title:'添加小组基本信息',
                        aim: 1,
                        area:[$(window).width()*0.90,($(window).height()-50)],
                        shade: 0.4,
                        fix: false, //不固定
                        shadeClose: true,
                        maxmin: true,
                        content:url
                    })
                }
            },

            //互审安排
            hushenanpai: function () {
                //获取选中行数据
                var checkStatus = table.checkStatus('gradesigncheckgroupInfo')
                    ,data = checkStatus.data;
                if(data.length != 2){
                    layer.msg('请选择两个互审小组！');
                }else {
//                    参数解码
//                    var param = encodeURIComponent(JSON.stringify(data));
                    var url = "middleArrangePerson.jsp?groupid1="+data[0].groupid+"&groupid2="+data[1].groupid;
                    layer.open({
                        type: 2,
                        title: '互审安排',
                        aim: 1,
                        area: [$(window).width() * 0.90, ($(window).height() - 50)],
                        shade: 0.4,
                        fix: false, //不固定
                        shadeClose: true,
                        maxmin: true,
                        content: url
                    })
                }
            }

        };

        //监听工具条,上面表格中的数据操作
        table.on('tool(checkgrouppersonInfo)', function(obj){
            var data = obj.data;
            //查看详情
            if(obj.event === 'detail'){
                layer.open({
                    type:2,
                    title:'详细信息',
                    area:[$(window).width()*0.90,($(window).height()-50)],
                    shade: 0.4,
                    fix: false, //不固定
                    shadeClose: true,
                    maxmin: true,
                    content:'${pageContext.request.contextPath}/gradesigncheckgroup/selectOneGradesigncheckgroup.action?groupid='+data.groupid
                })
            } else if(obj.event === 'del'){     //删除小组信息
                layer.confirm('真的删除小组信息么?', function(index){
                    $.ajax({
                        type:'POST',
                        url:"${pageContext.request.contextPath}/gradesigncheckgroup/deleteGroup.action",
                        data:{"groupId":data.groupid},
                        dataType:"JSON",
                        success:function(msg){
                            if(msg == "0"){
                                layer.msg("删除成功!");
                            }else if(msg == "1"){
                                layer.msg("删除失败!");
                            }else{
                                layer.msg("错误发生!");
                            }
                            checkgrouppersonInfoTable.reload({});
                        }
                    })
                });
            }
        });

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });

    //点击关闭其他，触发事件
//    function closeOther() {
//        var closeTable = $(".layui-tab-title", parent.document).children("li");
//        closeTable.each(function () {
//            if ($(this).attr("class") == "") {
//                $(this).children("i").trigger("click");
//            }
//        })
//    }

    //导出所有小组成员信息
    function download() {
        location.href = "${pageContext.request.contextPath}/checkgroupperson/downloadExcel.action";
    }

</script>
</body>
</html>