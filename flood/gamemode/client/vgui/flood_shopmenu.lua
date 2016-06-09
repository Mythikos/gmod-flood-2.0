local x = ScrW()
local y = ScrH()

local PANEL = {}
function PANEL:Init()
	self.MainFrame = vgui.Create("DFrame")
	self.MainFrame:SetPos(0, 0)
	self.MainFrame:SetSize(x, y)
	self.MainFrame:SetTitle(" ")
	self.MainFrame:SetScreenLock(true)
	self.MainFrame:SetDraggable(false)
	self.MainFrame:ShowCloseButton(false)
	self.MainFrame:SetBackgroundBlur(true)
	self.MainFrame.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
	end
	GAMEMODE.ShopMenu = self.MainFrame

	self.LeftFrame = vgui.Create("DFrame", self.MainFrame)
	self.LeftFrame:SetPos(x * 0.1, y * 0.1)
	self.LeftFrame:SetSize(x * 0.475, y * 0.8)
	self.LeftFrame:SetTitle(" ")
	self.LeftFrame:SetScreenLock(true)
	self.LeftFrame:SetDraggable(false)
	self.LeftFrame:ShowCloseButton(false)
	self.LeftFrame.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(24, 24, 24, 255))
	end

	self.RightFrame = vgui.Create("DFrame", self.MainFrame)
	self.RightFrame:SetPos(x * 0.6, y * 0.1)
	self.RightFrame:SetSize(x * 0.3, y * 0.8)
	self.RightFrame:SetTitle(" ")
	self.RightFrame:SetScreenLock(true)
	self.RightFrame:SetDraggable(false)
	self.RightFrame:ShowCloseButton(false)
	self.RightFrame.Paint = function(self, w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(24, 24, 24, 255))
	end

	self.LeftContentPanel = vgui.Create("DPropertySheet", self.LeftFrame)
	self.LeftContentPanel:SetPos(0, 25)
	self.LeftContentPanel:SetSize(self.LeftFrame:GetWide(), self.LeftFrame:GetTall() - 25)
	self.LeftContentPanel.Paint = function(panel, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, Color(240, 240, 240, 255), false, false, true, true)
		draw.RoundedBox(0, 0, 0, w, 20, Color(24, 24, 24, 255))
		for k, v in pairs(self.LeftContentPanel.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				if self:IsActive() then
					draw.RoundedBox(0, 0, 0, w - 5, h - 8, Color(24, 24, 24, 255))
					draw.RoundedBox(0, 0, 0, w - 5, h - 8, Color(255, 255, 255, 3))
				else
					draw.RoundedBox(0, 0, 0, w - 5, h, Color(24, 24, 24, 255))
				end
			end
		end
	end
	
	self.LeftContentPanel:AddSheet("Props", vgui.Create("Flood_ShopMenu_Props", self.LeftFrame), "icon16/house.png")
	self.LeftContentPanel:AddSheet("Weapons", vgui.Create("Flood_ShopMenu_Weapons", self.LeftFrame), "icon16/gun.png")

	self.RightContentPanel = vgui.Create("DPropertySheet", self.RightFrame)
	self.RightContentPanel:SetPos(0, 25)
	self.RightContentPanel:SetSize(self.RightFrame:GetWide(), self.RightFrame:GetTall() - 25)
	self.RightContentPanel.Paint = function(panel, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, Color(240, 240, 240, 255), false, false, true, true)
		draw.RoundedBox(0, 0, 0, w, 20, Color(24, 24, 24, 255))
		for k, v in pairs(self.RightContentPanel.Items) do
			if (!v.Tab) then continue end
			v.Tab.Paint = function(self,w,h)
				if self:IsActive() then
					draw.RoundedBox(0, 0, 0, w - 5, h - 8, Color(24, 24, 24, 255))
					draw.RoundedBox(0, 0, 0, w - 5, h - 8, Color(255, 255, 255, 3))
				else
					draw.RoundedBox(0, 0, 0, w - 5, h, Color(24, 24, 24, 255))
				end
			end
		end
	end

	self.RightContentPanel:AddSheet("Tools", vgui.Create("Flood_ShopMenu_Tools", self.RightFrame), "icon16/wrench.png")
	local PropProtection = vgui.Create("Flood_ShopMenu_PropProtection", self.RightFrame)
	self.RightContentPanel:AddSheet("Prop Protection", PropProtection, "icon16/asterisk_orange.png")
	self.RightContentPanel.SetActiveTab = function(self, tab)
		DPropertySheet.SetActiveTab(self, tab)
		PropProtection:Update()
	end	
end

function PANEL:DoClick()
	surface.PlaySound(Sound("ui/buttonclickrelease.wav"))
end
vgui.Register("Flood_ShopMenu", PANEL)