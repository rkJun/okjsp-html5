<%@ page contentType="text/html;charset=EUC-KR" pageEncoding="EUC-KR"
    errorPage = "/error.jsp"
%><jsp:useBean id="member" class="kr.pe.okjsp.member.Member" scope="page" />
    <jsp:useBean id="memberHandler" class="kr.pe.okjsp.member.MemberHandler" scope="page" />
    <jsp:setProperty name="member" property="*" />
<body>
<% 
    String cPath = application.getRealPath("");
    String msg = memberHandler.changeInfo(member, request.getParameter("pact"), cPath);
    if ("�����߽��ϴ�.".equals(msg)) {
        session.setAttribute("member", member);
    }
%><%= msg %>
<% 
  if("delete".equals(request.getParameter("pact"))) { 
    kr.pe.okjsp.util.CommonUtil.setCookie(response, "okid", "", 0);
    session.invalidate();
  } else { %><br>
<a href="login.jsp" target="_self">login</a>
<% } %>
<br>
<a href="<%= cPath %>" target="_top">Home</a>
<!-- jsp:include page="/googleAnalytics.jsp" / -->
</body>