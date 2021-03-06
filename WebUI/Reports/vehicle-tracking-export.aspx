﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vehicle-tracking-export.aspx.cs" Inherits="Orchestrator.WebUI.Reports.vehicle_tracking_export" MasterPageFile="~/default_tableless.Master" Title="Vehicle Tracking Export" %>
<%@ Register TagPrefix="uc1" TagName="ReportViewer" Src="~/UserControls/ReportViewer.ascx" %>
<%@ Register TagPrefix="nfvc" Namespace="P1TP.Components.Web.Validation" Assembly="P1TP.Components"%>
<%@ Register TagPrefix="cc3" Namespace="P1TP.Components.Web.UI" Assembly="P1TP.Components" %>



<asp:Content ContentPlaceHolderID="HeaderPlaceHolder1" runat="server"><h1>Pricing Report</h1></asp:Content>

<asp:Content ContentPlaceHolderID="Header" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script language="javascript" type="text/javascript">
    function FilterOptionsDisplayShow() {
        $("#overlayedClearFilterBox").css({ 'display': 'block' });
        $("#filterOptionsDiv").css({ 'display': 'none' });
        $("#filterOptionsDivHide").css({ 'display': 'block' });
        var fr = document.getElementById("overlayedIframe");
        fr.style.display = "block";
    }

    function FilterOptionsDisplayHide() {
        $("#overlayedClearFilterBox").css({ 'display': 'none' });
        $("#filterOptionsDivHide").css({ 'display': 'none' });
        $("#filterOptionsDiv").css({ 'display': 'block' });
        var fr = document.getElementById("overlayedIframe");
        fr.style.display = "none";

    }

    $(document).ready(function () {
        var width = $("#overlayedClearFilterBox").width();
        var height = $("#overlayedClearFilterBox").height();
        var position = $("#overlayedClearFilterBox").position();
        $("#overlayedIframe").css("width", width);
        $("#overlayedIframe").css("height", height + 25);
        $("#overlayedIframe").css("top", position.top);
        $("#overlayedIframe").css("left", position.left);
        FilterOptionsDisplayHide();
    });
  
    /*Fix that allows menu bars to overlay reports when using Adobe PDF plugin for Google Chrome */
    window.onload = function () {
        changeIframeToObject();
    }

    function changeIframeToObject() {
        $("iframe[src*=\"/Reports\"]").replaceWith("<object data=\"/Reports/ActiveReportPdf.ashx\" type=\"application/pdf\" width=\"100%\" height=\"1000\" style=\"z-index: 1;\"></object>")
    }

    Telerik.Web.UI.Overlay.IsSupported = function () {
        return true;
    }
</script>
            <div class="ToolbarBlue" style="height: 24px; padding: 1px 1px 1px 3px; background-position: top;">
		    <div class="overlayedFilterIconOff" id="filterOptionsDiv" onclick="FilterOptionsDisplayShow()" style="display: block;">Show filter Options</div>
		    <div class="overlayedFilterIconOn" id="filterOptionsDivHide" onclick="FilterOptionsDisplayHide()">Close filter Options</div>
            		<input type="reset" value="Reset">
		<nfvc:NoFormValButton id="btnExportToCSV" runat="server" text="Export To CSV"></nfvc:NoFormValButton>
	    </div>
        <!--Hidden Filter Options-->
        <iframe id="overlayedIframe" style="position: absolute; z-index: 95; background:white;"></iframe>
        <div class="overlayedFilterBox" id="overlayedClearFilterBox" style="display: block;">
	
            <fieldset>
		        <legend>Filter Options</legend>
		        <table>
			        <tr>
				        <td class="formCellLabel">Vehicle</td>
				        <td class="formCellField" colspan="2">
                            <asp:DropDownList ID="ddlVehicle" runat="server">
                            </asp:DropDownList>
				        </td>
			        </tr>
			        <tr>
				        <td class="formCellLabel">Start Date</td>
				        <td class="formCellField"> 
					        <telerik:RadDatePicker id="dteStartDate" Width="100" runat="server">
                            <DateInput runat="server"
                             dateformat="dd/MM/yy">
                             </DateInput>
                            </telerik:RadDatePicker>
				        </td>
				        <td class="formCellField">	
					        <asp:RequiredFieldValidator id="rfvDateFrom" runat="server" Display="Dynamic" ControlToValidate="dteStartDate"
						        ErrorMessage="Please enter the start date. ">
						        <img src="../images/Error.gif" height='16' width='16' title='Please enter the start date.'></asp:RequiredFieldValidator>
					        <asp:CustomValidator id="cfvStartDate" runat="server" OnServerValidate="cfvStartDate_ServerValidate" ControlToValidate="dteStartDate" ErrorMessage="The start date must be before the end date."><img src="../images/Error.gif" height="16" width="16" title="The start date must be before the end date." /></asp:CustomValidator>		
				        </td>
			        </tr>
			        <tr>
				        <td class="formCellLabel">End Date</td>
				        <td class="formCellField"> 
					        <telerik:RadDatePicker id="dteEndDate" Width="100" runat="server">
                            <DateInput runat="server"
                            dateformat="dd/MM/yy">
                            </DateInput>
                            </telerik:RadDatePicker>
				        </td>
				        <td class="formCellField">
					        <asp:RequiredFieldValidator id="rfvDateTo" runat="server" Display="Dynamic" ControlToValidate="dteEndDate" ErrorMessage="Please enter the end date.">
						        <img src="../images/Error.gif" height='16' width='16' title='Please enter the end date.'></asp:RequiredFieldValidator>
				        </td>
			        </tr>
		        </table>
	        </fieldset>
<%--    	    <div class="buttonbar">
    		    <nfvc:NoFormValButton id="btnGenerate" runat="server" text="Generate Report"></nfvc:NoFormValButton>
	        </div>--%>
    	</div>


	<table>
		<tr>
			<td align="center">
				<asp:Label id="lblError" cssclass="ControlErrorMessage" visible="True" runat="server"/>
			</td>
		</tr>
	</table>
	
	<uc1:ReportViewer id="reportViewer" runat="server" Visible="False" ViewerWidth="100%" ViewerHeight="800"></uc1:ReportViewer>
</asp:Content>