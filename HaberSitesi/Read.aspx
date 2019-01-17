<%@ Page Title="Read" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Read.aspx.cs" Inherits="HaberSitesi.Read" UnobtrusiveValidationMode="None" ValidateRequest="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" type="text/css" href="css/read.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<!--HABER OKUMA KUTUSU-->
	<div id="readNews">
		<div id="headln">
			<asp:Label ID="LblHeadLn" runat="server" Text="HeadLine"></asp:Label>
		</div>
		<div id="tm">
			<asp:Label ID="LblDt" runat="server" Text="2018:10:19 - 10:10:10"></asp:Label>
		</div><br />
		<asp:Image ID="img" Width="100%" runat="server" ImageUrl="#"/><br />
		<div id ="desc"><br />
			<asp:Label ID="lblDesc" runat="server" Text=""></asp:Label>
		</div><br /> <br />
		<div id ="content">
			<asp:Literal ID="LiteralContent" Mode="Transform" runat="server"></asp:Literal>
		</div><br /><br />
		<div id="source">
			<asp:Label ID="LblSource" runat="server" Text="Source: "></asp:Label><asp:Label ID="LblSourceName" runat="server" Text="AA"></asp:Label>
		</div>
		</div>
	<!--YAPILMIŞ YORUMLAR-->
	<div class="comment">
		<div class="heading green">
			<asp:Label ID="LblComments" runat="server" Text="Comments"></asp:Label><br />
		</div>
		<asp:Repeater ID="Repeater1" runat="server">
			<ItemTemplate>
			<div class="avatar">
			<asp:Image ID="Image2" runat="server" Height="80px" Width="80px" ImageUrl="images/no-avatar.jpg"/>
			</div><br />
			<div class="username">
			<asp:Label ID="Label1" runat="server" Width="100px" Text='<%#Eval("usrname") %>'></asp:Label>
			</div><br />
			<div class="commentText">
				<asp:Label ID="LblComment" runat="server" Text='<%#Eval("txt") %>'></asp:Label>
			</div><br />
			<div class="commentDt">
				<asp:Label ID="Label2" runat="server" Text='<%#Eval("tm") %>'></asp:Label>
			</div>
			<hr style="border: 1px dotted gray; margin-bottom: 10px;" />
			</ItemTemplate>
		</asp:Repeater>
	</div>
	<!--YORUM YAPMAK İÇİN-->
	<div class="comment">
		<asp:MultiView ID="MultiViewComments" runat="server">
			<!-- üye girişi yapılmazsa çalışan view-->
			<asp:View ID="View1" runat="server">
				<div id="login">
					<asp:Label ID="LblLogin" runat="server" Text="Please login to write comments"></asp:Label>
				</div>
			</asp:View>
			<!-- üye girişi yapıldıysa çalışan view-->
			<asp:View ID="View2" runat="server">
				<div id="writeComment">
					<div class="heading">
						<asp:Label ID="LblComment" runat="server" Text="Comment"></asp:Label><br />
					</div>
					<asp:Panel ID="Panel1" runat="server" DefaultButton="BtnComment">
						<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtComment" ErrorMessage="You have to write something to comment!" ></asp:RequiredFieldValidator><br />
						<div id="txtComment">
							<asp:TextBox ID="TxtComment" runat="server" Text=">" TextMode="MultiLine" height="50px" width="700px"  MaxLength="400"></asp:TextBox>		
						</div>
						<div id="btnComment">
							<asp:Button ID="BtnComment" runat="server" Text="Comment" OnClick="BtnComment_Click" />
						</div>
					</asp:Panel>
				</div>
			</asp:View>
		</asp:MultiView>
	</div>
</asp:Content>
