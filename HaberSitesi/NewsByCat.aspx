<%@ Page Title="News by Category" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="NewsByCat.aspx.cs" Inherits="HaberSitesi.NewsByCat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" href="css/newsbycat.css" type="text/css" />	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<asp:Repeater ID="Repeater1" runat="server">
		<ItemTemplate>
			<div class="catBox">
				<asp:HyperLink ID="link" runat="server" NavigateUrl='<%#"~/Read.aspx?nid=" + Eval("nid")%>'>
					<asp:Image ID="imgCatBox" CssClass="catBoxImg" ImageUrl='<%#Eval("imgUrl") %>' runat="server" />
				</asp:HyperLink><br />
				<asp:Label ID="Label1" runat="server" CssClass="lBoxHead catHead" Text='<%#Eval("headln") %>'></asp:Label><br /><br />
				<asp:Label ID="Label2" CssClass="txtDate" runat="server" Text='<%#Eval("tm") %>'></asp:Label> <br /><br />
				<asp:Label ID="Label3" CssClass="catDesc" runat="server" Text='<%#Eval("descr") %>'></asp:Label>
			</div>
		</ItemTemplate>
	</asp:Repeater>
</asp:Content>
