<!--  
 VMware Identity Manager SAML Toolkit

Copyright (c) 2016 VMware, Inc. All Rights Reserved.

This product is licensed to you under the BSD-2 license (the "License").  You may not use this product except in compliance with the BSD-2 License.

This product may include a number of subcomponents with separate copyright notices and license terms. Your use of these subcomponents is subject to the terms and conditions of the subcomponent's license, as noted in the LICENSE file.


-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.vmware.eucenablement.saml.sample.MySSO" %>
<%@ page import="com.vmware.samltoolkit.SSOService"%>
<%@ page import="com.vmware.samltoolkit.SAMLToolkitConf"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<!-- header -->
	<jsp:include page="headertpl.html"></jsp:include>
	<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">
		 <!-- Navigation -->
    	<jsp:include page="navtpl.html"></jsp:include>
    	
    	<!-- get related configuration-->
		<%
		String idpDomainURI = request.getParameter("vidmidp");	
		String spIssuer= request.getParameter("issuer");
		String spConsumer = spIssuer + "/consume";
		
		boolean byPassCert = Boolean.valueOf(request.getParameter("byPassCert"));
		SSOService facade = MySSO.initSsoService(idpDomainURI, spConsumer, byPassCert);
		SAMLToolkitConf conf = null;
		if(facade != null) {
			conf = facade.getSAMLToolkitConf();
		}
		%>		
		
    	<section id="ConfigDone" class="content-section text-center" style="height:100%;width:100%;">
        	<div class="ConfigDone-section">
            	<div class="container">
                <div class="col-lg-8 col-lg-offset-2">
					<%if((facade != null) && (conf != null)) {
					%>         
						<div class="jumbotron" style="color:#000" style="padding: 2rem;">
							<p>Congratulations. You are almost ready.</p>
							<p>Please go to your vIDM administration console, and follow this web page to add a new web applciation.</p>
							<p>Click the white arrow button for guidance.</p>
							<p>Click "SINGLE SIGN ON" button if you are ready.</p>
						</div>
								<div class="row">
								 <a href="#ConfigVIDM" class="btn btn-circle page-scroll">
			                            <i class="fa fa-angle-double-down animated"></i>
			                     </a>
	                    	</div>
						
						 <div class="row">
	            <div class="col-xs-6 col-lg-6">	
		          
		              <p><a class="btn btn-default btn-lg" target="_new" href="http://pubs.vmware.com/vidm/topic/com.vmware.vidm_workspace-one.doc/GUID-C1A2F5E4-E117-4CD7-A672-C19040527C4B.html" role="button">vIDM Document >>></a></p>
	          
	            </div>
	            <div class="col-xs-6 col-lg-6" >
		             <form action="ssoLogin.jsp" method="post">
						<p><input type=submit value="Single Sign On >>>" class="btn btn-default btn-lg"></p>
						</form>
	            </div>
	            
	            
	                    	
	           
	          </div><!--/row-->

	    	<div id="signcert" class="modal fade">
		        <div class="modal-dialog" style="boder-color:#fff">
		            <div class="modal-content">
		                <div class="modal-header black-background green-font">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                    <h4 class="modal-title">Signing Certificate</h4>
		                </div>
		                <div class="modal-body black-background">
		                    <div><%=conf.getCertificate()%></div>
		                </div>
		            </div>
		        </div>
		    </div>
						
					<%} else {%>
						<div class="jumbotron" style="color:#000">
				            <h2>Cannot fetch data from Idp Service!</h2>
				            <p>Hints: Bypass certificate validation if vIDM is using self-signed certificate. Check your vIDM URL and vIDM service.</p>
				         </div>
				         <div>
		                	<form action="idpDiscovery.jsp" method="get">
								<div><input type=submit value="<<< Back" class="btn btn-default btn-lg">
								</div>
							</form>
						</div>
					<%} %>
				</div>
				</div>
			</div>
		</section>
		
		<section id="ConfigVIDM" class="content-section text-center" style="height:100%;width:100%;">
				       <div class="row row-offcanvas">
				        <div class="col-xs-12 col-sm-12">
				          <div class="row"> 
				              <p>Step 1: Add A New Application in: <%= idpDomainURI %></p>
				              <p><img src="img/step1.png" > </p>
							
				          </div><!--/row-->
				          
				          
				          <div class="row">
				              <p>Step 2: Give A Name</p>
				              <p><img src="img/step2.png" > </p>
				           
				          </div>
				          
				          <div class="row">
				              <p>Step 3: Select "Manual Configuration", Input Consumer: <%=conf.getConsumerURL() %> </p>
				              <p><img src="img/step3.png" > </p>	            
					       
				          </div>
				          
				          
				          <div class="row">
				              <p>Step 4: Add Automatic Entitlements</p>
				              <p><img src="img/step4.png" > </p>	            
					       
				          </div>
				        </div><!--/.col-xs-12.col-sm-12-->
				      </div>
		</section>
	</body>
</html>