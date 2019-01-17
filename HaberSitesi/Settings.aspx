<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="HaberSitesi.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<div class="box">
		<div class="headingTxt">
			<asp:Label ID="LblHeading" runat="server" Text="Settings"></asp:Label>
		</div><br />
		<p>
			<asp:Panel ID="Panel1" runat="server" DefaultButton="BtnSave">
			<asp:Label ID="LblLangs" runat="server" Text="Show news in these languages:"></asp:Label><br /><br />
			<asp:CheckBoxList ID="CheckBoxListLang" runat="server" RepeatDirection="Vertical" RepeatLayout="Flow">
				<asp:ListItem Text="English"></asp:ListItem>
				<asp:ListItem Text="Turkish"></asp:ListItem>
				<asp:ListItem Text="French"></asp:ListItem>
			</asp:CheckBoxList><br /><br />
			<asp:Label ID="LblCats" runat="server" Text="Show news in these categories:"></asp:Label><br /><br />
			<asp:CheckBoxList ID="CheckBoxListCat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
				<asp:ListItem Text="World"></asp:ListItem>
				<asp:ListItem Text="Business"></asp:ListItem>
				<asp:ListItem Text="Technology"></asp:ListItem>
				<asp:ListItem Text="Science"></asp:ListItem>
				<asp:ListItem Text="Health"></asp:ListItem>
				<asp:ListItem Text="Video"></asp:ListItem>
				<asp:ListItem Text="Sport"></asp:ListItem>
			</asp:CheckBoxList><br /><br />
			<asp:Label ID="LblCngPass" runat="server" Text="Change password:<br /> (leave blank if you won't change):"></asp:Label><br /><br />
			<asp:Label ID="LblPass" runat="server" Text="Current Password:"></asp:Label><br />
			<asp:TextBox ID="TxtCrPass" runat="server" TextMode="Password"></asp:TextBox><br />
			<asp:Label ID="LblNpass" runat="server" Text="New Password:"></asp:Label><br />
			<asp:TextBox ID="TxtNPass" runat="server" TextMode="Password"></asp:TextBox><br />
			<asp:Label ID="LblNPass2" runat="server" Text="New Password Again:"></asp:Label><br />
			<asp:TextBox ID="TxtNPass2" runat="server" TextMode="Password"></asp:TextBox><br /><br />
			<asp:Button ID="BtnSave" runat="server" Text="Save" OnClick="BtnSave_Click"/>
			</asp:Panel>
		</p>
	</div>
</asp:Content>
