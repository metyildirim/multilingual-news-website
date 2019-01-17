<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="HaberSitesi.Home"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" href="css/home.css" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!--ANASAYFA SLIDER-->
<div class="slideBox">
		<div class="slideshow-container">
			<asp:Panel ID="panel" runat="server">
		<!--sadece seçili olan dilde haber getiren repeater-->
			<asp:Repeater ID="RepeaterSlider" runat="server">
				<ItemTemplate>
					<div class="mySlides fade">
						<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/Read.aspx?nid=" + Eval("nid") %>'>
							<asp:Image ID="imgSlider" CssClass="img-slider" ImageUrl='<%#Eval("imgUrl") %>' runat="server" />
						</asp:HyperLink>
					<div class="text">
						<asp:Label ID="LabelSlider" runat="server" Text='<%#Eval("headln") %>'></asp:Label>
					</div>
					</div>
				</ItemTemplate>
			</asp:Repeater>
			</asp:Panel>
		</div><br />
		<div style="text-align:center">
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span>
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span>
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span> 
			<span class="dot"></span> 
		</div>
</div>

<!--DÖVİZ KURLARI İÇİN-->
<div class="investing">
		<iframe src="https://tr.widgets.investing.com/live-currency-cross-rates?theme=lightTheme&pairs=1,3,4,66,75,18" width="100%" height="450" frameborder="0" allowtransparency="true" marginwidth="0" marginheight="0"></iframe>
	</div>

<!--WORLD-->
<asp:Panel ID="PnlWorld" runat="server">
	<div class="homeCat">
	<div class="headingTxt tmWorld">
			<asp:Label ID="LblWorld" runat="server" Text="World"></asp:Label>
	</div>
	<div class="leftBox">
		<asp:HyperLink ID="LinkWorld" runat="server" NavigateUrl="#">
			<asp:Image ID="ImgLeftWorld" runat="server" CssClass="imgLeftBox" ImageUrl="#" /> <br /><br />
		</asp:HyperLink>
		<asp:Label ID="LblWorldHl" runat="server" Text="" CssClass="lBoxHead"></asp:Label><br />
		<asp:Label ID="LblWorldDesc" runat="server" Text="" CssClass="lBoxDesc"></asp:Label><br />
		<asp:Label ID="LblWorldDt" runat="server" CssClass="txtDate" Text=""></asp:Label>
	</div>
		<asp:Repeater ID="RepeaterWorld" runat="server">
		<ItemTemplate>
			<div class="newsBox">
				<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%#"~/Read.aspx?nid=" + Eval("nid") %>'>
					<asp:Image ID="Image30" runat="server" CssClass="imgNewsBox" ImageUrl='<%#Eval("imgUrl") %>' />
				</asp:HyperLink>
				<asp:Label ID="Label45" runat="server" CssClass="nBoxHead" Text='<%#Eval("headln") %>'></asp:Label>
			</div>
		</ItemTemplate>
		</asp:Repeater>
</div>
</asp:Panel>
	
<!--BUSINESS-->
<asp:Panel ID="PnlBusiness" runat="server">
<div class="homeCat">
	<div class="headingTxt tmBusiness">
			<asp:Label ID="LblBusiness" runat="server" Text="Business"></asp:Label>
	</div>
		<div class="leftBox">
		<asp:HyperLink ID="LinkBus" runat="server" NavigateUrl="#">
			<asp:Image ID="ImgLeftBus" runat="server" CssClass="imgLeftBox" ImageUrl="#" />
		</asp:HyperLink> <br /><br />
		<asp:Label ID="LblBusHl" runat="server" Text="" CssClass="lBoxHead"></asp:Label><br />
		<asp:Label ID="LblBusDesc" runat="server" Text="" CssClass="lBoxDesc"></asp:Label><br />
		<asp:Label ID="LblBusDt" runat="server" CssClass="txtDate" Text=""></asp:Label>
	</div>
	<asp:Repeater ID="RepeaterBusiness" runat="server">
		<ItemTemplate>
			<div class="newsBox">
				<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%#"~/Read.aspx?nid=" + Eval("nid") %>'>
					<asp:Image ID="Image30" runat="server" CssClass="imgNewsBox" ImageUrl='<%#Eval("imgUrl") %>' />
				</asp:HyperLink>
				<asp:Label ID="Label45" runat="server" CssClass="nBoxHead" Text='<%#Eval("headln") %>'></asp:Label>
			</div>
		</ItemTemplate>
		</asp:Repeater>
</div>
</asp:Panel>
	
<!--TEKNOLOGY-->
<asp:Panel ID="PnlTechnology" runat="server">
<div class="homeCat">
	<div class="headingTxt tmTech">
			<asp:Label ID="LblTech" runat="server" Text="Technology"></asp:Label>
	</div>
	<div class="leftBox">
		<asp:HyperLink ID="LinkTech" runat="server" NavigateUrl="#">
			<asp:Image ID="ImgLeftTech" runat="server" CssClass="imgLeftBox" ImageUrl="#" /> <br /><br />
		</asp:HyperLink>
		<asp:Label ID="LblTechHl" runat="server" Text="" CssClass="lBoxHead"></asp:Label><br />
		<asp:Label ID="LblTechDesc" runat="server" Text="" CssClass="lBoxDesc"></asp:Label><br />
		<asp:Label ID="LblTechDt" runat="server" CssClass="txtDate" Text=""></asp:Label>
	</div>
	<asp:Repeater ID="RepeaterTech" runat="server">
		<ItemTemplate>
			<div class="newsBox">
				<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%#"~/Read.aspx?nid=" + Eval("nid") %>'>
					<asp:Image ID="Image30" runat="server" CssClass="imgNewsBox" ImageUrl='<%#Eval("imgUrl") %>' />
				</asp:HyperLink>
				<asp:Label ID="Label45" runat="server" CssClass="nBoxHead" Text='<%#Eval("headln") %>'></asp:Label>
			</div>
		</ItemTemplate>
		</asp:Repeater>
</div>
</asp:Panel>
	
<!--SCIENCE-->
<asp:Panel ID="PnlScience" runat="server">
	<div class="homeCat">
	<div class="headingTxt tmScience">
			<asp:Label ID="LblScience" runat="server" Text="Science"></asp:Label>
	</div>
		<div class="leftBox">
		<asp:HyperLink ID="LinkSci" runat="server" NavigateUrl="#">
			<asp:Image ID="ImgLeftSci" runat="server" CssClass="imgLeftBox" ImageUrl="#" /> <br /><br />
		</asp:HyperLink>
		<asp:Label ID="LblSciHl" runat="server" Text="" CssClass="lBoxHead"></asp:Label><br />
		<asp:Label ID="LblSciDesc" runat="server" Text="" CssClass="lBoxDesc"></asp:Label><br />
		<asp:Label ID="LblSciDt" runat="server" CssClass="txtDate" Text=""></asp:Label>
	</div>
		<asp:Repeater ID="RepeaterScience" runat="server">
		<ItemTemplate>
			<div class="newsBox">
				<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%#"~/Read.aspx?nid=" + Eval("nid") %>'>
					<asp:Image ID="Image30" runat="server" CssClass="imgNewsBox" ImageUrl='<%#Eval("imgUrl") %>' />
				</asp:HyperLink>
				<asp:Label ID="Label45" runat="server" CssClass="nBoxHead" Text='<%#Eval("headln") %>'></asp:Label>
			</div>
		</ItemTemplate>
		</asp:Repeater>
</div>
</asp:Panel>
	
<!--HEALTH-->
<asp:Panel ID="PnlHealth" runat="server">
	<div class="homeCat">
	<div class="headingTxt tmHealth">
			<asp:Label ID="LblHealth" runat="server" Text="Health"></asp:Label>
	</div>
	<div class="leftBox">
		<asp:HyperLink ID="LinkHealth" runat="server" NavigateUrl="#">
			<asp:Image ID="ImgLeftHealth" runat="server" CssClass="imgLeftBox" ImageUrl="#" /> <br /><br />
		</asp:HyperLink>
		<asp:Label ID="LblHealthHl" runat="server" Text="" CssClass="lBoxHead"></asp:Label><br />
		<asp:Label ID="LblHealthDesc" runat="server" Text="" CssClass="lBoxDesc"></asp:Label><br />
		<asp:Label ID="LblHealthDt" runat="server" CssClass="txtDate" Text=""></asp:Label>
	</div>
	<asp:Repeater ID="RepeaterHealth" runat="server">
		<ItemTemplate>
			<div class="newsBox">
				<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%#"~/Read.aspx?nid=" + Eval("nid") %>'>
					<asp:Image ID="Image30" runat="server" CssClass="imgNewsBox" ImageUrl='<%#Eval("imgUrl") %>' />
				</asp:HyperLink>
				<asp:Label ID="Label45" runat="server" CssClass="nBoxHead" Text='<%#Eval("headln") %>'></asp:Label>
			</div>
		</ItemTemplate>
	</asp:Repeater>
</div>
</asp:Panel>
	
<!--VIDEO-->
<asp:Panel ID="PnlVideo" runat="server">
	<div class="homeCat">
	<div class="headingTxt tmVideo">
			<asp:Label ID="LblVideo" runat="server" Text="Video"></asp:Label>
	</div>
		<div class="leftBox">
		<asp:HyperLink ID="LinkVideo" runat="server" NavigateUrl="#">
			<asp:Image ID="ImgLeftVideo" runat="server" CssClass="imgLeftBox" ImageUrl="#" /> <br /><br />
		</asp:HyperLink>
		<asp:Label ID="LblVideoHl" runat="server" Text="" CssClass="lBoxHead"></asp:Label><br />
		<asp:Label ID="LblVideoDesc" runat="server" Text="" CssClass="lBoxDesc"></asp:Label><br />
		<asp:Label ID="LblVideoDt" runat="server" CssClass="txtDate" Text=""></asp:Label>
	</div>
	<asp:Repeater ID="RepeaterVideo" runat="server">
		<ItemTemplate>
			<div class="newsBox">
				<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%#"~/Read.aspx?nid=" + Eval("nid") %>'>
					<asp:Image ID="Image30" runat="server" CssClass="imgNewsBox" ImageUrl='<%#Eval("imgUrl") %>' />
				</asp:HyperLink>
				<asp:Label ID="Label45" runat="server" CssClass="nBoxHead" Text='<%#Eval("headln") %>'></asp:Label>
			</div>
		</ItemTemplate>
		</asp:Repeater>
</div>
</asp:Panel>
	
<!--SPORT-->
<asp:Panel ID="PnlSport" runat="server">
<div class="homeCat">
	<div class="headingTxt tmSport">
			<asp:Label ID="LblSport" runat="server" Text="Sport"></asp:Label>
	</div>
	<div class="leftBox">
		<asp:HyperLink ID="LinkSport" runat="server" NavigateUrl="#">
			<asp:Image ID="ImgLeftSport" runat="server" CssClass="imgLeftBox" ImageUrl="#" /> <br /><br />
		</asp:HyperLink>
		<asp:Label ID="LblSportHl" runat="server" Text="" CssClass="lBoxHead"></asp:Label><br />
		<asp:Label ID="LblSportDesc" runat="server" Text="" CssClass="lBoxDesc"></asp:Label><br />
		<asp:Label ID="LblSportDt" runat="server" CssClass="txtDate" Text=""></asp:Label>
	</div>
	<asp:Repeater ID="RepeaterSport" runat="server">
		<ItemTemplate>
			<div class="newsBox">
				<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%#"~/Read.aspx?nid=" + Eval("nid") %>'>
					<asp:Image ID="Image30" runat="server" CssClass="imgNewsBox" ImageUrl='<%#Eval("imgUrl") %>' />
				</asp:HyperLink>
				<asp:Label ID="Label45" runat="server" CssClass="nBoxHead" Text='<%#Eval("headln") %>'></asp:Label>
			</div>
		</ItemTemplate>
	</asp:Repeater>
</div>
</asp:Panel>
<script src="js/slider.js" type="text/javascript" ></script>
</asp:Content>