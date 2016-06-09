local PANEL = {}
function PANEL:Init()
	self.FloodWeaponIconList = {}
	self.FloodWeaponIconList_Collapse = {}

	self.TabList = vgui.Create("DPanelList", self)
	self.TabList:Dock(FILL)
	self.TabList:EnableVerticalScrollbar(true)

	if WeaponCategories then
		for k,v in pairs (WeaponCategories) do
			self.FloodWeaponIconList[k] = vgui.Create("DPanelList", self)
			self.FloodWeaponIconList[k]:SetAutoSize(true) 
		 	self.FloodWeaponIconList[k]:EnableHorizontal(true) 
		 	self.FloodWeaponIconList[k]:SetPadding(4) 
			self.FloodWeaponIconList[k]:SetVisible(true) 
			self.FloodWeaponIconList[k].OnMouseWheeled = nil
			
			self.FloodWeaponIconList_Collapse[k] = vgui.Create("DCollapsibleCategory", self)
			self.FloodWeaponIconList_Collapse[k]:SizeToContents()
			self.FloodWeaponIconList_Collapse[k]:SetLabel(v) 
			self.FloodWeaponIconList_Collapse[k]:SetVisible(true) 
			self.FloodWeaponIconList_Collapse[k]:SetContents(self.FloodWeaponIconList[k])
			self.FloodWeaponIconList_Collapse[k].Paint = function(self, w, h) 
				draw.RoundedBox(0, 0, 1, w, h, Color(0, 0, 0, 0)) 
				draw.RoundedBox(0, 0, 0, w, self.Header:GetTall(), Color(24, 24, 24, 255)) 
			end

			self.TabList:AddItem(self.FloodWeaponIconList_Collapse[k])
		end
	else
		LocalPlayer():ChatPrint([[Failed to load weapon categories table - please notify the server operator.]])
	end

	if Weapons then
		for k, v in pairs(Weapons) do	
			local ItemIcon = vgui.Create("SpawnIcon", self)
			ItemIcon:SetModel(v.Model)
			ItemIcon:SetSize(55,55)
			ItemIcon.DoClick = function() 
				RunConsoleCommand("FloodPurchaseWeapon", k)
				surface.PlaySound("ui/buttonclick.wav")		
			end

			if v.Name and v.Price and v.Damage and v.Ammo then ItemIcon:SetToolTip(Format("%s", "Name: "..v.Name.."\nPrice: $"..v.Price.."\nDamage: "..v.Damage.."\nAmmo: "..v.Ammo)) 
			else ItemIcon:SetToolTip(Format("%s", "Failed to load tooltip - Missing Description")) end

			if v.Group then	self.FloodWeaponIconList[v.Group]:AddItem(ItemIcon) end
			ItemIcon:InvalidateLayout(true) 
		end
	else
		LocalPlayer():ChatPrint([[Failed to load weapon table - please notify the server operator.]])
	end
end
vgui.Register("Flood_ShopMenu_Weapons", PANEL)