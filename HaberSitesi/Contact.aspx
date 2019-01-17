<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="HaberSitesi.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	
<!--CONTACT KUTUSU-->
	<div class="box">
		<div class="headingTxt">
			<asp:Label ID="LblWrite" runat="server" Text="Write a Message"></asp:Label>
		</div><br />
		<p>
			<asp:MultiView ID="MultiView1" runat="server">
				<!-- kullanıcı girişi yapmayanlar bu view'dan mesaj gönderecek -->
				<asp:View ID="notUser" runat="server">
					<asp:Label ID="LblName" runat="server" Text="Name:"></asp:Label><br />
					<asp:TextBox ID="TxtName" runat="server"></asp:TextBox><br />
					<asp:Label ID="LblSname" runat="server" Text="Surname:"></asp:Label><br />
					<asp:TextBox ID="TxtSname" runat="server"></asp:TextBox><br />
					<asp:Label ID="LblMail" runat="server" Text="Email:"></asp:Label><br />
					<asp:TextBox ID="TxtMail" runat="server" TextMode="Email"></asp:TextBox><br />
					<asp:Label ID="LblMsg" runat="server" Text="Message:"></asp:Label><br />
					<asp:TextBox ID="TxtMsg" Rows="10" runat="server" TextMode="MultiLine"></asp:TextBox> <br />
					<asp:Button ID="BtnSend" runat="server" Text="Send" OnClick="BtnSend_Click" />
				</asp:View>
				<!--giriş yapanlar buradan mesaj gönderebilir-->
				<asp:View ID="User" runat="server">
					<asp:Label ID="LblMsg2" runat="server" Text="Message:"></asp:Label><br />
					<asp:TextBox ID="TxtMsg2" Rows="10" runat="server" TextMode="MultiLine"></asp:TextBox> <br />
					<asp:Button ID="BtnSend2" runat="server" Text="Send" OnClick="BtnSend_Click" />
				</asp:View>
			</asp:MultiView>
		</p>
	</div>
</asp:Content>
