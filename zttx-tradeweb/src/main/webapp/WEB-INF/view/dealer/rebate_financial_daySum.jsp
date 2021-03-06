<!DOCTYPE html>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>管理中心-品牌财务账</title>
    <link href="${res}/styles/dealer/global.css" rel="stylesheet"/>
    <link href="${res}/styles/dealer/factory.css" rel="stylesheet"/>
    <style>
        .ui-form-item{display: inline-block;*display: inline;*zoom: 1;padding-left: 100px;}
        .ui-label{width: 100px;margin-left: -100px;}
    </style>
</head>
<body>
<div class="container">
    <jsp:include page="${ctx}/common/menuInfo/mainmenu"/>
    <div class="em100">
        <div class="main clearfix pr">
            <jsp:include page="${ctx}/common/menuInfo/sidemenu"/>
            <div class="main-right">
                <!--面包屑-->
                <div class="main-grid mb10">
                    <div class="panel-crumbs">
                        <i class="icon i-setting"></i><a href="${ctx}/dealer/center">管理中心</a> >> <span class="bb">返点产品调价明细</span>
                        <a class="panel-crumbs-help" href="${ctx}/help"><i class="icon i-help"></i>帮助中心</a>
                    </div>
                </div>
                <div class="inner">
                    <div class="main-grid">
                        <form:form id="favorite" name="pageForm" class="ui-form factory-seeking-form clearfix">
                            <input type="hidden" value="${param.dealerId}" name="dealerId">
                            <input type="hidden" value="true" name="factoryStore">

                            <div class="ui-form-item">
                                <label for="" class="ui-label"> 品牌商名称： </label> <input
                                    class="ui-input" type="text" disabled id="dealerName"
                                    style="width: 200px;" value="${brandInfo.brandName}"/>
                            </div>
                            <div class="ui-form-item">
                                <label for="" class="ui-label"> 联系人姓名： </label> <input
                                    class="ui-input" type="text" disabled id="brandUser"
                                    style="width: 190px;" value="${brandInfo.connectUserName}"/>
                            </div>
                            <div class="ui-form-item">
                                <label for="" class="ui-label"> 联系方式： </label> <input
                                    class="ui-input" type="text" disabled id="brandMobile"
                                    style="width: 190px;" value="${brandInfo.userMobile}"/>
                            </div>
                            <div class="ui-form-item">
                                <label for="" class="ui-label"> 所在地：</label>
                                <input class="ui-input" type="text" disabled id="address" style="width: 200px;"
                                       value="${fns:getFullAreaNameByNo(brandInfo.areaNo)}"/>
                            </div>
                            <div class="ui-form-item">
                                <label for="" class="ui-label"> 日期： </label> <input type="text"
                                                                                    class="ui-input date" id="start-cal"
                                                                                    readonly
                                                                                    style="width: 74px;" name="startTime"/> 至
                                <input type="text"
                                       class="ui-input date" id="end-cal" readonly
                                       style="width: 74px;" name="endTime"/>
                            </div>
                            <div class="ui-form-item">
                                <div class="inline-block">
                                    <input type="button" value="搜索"
                                           class="ui-button ui-button-mwhite event-query">
                                </div>
                            </div>
                        </form:form>
                    </div>
                    <%--详细表格--%>
                    <table class="factory-count-table ui-table" id="count_detail">
                        <colgroup>
                            <col width="200">
                            <col width="135">
                            <col width="120">
                            <col width="120">
                            <col width="120">
                            <col width="120">
                            <col width="120">
                            <col width="120">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>时间</th>
                            <th>销量</th>
                            <th>销售额</th>
                            <th>返点金额</th>
                            <th>应付款</th>
                            <th>已付款</th>
                            <th>欠付款</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <!-- 分页 -->
                    <div id="pagination"></div>
                    <div class="factory-count-box" style="font-size: 12px;"></div>
                    <%--合计表格--%>
                    <%--<table class="factory-count-box ui-table" id="count_count"
                        style="border-top:0;">
                        <colgroup>
                            <col width="85">
                            <col width="115">
                            <col width="90">
                            &lt;%&ndash;
                            <col width="90">
                            <col width="90">
                             &ndash;%&gt;
                            <col width="90">
                            <col width="90">
                            <col width="90">
                            <col width="90">
                            &lt;%&ndash;<col width="90"> &ndash;%&gt;
                            <col width="90">
                        </colgroup>
                        <tbody>
                        </tbody>
                    </table>--%>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/view/dealer/agency_footer.jsp"/>
</div>

<jsp:include page="${ctx}/WEB-INF/view/dealer/import_javascript.jsp" />
<script id="data-template" type="text/html">
    {{if null||length==0}}
    <tr>
        <td class="ta-c" colspan="8">暂无数据</td>
    </tr>
    {{else}}
    {{each}}
    <tr>
        <td>{{$formatDate $value.erpTime}}</td>
        <td>{{ $value.saleNumSum}}</td>
        <td>{{ $value.salePriceSum}}</td>
        <td>{{ $value.pointPriceSum}}</td>
        <td>{{ $value.costPriceSum}}</td>
        <td>{{ $value.paidPriceSum}}</td>
        <td>{{ $value.debtPriceSum}}</td>
        <td><a href="${crx}/dealer/dealerFinancialPoint/saleDetail?brandId=${param.brandId}&&erpTime={{$value.erpTime}}"
               class="link">查看明细</a></td>
    </tr>
    {{/each}}
    {{/if}}
</script>

<script id="count-template" type="text/html">
    <div class="fr">
        合计&nbsp;应收款:
        <span class="consult" style="color: #f00;">
        {{if count!=0}}{{ $formatPrice costPriceSum}}{{else}}0.00{{/if}}
        </span>&nbsp; 已收款： <span class="consult" style="color: #f00;">
        {{if count!=0}}{{ $formatPrice paidPriceSum}}{{else}}0.00{{/if}}
        </span>&nbsp; 未收款：<span class="consult" style="color: #f00;">
        {{if count!=0}}{{ $formatPrice debtPriceSum}}{{else}}0.00{{/if}}
        </span>&nbsp;
        共 <span class="consult" style="color: #f00;">{{count}}</span> 条
    </div>
</script>

<script>
    $(function () {
        seajs.use(["pagination", "template", "moment"], function (Pagination, template, moment) {
            template.helper('$formatPrice', function (price) {
                if (isNaN(price)) {
                    return price;
                } else {
                    return price.toFixed(2);
                }
            });
            template.helper('$formatDate', function (millsec) {
                return moment(millsec).format("YYYY-MM-DD HH:mm:00");
            });

            window['g_pagination'] = new Pagination({
                url: "${ctx}/dealer/dealerFinancialPoint/saleSum/data",
                elem: "#pagination",
                form: "#favorite",
                data: {brandId: '${param.brandId}'},
                method: "post",
                handleData: function (json) {
                    if (json.code == 126000) {
                        var html1 = template.render("data-template", json.rows);
                        var html2 = template.render("count-template", json.object);
                        $(".factory-count-table tbody").html(html1);
                        $(".factory-count-box").html(html2);
                    } else {
                        remind("error", json.message);
                    }
                }
            });
        });
        $(".event-query").click(function () {
            g_pagination.goTo(1);
        });
    });
</script>
</body>
</html>