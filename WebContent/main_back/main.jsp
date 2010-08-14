<!DOCTYPE html>
<html lang="ko">
<%@ page errorPage="error.jsp"
    import="kr.pe.okjsp.*,
    	    kr.pe.okjsp.util.CommonUtil,
    	    kr.pe.okjsp.util.DateLabel,
            java.util.*,
            java.util.Iterator"
    pageEncoding="euc-kr"
%>
<head>
<%
//ContextPath
String cPath = request.getContextPath();

%>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<!-- ũ��  ������ ���� -->
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<link rel="stylesheet" type="text/css" media="screen,projection,print" href="<%=cPath%>/css/mf42_layout4_setup.css" />
<link rel="stylesheet" type="text/css" media="screen,projection,print" href="<%=cPath%>/css/mf42_layout4_text.css" />
<link rel="icon" type="image/x-icon" href="<%=cPath%>/img/favicon.ico" />
<script>
/**server-sent-event_���� */
(function() {
    var INIT_MESSAGE = "Now wait for server-side events. They will keep appearing in the console...",
        FAIL_MESSAGE = "Sorry, I have never heard that your browser supports SSE";

    /**
     * Event logger
     * @param (string) message
     */
    var log = function(message) {
    	document.getElementById('output').innerHTML =  message + "\n";
    };
    /**
     * Detects which sort of SSE support to apply if to apply it at all
     * @return user agent type
     */
    var detectUAgent = function() {
        if (navigator.appName == "Opera" && -1 !== navigator.appVersion.indexOf("9.")) {
            //log("Opera browser detected. " + INIT_MESSAGE);
            return 'opera';
        } else
        if (-1 !== navigator.appVersion.indexOf("AppleWebKit/5")) {
            //log("Apparently, your browser supports SSE. " + INIT_MESSAGE);
            return 'webkit';
        } else
        if (navigator.appName == "Netscape" && -1 !== navigator.appVersion.indexOf("5.0")) {
            //log("Your browser does not support SSE yet natively, but you can see here emulation. " + INIT_MESSAGE);
            return 'webkit';
        } else
        if (undefined !== window['EventSource']) {
            //log("I'm not sure about your browser, but let's try. " + INIT_MESSAGE);
            return 'webkit';
        }  else {
            //log(FAIL_MESSAGE);
            return false;
        }
    };
    /**
     * Event handler for upcomming server-sent messages
     * @param (event) event
     * @event
     */
    var onMessageHandler = function (event) {
        log(event.data);
    };
    /**
     * Init event source in Opera fashion
     */
    var operaEventSource = function() {
        alert( "Opera" );
        document.getElementsByTagName("event-source")[0]
        .addEventListener("server-time", onMessageHandler, false);
    };
    /**
     * Init event source in WebKit fashion
     */
    var webkitEventSource = function() {
      var eventSrc = new EventSource('main/main_event.jsp');
      eventSrc.addEventListener('message', onMessageHandler);
    };

    var startEvent = function() {
            switch(detectUAgent()) {
                case "opera":
                    operaEventSource();
                    break;
                case "webkit":
                    webkitEventSource();
                    break;
            }
    };
    startEvent();
}());
/**server-sent-event_�� */
</script>
<title>OKJSP_HTML5</title>
</head>
<body>
  <!-- Main Page Container -->
  <div class="page-container">

    <!-- header -->
    <jsp:include page="header.jsp"></jsp:include>

    <!-- ��� ī�װ���(���ο����� ���� �˸�),�˻�_���� -->
    <aside class="header-breadcrumbs">
      <!-- ���۾˸� -->
      <ul>
        <li>13���� ���ñ��� �ö�Խ��ϴ�</li>
      </ul>

      <!-- �˻�_���� -->
      <div class="searchform">
        <form action="index.html" method="get">
          <fieldset>
            <input name="field" class="field"  placeholder="Search..." />
            <input type="submit" name="button" class="button" value="GO!" />
          </fieldset>
        </form>
      </div>
      <!-- �˻�_�� -->
    </aside>
    <!-- ��� ī�װ���,�˻�_��-->

    <div class="main">
      <!-- �����޴� -->
      <jsp:include page="left.jsp"></jsp:include>

      <!-- ���� ������_����======================================= -->
      <div class="main-content">
        <!-- ��õ ����_���� -->
        <div>
          <h1 class="pagetitle">��õ ����</h1>
          <p/> 
	        <table border='1' bordercolor='blue' width="100%">
	          <tr>
	      		<td height="180" width="25%">
	      			<a rel='external' href="#">
	      				<img class="center-box-shadow" src="<%=cPath%>/img/image.jpg" alt="Image description" title="Image title" /></a>
	      		</td>
	      		<td width="25%">
	      			<a rel='external' href="#">
	      				<img class="center-box-shadow" src="<%=cPath%>/img/image.jpg" alt="Image description" title="Image title" /></a>
	      		</td>
	      		<td width="25%">
	      			<a rel='external' href="#">
	      				<img class="center-box-shadow" src="<%=cPath%>/img/image.jpg" alt="Image description" title="Image title" /></a>
	      		</td>
	      		<td width="25%">
	      			<a rel='external' href="#">
	      				<img class="center-box-shadow" src="<%=cPath%>/img/image.jpg" alt="Image description" title="Image title" /></a>
	      		</td>
	          </tr>
	        </table>
          <p/>
        </div>
        <!-- ��õ ����_��-->
        
        <!-- ��������_���� -->
        <div class="column1-unit">
          	<%
          	Iterator iterList = null;
        	Article one = null;
          	ArrayList arrayList = new ArrayList();
          	arrayList.add("notice|��������");

        	Iterator iter = arrayList.iterator();
        	String [] rec = null;
        	while(iter.hasNext()) {
        		rec = ((String)iter.next()).split("\\|");
        		%>
        		<h1 class="pagetitle"><a href="<%=cPath%>/bbs?act=LIST&bbs=<%= rec[0] %>"><%= rec[1] %></a></h1>
          		<p/>
          		<table border='1' bordercolor='blue' width="100%">
        		<%
        		iterList = getCachedList(rec[0]);
        		while (iterList.hasNext()) {
        			one = (Article) iterList.next();
        			%>
        			<tr align="center">
				        <td ><%= one.getRef() %></td>
				        <td ><div>
				            <a href="<%=cPath%>/seq/<%= one.getSeq() %>">
				            <%= CommonUtil.rplc(one.getSubject(), "<", "&lt;") %>
				            </a>
				        <span ><str:replace replace="[0]" with="">[<%= one.getMemo() %>]</str:replace></span>
				        </div>
				        </td>
				        <td "><div><%= CommonUtil.rplc(one.getWriter(), "<", "&lt;") %></div></td>
				        <td ><div><%
					    if (one.getId() != null) {
					        %><img src="<%=cPath%>/profile/<%= one.getId() %>.jpg"
					        	alt="<%= one.getId() %>"
					        	style="width:14px;height:14px"
					        	onerror="this.src='<%=cPath%>/images/spacer.gif'"><%
					    }
				        	%></div></td>
				        <td title="<%= one.getWhen() %>">
				        <%= DateLabel.getTimeDiffLabel(one.getWhen()) %></td>
				    </tr>
        			<%
        		}
        		%>
        		</table>
        		<%
        	}
          	%>
          <p/>
        </div>
        <!-- ��������_�� -->
        
        
        <!-- ��ü�Խ���_���� -->
        <div class="column1-unit">
          <h1 class="pagetitle">��ü�Խ���</h1>
          <div id="output">aa</div>
          <p/>
          
          
          
            <table border='1' bordercolor='blue' width="100%">
            <%
				HashMap bbsInfoMap = (HashMap)application.getAttribute("bbsInfoMap");
				iterList = list.getAllRecentList(48).iterator();
				int i = 0;
				while (iterList.hasNext() && i < 40) {
			
				    one = (Article) iterList.next();
				    BbsInfoBean bbsInfo = ((BbsInfoBean)(bbsInfoMap.get(one.getBbs())));
				    if (bbsInfo == null) {
				    	bbsInfo = new BbsInfoBean();
				    }
			    	
				    // ������� ������Ʈ �����߿��� �׽�Ʈ ����Ÿ��
			    	// twitter �� null �� �������� �ʽ��ϴ�.
			    	if (bbsInfo.getCseq() == null || "".equals(bbsInfo.getCseq()) || "twitter".equals(bbsInfo.getBbs())) {
			    		continue;
			    	}
			    	
				    if ("2".equals(bbsInfo.getCseq())) {
				    	continue;
				    }
				    i++;
			%>
                <tr align="center">
			        <td><div style="width:73px;height:12px;overflow:hidden">
			        <a href="<%=cPath%>/bbs?act=LIST&bbs=<%= one.getBbs() %>">
			        <%= bbsInfo.getName() %></a></div></td>
			        <td><div>
			            <a href="<%=cPath%>/seq/<%= one.getSeq() %>">
			            <%= CommonUtil.rplc(one.getSubject(), "<", "&lt;") %>
			            </a>
			        <span>[<%= one.getMemo() %>]</span>
			        </div>
			        </td>
			        <td><div><%= CommonUtil.rplc(one.getWriter(), "<", "&lt;") %></div></td>
			        <td><div><%
			    if (one.getId() != null) {
			        %><img src="<%=cPath%>/profile/<%= one.getId() %>.jpg"
			        	alt="<%= one.getId() %>"
			        	style="width:14px;height:14px"
			        	onerror="this.src='<%=cPath%>/images/spacer.gif'"><%
			    }
			        	%></div></td>
			        <td title="<%= one.getWhen() %>">
			        <%= DateLabel.getTimeDiffLabel(one.getWhen()) %></td>
			    </tr>
			<%
				}
			%>
              
            </table>
            
            
            
          <p/>
        </div>
        <!-- ��ü�Խ���_�� -->
      </div>
      <!-- ���� ������_��========================================== -->
      <!-- ���� ����_���� ȭ�� �ܿ��� ���� �ϰ� �۾�... -->
      <jsp:include page="right.jsp"></jsp:include>
    </div>
    <!-- footer -->
    <jsp:include page="footer.jsp"></jsp:include>
  </div>
</body>
</html>
<event-source src="main_event.jsp" />
<%!
	ListHandler list = new ListHandler();
	Iterator getCachedList(String bbsid) {
		Iterator iter = null;
		try {
			iter = list.getRecentList(bbsid, 5).iterator();
		} catch(Exception e) {
			iter = new ArrayList().iterator();
		}
		return iter;
	}

%>