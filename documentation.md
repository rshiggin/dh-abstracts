##DH Abstracts Documentation
Richard Higgins, PhD
Indiana University

####Versions
XTF 3.1
Apache Tomcat 8.0.21
Java SE 8u45 (JDK)
Mac OS X 10.10 Yosemite

####Install help
<a href="http://wolfpaulus.com/jounal/mac/tomcat8/">wolfpaulus.com/jounal/mac/tomcat8</a>
<a href="http://xtf.cdlib.org/documentation/deployment-guide/">xtf.cdlib.org/documentation/deployment-guide</a>

####Verify Java environment
```
$ echo $JAVA_HOME    
/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/Home    
$ java -version    
java version "1.8.0_20"    
Java(TM) SE Runtime Environment (build 1.8.0_20-b26)    
Java HotSpot(TM) 64-Bit Server VM (build 25.20-b23, mixed mode)
```   

####Tomcat set directory and permissions    

```
$ sudo mkdir -p /usr/local    
$ sudo mv ~/Downloads/apache-tomcat /usr/local
$ sudo rm -f /Library/Tomcat
$ sudo ln -s /usr/local/apache-tomcat /Library/Tomcat
$ sudo chown -R Richard /Library/Tomcat
$ sudo chmod +x /Library/Tomcat/bin/*.sh
```

![](img/directory.jpg)     


####Set localhost port
>Open tomcat/conf/server.xml
>Go to "Connector port"
>Replace "8080" with "9999" (or other)
>Restart tomcat server.


http://localhost:9999
   

![](img/tomcat.jpg)


####Permissions for Tomcat admin
Edit __tomcat/conf/tomcat-users.xml__
```
<role rolename="richard"/>
<user username="richard" password="adho" roles="richard"/>
```
![](img/tomcatmgr.jpg)
 

####Verify Tomcat Java paths
__run bin/catalina.sh__     

```
$ ./catalina.sh run
Using CATALINA_BASE: /usr/local/apache-tomcat
Using CATALINA_HOME: /usr/local/apache-tomcat
Using CATALINA_TMPDIR: /usr/local/apache-tomcat/temp
Using JRE_HOME: /Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/Home
Using CLASSPATH: /usr/local/apache-tomcat/bin/bootstrap.jar:/usr/local/apache-tomcat
```

####Solution for Java path bug: Tomcat 8.0/XTF 3.0
```
java.lang.NullPointerException
	java.io.File.<init>(Unknown Source)
	org.cdlib.xtf.servletBase.TextServlet.firstTimeInit(TextServlet.java:281)
	org.cdlib.xtf.servletBase.TextServlet.service(TextServlet.java:361)
	javax.servlet.http.HttpServlet.service(HttpServlet.java:725)
	org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)
```

In WEB-INF/web.xml, look for this section:
```
    <servlet>
        <servlet-name>crossQuery</servlet-name>
        <servlet-class>org.cdlib.xtf.crossQuery.CrossQuery</servlet-class>
    </servlet>
```
and add a base-dir parameter like this:
```
    <servlet>
        <servlet-name>crossQuery</servlet-name>
        <servlet-class>org.cdlib.xtf.crossQuery.CrossQuery</servlet-class>
        <init-param>
            <param-name>base-dir</param-name>
            <param-value>YOUR_PATH_HERE</param-value>
        </init-param>
    </servlet>
```
<a href="https://groups.google.com/forum/#!topic/xtf-user/ZcRdb90qV6Q">groups.google.com/forum/#!topic/xtf-user/ZcRdb90qV6Q</a>

####Set permissions for XTF textIndexer
__webapps/xtf/bin__
```
$ chmod +x textIndexer 
$ ./textIndexer -index default
```

__http://localhost:9999/xtf/search__   

![](img/home.jpg)       

![](img/results.jpg)     
      
      

####Java CLASSPATH help
$ export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/Home"
$ echo $JAVA_HOME
```
/Library/Java/JavaVirtualMachines/jdk1.8.0_20.jdk/Contents/Home
```

See all installed java versions,  (Please note the capital V, simple v will be used later on for different purpose)
$ /usr/libexec/java_home -V  
```
Outputs..
 Matching Java Virtual Machines (4):  
   1.8.0_25, x86_64:  "Java SE 8"  /Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home  
   1.7.0_71, x86_64:  "Java SE 7"  /Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home  
   1.6.0_65-b14-466.1, x86_64:  "Java SE 6"  /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home  
   1.6.0_65-b14-466.1, i386:  "Java SE 6"  /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
```  
Now you know whats available. All you need to do now is change your ~/.bash_profile to set JAVA_HOME. Before we do so, lets see how we can use /usr/libexec/java_home tool to retrieve JAVA_HOME paths of each versions.

Following command gives JAVA_HOME path of a given java version installed.
$ /usr/libexec/java_home -v  

__v1.8__
$ /usr/libexec/java_home -v 1.8  

```
/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home
```

__v1.7__
$ /usr/libexec/java_home -v 1.7 
``` 
 /Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home
```

Now, lets add that trick to our ~/.bash_profile.
```
 export JAVA_HOME=`/usr/libexec/java_home -v 1.8`  
 #export JAVA_HOME=`/usr/libexec/java_home -v 1.7`  
 #export JAVA_HOME=`/usr/libexec/java_home -v 1.6`
``` 
  
Now you can uncomment the version you need when you need.

Source: <a href="http://asanga.blogspot.com/2015/01/setting-up-multiple-javahome-versions.html">asanga.blogspot.com/</a>

##Customizing XTF (XLS stylesheets and CSS customization)

__Initial Custom Redesign__     
      
![](img/redesign01.jpg)



####1. Default search form

__Find in directory__
style/crossQuery/resultFormatter/default/searchForms.xsl

```
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns="http://www.w3.org/1999/xhtml"
   version="2.0">
   
   
   
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   <!-- Search forms stylesheet                                                -->
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   <!-- DHQ revisions: comment out freeform search; for relevance changed search examples from "south africa" to "digital archive." 2015-5-7 R. Higgins -->
   <!--
      Copyright (c) 2008, Regents of the University of California
      All rights reserved. -->
   
   <!-- ====================================================================== -->
   <!-- Global parameters                                                      -->
   <!-- ====================================================================== -->
   
   <!-- <xsl:param name="freeformQuery"/> -->
   
   <!-- ====================================================================== -->
   <!-- Form Templates                                                         -->
   <!-- ====================================================================== -->
   
   <!-- main form page -->
   <xsl:template match="crossQueryResult" mode="form" exclude-result-prefixes="#all">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
         <head>
            <title>XTF: Search Form</title>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <xsl:copy-of select="$brand.links"/>
         </head>
         <body>
            <xsl:copy-of select="$brand.header"/>
            <div class="searchPage">
               <div class="forms">
                  <table>
                     <tr>
                        <td class="{if(matches($smode,'simple')) then 'tab-select' else 'tab'}"><a href="search?smode=simple">Keyword</a></td>
                        <td class="{if(matches($smode,'advanced')) then 'tab-select' else 'tab'}"><a href="search?smode=advanced">Advanced</a></td>
                        <!-- <td class="{if(matches($smode,'freeform')) then 'tab-select' else 'tab'}"><a href="search?smode=freeform">Freeform</a></td> -->
                        <td class="{if(matches($smode,'browse')) then 'tab-select' else 'tab'}"><a href="search?smode=browse">Browse</a></td>
                     </tr>
                     <tr>
                        <td colspan="3"> <!-- changed colspan to "4": commenting out "freeform" -->
                           <div class="form">
                              <xsl:choose>
                                 <xsl:when test="matches($smode,'simple')">
                                    <xsl:call-template name="simpleForm"/>
                                 </xsl:when>
                                 <xsl:when test="matches($smode,'advanced')">
                                    <xsl:call-template name="advancedForm"/>
                                 </xsl:when>
                                <!-- <xsl:when test="matches($smode,'freeform')">
                                    <xsl:call-template name="freeformForm"/>
                                 </xsl:when> -->
                                 <xsl:when test="matches($smode,'browse')">
                                    <table>
                                       <tr>
                                          <td>
                                             <p>Browse all documents by the available facets, or alphanumerically by author or title:</p>
                                          </td>
                                       </tr>
                                       <tr>
                                          <td>
                                             <xsl:call-template name="browseLinks"/>
                                          </td>
                                       </tr>
                                    </table>
                                 </xsl:when>
                              </xsl:choose>
                           </div>
                        </td>
                     </tr>
                  </table>
               </div>
            </div>
            <xsl:copy-of select="$brand.footer"/>
         </body>
      </html>
   </xsl:template>
   
   <!-- simple form -->
   <xsl:template name="simpleForm" exclude-result-prefixes="#all">
      <form method="get" action="{$xtfURL}{$crossqueryPath}">
         <table>
            <tr>
               <td>
                  <input type="text" name="keyword" size="40" value="{$keyword}"/>
                  <xsl:text>&#160;</xsl:text>
                  <input type="submit" value="Search"/>
                  <input type="reset" onclick="location.href='{$xtfURL}{$crossqueryPath}'" value="Clear"/>
               </td>
            </tr>
            <tr>
               <td>
                  <table class="sampleTable">
                     <tr>
                        <td colspan="2">Examples:</td>                  
                     </tr>
                     <tr>
                        <td class="sampleQuery">digital</td>
                        <td class="sampleDescrip">Search keywords (full text and metadata) for 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">digital archive</td>
                        <td class="sampleDescrip">Search keywords for 'digital' AND 'archive'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">"digital archive"</td>
                        <td class="sampleDescrip">Search keywords for the phrase 'digital archive'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">digital*</td>
                        <td class="sampleDescrip">Search keywords for the string 'digital' followed by 0 or more characters</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">digital?</td>
                        <td class="sampleDescrip">Search keywords for the string 'digital' followed by a single character</td>
                     </tr>
                  </table>
               </td>
            </tr>
         </table>
      </form>
   </xsl:template>
   
   <!-- advanced form -->
   <xsl:template name="advancedForm" exclude-result-prefixes="#all">
      <form method="get" action="{$xtfURL}{$crossqueryPath}">
         <table class="top_table">
            <tr>
               <td>
                  <table class="left_table">
                     <tr>
                        <td colspan="3">
                           <h4>Entire Text</h4>
                        </td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td colspan="2">
                           <input type="text" name="text" size="30" value="{$text}"/>
                        </td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td colspan="2">
                           <xsl:choose>
                              <xsl:when test="$text-join = 'or'">
                                 <input type="radio" name="text-join" value=""/>
                                 <xsl:text> all of </xsl:text>
                                 <input type="radio" name="text-join" value="or" checked="checked"/>
                                 <xsl:text> any of </xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                 <input type="radio" name="text-join" value="" checked="checked"/>
                                 <xsl:text> all of </xsl:text>
                                 <input type="radio" name="text-join" value="or"/>
                                 <xsl:text> any of </xsl:text>
                              </xsl:otherwise>
                           </xsl:choose>
                           <xsl:text>these words</xsl:text>
                        </td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td><b>Exclude</b></td>
                        <td>
                           <input type="text" name="text-exclude" size="20" value="{$text-exclude}"/>
                        </td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td><b>Proximity</b></td>
                        <td>
                           <select size="1" name="text-prox">
                              <xsl:choose>
                                 <xsl:when test="$text-prox = '1'">
                                    <option value=""></option>
                                    <option value="1" selected="selected">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                 </xsl:when>
                                 <xsl:when test="$text-prox = '2'">
                                    <option value=""></option>
                                    <option value="1">1</option>
                                    <option value="2" selected="selected">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                 </xsl:when>
                                 <xsl:when test="$text-prox = '3'">
                                    <option value=""></option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3" selected="selected">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                 </xsl:when>
                                 <xsl:when test="$text-prox = '4'">
                                    <option value=""></option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4" selected="selected">4</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                 </xsl:when>
                                 <xsl:when test="$text-prox = '5'">
                                    <option value=""></option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5" selected="selected">5</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                 </xsl:when>
                                 <xsl:when test="$text-prox = '10'">
                                    <option value=""></option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="10" selected="selected">10</option>
                                    <option value="20">20</option>
                                 </xsl:when>
                                 <xsl:when test="$text-prox = '20'">
                                    <option value=""></option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="20" selected="selected">20</option>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <option value="" selected="selected"></option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="20">20</option>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </select>
                           <xsl:text> word(s)</xsl:text>
                        </td>
                     </tr>           
                     <tr>
                        <td class="indent">&#160;</td>
                        <td><b>Section</b></td>
                        <td>
                           <xsl:choose>
                              <xsl:when test="$sectionType = 'head'">
                                 <input type="radio" name="sectionType" value=""/><xsl:text> any </xsl:text><br/>
                                 <input type="radio" name="sectionType" value="head" checked="checked"/><xsl:text> headings </xsl:text><br/>
                                 <input type="radio" name="sectionType" value="citation"/><xsl:text> citations </xsl:text>
                              </xsl:when>
                              <xsl:when test="$sectionType = 'note'"> 
                                 <input type="radio" name="sectionType" value=""/><xsl:text> any </xsl:text><br/>
                                 <input type="radio" name="sectionType" value="head"/><xsl:text> headings </xsl:text><br/>
                                 <input type="radio" name="sectionType" value="citation" checked="checked"/><xsl:text> citations </xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                 <input type="radio" name="sectionType" value="" checked="checked"/><xsl:text> any </xsl:text><br/>
                                 <input type="radio" name="sectionType" value="head"/><xsl:text> headings </xsl:text><br/>
                                 <input type="radio" name="sectionType" value="citation"/><xsl:text> citations </xsl:text>
                              </xsl:otherwise>
                           </xsl:choose>
                        </td>
                     </tr>
                  </table>
               </td>
               <td>
                  <table class="right_table">
                     <tr>
                        <td colspan="3"><h4>Metadata</h4></td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td><b>Title</b></td>
                        <td>
                           <input type="text" name="title" size="20" value="{$title}"/>
                        </td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td><b>Author</b></td>
                        <td>
                           <input type="text" name="creator" size="20" value="{$creator}"/>
                        </td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td><b>Location</b></td> <!-- substituting "Location" for "Subject" -->
                        <td>
                           <input type="text" name="location" size="20" value="{$subject}"/>
                        </td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td><b>Year(s)</b></td>
                        <td>
                           <xsl:text>From </xsl:text>
                           <input type="text" name="year" size="4" value="{$year}"/>
                           <xsl:text> to </xsl:text>
                           <input type="text" name="year-max" size="4" value="{$year-max}"/>
                        </td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td><b>Type</b></td>
                        <td>
                           <select size="1" name="type">
                              <option value="">All</option>
                              <option value="ead">EAD</option>
                              <option value="html">HTML</option>
                              <option value="word">Word</option>
                              <option value="nlm">NLM</option>
                              <option value="pdf">PDF</option>
                              <option value="tei">TEI</option>
                              <option value="text">Text</option>
                           </select>
                        </td>
                     </tr>
                     <tr>
                        <td colspan="3">&#160;</td>
                     </tr>
                     <tr>
                        <td class="indent">&#160;</td>
                        <td>&#160;</td>
                        <td>
                           <input type="hidden" name="smode" value="advanced"/>
                           <input type="submit" value="Search"/>
                           <input type="reset" onclick="location.href='{$xtfURL}{$crossqueryPath}?smode=advanced'" value="Clear"/>
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
            <tr>
               <td colspan="2">
                  <table class="sampleTable">
                     <tr>
                        <td colspan="3">Examples:</td>                  
                     </tr>
                     <tr>
                        <td/>
                        <td class="sampleQuery">digital archive</td>
                        <td class="sampleDescrip">Search full text for 'digital' AND 'archive'</td>
                     </tr>
                     <tr>
                        <td>Exclude</td>
                        <td class="sampleQuery">text</td>
                        <td class="sampleDescrip">Exclude results which contain the term 'text'</td>
                     </tr>
                     <tr>
                        <td>Proximity</td>
                        <td><form action=""><select><option>5</option></select></form></td>
                        <td class="sampleDescrip">Match the full text terms, only if they are 5 or fewer words apart</td>
                     </tr>
                     <tr>
                        <td>Section</td>
                        <td><form action=""><input type="radio" checked="checked"/>headings</form></td>
                        <td class="sampleDescrip">Match the full text terms, only if they appear in document 'headings' (e.g. section titles)</td>
                     </tr>
                     <tr>
                        <td>Title</td>
                        <td class="sampleQuery">"digital archive"</td>
                        <td class="sampleDescrip">Search for the phrase 'digital archive' in the 'title' field</td>
                     </tr>
                     <tr>
                        <td>Year(s)</td>
                        <td><form action="">from <input type="text" value="2000" size="4"/> to <input type="text" value="2003" size="4"/></form></td>
                        <td class="sampleDescrip">Search for documents whose date falls in the range from '2000' to '2003'</td>
                     </tr>
                  </table>
               </td>
            </tr>
         </table>
      </form>
   </xsl:template>
   
   <!-- free-form form 
   <xsl:template name="freeformForm" exclude-result-prefixes="#all">
      <form method="get" action="{$xtfURL}{$crossqueryPath}">
         <table>
            <tr>
               <td>
                  <p><i>Experimental feature:</i> "Freeform" complex query supporting -/NOT, |/OR, &amp;/AND, field names, and parentheses.</p>
                  <input type="text" name="freeformQuery" size="40" value="{$freeformQuery}"/>
                  <xsl:text>&#160;</xsl:text>
                  <input type="submit" value="Search"/>
                  <input type="reset" onclick="location.href='{$xtfURL}{$crossqueryPath}'" value="Clear"/>
               </td>
            </tr>
            <tr>
               <td>
                  <table class="sampleTable">
                     <tr>
                        <td colspan="2">Examples:</td>                  
                     </tr>
                     <tr>
                        <td class="sampleQuery">africa</td>
                        <td class="sampleDescrip">Search keywords (full text and metadata) for 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south africa</td>
                        <td class="sampleDescrip">Search keywords for 'south' AND 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south &amp; africa</td>
                        <td class="sampleDescrip">(same)</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south AND africa</td>
                        <td class="sampleDescrip">(same; note 'AND' must be capitalized)</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">title:south africa</td>
                        <td class="sampleDescrip">Search title for 'south' AND 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">creator:moodley title:africa</td>
                        <td class="sampleDescrip">Search creator for 'moodley' AND title for 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south | africa</td>
                        <td class="sampleDescrip">Search keywords for 'south' OR 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south OR africa</td>
                        <td class="sampleDescrip">(same; note 'OR' must be capitalized)</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">africa -south</td>
                        <td class="sampleDescrip">Search keywords for 'africa' not near 'south'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">africa NOT south</td>
                        <td class="sampleDescrip">(same; note 'NOT' must be capitalized)</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">title:africa -south</td>
                        <td class="sampleDescrip">Search title for 'africa' not near 'south'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">title:africa subject:-politics</td>
                        <td class="sampleDescrip">
                           Search items with 'africa' in title but not 'politics' in subject.
                           Note '-' must follow ':'
                        </td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">title:-south</td>
                        <td class="sampleDescrip">Match all items without 'south' in title</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">-africa</td>
                        <td class="sampleDescrip">Match all items without 'africa' in keywords</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south (africa OR america)</td>
                        <td class="sampleDescrip">Search keywords for 'south' AND either 'africa' OR 'america'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south africa OR america</td>
                        <td class="sampleDescrip">(same, due to precedence)</td>
                     </tr>
                  </table>
               </td>
            </tr>
         </table>
      </form>
   </xsl:template> -->
   
</xsl:stylesheet>    
```


