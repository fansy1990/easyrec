<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<div class="appendbody">
    <h1>性能</h1>

    <p>这部分展示了
        <a href="${webappPath}/API">REST-API</a>
        调用的计算时间。
    </p>
    ${outstr}
</div>
<script type="text/javascript">
    function jamonreset()
    {
        confirm("你将要重置性能统计数据，你要继续吗？", function ()
        {
            $.ajax({url:"${webappPath}/dev/jamonreset",
                    data: ({tenantId : "${tenantId}" , operatorId: "${operatorId}"}),
                    cache: false,
                    success: function() {
                        window.location = "${webappPath}/dev/jamonreport?tenantId=${tenantId}&operatorId=${operatorId}"
                    }
            });
        });
    }
</script>

