<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<table style="float:left;color:#888888;margin-top: 5px;" width="100%">
    <tr>
        <td align="left">
            <a class="footer_link" href="${webappPath}/about">关于</a> |
            <a class="footer_link" target="_blank" href="https://sourceforge.net/p/easyrec/blog/">博客</a> |
            <a class="footer_link" href="${webappPath}/contact">联系我们</a>  |
            <a class="footer_link" href="https://sourceforge.net/p/easyrec/forum/" target="_blank">论坛</a>  |
            <a class="footer_link" href="https://sourceforge.net/p/easyrec/wiki/Home/" target="_blank">维基百科</a>
        </td>
        <td align="right">${easyrecName} v${easyrecVersion} &copy; ${currentYear}
        </td>
    </tr>
</table>