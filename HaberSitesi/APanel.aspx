<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="APanel.aspx.cs" Inherits="HaberSitesi.APanel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="css/apanel.css" />
    <title>Admin Panel</title>
</head>
<body>
    <form id="form1" runat="server">	
	<header>
		<asp:Image ID="ImgBtnLogo" CssClass="logo" ImageUrl="images/logo.png" runat="server"/>
	</header>
    <div id="box">
		<!-- İLK MULTİVİEW SADECE GİRİŞ YAPMA KISMI VE 2.MULTIVIEWI DEĞİŞTİREN BUTONLARDAN OLUŞUYOR-->
		<asp:MultiView ID="MultiView1" runat="server">
			<asp:View ID="View1" runat="server">
				<h3>Admin Login</h3>
				<asp:Label ID="Lblusrname" runat="server" Text="Username:"></asp:Label><br />
				<asp:TextBox ID="txtusername" runat="server" ToolTip="username"></asp:TextBox><br /><br />
				<asp:Label ID="Lblpass" runat="server" Text="Password:"></asp:Label><br />
				<asp:TextBox ID="txtPassword" runat="server" ToolTip="password" TextMode="Password"></asp:TextBox><br /><br />
				<asp:Button ID="BtnLogin" runat="server" Text="Login" OnClick="BtnLogin_Click"/>
			</asp:View>
			<asp:View ID="View2" runat="server">
				<asp:Button ID="BtnMain" runat="server" Text="Main" OnClick="BtnMain_Click"/>
				<asp:Button ID="BtnMessages" runat="server" Text="Messages" OnClick="BtnMessages_Click"/>
				<asp:Button ID="BtnEditors" runat="server" Text="Editors" OnClick="BtnEditors_Click"/>
				<asp:Button ID="BtnUsers" runat="server" Text="Users" OnClick="BtnUsers_Click"/>
				<asp:Button ID="BtnLogout" runat="server" Text="Logout" OnClick="BtnLogout_Click"/> 
			</asp:View>
		</asp:MultiView><br />
		<!--BU MULTIVIEWDA ADMIN FONKSİYONLARI ÇALIŞIYOR-->
		<asp:MultiView ID="MultiView2" runat="server">
			<asp:View ID="ViewMain" runat="server">
				<h3>Change your username</h3>
				<asp:Label ID="LblNewusr" runat="server" Text="new username:"></asp:Label><br />
				<asp:TextBox ID="TxtNewusr" runat="server"></asp:TextBox><br />
				<h3>Change your password</h3>
				<asp:Label ID="LblCurrentPass" runat="server" Text="current password:"></asp:Label><br />
				<asp:TextBox ID="TxtCurrentPass" runat="server" TextMode="Password"></asp:TextBox><br />
				<asp:Label ID="LblNewPass1" runat="server" Text="new password:"></asp:Label><br />
				<asp:TextBox ID="TxtNewPass" runat="server" TextMode="Password"></asp:TextBox><br />
				<asp:Label ID="LblNewPass2" runat="server" Text="new password again:"></asp:Label><br />
				<asp:TextBox ID="TxtNewPass2" runat="server" TextMode="Password"></asp:TextBox><br /><br />
				<asp:Button ID="BtnSaveAdmin" runat="server" Text="Save" OnClick="BtnSaveAdmin_Click"/>
			</asp:View>
			<asp:View ID="ViewMessages" runat="server">
				<h3>Messages From Users</h3>
				<asp:Repeater ID="RepeaterMessages" runat="server">
					<ItemTemplate>
						<asp:Label ID="LblUserName" runat="server" Text='<%#Eval("usrname")%>'></asp:Label><br />
						<asp:Label ID="LblMessage" runat="server" Text='<%#Eval("msg") %>'></asp:Label><br /><hr /><br />
					</ItemTemplate>
				</asp:Repeater>
				<h3>Other Messages</h3>
				<asp:Repeater ID="RepeaterOtherMsg" runat="server">
					<ItemTemplate>
						<asp:Label ID="LblName" runat="server" Text='<%#Eval("nm") %>'></asp:Label> 
						<asp:Label ID="LblSname" runat="server" Text='<%#Eval("srname") %>'></asp:Label><br />
						<asp:Label ID="LblMail" runat="server" Text='<%#Eval("email") %>'></asp:Label><br />
						<asp:Label ID="LblMsg" runat="server" Text='<%#Eval("msg") %>'></asp:Label><br /><hr /><br />
					</ItemTemplate>
				</asp:Repeater>
			</asp:View>
			<asp:View ID="ViewEditors" runat="server">
				<h3>Editors</h3>
				<asp:Repeater ID="RepeaterEditors" runat="server">
					<ItemTemplate>
						<asp:Label ID="LblEditor" runat="server" Text='<%#Eval("usrname") %>'></asp:Label><br /><hr />
					</ItemTemplate>
				</asp:Repeater>
				<h3>Editor Requests</h3>
				<asp:Repeater ID="RepeaterRequests" runat="server">
					<ItemTemplate>
						<asp:Label ID="LblEditorReq" runat="server" Text='<%#Eval("usrname") %>'></asp:Label><br /><hr />
					</ItemTemplate>
				</asp:Repeater><br />
				<h3>Add Editor</h3>
				<asp:Label ID="LblAddEdt" runat="server" Text="username:"></asp:Label><br />
				<asp:TextBox ID="TxtAddEdt" runat="server"></asp:TextBox><br /><br />
				<asp:Button ID="BtnAddEdt" runat="server" Text="Add" OnClick="BtnAddEdt_Click"/><br />
				<h3>Remove Editor</h3>
				<asp:Label ID="LblRemoveEdt" runat="server" Text="username:"></asp:Label><br />
				<asp:TextBox ID="TxtRemoveEdt" runat="server"></asp:TextBox><br /><br />
				<asp:Button ID="BtnRemoveEdt" runat="server" Text="Remove" OnClick="BtnRemoveEdt_Click"/>
			</asp:View>
			<asp:View ID="ViewUsers" runat="server">
				<h3>Search and Find Users</h3>
				<asp:Label ID="LblSrc" runat="server" Text="Type here:"></asp:Label><br />
				<asp:TextBox ID="TxtSrcUsr" runat="server"></asp:TextBox>
				<asp:Button ID="BtnSrcUsr" runat="server" Text="Search" OnClick="BtnSrcUsr_Click"/><br /><hr />
				<asp:Repeater ID="RepeaterSrcUsr" runat="server">
					<HeaderTemplate>
						<asp:Label ID="Lbl1" Font-Size="Large" runat="server" Text="Usernames Found:"></asp:Label><br /><hr /></HeaderTemplate>
					<ItemTemplate>
						<asp:Label ID="lblUsrName" runat="server" Text='<%#Eval("usrname") %>'></asp:Label><br /><hr />
					</ItemTemplate>
				</asp:Repeater>
				<h3>Block a User</h3>
				<asp:Label ID="LblBlock" runat="server" Text="username:"></asp:Label><br />
				<asp:TextBox ID="TxtBlock" runat="server"></asp:TextBox>
				<asp:Button ID="BtnBlock" runat="server" Text="Block" OnClick="BtnBlock_Click" /><br />
				<h3>Remove Blockage</h3>
				<asp:Label ID="LblRBlock" runat="server" Text="username:"></asp:Label><br />
				<asp:TextBox ID="TxtRBlock" runat="server"></asp:TextBox>
				<asp:Button ID="BtnRBlock" runat="server" Text="Remove" OnClick="BtnRBlock_Click"/><br />
			</asp:View>
		</asp:MultiView>
    </div>
    </form>
</body>
</html>
