<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HaberSitesi.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
    <title>Default - World's News Point</title>
	<link rel="stylesheet" type="text/css" href="css/default.css" />
</head>
<body>
    <form id="form1" runat="server">
		<header>
			<asp:ImageButton ID="ImageBtnLogo" CssClass="logo" ImageUrl="images/logo.png" OnClick="ImageBtnLogo_Click" runat="server" />
		</header>
		<div class="box">
			<asp:Panel ID="Panel1" runat="server" DefaultButton="BtnSignUp">
			<h3>Sign up for customizable news stream</h3>
			<asp:Label ID="LblSemail" runat="server" Text="Email:"></asp:Label><br />
			<asp:TextBox ID="txtSEmail" runat="server" ToolTip="email" TextMode="Email"></asp:TextBox><br /><br />
			<asp:Label ID="LblSusrname" runat="server" Text="Username:"></asp:Label><br />
			<asp:TextBox ID="txtSUsername" runat="server" ToolTip="username"></asp:TextBox><br /><br />
			<asp:Label ID="LblSpass" runat="server" Text="Password:"></asp:Label><br />
			<asp:TextBox ID="txtSPassword" runat="server" ToolTip="password" TextMode="Password"></asp:TextBox><br /><br />
			<asp:Button ID="BtnSignUp" runat="server" Text="Sign Up" OnClick="BtnSignUp_Click" />
			</asp:Panel>
		</div>
		<div class="box">
			<asp:Panel ID="Panel2" runat="server" DefaultButton="Button1">
			<h3>Enter the site without an account</h3>
			<asp:DropDownList ID="DropDownList1" runat="server">
				<asp:ListItem>English</asp:ListItem>
				<asp:ListItem>Turkish</asp:ListItem>
				<asp:ListItem>French</asp:ListItem>
			</asp:DropDownList><br /><br />
			<asp:Button ID="Button1" runat="server" Text="Enter the site" OnClick="Button1_Click"/><br />
			</asp:Panel>
		</div>
		<div class="box">
			<asp:Panel ID="Panel3" runat="server" DefaultButton="BtnLogin">
			<h3>Do you have an account?</h3>
			<asp:Label ID="LblLusrname" runat="server" Text="Username:"></asp:Label><br />
			<asp:TextBox ID="txtLusername" runat="server" ToolTip="username"></asp:TextBox><br /><br />
			<asp:Label ID="LblLpass" runat="server" Text="Password:"></asp:Label><br />
			<asp:TextBox ID="txtLPassword" runat="server" ToolTip="password" TextMode="Password"></asp:TextBox><br /><br />
			<asp:Button ID="BtnLogin" runat="server" Text="Login" OnClick="BtnLogin_Click"/>
			</asp:Panel>
		</div>
    </form>
</body>
</html>
