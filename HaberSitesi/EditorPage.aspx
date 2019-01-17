<%@ Page Title="Editor Page" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EditorPage.aspx.cs" Inherits="HaberSitesi.EditorPage" UnobtrusiveValidationMode="None" ValidateRequest="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	
<!--HABER EKLEME SAYFASI-->
	<div class="box">
		<div class="headingTxt">
			<asp:Label ID="LblEditorHeading" runat="server" Text="Add News"></asp:Label>
		</div><br />
		<p>
			<asp:Panel ID="Panel1" runat="server" DefaultButton="BtnAdd">
			<asp:Label ID="LblHeading" runat="server" Text="Heading: (70 characters)"></asp:Label><br />
			<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="You can't leave here blank" ControlToValidate="TxtHeading"></asp:RequiredFieldValidator><br />
			<asp:TextBox ID="TxtHeading" runat="server" Width="500px" Text=">"></asp:TextBox><br />
			<asp:Label ID="LblDesc" runat="server" Text="Description: (500 characters)"></asp:Label><br />
			<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="You can't leave here  blank" ControlToValidate="TxtDesc"></asp:RequiredFieldValidator><br />
			<asp:TextBox ID="TxtDesc" runat="server"  Width="500px" Columns="3" Text=">" TextMode="MultiLine"></asp:TextBox><br />
			<asp:Label ID="LblContent" runat="server" Text="Content: (8000 characters)"></asp:Label><br />
			<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="You can't leave here blank" ControlToValidate="TxtContent"></asp:RequiredFieldValidator><br />
			<asp:TextBox ID="TxtContent" runat="server" TextMode="MultiLine" Text=">" Width="500px" Height="300px"></asp:TextBox><br />
			<asp:Label ID="LblUrl" runat="server" Text="Image Url: (250 characters)"></asp:Label><br />
			<asp:TextBox ID="TxtUrl" runat="server" TextMode="Url" Width="500px" Text=""></asp:TextBox><br />
			<asp:Label ID="LblCat" runat="server" Text="Category:"></asp:Label><br />
			<asp:DropDownList ID="DropDownCat" runat="server">
				<asp:ListItem>World</asp:ListItem>
				<asp:ListItem>Business</asp:ListItem>
				<asp:ListItem>Technology</asp:ListItem>
				<asp:ListItem>Science</asp:ListItem>
				<asp:ListItem>Health</asp:ListItem>
				<asp:ListItem>Video</asp:ListItem>
				<asp:ListItem>Sport</asp:ListItem>
			</asp:DropDownList><br />
			<asp:Label ID="LblSource" runat="server" Text="Source:"></asp:Label><br />
			<asp:DropDownList ID="DropDownSource" runat="server">
				<asp:ListItem>AA</asp:ListItem>
				<asp:ListItem>BBC</asp:ListItem>
				<asp:ListItem>CNN</asp:ListItem>
				<asp:ListItem>DHA</asp:ListItem>
				<asp:ListItem>Fanatik</asp:ListItem>
				<asp:ListItem>France24</asp:ListItem>
				<asp:ListItem>The Paris News</asp:ListItem>
			</asp:DropDownList><br />
			<asp:Label ID="LblLang" runat="server" Text="Language:"></asp:Label><br />
			<asp:DropDownList ID="DropDownLang" runat="server">
				<asp:ListItem>English</asp:ListItem>
				<asp:ListItem>Turkish</asp:ListItem>
				<asp:ListItem>French</asp:ListItem>
			</asp:DropDownList><br />
			<asp:Button ID="BtnAdd" runat="server" Text="Add" OnClick="BtnAdd_Click"/>
			</asp:Panel>
		</p>
	</div>
</asp:Content>
