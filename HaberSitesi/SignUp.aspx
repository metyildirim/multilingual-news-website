<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="HaberSitesi.SignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<div class="box">
		<div class="headingTxt">
			<asp:Label ID="LblSignUp" runat="server" Text="Sign Up"></asp:Label>
		</div><br />
		<p>
			<asp:Label ID="LblSemail" runat="server" Text="Email:"></asp:Label><br />
			<asp:TextBox ID="txtSEmail" runat="server" ToolTip="email" TextMode="Email"></asp:TextBox><br />
			<asp:Label ID="LblSusrname" runat="server" Text="Username:"></asp:Label><br />
			<asp:TextBox ID="txtSUsername" runat="server" ToolTip="username"></asp:TextBox><br />
			<asp:Label ID="LblSpass" runat="server" Text="Password:"></asp:Label><br />
			<asp:TextBox ID="txtSPassword" runat="server" ToolTip="password" TextMode="Password"></asp:TextBox><br />
			<asp:Button ID="BtnSignUp" runat="server" Text="Sign Up" OnClick="BtnSignUp_Click"/>
		</p>
	</div>
</asp:Content>
