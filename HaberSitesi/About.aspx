<%@ Page Title="About" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="HaberSitesi.About" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<div class="box">
		<div class="headingTxt">
			<asp:Label ID="LblAbout" runat="server" Text="About WorldsNewsPoint.com"></asp:Label>
		</div><br />
		<p>
			<asp:Literal ID="Literal1" runat="server">
				Welcome to the world's news point!<br />
				here is the news website anyone can easily use from all around the world,<br />
				people can customize their own news stream here,<br />
				there are more new features waits to be discovered in this website.<br />
			</asp:Literal>
		</p>
	</div>
</asp:Content>
