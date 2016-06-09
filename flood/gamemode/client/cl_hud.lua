surface.CreateFont( "Flood_HUD_Small", {
	 font = "Tehoma",
	 size = 14,
	 weight = 500,
	 antialias = true
})

surface.CreateFont( "Flood_HUD", {
	 font = "Tehoma",
	 size = 16,
	 weight = 500,
	 antialias = true
})

surface.CreateFont( "Flood_HUD_Large", {
	 font = "Tehoma",
	 size = 30,
	 weight = 500,
	 antialias = true
})

surface.CreateFont( "Flood_HUD_B", {
	 font = "Tehoma",
	 size = 18,
	 weight = 600,
	 antialias = true
})

-- Hud Stuff
local color_grey = Color(120, 120, 120, 100)
local color_black = Color(0, 0, 0, 200)
local active_color = Color(24, 24, 24, 255)
local outline_color = Color(0, 0, 0, 255)
local x = ScrW()
local y = ScrH()

-- Timer Stuff
local GameState = 0
local BuildTimer = -1
local FloodTimer = -1
local FightTimer = -1
local ResetTimer = -1

local xPos = x * 0.0025
local yPos = y * 0.005

-- Hud Positioning
local Spacer = y * 0.006
local xSize = x * 0.2
local ySize = y * 0.04
local bWidth = Spacer + xSize + Spacer
local bHeight = Spacer + ySize + Spacer

net.Receive("RoundState", function(len)
	GameState = net.ReadFloat()
	BuildTimer = net.ReadFloat()
	FloodTimer = net.ReadFloat()
	FightTimer = net.ReadFloat()
	ResetTimer = net.ReadFloat()
end)

function GM:HUDPaint()

	if BuildTimer and FloodTimer and FightTimer and ResetTimer then
		if GameState == 0 then
			draw.RoundedBoxEx(6, xPos, y * 0.005, x * 0.175,  x * 0.018, active_color, true, true, false, false)
			
			draw.SimpleText("Waiting for players.", "Flood_HUD", x * 0.01, y * 0.01, color_white, 0, 0)
			draw.SimpleText("Build a boat.", "Flood_HUD", x * 0.01, y * 0.044, color_grey, 0, 0)
			draw.SimpleText("Get on your boat!", "Flood_HUD", x * 0.01, y * 0.078, color_grey, 0, 0)
			draw.SimpleText("Destroy enemy boats!", "Flood_HUD", x * 0.01, y * 0.115, color_grey, 0, 0)
			draw.SimpleText("Restarting the round.", "Flood_HUD", x * 0.01, y * 0.151, color_grey, 0, 0)
		else
			draw.RoundedBoxEx(6, xPos, y * 0.005, x * 0.175,  x * 0.018, color_grey, true, true, false, false)
		end
		
		if GameState == 1 then
			draw.RoundedBox(0, xPos, yPos + (Spacer * 6), x * 0.175,  x * 0.018, active_color)
			draw.SimpleText(BuildTimer, "Flood_HUD", x * 0.15, y * 0.044, color_white, 0, 0)

			draw.SimpleText("Waiting for players.", "Flood_HUD", x * 0.01, y * 0.01, color_grey, 0, 0)
			draw.SimpleText("Build a boat.", "Flood_HUD", x * 0.01, y * 0.044, color_white, 0, 0)
			draw.SimpleText("Get on your boat!", "Flood_HUD", x * 0.01, y * 0.078, color_grey, 0, 0)
			draw.SimpleText("Destroy enemy boats!", "Flood_HUD", x * 0.01, y * 0.115, color_grey, 0, 0)
			draw.SimpleText("Restarting the round.", "Flood_HUD", x * 0.01, y * 0.151, color_grey, 0, 0)
		else
			draw.RoundedBox(0, xPos, yPos + (Spacer * 6), x * 0.175,  x * 0.018, color_grey)
			draw.SimpleText(BuildTimer, "Flood_HUD", x * 0.15, y * 0.044, color_grey, 0, 0)
		end

		if GameState == 2 then
			draw.RoundedBox(0, xPos, yPos + (Spacer * 12), x * 0.175,  x * 0.018, active_color)
			draw.SimpleText(FloodTimer, "Flood_HUD", x * 0.15, y * 0.078, color_white, 0, 0)

			draw.SimpleText("Waiting for players.", "Flood_HUD", x * 0.01, y * 0.01, color_grey, 0, 0)
			draw.SimpleText("Build a boat.", "Flood_HUD", x * 0.01, y * 0.044, color_grey, 0, 0)
			draw.SimpleText("Get on your boat!", "Flood_HUD", x * 0.01, y * 0.078, color_white, 0, 0)
			draw.SimpleText("Destroy enemy boats!", "Flood_HUD", x * 0.01, y * 0.115, color_grey, 0, 0)
			draw.SimpleText("Restarting the round.", "Flood_HUD", x * 0.01, y * 0.151, color_grey, 0, 0)
		else
			draw.RoundedBox(0, xPos, yPos + (Spacer * 12), x * 0.175,  x * 0.018, color_grey)
			draw.SimpleText(FloodTimer, "Flood_HUD", x * 0.15, y * 0.078, color_grey, 0, 0)
		end
		
		if GameState == 3 then
			draw.RoundedBox(0, xPos, yPos + (Spacer * 18), x * 0.175,  x * 0.018, active_color)

			draw.SimpleText(FightTimer, "Flood_HUD", x * 0.15, y * 0.115, color_white, 0, 0)
			draw.SimpleText("Waiting for players.", "Flood_HUD", x * 0.01, y * 0.01, color_grey, 0, 0)
			draw.SimpleText("Build a boat.", "Flood_HUD", x * 0.01, y * 0.044, color_grey, 0, 0)
			draw.SimpleText("Get on your boat!", "Flood_HUD", x * 0.01, y * 0.078, color_grey, 0, 0)
			draw.SimpleText("Destroy enemy boats!", "Flood_HUD", x * 0.01, y * 0.115, color_white, 0, 0)
			draw.SimpleText("Restarting the round.", "Flood_HUD", x * 0.01, y * 0.151, color_grey, 0, 0)
		else
			draw.RoundedBox(0, xPos, yPos + (Spacer * 18), x * 0.175,  x * 0.018, color_grey)
			draw.SimpleText(FightTimer, "Flood_HUD", x * 0.15, y * 0.115, color_grey, 0, 0)
		end

		if GameState == 4 then
			draw.RoundedBoxEx(6, xPos, yPos + (Spacer * 24), x * 0.175,  x * 0.018, active_color, false, false, true, true)
			
			draw.SimpleText(ResetTimer, "Flood_HUD", x * 0.15, y * 0.151, color_white, 0, 0)
			draw.SimpleText("Waiting for players.", "Flood_HUD", x * 0.01, y * 0.01, color_grey, 0, 0)
			draw.SimpleText("Build a boat.", "Flood_HUD", x * 0.01, y * 0.044, color_grey, 0, 0)
			draw.SimpleText("Get on your boat!", "Flood_HUD", x * 0.01, y * 0.078, color_grey, 0, 0)
			draw.SimpleText("Destroy enemy boats!", "Flood_HUD", x * 0.01, y * 0.115, color_grey, 0, 0)
			draw.SimpleText("Restarting the round.", "Flood_HUD", x * 0.01, y * 0.151, color_white, 0, 0)
		else
			draw.RoundedBoxEx(6,xPos, yPos + (Spacer * 24), x * 0.175,  x * 0.018, color_grey, false, false, true, true)
			draw.SimpleText(ResetTimer, "Flood_HUD", x * 0.15, y * 0.151, color_grey, 0, 0)
		end
	end

	-- Display Prop's Health
	local tr = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
	if tr.Entity:IsValid() and not tr.Entity:IsPlayer() then
		if tr.Entity:GetNWInt("CurrentPropHealth") == "" or tr.Entity:GetNWInt("CurrentPropHealth") == nil or tr.Entity:GetNWInt("CurrentPropHealth") == NULL then
			draw.SimpleText("Fetching Health", "Flood_HUD_Small", x * 0.5, y * 0.5 - 25, color_white, 1, 1)
		else
			draw.SimpleText("Health: " .. tr.Entity:GetNWInt("CurrentPropHealth"), "Flood_HUD_Small", x * 0.5, y * 0.5 - 25, color_white, 1, 1)
		end
	end

	-- Display Player's Health and Name
	if tr.Entity:IsValid() and tr.Entity:IsPlayer() then
		draw.SimpleText("Name: " .. tr.Entity:GetName(), "Flood_HUD_Small", x * 0.5, y * 0.5 - 75, color_white, 1, 1)
		draw.SimpleText("Health: " .. tr.Entity:Health(), "Flood_HUD_Small", x * 0.5, y * 0.5 - 60, color_white, 1, 1)
	end

	-- Bottom left HUD Stuff
	if LocalPlayer():Alive() and IsValid(LocalPlayer()) then
		draw.RoundedBox(6, 4, y - ySize - Spacer - (bHeight * 2), bWidth, bHeight * 2 + ySize, Color(24, 24, 24, 255))
		
		-- Health
		local pHealth = LocalPlayer():Health()
		local pHealthClamp = math.Clamp(pHealth / 100, 0, 1)
		local pHealthWidth = (xSize - Spacer) * pHealthClamp

		draw.RoundedBoxEx(6, Spacer * 2, y - (Spacer * 4) - (ySize * 3), Spacer + pHealthWidth, ySize, Color(128, 28, 28, 255), true, true, false, false)
		draw.SimpleText(math.Max(pHealth, 0).." HP","Flood_HUD_B", xSize * 0.5 + (Spacer * 2), y - (ySize * 2.5) - (Spacer * 4), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
		-- Ammo
		if IsValid(LocalPlayer():GetActiveWeapon()) then
			if LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 or LocalPlayer():GetActiveWeapon():Clip1() > 0 then
				local wBulletCount = (LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) + LocalPlayer():GetActiveWeapon():Clip1()) + 1
				local wBulletClamp = math.Clamp(wBulletCount / 100, 0, 1)
				local wBulletWidth = (xSize - bWidth) * wBulletClamp

				draw.RoundedBox(0, Spacer * 2, y - (ySize * 2) - (Spacer * 3), bWidth + wBulletWidth, ySize, Color(30, 105, 105, 255))
				draw.SimpleText(wBulletCount.." Bullets", "Flood_HUD_B", xSize * 0.5 + (Spacer * 2), y - ySize - (ySize * 0.5) - (Spacer * 3), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.RoundedBox(0, Spacer * 2, y - (ySize * 2) - (Spacer * 3), xSize, ySize, Color(30, 105, 105, 255))
				draw.SimpleText("Doesn't Use Ammo", "Flood_HUD_B", xSize * 0.5 + (Spacer * 2), y - ySize - (ySize * 0.5) - (Spacer * 3), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		else
			draw.RoundedBox(0, Spacer * 2, y - (ySize * 2) - (Spacer * 3), xSize, ySize, Color(30, 105, 105, 255))
			draw.SimpleText("No Ammo", "Flood_HUD_B", xSize * 0.5 + (Spacer * 2), y - ySize - (ySize * 0.5) - (Spacer * 3), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		-- Cash
		local pCash = LocalPlayer():GetNWInt("flood_cash") or 0
		local pCashClamp = math.Clamp(pCash / 5000, 0, xSize)

		draw.RoundedBoxEx(6, Spacer * 2, y - ySize - (Spacer * 2), xSize, ySize, Color(63, 140, 64, 255), false, false, true, true)
		draw.SimpleText("$"..pCash, "Flood_HUD_B", (xSize * 0.5) + (Spacer * 2), y - (ySize * 0.5) - (Spacer * 2), WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

function hidehud(name)
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do 
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud) 