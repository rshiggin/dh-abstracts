<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
   Copyright (c) 2005, Regents of the University of California
   All rights reserved.
 
   Redistribution and use in source and binary forms, with or without 
   modification, are permitted provided that the following conditions are 
   met:

   - Redistributions of source code must retain the above copyright notice, 
     this list of conditions and the following disclaimer.
   - Redistributions in binary form must reproduce the above copyright 
     notice, this list of conditions and the following disclaimer in the 
     documentation and/or other materials provided with the distribution.
   - Neither the name of the University of California nor the names of its
     contributors may be used to endorse or promote products derived from 
     this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
   POSSIBILITY OF SUCH DAMAGE.
-->

<!-- ====================================================================== -->
<!-- Heads                                                                  -->
<!-- ====================================================================== -->

<xsl:template match="head">

  <xsl:variable name="type" select="parent::*/@type"/>

  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@rend">
        <xsl:value-of select="@rend"/>
      </xsl:when>
      <xsl:otherwise>centerbold</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="@type='supplied'">
      <!--    Do nothing, suppress head when supplied by encoder-->
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$type='bookReview'">
        	<h4 class="{$class}"><xsl:apply-templates/></h4>
        </xsl:when>
        <xsl:when test="parent::table">
        	<tr><th colspan="20" class="{$class}"><xsl:apply-templates/></th></tr>
        </xsl:when>
        <xsl:when test="@type='sub' or @type='subtitle'">
          <!-- Needs more choices here -->
          <h3 class="{$class}"><xsl:apply-templates/></h3>
        </xsl:when>
        <xsl:when test="$type='fmsec'">
          <h2 class="{$class}"><xsl:apply-templates/></h2>
        </xsl:when>
        <xsl:when test="$type='volume'">
          <h1 class="{$class}">
            <xsl:if test="parent::*/@n">
              <xsl:value-of select="parent::*/@n"/><xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
          </h1>
        </xsl:when>
        <xsl:when test="$type='part'">
          <h1 class="{$class}">
            <xsl:if test="parent::*/@n">
              <xsl:value-of select="parent::*/@n"/><xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
          </h1>
        </xsl:when>
        <xsl:when test="$type='chapter'">
          <h2 class="{$class}">
            <xsl:if test="parent::*/@n">
              <xsl:value-of select="parent::*/@n"/><xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
          </h2>
        </xsl:when>
        <xsl:when test="$type='ss1'">
          <h3 class="{$class}">
            <xsl:if test="parent::*/@n">
              <xsl:value-of select="parent::*/@n"/><xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
          </h3>
        </xsl:when>
        <xsl:when test="$type='ss2'">
          <h3 class="{$class}"><xsl:apply-templates/></h3>
        </xsl:when>
        <xsl:when test="$type='ss3'">
          <h3 class="{$class}"><xsl:apply-templates/></h3>
        </xsl:when>
        <xsl:when test="$type='ss4'">
          <h4 class="{$class}"><xsl:apply-templates/></h4>
        </xsl:when>
        <xsl:when test="$type='ss5'">
          <h4 class="{$class}"><xsl:apply-templates/></h4>
        </xsl:when>
        <xsl:when test="$type='bmsec'">
          <h2 class="{$class}"><xsl:apply-templates/></h2>
        </xsl:when>
        <xsl:when test="$type='appendix'">
          <h2 class="{$class}">
            <xsl:if test="parent::*/@n">
              <xsl:value-of select="parent::*/@n"/><xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
          </h2>
        </xsl:when>
        <xsl:when test="$type='endnotes'">
          <h3 class="{$class}"><xsl:apply-templates/></h3>
        </xsl:when>
        <xsl:when test="$type='bibliography'">
          <h2 class="{$class}"><xsl:apply-templates/></h2>
        </xsl:when>
        <xsl:when test="$type='glossary'">
          <h2 class="{$class}"><xsl:apply-templates/></h2>
        </xsl:when>
        <xsl:when test="$type='index'">
          <h2 class="{$class}"><xsl:apply-templates/></h2>
        </xsl:when>
        <xsl:otherwise>
          <h4 class="{$class}"><xsl:apply-templates/></h4>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="docAuthor">
  <h4><xsl:apply-templates/></h4>
</xsl:template>

<!-- ====================================================================== -->
<!-- Verse                                                                  -->
<!-- ====================================================================== -->

  <xsl:template match="lg">
    <xsl:choose>
      <xsl:when test="@type='stanza' and parent::lg">
        <tr>
          <td colspan="2">
            <xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text><table border="0" cellspacing="0" cellpadding="0"><xsl:apply-templates/></table>
          </td>
        </tr>
      </xsl:when>
      <xsl:when test="parent::lg">
      	<li>
      		<ul class="epigraph {@rend}"><xsl:apply-templates/></ul>
      	</li>
      </xsl:when>
      <xsl:when test="ancestor::p and not(ancestor::q)">
      	<xsl:text disable-output-escaping='yes'> <![CDATA[</p>]]></xsl:text>
      		<ul class="epigraph {@rend}"><xsl:apply-templates/></ul>
      	<xsl:text disable-output-escaping='yes'> <![CDATA[<p>]]></xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <ul class="epigraph {@rend}"><xsl:apply-templates/></ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="l">
  	<xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@rend='i'">
        italic
      </xsl:when>
<!--      <xsl:when test="@rend='ti-1'">
      	ti-1
      </xsl:when> -->
      <xsl:when test="@rend">
      	<xsl:value-of select="@rend"/>
      </xsl:when>
      <xsl:otherwise>epigraphline</xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
  
    <xsl:choose>
      <xsl:when test="parent::lg">
          
            <xsl:choose>
              <xsl:when test="@n">
              <li class="{$class}">
              	<xsl:apply-templates/>
                <div class="run-head"><xsl:value-of select="@n"/></div>        
              </li>
              </xsl:when>
              <xsl:otherwise>
              	<li class="{$class}">
            		<xsl:apply-templates/>
        		</li>
        	  </xsl:otherwise>
            </xsl:choose>
        
       <!-- <li class="{$class}">
            <xsl:apply-templates/>
        </li> -->
          
      </xsl:when>
      <xsl:when test="parent::epigraph">
      	<p class="nopadding {$class}"><xsl:apply-templates/></p>
      </xsl:when>
      <xsl:when test="ancestor::floatingText">
      	<xsl:choose>
      		<xsl:when test="not(preceding-sibling::l) and following-sibling::l">
      			<div class="verseline-top {$class}"><xsl:apply-templates/></div>
	        </xsl:when>
      		<xsl:when test="not(following-sibling::l) and preceding-sibling::l">
		      	<div class="verseline-bottom {$class}"><xsl:apply-templates/></div>
	        </xsl:when>
      		<xsl:when test="preceding-sibling::l and following-sibling::l">
		      	<div class="verseline-middle {$class}"><xsl:apply-templates/></div>
      		</xsl:when>
      	</xsl:choose>
      </xsl:when>
      <xsl:when test="not(preceding-sibling::l) and following-sibling::l">
      	<span class="verseline-top {$class}"><xsl:apply-templates/></span>
      </xsl:when>
      <xsl:when test="not(following-sibling::l) and preceding-sibling::l">
      	<span class="verseline-bottom {$class}"><xsl:apply-templates/></span>
      </xsl:when>
      <xsl:when test="preceding-sibling::l and following-sibling::l">
      	<span class="verseline-middle {$class}"><xsl:apply-templates/></span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="@n">
          <span class="run-head"><xsl:value-of select="@n"/></span>
        </xsl:if>
        <span class="blockquote">
          <xsl:choose>
          	<xsl:when test="@rend">
          		<span class="{@rend}">
          			<xsl:apply-templates/>
          		</span>
          	</xsl:when>
          	<xsl:otherwise>
	            <xsl:apply-templates/>
	        </xsl:otherwise>
          </xsl:choose>
        </span>
        
<!--        <xsl:apply-templates/><br/>-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  

<!--
<xsl:template match="lg">
  <xsl:choose>
    <xsl:when test="@type='stanza' and parent::lg">
      <tr>
        <td colspan="2">
          <br/><table border="0" cellspacing="0" cellpadding="0"><xsl:apply-templates/></table>
        </td>
      </tr>
    </xsl:when>
    <xsl:otherwise>
      <table border="0" cellspacing="0" cellpadding="0"><xsl:apply-templates/></table>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="l">
  <xsl:choose>
    <xsl:when test="parent::lg">
      <tr>
        <td width="30">
          <xsl:choose>
            <xsl:when test="@n">
              <span class="run-head"><xsl:value-of select="@n"/></span>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <td>
          <xsl:apply-templates/>
        </td>
      </tr>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="@n">
        <span class="run-head"><xsl:value-of select="@n"/></span>
      </xsl:if>
      <xsl:apply-templates/><br/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="seg">
  <xsl:if test="position() > 1">
    <xsl:text>&#160;&#160;&#160;&#160;</xsl:text>
  </xsl:if>
  <xsl:apply-templates/><br/>
</xsl:template>
-->

<!-- ====================================================================== -->
<!-- Speech                                                                 -->
<!-- ====================================================================== -->

<xsl:template match="sp">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="speaker">
  <p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="sp/p">
  <p class="noindent">
  	<xsl:choose>
  		<xsl:when test="@rend='i'">
  			<span class="italic">
  				<xsl:apply-templates/>
  			</span>
  		</xsl:when>
  		<xsl:otherwise>
		  	<xsl:apply-templates/>
		</xsl:otherwise>
  	</xsl:choose>
  </p>
</xsl:template>

<!-- ====================================================================== -->
<!-- Lists                                                                  -->
<!-- ====================================================================== -->

<xsl:template match="list">
<xsl:if test="head">
  <xsl:apply-templates select="head" />
</xsl:if>
  <xsl:choose>
  	<xsl:when test="ancestor::*[@type='contents'] or ancestor::*[@type='figures']">
  		<xsl:choose>
  			<xsl:when test="@type='ordered'">
      			<xsl:choose>
			        <xsl:when test="@rend">
			          <ol class="toc {@rend}">
          				<xsl:for-each select="item|pb">
	          				<xsl:apply-templates select="."/>
	        			</xsl:for-each>
			          </ol>
			        </xsl:when>
			        <xsl:otherwise>
			        	<ol class="toc">
			          		<xsl:for-each select="item|pb">
	          					<xsl:apply-templates select="."/>
	        		  		</xsl:for-each>
	        			</ol>
			        </xsl:otherwise>
			    </xsl:choose>
			</xsl:when>
  			<xsl:when test="label">
		  		<dl class="toc">
		  			<xsl:for-each select="item|pb">
	          			<xsl:apply-templates select="."/>
			        </xsl:for-each>
		  		</dl>
		  	</xsl:when>
		  	<xsl:otherwise>
		  		<xsl:choose>
		  			<xsl:when test="@rend">
				  		<ul class="toc {@rend}">
		  					<xsl:for-each select="item|pb">
		  						<xsl:apply-templates select="."/>
				  			</xsl:for-each>
		  				</ul>
		  			</xsl:when>
		  			<xsl:otherwise>
		  				<ul class="toc">
		  					<xsl:for-each select="item|pb">
		  						<xsl:apply-templates select="."/>
				  			</xsl:for-each>
		  				</ul>
		  			</xsl:otherwise>
		  		</xsl:choose>
		  	</xsl:otherwise>
  		</xsl:choose>
  	</xsl:when>
    <xsl:when test="@type='bibliography'">
    	<dl class="bibliography">
    		<dt style="display:none"></dt>
    		<xsl:for-each select="item|pb">
	          	<xsl:apply-templates select="."/>
	        </xsl:for-each>
    	</dl>
    </xsl:when>
    <xsl:when test="@type='footnotes'">
    	<ul class="footnote">
    		<li><hr /></li>
    		<xsl:for-each select="item|pb">
	          	<xsl:apply-templates select="."/>
	        </xsl:for-each>
    	</ul>
    </xsl:when>
    <xsl:when test="@type='gloss'">
      <dl>
      	<xsl:for-each select="item|pb">
	        <xsl:apply-templates select="."/>
	    </xsl:for-each>
      </dl>
    </xsl:when>
    <xsl:when test="@type='simple'">
      <ul class="nobull">
      	<xsl:for-each select="item|pb">
	       <xsl:apply-templates select="."/>
	    </xsl:for-each>
      </ul>
    </xsl:when>
    <xsl:when test="@type='ordered'">
      <xsl:choose>
        <xsl:when test="@rend">
          <ol class="{@rend}">
          	<xsl:for-each select="item|pb">
	          	<xsl:apply-templates select="."/>
	        </xsl:for-each>
          </ol>
        </xsl:when>
        <xsl:otherwise>
          <ol>
          	<xsl:for-each select="item|pb">
	          	<xsl:apply-templates select="."/>
	        </xsl:for-each>
          </ol>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="@type='unordered'">
      <ul>
      	<xsl:for-each select="item|pb">
	      	<xsl:apply-templates select="."/>
	    </xsl:for-each>
      </ul>
    </xsl:when>
    <xsl:when test="@type='bulleted'">
      <xsl:choose>
        <xsl:when test="@rend='dash'">
          <ul class="nobull">
          	<xsl:text>- </xsl:text>
          	<xsl:for-each select="item|pb">
	          	<xsl:apply-templates select="."/>
	        </xsl:for-each>
          </ul>
        </xsl:when>
        <xsl:when test="@rend">
        	<ul class="{@rend}">
        		<xsl:for-each select="item|pb">
	          		<xsl:apply-templates select="."/>
		        </xsl:for-each>
        	</ul>
        </xsl:when>
        <xsl:otherwise>
          <ul>
          	<xsl:for-each select="item|pb">
	          	<xsl:apply-templates select="."/>
	        </xsl:for-each>
          </ul>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="@type='bibliographic'">
      <ol>
      	<xsl:for-each select="item|pb">
	      	<xsl:apply-templates select="."/>
	    </xsl:for-each>
      </ol>
    </xsl:when>
    <xsl:when test="@type='special'">
      <ul>
      	<xsl:for-each select="item|pb">
	      	<xsl:apply-templates select="."/>
	    </xsl:for-each>
      </ul>
    </xsl:when>
    <xsl:otherwise>
    	<ul>
    		<xsl:for-each select="item|pb">
	          	<xsl:apply-templates select="."/>
	        </xsl:for-each>
    	</ul>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="item">
  <xsl:choose>
  	<xsl:when test="(ancestor::*[@type='contents'] or ancestor::*[@type='figures']) and preceding-sibling::label">
  		<dd>
  			<xsl:choose>
  				<xsl:when test="ref">
  					<xsl:variable name="refLink">
  						<xsl:for-each select="ref">
			  				<xsl:if test="@rend='right'">
  								<xsl:value-of select="@target"/>
			  				</xsl:if>
  						</xsl:for-each>
  					</xsl:variable>
  					<xsl:variable name="footnote">
  						<xsl:for-each select="ref">
			  				<xsl:if test="@type='note'">
  								<xsl:value-of select="text()"/>
		  					</xsl:if>
  						</xsl:for-each>
			  		</xsl:variable>
			  		<xsl:if test="$footnote != ''">
  						<a href="{ref[@type='note']/@target}"><xsl:value-of select="$footnote"/></a>&#160;
		  			</xsl:if>
		  			<a href="{$refLink}">
		  			<!-- <xsl:value-of select="text()"/> -->
		  			<xsl:if test="not(list)">
	  					<xsl:apply-templates/>		
	  				</xsl:if>
		  			<!-- <span class="tocRight"><xsl:value-of select="ref"/></span> -->
		  			</a>
  					<xsl:if test="list">
  						<xsl:apply-templates select="list"/>
  					</xsl:if>
  				</xsl:when>
  				<xsl:otherwise>
  					<xsl:apply-templates/>
  				</xsl:otherwise>
  			</xsl:choose>
  		</dd>
  	</xsl:when>
  	<xsl:when test="(ancestor::*[@type='contents'] or ancestor::*[@type='figures']) and contains(@rend, 'right')">
  		<li class="tocRight"><xsl:apply-templates/></li>
  	</xsl:when>
    <xsl:when test="(ancestor::*[@type='contents'] or ancestor::*[@type='figures']) and (ref or descendant::*[matches(local-name(), 'ptr')])">
  	  <xsl:variable name="refLink">
  	    <xsl:choose>
  	      <xsl:when test="ref">
  	        <xsl:for-each select="ref">
  	          <xsl:if test="not(@type='note')">
  	            <xsl:if test="not(matches(@target,'^#'))">
  	              <xsl:text>#</xsl:text>
  	            </xsl:if>
  	            <xsl:value-of select="@target"/>
  	          </xsl:if>
  	        </xsl:for-each>
  	      </xsl:when>
  	      <xsl:when test="descendant::*[matches(local-name(), 'ptr')]">
  	        <xsl:for-each select="descendant::*[matches(local-name(), 'ptr')]">
  	          <xsl:if test="not(@type='note')">
  	            <xsl:if test="not(matches(@target,'^#'))">
  	              <xsl:text>#</xsl:text>
  	            </xsl:if>
  	            <xsl:value-of select="@target"/>
  	          </xsl:if>
  	        </xsl:for-each>
  	      </xsl:when>
  	    </xsl:choose>
  	  </xsl:variable>
  	  <xsl:variable name="chunk">
  	    <xsl:call-template name="getRefChunk">
  	      <xsl:with-param name="refId">
  	        <xsl:value-of select="$refLink"/>
  	      </xsl:with-param>
  	    </xsl:call-template>
  	  </xsl:variable>
  		<xsl:variable name="footnote">
  			<xsl:for-each select="ref">
  				<xsl:if test="@type='note'">
  					<xsl:value-of select="text()"/>
  				</xsl:if>
  			</xsl:for-each>
  		</xsl:variable>
  		<li>
  			<xsl:if test="$footnote != ''">
  				<a href="{ref[@type='note']/@target}"><xsl:value-of select="$footnote"/></a>&#160;
  			</xsl:if>
  			<a>
  			  <xsl:attribute name="href"><xsl:value-of select="$doc.path"/>&#038;<xsl:if test="$doc.view!='print'">chunk.id=<xsl:value-of select="$chunk"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;</xsl:if>doc.view=<xsl:value-of select="$doc.view"/>&#038;anchor.id=<xsl:value-of select="$refLink"/></xsl:attribute>
  		    <!-- <xsl:value-of select="text()"/> -->
  				<xsl:if test="not(list)">
	  				<xsl:apply-templates/>		
  				</xsl:if>
  			  
<!--  			<span class="tocRight"><xsl:apply-templates select="ref[not(@type='note')]/text()"/></span> -->
  			
  			</a> 
  			<xsl:if test="list">
  				<xsl:apply-templates select="list"/>
  			</xsl:if>
	    </li>
  	</xsl:when>
    <xsl:when test="parent::list[@type='gloss']">
      <dd><xsl:apply-templates/></dd>
    </xsl:when>
    <xsl:when test="parent::list[@type='footnotes']">
      <li><xsl:apply-templates/></li>
    </xsl:when>
    <xsl:when test="parent::list[@type='bibliography']">
      <dd><xsl:apply-templates/></dd>
    </xsl:when>
    <xsl:when test="hi[@rend='center']">
    	<li class="center"><xsl:apply-templates/></li>
    </xsl:when>
    <xsl:otherwise>
      <li><xsl:apply-templates/></li>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template  match="label">
  <xsl:choose>
  	<xsl:when test="parent::p">
  		<xsl:apply-templates/><xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
  	</xsl:when>
  	<xsl:when test="parent::note">
  		<xsl:apply-templates/>
  	</xsl:when>
  	<xsl:when test="ancestor::list or (ancestor::*[@type='contents'] or ancestor::*[@type='figures'])">
  		<dt><xsl:apply-templates/></dt>
  	</xsl:when>
  	<xsl:otherwise>
	  <xsl:apply-templates/>
	</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="name">
  <xsl:apply-templates/>
</xsl:template>

<!-- ====================================================================== -->
<!-- Notes                                                                  -->
<!-- ====================================================================== -->

<xsl:template match="note">
  <xsl:if test="not(preceding-sibling::note or parent::lg or parent::q[@rend='blockquote'] or ancestor::bibl)">
  	<xsl:if test="parent::hi">
  		<xsl:text disable-output-escaping='yes'> <![CDATA[</span>]]></xsl:text>
	</xsl:if>
  	<xsl:if test="parent::p/parent::div or parent::p/parent::sp">
  		<xsl:text disable-output-escaping='yes'> <![CDATA[</p>]]></xsl:text>
  	</xsl:if>
  	<hr class="note" />
  </xsl:if>
  <xsl:if test="@id">
  	<a id="{@id}"></a>
  </xsl:if>
  <xsl:choose>
  	<xsl:when test="ancestor::bibl">
  		<xsl:apply-templates/>
  	</xsl:when>
    <xsl:when test="parent::lg">
    	<li>
    		<xsl:if test="not(preceding-sibling::note)"><hr class="note" /></xsl:if>
    		<xsl:if test="@xml:id"><a id="{@*:id}"></a></xsl:if>
    		<xsl:apply-templates/>
    	</li>
    </xsl:when>
    <xsl:when test="(@type='footnote' or @place='foot' or @place='side' or @place='top') and @xml:id">
<!--      <xsl:if test="$doc.view='popup' or $doc.view='print'"> -->
		<xsl:choose>
			<xsl:when test="descendant::p or descendant::q/l">
				<div class="footnote"><a id="{@*:id}"></a><xsl:apply-templates/></div>
			</xsl:when>
			<xsl:otherwise>
		        <p class="footnote"><a id="{@*:id}"></a><xsl:apply-templates/></p>
		    </xsl:otherwise>
  		</xsl:choose>
  		<xsl:if test="parent::p and not(preceding-sibling::q/lg or preceding-sibling::note or following-sibling::q/lg or following-sibling::note)">
			<xsl:text disable-output-escaping='yes'> <![CDATA[<p>]]></xsl:text>
  		</xsl:if>
<!--      </xsl:if> -->
    </xsl:when>
    <xsl:when test="@type='endnote' or @place='end'">
      <xsl:choose>
        <xsl:when test="$anchor.id=@id">
          <a id="X"></a>
          
            <xsl:apply-templates/>
          
        </xsl:when>
        <xsl:when test="@xml:id">
    		<a id="{@*:id}"></a>
    		<xsl:apply-templates/>
    	</xsl:when>
        <xsl:otherwise>
          
            <xsl:apply-templates/>
          
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="@type='note' or @place='inline'">
      
      	<xsl:if test="@xml:id">
      		<a id="{@*:id}"></a>
      	</xsl:if>
        <xsl:apply-templates/>
      
    </xsl:when>
    <xsl:when test="descendant::p">
    	<div class="notes"><xsl:apply-templates/></div>
    </xsl:when>
    <xsl:when test="parent::q[@rend='blockquote']">
    	<xsl:if test="not(preceding-sibling::*)">
    		<xsl:text disable-output-escaping='yes'> <![CDATA[</span><hr class="note" />]]></xsl:text>
    	</xsl:if>
    	<p class="notes">
    		<xsl:if test="@xml:id">
      			<a id="{@*:id}"></a>
      		</xsl:if>
	    	<xsl:apply-templates/>
    	</p>
    	<xsl:if test="not(following-sibling::*)">
    		<xsl:text disable-output-escaping='yes'> <![CDATA[<span class="blockquote">]]></xsl:text>
    	</xsl:if>
    </xsl:when>
    <xsl:otherwise>
    	<p class="notes">
    		<xsl:if test="@xml:id">
      			<a id="{@*:id}"></a>
      		</xsl:if>
	        <xsl:apply-templates/>
	    </p>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:if test="parent::hi[@rend='i']">
  	<xsl:text disable-output-escaping='yes'> <![CDATA[<span class="italic">]]></xsl:text>
  </xsl:if>
  <xsl:if test="parent::p/parent::sp">
  	<xsl:text disable-output-escaping='yes'> <![CDATA[<p class="noindent">]]></xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="p[ancestor::note[@type='footnote' or @place='foot']]">

  <xsl:variable name="n" select="parent::note/@n"/>

  <p>
    <xsl:if test="position()=1">
      <xsl:if test="$n != ''">
        <xsl:text>[</xsl:text><xsl:value-of select="$n"/><xsl:text>] </xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:apply-templates/>
  </p>

</xsl:template>

<xsl:template match="p[ancestor::note[@type='endnote' or @place='end']]">

  <xsl:variable name="n" select="parent::note/@n"/>

  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="position()=1">noindent</xsl:when>
      <xsl:otherwise>indent</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <p class="{$class}">
    <xsl:if test="position()=1">
      <xsl:if test="$n != ''">
        <xsl:value-of select="$n"/><xsl:text>. </xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:if test="position()=last()">
      <xsl:if test="parent::note/@corresp">

        <xsl:variable name="corresp" select="parent::note/@corresp"/>

        <xsl:variable name="chunk" select="key('ref-id', $corresp)/ancestor::*[self::div1 or self::div2 or self::div3 or self::div4 or self::div5 or self::div6][1]/@id"/>

        <xsl:variable name="toc" select="key('div-id', $chunk)/parent::*/@id"/>

        <span class="down1">
        <xsl:text> [</xsl:text>
        <a>
<!--          <xsl:attribute name="href"><xsl:value-of select="$doc.path"/>&#038;chunk.id=<xsl:value-of select="$chunk"/>&#038;toc.id=<xsl:value-of select="$toc"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of select="$search"/>&#038;anchor.id=<xsl:value-of select="$corresp"/>#X</xsl:attribute>-->
          <xsl:attribute name="href"><xsl:value-of select="$doc.path"/>&#038;chunk.id=<xsl:value-of select="$chunk"/>&#038;toc.id=<xsl:value-of select="$toc"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of select="$search"/>&#038;anchor.id=<xsl:value-of select="$corresp"/></xsl:attribute>
           
          <!-- <xsl:attribute name="target">_top</xsl:attribute> -->
          <xsl:text>BACK</xsl:text>
        </a>
        <xsl:text>]</xsl:text>
        </span>
      </xsl:if>
    </xsl:if>
  </p>
</xsl:template>

<!-- ====================================================================== -->
<!-- Paragraphs                                                             -->
<!-- ====================================================================== -->

<xsl:template match="p">
<xsl:choose>
 <xsl:when test="(parent::p or ancestor::p) and not(ancestor::floatingText) and not(ancestor::div[@type='letter'])">
 	<xsl:choose>
  	<xsl:when test="parent::div[@type='diary']">
  		<span class="indent {@rend}"><xsl:apply-templates/></span>
  	</xsl:when>
  	<xsl:when test="parent::figure">
  		<span class="figureText {@rend}"><xsl:apply-templates/></span>
  	</xsl:when>
    <xsl:when test="@rend">
      <span class="{@rend}"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="name(preceding-sibling::node()[1])='pb'">
      <span class="noindent {@rend}"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="parent::td">
      <span><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="contains(@rend, 'IndentHanging')">
      <span class="{@rend}"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="not(preceding-sibling::p)">
      <xsl:choose>
        <xsl:when test="@rend">
          <span class="{@rend}"><xsl:apply-templates/></span>
        </xsl:when>
        <xsl:when test="parent::q and hi[@rend='right']">
        	<p class="right"><xsl:apply-templates/></p>
        </xsl:when>
        <xsl:otherwise>
          <span class="noindent"><xsl:apply-templates/></span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="not(following-sibling::p)">
      <xsl:choose>
        <xsl:when test="@rend">
          <span class="{@rend}"><xsl:apply-templates/></span>
        </xsl:when>
        <xsl:otherwise>
          <span class="padded"><xsl:apply-templates/></span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="parent::q">
    	<div class="normal"><xsl:apply-templates/></div>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="@rend">
          <span class="{@rend}"><xsl:apply-templates/></span>
        </xsl:when>
        <xsl:otherwise>
          <span class="normal"><xsl:apply-templates/></span>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
 </xsl:when>
 <xsl:otherwise>
  <xsl:choose>
  	<xsl:when test="descendant::floatingText or descendant::lg or descendant::list">
    	<div class="normal {@rend}"><xsl:apply-templates/></div>
    </xsl:when>
  	<xsl:when test="ancestor::*[@type='letter'] or ancestor::*[@type='dedication']">
  		<p class="indent {@rend}"><xsl:apply-templates/></p>
  	</xsl:when>
  	<xsl:when test="parent::div[@type='diary']">
  		<p class="indent {@rend}"><xsl:apply-templates/></p>
  	</xsl:when>
  	<xsl:when test="parent::figure">
  		<p class="figureText {@rend}"><xsl:apply-templates/></p>
  	</xsl:when>
    <xsl:when test="@rend">
      <p class="{@rend}"><xsl:apply-templates/></p>
    </xsl:when>
    <xsl:when test="name(preceding-sibling::node()[1])='pb' and q">
      <div class="noindent {@rend}"><xsl:apply-templates/></div>
    </xsl:when>
    <xsl:when test="name(preceding-sibling::node()[1])='pb'">
      <p class="noindent {@rend}"><xsl:apply-templates/></p>
    </xsl:when>
    <xsl:when test="parent::td">
      <p><xsl:apply-templates/></p>
    </xsl:when>
    <xsl:when test="contains(@rend, 'IndentHanging')">
      <p class="{@rend}"><xsl:apply-templates/></p>
    </xsl:when>
    <xsl:when test="not(preceding-sibling::p)">
      <xsl:choose>
        <xsl:when test="@rend">
          <p class="{@rend}"><xsl:apply-templates/></p>
        </xsl:when>
        <xsl:otherwise>
          <p class="noindent"><xsl:apply-templates/></p>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="not(following-sibling::p)">
      <xsl:choose>
        <xsl:when test="@rend">
          <p class="{@rend}"><xsl:apply-templates/></p>
        </xsl:when>
        <xsl:otherwise>
          <p class="padded"><xsl:apply-templates/></p>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="@rend">
          <p class="{@rend}"><xsl:apply-templates/></p>
        </xsl:when>
        <xsl:when test="q or descendant::div[@type='letter']">
      		<div class="normal"><xsl:apply-templates/></div>
      	</xsl:when>
        <xsl:otherwise>
          <p class="normal"><xsl:apply-templates/></p>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- ====================================================================== -->
<!-- Other Text Blocks                                                      -->
<!-- ====================================================================== -->

<xsl:template match="epigraph">
  <xsl:choose>
  	<xsl:when test="descendant::q or descendant::quote">
  		<div class="blockquote"><xsl:apply-templates/></div>
  	</xsl:when>
  	<xsl:otherwise>
	  <blockquote><xsl:apply-templates/></blockquote><xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
	</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- <xsl:template match="bibl" priority="1">
  <p class="right"><xsl:apply-templates/></p>
</xsl:template> -->

<xsl:template match="byline">
  <p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="cit">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="cit/bibl">
	<xsl:choose>
		<xsl:when test="ancestor::note or ancestor::p or ancestor::head">
			<span class="cite"><cite><xsl:apply-templates/></cite></span>
		</xsl:when>
		<xsl:otherwise>
			<p class="right"><cite><xsl:apply-templates/></cite></p>
		</xsl:otherwise>
  	</xsl:choose>
</xsl:template>

<xsl:template match="quote">
    <xsl:choose>
		<xsl:when test="floatingText or (p and not(ancestor::p))">
			<blockquote class="blockquoteletter"><xsl:apply-templates/></blockquote>
		</xsl:when>
		<xsl:when test="lg or l">
			<xsl:apply-templates/>
		</xsl:when>
		<xsl:when test="@rend='blockquote'">
			<span class="blockquote"><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="q">
	<xsl:choose>
		<xsl:when test="floatingText or lg or (p and not(ancestor::p))">
			<blockquote class="blockquoteletter"><xsl:apply-templates/></blockquote>
		</xsl:when>
		<xsl:when test="l and (not(ancestor::p or ancestor::q or ancestor::quote) or (following-sibling::p or preceding-sibling::p))">
			<p><xsl:apply-templates/></p>
		</xsl:when>
		<xsl:when test="l">
			<xsl:apply-templates/>
		</xsl:when>
		<xsl:when test="p or list">
			<xsl:choose>
				<xsl:when test="p[@rend]">
					<div class="blockquote {p/@rend}"><xsl:apply-templates/></div>
				</xsl:when>
				<xsl:otherwise>
					<div class="blockquote"><xsl:apply-templates/></div>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:when test="@rend='blockquote'">
			<span class="blockquote"><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="date">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="foreign">
  <span class="italic"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="opener">
	<xsl:choose>
		<xsl:when test="ancestor::floatingText">
			<p><xsl:apply-templates/></p>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="address">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="addrLine">
  <xsl:choose>
  	<xsl:when test="ancestor::p and @rend='right'">
  		<span class="right"><xsl:apply-templates/></span>
  	</xsl:when>
    <xsl:when test="@rend='right'">
      <p class="right"><xsl:apply-templates/></p>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/><xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="signed">
<xsl:choose>
 <xsl:when test="ancestor::p or ancestor::closer">
  <xsl:choose>
  	<xsl:when test="@rend='right'">
	  <span class="right"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='center'">
      <span class="center"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:otherwise>
      <span class="signed"><xsl:apply-templates/></span>
     </xsl:otherwise>
  </xsl:choose>
 </xsl:when>
 <xsl:otherwise>
  <xsl:choose>
  	<xsl:when test="@rend='right'">
	  <p class="right"><xsl:apply-templates/></p>
    </xsl:when>
    <xsl:when test="@rend='center'">
      <p class="center"><xsl:apply-templates/></p>
    </xsl:when>
    <xsl:otherwise>
      <p class="signed"><xsl:apply-templates/></p>
     </xsl:otherwise>
  </xsl:choose>
 </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="salute">
 <xsl:choose>
   <xsl:when test="ancestor::p or ancestor::opener or ancestor::closer">
   	<xsl:choose>
		<xsl:when test="@rend='i'">
			<span class="italic"><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:when test="@rend='right'">
			<span class="right"><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:when test="@rend='center'">
			<span class="center"><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:otherwise>
			<span class="salute"><xsl:apply-templates/></span>
		</xsl:otherwise>
	</xsl:choose>
   </xsl:when>
   <xsl:otherwise>
	<xsl:choose>
		<xsl:when test="@rend='i'">
			<span class="italic"><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:when test="@rend='right'">
			<p class="right"><xsl:apply-templates/></p>
		</xsl:when>
		<xsl:when test="@rend='center'">
			<p class="center"><xsl:apply-templates/></p>
		</xsl:when>
		<xsl:otherwise>
			<p class="salute"><xsl:apply-templates/></p>
		</xsl:otherwise>
	</xsl:choose>
   </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="stage">
	<xsl:choose>
		<xsl:when test="@type='mix'">
			<xsl:choose>
				<xsl:when test="ancestor::p or ancestor::q">
					<span class="italicBlock"><xsl:apply-templates/></span>
				</xsl:when>
				<xsl:otherwise>
					<p class="italic"><xsl:apply-templates/></p>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="hi[@rend='center']">
					<div class="center"><xsl:apply-templates/></div>
				</xsl:when>
				<xsl:when test="not(parent::sp or ancestor::sp)">
					<div><xsl:apply-templates/></div>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- ====================================================================== -->
<!-- Bibliographies                                                         -->
<!-- ====================================================================== -->

<xsl:template match="listBibl">
  <xsl:if test="$anchor.id=@id">
    <a id="X"></a>
  </xsl:if>
  <ul class="listbibl">
	<xsl:apply-templates/>
  </ul>
</xsl:template>

<xsl:template match="bibl">
  <xsl:choose>
    <xsl:when test="parent::listBibl">
      <xsl:choose>
		<xsl:when test="$anchor.id=@id">
	  		<a id="X"></a>
	    		<li>
              		<xsl:apply-templates/>
              	</li>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="listBiblPosition">
				<xsl:value-of select="index-of((//listBibl), parent::listBibl)"/>-<xsl:value-of select="position()"/>
			</xsl:variable>
			<xsl:variable name="apos">'</xsl:variable>
			<xsl:variable name="bookTitle">
				<xsl:value-of select="replace(normalize-space(title),$apos,'')"/>
			</xsl:variable>
			<li>
            	<xsl:apply-templates/> <a href="javascript:showTitleSearch('{$listBiblPosition}','{$bookTitle}')" class="showtitlesearch"><img src="/inauthors/images/external.png" alt="Search &quot;{title}&quot; by {ancestor::div[@type='bibliography']/preceding-sibling::head} in IUCAT, Google Books, OCLC WorldCat, or HathiTrust" /></a>
            		<div id="listBiblDiv{$listBiblPosition}" style="display:none;" class="titlesearch">
  						<p>Search &quot;<xsl:value-of select="title"/>&quot; by <xsl:value-of select="ancestor::div[@type='bibliography']/preceding-sibling::head"/> in:</p>
  						<ul class="nobull">
  							<li><a href="" id="iucat{$listBiblPosition}">IUCAT</a></li>
  							<li><a href="" id="google{$listBiblPosition}">Google Books</a></li>
  							<li><a href="" id="oclc{$listBiblPosition}">OCLC WorldCat</a></li>
  							<li><a href="" id="hathitrust{$listBiblPosition}">HathiTrust</a></li>
  						</ul>
  						<a href="javascript:closeTitleSearch('{$listBiblPosition}')" class="closetitlesearch">Close X</a>
  					</div>
            </li>
		</xsl:otherwise>
     </xsl:choose>
    </xsl:when>
    <xsl:when test="parent::epigraph or ancestor::epigraph">
    	<p><xsl:apply-templates/></p>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Because of order in the following, "rend" takes precedence over "level" -->

<xsl:template match="title">
	<xsl:choose>
	  <xsl:when test="@ref">
	  	<a href="{@ref}">
		  <xsl:choose>
    		<xsl:when test="@level='a'">
	    	  &#x201C;<xsl:apply-templates/>&#x201D;
	    	</xsl:when>
		    <xsl:when test="@level='u'">
    		  <xsl:apply-templates/>
		    </xsl:when>
    		<xsl:otherwise>
	    	  <em><xsl:apply-templates/></em>
	    	</xsl:otherwise>
		  </xsl:choose>
	  	</a>
	  </xsl:when>
	  <xsl:otherwise>
	  	<xsl:choose>
    		<xsl:when test="@level='a'">
	    	  &#x201C;<xsl:apply-templates/>&#x201D;
	    	</xsl:when>
		    <xsl:when test="@level='u'">
    		  <xsl:apply-templates/>
		    </xsl:when>
    		<xsl:otherwise>
	    	  <em><xsl:apply-templates/></em>
	    	</xsl:otherwise>
		 </xsl:choose>
	  </xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="author">
  <xsl:choose>
    <xsl:when test="@rend='hide'">
      <xsl:text>&#x2014;&#x2014;&#x2014;</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ====================================================================== -->
<!-- Formatting                                                             -->
<!-- ====================================================================== -->

<xsl:template match="hi">
  <xsl:choose>
    <xsl:when test="@rend='bold' or @rend='b'">
      <span class="bold"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='italic' or @rend='i'">
      <span class="italic"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='mono'">
      <code><xsl:apply-templates/></code>
    </xsl:when>
    <xsl:when test="@rend='roman'">
      <span class="normal"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='smallcaps' or @rend='sc'">
      <span class="sc"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='sub' or @rend='subscript'">
      <sub><xsl:apply-templates/></sub>
    </xsl:when>
    <xsl:when test="@rend='sup' or @rend='superscript' or @rend='super'">
      <sup><xsl:apply-templates/></sup>
    </xsl:when>
    <xsl:when test="@rend='strike' or @rend='strike-through'">
    	<span class="strikethrough"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='underline' or @rend='u'">
      <span class="underline"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='u b' or @rend='b u'">
      <span class="ub"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='i b' or @rend='b i'">
      <span class="ib"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="@rend='u i' or @rend='i u'">
      <span class="ui"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:when test="contains(@rend, 'right') and (ancestor::*[@type='contents'] or ancestor::*[@type='figures'] or parent::item)">
    	<span class="tocRight"><xsl:apply-templates/></span>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="lb">
	<xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
</xsl:template>

<xsl:template match="emph">
	<em><xsl:apply-templates/></em>
</xsl:template>

<xsl:template match="sic">
	<span class="strikethrough"><xsl:apply-templates/></span>
</xsl:template>

<!-- ====================================================================== -->
<!-- References                                                             -->
<!-- ====================================================================== -->

<xsl:template match="ref">

  <xsl:variable name="target">
  	<xsl:choose>
  		<xsl:when test="contains(@target, '#')">
			<xsl:value-of select="@target"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>#</xsl:text><xsl:value-of select="@target"/>
		</xsl:otherwise>
  	</xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="targetMatch">
  	<xsl:choose>
  		<xsl:when test="contains(@target, '#')">
  			<xsl:value-of select="substring(@target,2)"/>
  		</xsl:when>
  		<xsl:otherwise>
  			<xsl:value-of select="@target"/>
  		</xsl:otherwise>
  	</xsl:choose>
  </xsl:variable>


  <xsl:variable name="chunk">
    <xsl:choose>
      <xsl:when test="@type='secref'">
        <xsl:value-of select="$target"/>
      </xsl:when>
      <xsl:when test="@type='noteref' or @type='endnote'">
        <xsl:value-of select="key('endnote-id', $target)/ancestor::*[matches(local-name(), '^div$')][1]/@*:id"/>
      </xsl:when>
      <xsl:when test="@type='fnoteref'">
        <xsl:value-of select="key('fnote-id', $target)/ancestor::*[matches(local-name(), '^div$')][1]/@*:id"/>
      </xsl:when>
      <xsl:when test="@type='pageref'">
        <xsl:choose>
          <xsl:when test="$target='endnotes'">
            <xsl:value-of select="'endnotes'"/>
          </xsl:when>
          <xsl:otherwise>
          <xsl:value-of select="key('pb-id', $target)/ancestor::*[matches(local-name(), '^div$')][1]/@*:id"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="not(@type) and not(matches($targetMatch, 'VA.{5}-\d+'))">
      	<xsl:choose>
      		<xsl:when test="ancestor::note">
	      		<xsl:value-of select="key('ref-id', $targetMatch)/ancestor::*/@*[local-name()='id']"/>
	      	</xsl:when>
	      	<xsl:otherwise>
	      		<xsl:value-of select="key('note-id', $targetMatch)/ancestor::*/@*[local-name()='id']"/>
	      	</xsl:otherwise>
      	</xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="getRefChunk">
          <xsl:with-param name="refId">
            <xsl:value-of select="$target"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="toc" select="key('div-id', $chunk)/parent::*/@id"/>

  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="$anchor.id=@id">ref-hi</xsl:when>
      <xsl:otherwise>ref</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:if test="$anchor.id=@id">
    <a id="X"></a>
  </xsl:if>
  
  <xsl:if test="@xml:id">
  	<a id="{@*:id}"></a>
  </xsl:if>

  <xsl:choose>
  	<xsl:when test="ancestor::*[@type='contents'] or ancestor::*[@type='figures']">
  		<span class="tocRight"><xsl:apply-templates/></span>
  	</xsl:when>
    <xsl:when test="@type='noteref' or @type='endnote'">
      <sup>
        <xsl:attribute name="class">
          <xsl:value-of select="$class"/>
        </xsl:attribute>
        <xsl:text>[</xsl:text>
          <a>
            <xsl:attribute name="href"><xsl:value-of select="$doc.path"/>&#038;chunk.id=<xsl:value-of select="$chunk"/>&#038;toc.id=<xsl:value-of select="$toc"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;doc.view=<xsl:value-of select="$doc.view"/><xsl:value-of select="$search"/>&#038;anchor.id=<xsl:value-of select="$target"/></xsl:attribute>
            <xsl:apply-templates/>
          </a>
        <xsl:text>]</xsl:text>
      </sup>
    </xsl:when>
    <xsl:when test="@type='fnoteref'">
      <sup>
        <xsl:attribute name="class">
          <xsl:value-of select="$class"/>
        </xsl:attribute>
        <xsl:text>[</xsl:text>
          <a>
            <xsl:attribute name="href">javascript://</xsl:attribute>
            <xsl:attribute name="onclick">
              <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/>&#038;doc.view=popup&#038;chunk.id=<xsl:value-of select="$target"/><xsl:text>','popup','width=300,height=300,resizable=yes,scrollbars=yes')</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </a>
        <xsl:text>]</xsl:text>
      </sup>
    </xsl:when>
    <xsl:when test="@type='pageref'">
      <xsl:if test="@rend='sup' or @rend='superscript' or @rend='super'">
      	<xsl:text disable-output-escaping='yes'> <![CDATA[<sup>]]></xsl:text>
      </xsl:if>
      <a>
<!--        <xsl:attribute name="href"><xsl:value-of select="$doc.path"/>&#038;chunk.id=<xsl:value-of select="$chunk"/>&#038;toc.id=<xsl:value-of select="$toc"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;anchor.id=<xsl:value-of select="$target"/>#X</xsl:attribute>-->
        <xsl:attribute name="href"><xsl:value-of select="$doc.path"/>&#038;chunk.id=<xsl:value-of select="$chunk"/>&#038;toc.id=<xsl:value-of select="$toc"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;doc.view=<xsl:value-of select="$doc.view"/>&#038;anchor.id=<xsl:value-of select="$target"/></xsl:attribute>
        <!-- <xsl:attribute name="target">_top</xsl:attribute> -->
        <xsl:apply-templates/>
      </a>
      <xsl:if test="@rend='sup' or @rend='superscript' or @rend='super'">
      	<xsl:text disable-output-escaping='yes'> <![CDATA[</sup>]]></xsl:text>
      </xsl:if>
    </xsl:when>
    <!-- <xsl:when test="parent::item and (ancestor::*[@type='contents'] or ancestor::*[@type='figures'])">
    		<xsl:choose>
    			<xsl:when test="@rend='right'">
    				<span class="tocRight"><xsl:apply-templates/></span>
    			</xsl:when>
    			<xsl:when test="@rend">
		    		<span class="{@rend}"><xsl:apply-templates/></span>
		    	</xsl:when>
		    	<xsl:otherwise>
		    		<xsl:apply-templates/>
		    	</xsl:otherwise>
		    </xsl:choose>
    </xsl:when> -->
    <xsl:when test="not(@*)">
    	<xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="@rend='sup' or @rend='superscript' or @rend='super'">
      	<xsl:text disable-output-escaping='yes'> <![CDATA[<sup>]]></xsl:text>
      </xsl:if>
      <xsl:if test="@id">
    	 <a id="{@id}"></a>
      </xsl:if>
      <a>
<!--        <xsl:attribute name="href"><xsl:value-of select="$doc.path"/>&#038;chunk.id=<xsl:value-of select="$chunk"/>&#038;toc.id=<xsl:value-of select="$toc"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;anchor.id=<xsl:value-of select="$target"/>#X</xsl:attribute>-->
        <xsl:attribute name="href"><xsl:value-of select="$doc.path"/>&#038;chunk.id=<xsl:value-of select="tokenize($chunk, '\s+')[last()]"/>&#038;toc.id=<xsl:value-of select="$toc"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;doc.view=<xsl:value-of select="$doc.view"/>&#038;anchor.id=<xsl:value-of select="$target"/></xsl:attribute>
        <!-- <xsl:attribute name="target">_top</xsl:attribute> -->
        <xsl:apply-templates/>
      </a>
      <xsl:if test="@rend='sup' or @rend='superscript' or @rend='super'">
      	<xsl:text disable-output-escaping='yes'> <![CDATA[</sup>]]></xsl:text>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>

<xsl:template match="xref">
  <xsl:choose>
    <xsl:when test="@type='pdf'">
      <a class="ref">
        <xsl:attribute name="href">
          <xsl:value-of select="$pdf.path"/>
          <xsl:value-of select="@doc"/>
        </xsl:attribute>
        <sup class="down1">[PDF]</sup>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="@to"/>
        </xsl:attribute>
        <!-- <xsl:attribute name="target">_top</xsl:attribute> -->
        <xsl:apply-templates/>
      </a>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ====================================================================== -->
<!-- Figures                                                                -->
<!-- ====================================================================== -->

<xsl:template match="figure">

  <xsl:variable name="pageFigureId">
 	<xsl:choose>
 		<xsl:when test="preceding::pb[1]/@id">
 			<xsl:value-of select="preceding::pb[1]/@id"/>
	 	</xsl:when>
	 	<xsl:when test="following::pb[1]/@id">
	 		<xsl:value-of select="following::pb[1]/@id"/>
	 	</xsl:when>
 		<xsl:when test="preceding::pb[1]/@xml:id">
 			<xsl:value-of select="preceding::pb[1]/@xml:id"/>
 		</xsl:when>
 		<xsl:when test="following::pb[1]/@xml:id">
 			<xsl:value-of select="following::pb[1]/@xml:id"/>
 		</xsl:when>
 		<xsl:otherwise/>
 	</xsl:choose>
 </xsl:variable>
 
 <xsl:variable name="figurePage" select="if(preceding::pb[1]) then substring(preceding::pb[1]/$pageFigureId, $pageImageId-page) else number(substring(following::pb[1]/$pageFigureId, $pageImageId-page))-1"/>
 <xsl:variable name="articleId" select="if(preceding::pb[1]) then substring(preceding::pb[1]/$pageFigureId, 0, $pageImageId-length) else substring(following::pb[1]/$pageFigureId, 0, $pageImageId-length)"/>

  
  <xsl:variable name="img_src">
    <xsl:choose>
      <xsl:when test="contains($docId, 'preview')">
        <xsl:value-of select="unparsed-entity-uri(@entity)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($figure.path, @entity)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="fullsize">
    <xsl:choose>
      <xsl:when test="contains($docId, 'preview')">
        <xsl:value-of select="unparsed-entity-uri(substring-before(substring-after(@rend, 'popup('), ')'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($figure.path, substring-before(substring-after(@rend,'('),')'))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
      
  <xsl:variable name="height">
    <xsl:choose>
      <xsl:when test="contains(@rend,'X')">
        <xsl:value-of select="number(substring-before(@rend,'X'))"/>
      </xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="width">
    <xsl:choose>
      <xsl:when test="contains(@rend,'X')">
        <xsl:value-of select="number(substring-after(@rend,'X'))"/>
      </xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="$anchor.id=@id">
    <a id="X"></a>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="@rend='hide'">
      <div class="illgrp">
        <p>Image Withheld</p>
        <!-- for figDesc -->
        <xsl:apply-templates/>
      </div>
    </xsl:when>
    <xsl:when test="@rend='inline'">
      <!-- img src="{$img_src}" alt="inline image"/ -->
    </xsl:when>
    <xsl:when test="@rend='block'">
<!--      <div class="illgrp"> -->
        <!-- img src="{$img_src}" width="400" alt="block image"/ -->
        <!-- for figDesc -->
<!--        <xsl:text>[</xsl:text>
        <a>
          <xsl:attribute name="href">javascript://</xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/><xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text><xsl:value-of select="$img_src"/><xsl:text>','popup','width=600,height=600,resizable=yes,scrollbars=yes')</xsl:text>
          </xsl:attribute>
          <xsl:text>View Figure</xsl:text>
        </a>
        <xsl:text>]</xsl:text>
        <xsl:text>[Figure]</xsl:text>
        <xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
        <xsl:apply-templates/>
      </div> -->
    </xsl:when>
    <xsl:when test="contains(@rend, 'popup(')">
<!--      <div class="illgrp"> -->
        <!-- img src="{$img_src}" alt="figure"/ -->
        <!-- for figDesc -->
<!--        <xsl:text>[</xsl:text>
        <a>
          <xsl:attribute name="href">javascript://</xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/><xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text><xsl:value-of select="$fullsize"/><xsl:text>','popup','width=400,height=400,resizable=yes,scrollbars=yes')</xsl:text>
          </xsl:attribute>
          <xsl:text>View Figure</xsl:text>
        </a>
        <xsl:text>]</xsl:text>
        <xsl:text>[Figure]</xsl:text>
        <xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
        <xsl:apply-templates/>
      </div> -->
    </xsl:when>
    <xsl:when test="($height != '0') and ($height &lt; 50)">
      <xsl:text>&#160;</xsl:text><img src="{$img_src}" width="{$width}" height="{$height}" alt="image"/>
    </xsl:when>
    <xsl:when test="($height != '0') and ($height &gt; 50) and ($width &lt; 400)">
<!--      <div class="illgrp"> -->
        <!-- img src="{$img_src}" width="{$width}" height="{$height}" alt="image"/ -->
        <!-- for figDesc -->
<!--        <xsl:text>[</xsl:text>
        <a>
          <xsl:attribute name="href">javascript://</xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/><xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text><xsl:value-of select="$img_src"/><xsl:text>','popup','width=</xsl:text><xsl:value-of select="$width + 50"/><xsl:text>,height=</xsl:text><xsl:value-of select="$height + 50"/><xsl:text>,resizable=yes,scrollbars=yes')</xsl:text>
          </xsl:attribute>
          <xsl:text>View Figure</xsl:text>
        </a>
        <xsl:text>]</xsl:text>
        <xsl:text>[Figure]</xsl:text>
        <xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
        <xsl:apply-templates/>
      </div> -->
    </xsl:when>
    <xsl:when test="($height != '0') and ($height &gt; 50) and ($width &gt; 400)">
<!--      <div class="illgrp"> -->
        <!-- img src="{$img_src}" width="400" alt="image"/ -->
        <!-- for figDesc -->
<!--        <xsl:text>[</xsl:text>
        <a>
          <xsl:attribute name="href">javascript://</xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/><xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text><xsl:value-of select="$img_src"/><xsl:text>','popup','width=</xsl:text><xsl:value-of select="$width + 50"/><xsl:text>,height=</xsl:text><xsl:value-of select="$height + 50"/><xsl:text>,resizable=yes,scrollbars=yes')</xsl:text>
          </xsl:attribute>
          <xsl:text>View Figure</xsl:text>
        </a>
        <xsl:text>]</xsl:text>
        <xsl:text>[Figure]</xsl:text>
        <xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
        <xsl:apply-templates/>
      </div> -->
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="parent::p or ancestor::p">
       <span class="illgrp">
<!--        <xsl:variable name="figurePage" select="if(preceding::pb[1]) then substring(preceding::pb[1]/@id, 9) else number(substring(following::pb[1]/@id, 9))-1"/>
        <xsl:variable name="articleId" select="if(preceding::pb[1]) then substring(preceding::pb[1]/@id, 0, 8) else substring(following::pb[1]/@id, 0, 8)"/> -->
        <xsl:choose>
	        <xsl:when test="$doc.view!='print' and $hasPageImage = 'yes'">
		        <a>
<!--          <xsl:attribute name="href">http://purl.dlib.indiana.edu/iudl/imh/<xsl:value-of select="$articleId"/>?pn=<xsl:value-of select="$figurePage"/></xsl:attribute> -->
			  		<xsl:attribute name="href">javascript:showPageImage('<xsl:value-of select="$pageImageBrand"/>','<xsl:value-of select="$articleId"/>-<xsl:value-of select="$figurePage"/>');</xsl:attribute>
			  		<xsl:attribute name="id">viewFigure-<xsl:value-of select="$articleId"/>-<xsl:value-of select="$figurePage"/></xsl:attribute>
	        	    <xsl:text>[View Figure]</xsl:text>
    		    </a>
    		    <span id="showFigure-{$articleId}-{$figurePage}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
    		    <a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageFigureId}" class="left">Switch to Image Mode</a>
     			<a href="javascript:closeFigure('{$articleId}-{$figurePage}');" aria-controls="showFigure-{$articleId}-{$figurePage}">CLOSE Figure</a>
	       		<img src="" id="figureOverlay-{$articleId}-{$figurePage}" class="overlay" style="display:none;" alt="Figure"/>
    			</span>
        	</xsl:when>
        	<xsl:otherwise>
        		<xsl:text>[Figure]</xsl:text>
        	</xsl:otherwise>
        </xsl:choose>
        
<!--        <xsl:text>[Figure]</xsl:text> -->
        <xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
        <xsl:apply-templates/>
       </span>
      </xsl:when>
      <xsl:otherwise>
      <div class="illgrp">
        <!-- img src="{$img_src}" width="400" alt="image"/ -->
        <!-- for figDesc -->
        <!--
          <xsl:text>[</xsl:text>
        <a>
          <xsl:attribute name="href">javascript://</xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/><xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text><xsl:value-of select="$img_src"/><xsl:text>','popup','width=400,height=400,resizable=yes,scrollbars=yes')</xsl:text>
          </xsl:attribute>
          <xsl:text>View Figure</xsl:text>
        </a>
        <xsl:text>]</xsl:text>
        <br/>
        -->
        <xsl:choose>
        	<xsl:when test="$doc.view!='print' and $hasPageImage = 'yes'">		
		        <a>
<!--          <xsl:attribute name="href">http://purl.dlib.indiana.edu/iudl/<xsl:value-of select="$pageImageBrand"/>/<xsl:value-of select="$articleId"/>?pn=<xsl:value-of select="$figurePage"/></xsl:attribute> -->
		  			<xsl:attribute name="href">javascript:showFigure('<xsl:value-of select="$pageImageBrand"/>','<xsl:value-of select="$articleId"/>-<xsl:value-of select="$figurePage"/>');</xsl:attribute>
		  			<xsl:attribute name="id">viewFigure-<xsl:value-of select="$articleId"/>-<xsl:value-of select="$figurePage"/></xsl:attribute>
		            <xsl:text>[View Figure]</xsl:text>
		        </a>
		        <div id="showFigure-{$articleId}-{$figurePage}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
		        <a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageFigureId}" class="left">Switch to Image Mode</a>
     			<a href="javascript:closeFigure('{$articleId}-{$figurePage}');" aria-controls="showFigure-{$articleId}-{$figurePage}">CLOSE Figure</a>
	       		<img src="" id="figureOverlay-{$articleId}-{$figurePage}" class="overlay" style="display:none;" alt="Figure"/>
    			</div>
	        </xsl:when>
	        <xsl:otherwise>
	        	<xsl:text>[Figure]</xsl:text>
	        </xsl:otherwise>
	    </xsl:choose>
<!--        <xsl:text>[Figure]</xsl:text> -->
        <xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>        
        <xsl:apply-templates/>
      </div>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>

<xsl:template match="figDesc">
  <xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text><span class="down1"><xsl:if test="@n"><xsl:value-of select="@n"/>. </xsl:if><xsl:apply-templates/></span>
</xsl:template>

<!-- ====================================================================== -->
<!-- Tables                                                                 -->
<!-- ====================================================================== -->

<xsl:template match="table">
	<xsl:if test="parent::p">
		<xsl:text disable-output-escaping='yes'> <![CDATA[</p>]]></xsl:text>
	</xsl:if>
	<table><xsl:apply-templates/></table>
	<xsl:if test="parent::p">
		<xsl:text disable-output-escaping='yes'> <![CDATA[<p>]]></xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="row">
	<tr><xsl:apply-templates/></tr>
</xsl:template>

<xsl:template match="cell">
	<td><xsl:apply-templates/></td>
</xsl:template>

<!-- ====================================================================== -->
<!-- Formulas                                                               -->
<!-- ====================================================================== -->

<xsl:template match="formula">

  <xsl:if test="$anchor.id=@id">
    <a id="X"></a>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="@rend='inline'">
      <img src="{$figure.path}{@id}.gif" alt="formula"/>
      <xsl:text> [</xsl:text>
      <a>
        <xsl:attribute name="href">javascript://</xsl:attribute>
        <xsl:attribute name="onclick">
          <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/><xsl:text>&#038;doc.view=popup&#038;formula.id=</xsl:text><xsl:value-of select="@id"/><xsl:text>','popup','width=600,height=600,resizable=yes,scrollbars=yes')</xsl:text>
        </xsl:attribute>
        <xsl:text>Equation</xsl:text>
      </a>
      <xsl:text>]</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <div class="illgrp">
        <img src="{$figure.path}{@id}.gif" alt="formula"/>
        <xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
        <xsl:text>[</xsl:text>
        <a>
          <xsl:attribute name="href">javascript://</xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/><xsl:text>&#038;doc.view=popup&#038;formula.id=</xsl:text><xsl:value-of select="@id"/><xsl:text>','popup','width=600,height=600,resizable=yes,scrollbars=yes')</xsl:text>
          </xsl:attribute>
          <xsl:text>Equation</xsl:text>
        </a>
        <xsl:text>]</xsl:text>
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ====================================================================== -->
<!-- Milestones                                                             -->
<!-- ====================================================================== -->

<xsl:template match="pb">

 <xsl:variable name="pageImageId">
 	<xsl:choose>
 		<xsl:when test="@id">
 			<xsl:value-of select="@id"/>
	 	</xsl:when>
 		<xsl:when test="@xml:id">
 			<xsl:value-of select="@xml:id"/>
 		</xsl:when>
 		<xsl:otherwise/>
 	</xsl:choose>
 </xsl:variable>

 <!-- Make sure there is a page number to show and that the page image matches the current volume being viewed (so page numbers don't show when viewing an encyclopedia entry from within a book) -->
 <xsl:if test="@n and (substring-before($this.image.id,'-') = substring-before($pageImageId,'-'))">
  <xsl:choose>
  	<xsl:when test="(preceding-sibling::lg or following-sibling::lg) and ancestor::q">
  		<p class="pbRight"><a id="{@*:id}"></a>
      	page: <xsl:value-of select="@n"/> 
      	<xsl:if test="$doc.view!='print' and $hasPageImage = 'yes'">
      		<span class="pageImageLink"><a href="javascript:showPageImage('{$pageImageBrand}', '{$pageImageId}');" title="[View Page Image]" class="run-head" aria-controls="showPageImage-{$pageImageId}" id="view-{$pageImageId}">[View Page <xsl:value-of select="@n"/>]</a> </span>
      		<span id="showPageImage-{$pageImageId}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
      		<a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageImageId}" class="left">Switch to Image Mode</a>
     		<a href="javascript:closePageImage('{$pageImageId}');" aria-controls="showPageImage-{$pageImageId}">CLOSE  X</a>
	       <img src="" id="overlay-{$pageImageId}" class="overlay" style="display:none;" alt="Page {@n}"/>
    		</span>
      	</xsl:if>
      	</p>
  	</xsl:when>
  	<xsl:when test="ancestor::lg or parent::list">
  		<li class="pbRight"><a id="{@*:id}"></a>
      	page: <xsl:value-of select="@n"/> 
      	<xsl:if test="$doc.view!='print' and $hasPageImage = 'yes'">
      		<span class="pageImageLink"><a href="javascript:showPageImage('{$pageImageBrand}', '{$pageImageId}');" title="[View Page Image]" class="run-head" aria-controls="showPageImage-{$pageImageId}" id="view-{$pageImageId}">[View Page <xsl:value-of select="@n"/>]</a> </span>
      		<span id="showPageImage-{$pageImageId}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
      		<a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageImageId}" class="left">Switch to Image Mode</a>
     		<a href="javascript:closePageImage('{$pageImageId}');" aria-controls="showPageImage-{$pageImageId}">CLOSE Page <xsl:value-of select="@n"/></a>
	       <img src="" id="overlay-{$pageImageId}" class="overlay" style="display:none;" alt="Page {@n}"/>
    		</span>
      	</xsl:if>
      	</li>
  	</xsl:when>
  	<xsl:when test="ancestor::floatingText or (ancestor::q and not(ancestor::p))">
  		<xsl:if test="parent::p">
  			<xsl:text disable-output-escaping='yes'> <![CDATA[</p>]]></xsl:text>
  		</xsl:if>
  		<xsl:if test="(ancestor::q and (ancestor::floatingText or ancestor::lg)) and not(preceding-sibling::l or following-sibling::l)">
	  		<xsl:text disable-output-escaping='yes'> <![CDATA[</blockquote>]]></xsl:text>
	  	</xsl:if>
  		<span class="pbRight"><!--&#x2015;-->
      	<a id="{@*:id}"></a>
      	page: <xsl:value-of select="@n"/> 
      	<xsl:if test="$doc.view!='print' and $hasPageImage = 'yes'">
      		<span class="pageImageLink"><a href="javascript:showPageImage('{$pageImageBrand}', '{$pageImageId}');" title="[View Page Image]" class="run-head" aria-controls="showPageImage-{$pageImageId}" id="view-{$pageImageId}">[View Page <xsl:value-of select="@n"/>]</a> </span>
      		<span id="showPageImage-{$pageImageId}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
      		<a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageImageId}" class="left">Switch to Image Mode</a>
     		<a href="javascript:closePageImage('{$pageImageId}');" aria-controls="showPageImage-{$pageImageId}">CLOSE Page <xsl:value-of select="@n"/></a>
	       <img src="" id="overlay-{$pageImageId}" class="overlay" style="display:none;" alt="Page {@n}"/>
    		</span>
      	</xsl:if><!--[ <a href="http://purl.dlib.indiana.edu/iudl/imh/{substring(@id, 0, 8)}?pn={substring(@id, 9)}" title="[View Page Image]" class="run-head"> View Page Image </a> ]-->
      	</span>
      	<xsl:if test="(ancestor::q and (ancestor::floatingText or ancestor::lg)) and not(preceding-sibling::l or following-sibling::l)">
	      	<xsl:text disable-output-escaping='yes'> <![CDATA[<blockquote>]]></xsl:text>
	    </xsl:if>
      	<xsl:if test="parent::p">
  			<xsl:text disable-output-escaping='yes'> <![CDATA[<p>]]></xsl:text>
  		</xsl:if>
  		<xsl:if test="ancestor::q[@rend='blockquote'] and not(following-sibling::*)">
  			<xsl:text disable-output-escaping='yes'> <![CDATA[<span class="blockquote">]]></xsl:text>
  		</xsl:if>
  	</xsl:when>
  	<xsl:when test="preceding-sibling::row">
  		<xsl:text disable-output-escaping='yes'> <![CDATA[</table>]]></xsl:text>
  		<span class="pbRight">
      	<a id="{@*:id}"></a>
      	page: <xsl:value-of select="@n"/> 
      	<xsl:if test="$doc.view!='print' and $hasPageImage = 'yes'">
      		<span class="pageImageLink"><a href="javascript:showPageImage('{$pageImageBrand}', '{$pageImageId}');" title="[View Page Image]" class="run-head" aria-controls="showPageImage-{$pageImageId}" id="view-{$pageImageId}">[View Page <xsl:value-of select="@n"/>]</a> </span>
      		<span id="showPageImage-{$pageImageId}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
      		<a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageImageId}" class="left">Switch to Image Mode</a>
     		<a href="javascript:closePageImage('{$pageImageId}');" aria-controls="showPageImage-{$pageImageId}">CLOSE Page <xsl:value-of select="@n"/></a>
	       <img src="" id="overlay-{$pageImageId}" class="overlay" style="display:none;" alt="Page {@n}"/>
    		</span>
      	</xsl:if>
      	</span>
      	<xsl:text disable-output-escaping='yes'> <![CDATA[<table>]]></xsl:text>
  	</xsl:when>
    <xsl:when test="parent::row">
      <a id="{@*:id}"></a>
    	<xsl:element name="td">
    		<xsl:text>&#160;</xsl:text>
    	</xsl:element>
    	<xsl:element name="tr">
    		<xsl:element name="td">
    			<xsl:attribute name="class">tablePB</xsl:attribute>
<!--    			page: <xsl:value-of select="@n"/> [<a href="http://purl.dlib.indiana.edu/iudl/imh/{substring(@id, 0, 8)}?pn={substring(@id, 9)}" title="[View Page Image]" class="run-head">View Page Image</a>]-->
    		  page: <xsl:value-of select="@n"/> 
    		  <xsl:if test="$doc.view!='print' and $hasPageImage = 'yes'">
    		  	<span class="pageImageLink"><a href="javascript:showPageImage('{$pageImageBrand}', '{$pageImageId}');" title="[View Page Image]" class="run-head" aria-controls="showPageImage-{$pageImageId}" id="view-{$pageImageId}">[View Page <xsl:value-of select="@n"/>]</a></span>
    		  	<span id="showPageImage-{$pageImageId}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
    		  	<a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageImageId}" class="left">Switch to Image Mode</a>
     			<a href="javascript:closePageImage('{$pageImageId}');" aria-controls="showPageImage-{$pageImageId}">CLOSE Page <xsl:value-of select="@n"/></a>
	       		<img src="" id="overlay-{$pageImageId}" class="overlay" style="display:none;" alt="Page {@n}"/>
    			</span>
    		  </xsl:if>
    		</xsl:element>
    	</xsl:element>
    </xsl:when>
    <!-- xsl:when test="not(following-sibling::*)"/ -->
    <xsl:when test="$anchor.id=@id">
      <!-- hr class="pb"/ -->
      <span class="pbRight"><!--&#x2015;-->
      	<hr/>
      	<xsl:if test="parent::row">
      		<xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
      	</xsl:if>
      <a id="{@*:id}"></a>
        page: <xsl:value-of select="@n"/> 
        <xsl:if test="$doc.view!='print' and $hasPageImage = 'yes'">
        	<span class="pageImageLink"><a href="javascript:showPageImage('{$pageImageBrand}', '{$pageImageId}');" title="[View Page Image]" class="run-head" aria-controls="showPageImage-{$pageImageId}" id="view-{$pageImageId}">[View Page <xsl:value-of select="@n"/>]</a></span>
        	<span id="showPageImage-{$pageImageId}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
        	<a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageImageId}" class="left">Switch to Image Mode</a>
     		<a href="javascript:closePageImage('{$pageImageId}');" aria-controls="showPageImage-{$pageImageId}">CLOSE Page <xsl:value-of select="@n"/></a>
	       <img src="" id="overlay-{$pageImageId}" class="overlay" style="display:none;" alt="Page {@n}"/>
    		</span>
        </xsl:if>
<!--      page: <xsl:value-of select="@n"/> [<a href="http://purl.dlib.indiana.edu/iudl/imh/{substring(@id, 0, 8)}?pn={substring(@id, 9)}" title="[View Page Image]" class="run-head">View Page Image</a>]-->
      </span>
    </xsl:when>
    <xsl:when test="preceding-sibling::item/parent::list or preceding-sibling::l/parent::lg or preceding-sibling::bibl/parent::listBible or following-sibling::item/parent::list or following-sibling::l/parent::lg or following-sibling::lg/parent::lg or following-sibling::bibl/parent::listBibl">
    	<li>
    		<span class="pbRight">
    			<a id="{@*:id}"></a>
    		  page: <xsl:value-of select="@n"/> 
    		  <xsl:if test="$doc.view!='print' and $hasPageImage = 'yes'">
    		  	<span class="pageImageLink"><a href="javascript:showPageImage('{$pageImageBrand}', '{$pageImageId}');" title="[View Page Image]" class="run-head" aria-controls="showPageImage-{$pageImageId}" id="view-{$pageImageId}">[View Page <xsl:value-of select="@n"/>]</a></span>
    		  	<span id="showPageImage-{$pageImageId}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
    		  	<a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageImageId}" class="left">Switch to Image Mode</a>
     			<a href="javascript:closePageImage('{$pageImageId}');" aria-controls="showPageImage-{$pageImageId}">CLOSE Page <xsl:value-of select="@n"/></a>
	       		<img src="" id="overlay-{$pageImageId}" class="overlay" style="display:none;" alt="Page {@n}"/>
    			</span>
    		  </xsl:if>
<!--      page: <xsl:value-of select="@n"/> [<a href="http://purl.dlib.indiana.edu/iudl/imh/{substring(@id, 0, 8)}?pn={substring(@id, 9)}" title="[View Page Image]" class="run-head">View Page Image</a>]-->
     		</span>
    	</li>
    </xsl:when>
    <xsl:otherwise>
      <!-- hr class="pb"/ -->
      <span class="pbRight"><!--&#x2015;-->
      	<xsl:if test="parent::row">
      		<xsl:text disable-output-escaping='yes'><![CDATA[<br/>]]></xsl:text>
      	</xsl:if>
      <a id="{@*:id}"></a>
        page: <xsl:value-of select="@n"/> 
        <xsl:if test="$doc.view!='print' and $hasPageImage = 'yes'">
        	<span class="pageImageLink"><a href="javascript:showPageImage('{$pageImageBrand}', '{$pageImageId}');" title="[View Page Image]" class="run-head" aria-controls="showPageImage-{$pageImageId}" id="view-{$pageImageId}">[View Page <xsl:value-of select="@n"/>]</a></span>
        	<span id="showPageImage-{$pageImageId}" class="showPageImage" style="display:none;position:absolute;" aria-expanded="false">
        	<a href="{$doc.path}&amp;brand={$brand}&amp;doc.view=pagedImage&amp;image.id={$pageImageId}" class="left">Switch to Image Mode</a>
     		<a href="javascript:closePageImage('{$pageImageId}');" aria-controls="showPageImage-{$pageImageId}">CLOSE Page <xsl:value-of select="@n"/></a>
	       <img src="" id="overlay-{$pageImageId}" class="overlay" style="display:none;" alt="Page {@n}"/>
    		</span>
        </xsl:if>
<!--      page: <xsl:value-of select="@n"/> [<a href="http://purl.dlib.indiana.edu/iudl/imh/{substring(@id, 0, 8)}?pn={substring(@id, 9)}" title="[View Page Image]" class="run-head">View Page Image</a>]-->
      </span>
    </xsl:otherwise>
  </xsl:choose>
 </xsl:if>
</xsl:template>

<xsl:template match="closer">
	<xsl:choose>
		<xsl:when test="ancestor::lg">
			<li class="center"><xsl:apply-templates/></li>
		</xsl:when>
		<xsl:when test="ancestor::p">
			<span class="center"><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:otherwise>
			<p class="center"><xsl:apply-templates/></p>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="trailer">
	<hr/>
	<p class="center"><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="milestone">

  <xsl:if test="$anchor.id=@id">
    <a id="X"></a>
  </xsl:if>

  <xsl:if test="@rend='ornament' or @rend='ornamental_break'">
    <div class="center">
      <div class="ornament">
      	&#x2022; &#x2022; &#x2022;
      </div>
    </div>
  </xsl:if>
  
  <xsl:if test="@n">
  	<xsl:variable name="milestonerend">
  		<xsl:choose>
  			<xsl:when test="@rend">
  				<xsl:value-of select="@rend"/>
  			</xsl:when>
  			<xsl:otherwise>
  				center
  			</xsl:otherwise>
  		</xsl:choose>
  	</xsl:variable>
  	<xsl:choose>
  		<xsl:when test="ancestor::lg">
  			<li class="{$milestonerend}"><xsl:value-of select="@n"/></li>
  		</xsl:when>
  		<xsl:otherwise>
		  	<p class="{$milestonerend}"><xsl:value-of select="@n"/></p>
		</xsl:otherwise>
  	</xsl:choose>
  </xsl:if>

</xsl:template>

<xsl:template name="getRefChunk">
  
  <xsl:param name="refId"/>
  
  <xsl:variable name="cleanRefLink">
       <xsl:value-of select="replace($refId,'#','')"/>
  </xsl:variable>

    <xsl:choose>
      <xsl:when test="key('pb-id', $cleanRefLink)/ancestor::*[matches(local-name(), '^div')]">
        <xsl:value-of select="key('pb-id', $cleanRefLink)/ancestor::*[matches(local-name(), '^div')][1]/@*:id"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="key('pb-id', $cleanRefLink)/following-sibling::*[matches(local-name(), '^div')]">
          <xsl:value-of select="key('pb-id', $cleanRefLink)/following-sibling::*[matches(local-name(), '^div')][1]/@*:id"/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  
</xsl:template>

</xsl:stylesheet>
