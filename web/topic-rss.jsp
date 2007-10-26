<?xml version="1.0" encoding="koi8-r"?>
<%@ page contentType="application/rss+xml; charset=koi8-r"%>
<%@ page import="java.sql.Connection,ru.org.linux.site.MessageTable,ru.org.linux.site.Template" errorPage="/error.jsp" buffer="200kb"%>
<% Template tmpl = new Template(request, config, response); %>

<%
  int topic = 1;
  if (request.getParameter("topic") != null) {
    topic = tmpl.getParameters().getInt("topic");
  }

  int num = MessageTable.RSS_DEFAULT;
  if (request.getParameter("num") != null) {
    num = tmpl.getParameters().getInt("num");
	if (num < MessageTable.RSS_MIN || num > MessageTable.RSS_MAX) {
	  num = MessageTable.RSS_DEFAULT;
	}
  }

%>
<rss version="2.0">
<channel>
<link>http://www.linux.org.ru/view-message.jsp?msgid=<%= topic %></link>
<language>ru</language>
<%

  Connection db = null;
  try {
    db = tmpl.getConnection();
    out.print(MessageTable.getTopicRss(db, topic, num, tmpl.getConfig().getProperty("HTMLPathPrefix"), tmpl.getMainUrl()));
%>
<%
  } finally {
    if (db!=null) {
      db.close();
    }
  }
%>
</channel>
</rss>
