local x = ScrW()
local y = ScrH()

surface.CreateFont( "ScoreboardFont", {
	font = "Tehoma",
	size = 15,
	weight = 600,
	antialias = true,
})

function GM:ScoreboardShow()
	self.ShowScoreBoard = true
end

function GM:ScoreboardHide()
	self.ShowScoreBoard = false
end

function GM:GetTeamScoreInfo()
	local TeamInfo = {}
	
	for _, ply in pairs( player.GetAll() ) do
		local _team = ply:Team()
		local _deaths = ply:Deaths()
		local _ping = ply:Ping()
		local _cash = ply:GetNWInt("flood_cash")
		
		if (not TeamInfo[_team]) then
			TeamInfo[_team] = {}
			TeamInfo[_team].TeamName = team.GetName( _team )
			TeamInfo[_team].Color = team.GetColor( _team )
			TeamInfo[_team].Players = {}
		end		
		
		local PlayerInfo = {}
		PlayerInfo.Deaths = _deaths
		PlayerInfo.Ping = _ping
		PlayerInfo.Name = ply:Nick()
		PlayerInfo.PlayerObj = ply
		PlayerInfo.cash = _cash
		
		local insertPos = #TeamInfo[_team].Players + 1
		for idx, info in pairs(TeamInfo[_team].Players) do
			if (PlayerInfo.Deaths < info.Deaths) then
				insertPos = idx
				break
			elseif (PlayerInfo.Deaths == info.Deaths) then
				if (PlayerInfo.Name < info.Name) then
					insertPos = idx
					break
				end
			end
		end
		
		table.insert(TeamInfo[_team].Players, insertPos, PlayerInfo)
	end
	
	return TeamInfo
end

function GM:HUDDrawScoreBoard()

	if not self.ShowScoreBoard then return end
	
	if self.ScoreDesign == nil then
		self.ScoreDesign = {}
		self.ScoreDesign.HeaderY = 0
		self.ScoreDesign.Height = ScrH() / 2
	end
	
	local alpha = 255

	local ScoreboardInfo = self:GetTeamScoreInfo()
	
	local xOffset = x * 0.15
	local yOffset = 32
	local scrWidth = x
	local scrHeight = y - 64
	local boardWidth = scrWidth - (2 * xOffset)
	local boardHeight = scrHeight
	local colWidth = 75

	local ScoreboardFont = "ScoreboardFont"
	
	boardWidth = math.Clamp(boardWidth, 400, 600)
	boardHeight = self.ScoreDesign.Height
	
	xOffset = (ScrW() - boardWidth) / 2.0
	yOffset = (ScrH() - boardHeight) / 2.0
	yOffset = yOffset - ScrH() / 4.0
	yOffset = math.Clamp( yOffset, 32, ScrH() )

	-- Background
	draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 150))
	
	-- Header
	draw.RoundedBoxEx(6, xOffset, yOffset, boardWidth, self.ScoreDesign.HeaderY, Color(24, 24, 24, 255), true, true, false, false)
	draw.RoundedBoxEx(6, xOffset, yOffset + 30, boardWidth, self.ScoreDesign.Height - 25, Color(240, 240, 240, 255), false, false, true, true)
	-- Header text
	local ySpacing = yOffset + 25
	draw.SimpleText(GetGlobalString("ServerName"), ScoreboardFont, xOffset + boardWidth * 0.5, ySpacing - 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	ySpacing = ySpacing + 8
	self.ScoreDesign.HeaderY = ySpacing - yOffset
	ySpacing = ySpacing + 2

	-- Titles
	draw.SimpleText("Name", ScoreboardFont, xOffset + 16, ySpacing, color_black)
	draw.SimpleText("Cash", ScoreboardFont, xOffset + boardWidth - (colWidth*3) + 8, ySpacing, color_black)
	draw.SimpleText("Deaths", ScoreboardFont, xOffset + boardWidth - (colWidth*2) + 8, ySpacing, color_black)
	draw.SimpleText("Ping", ScoreboardFont, xOffset + boardWidth - (colWidth*1) + 8, ySpacing, color_black)

	ySpacing = ySpacing + 22

	local yPosition = ySpacing
	for team,info in pairs(ScoreboardInfo) do
		local teamText = info.TeamName .. "  (" .. #info.Players .. " Players)"
		
		draw.RoundedBox(0, xOffset + 5, yPosition, boardWidth - 10, 19, Color(info.Color.r, info.Color.g, info.Color.b, 255))
		
		yPosition = yPosition + 2
		
		draw.SimpleText(teamText, ScoreboardFont, xOffset + boardWidth * 0.5, yPosition + 8, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		yPosition = yPosition + 24
		
		for index, plinfo in pairs(info.Players) do
					
			if (plinfo.PlayerObj == LocalPlayer()) then
				draw.RoundedBox(0, xOffset + 10, yPosition, boardWidth - 20, 16, Color(0, 0, 0, 100))
			end
						
			local px = xOffset + 16
			draw.SimpleText(plinfo.Name, ScoreboardFont, px, yPosition, Color(24, 24, 24, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)

			px = xOffset + boardWidth - (colWidth*3) + 8	
			draw.SimpleText("$"..plinfo.cash, ScoreboardFont, px, yPosition, Color(0, 100, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)

			px = xOffset + boardWidth - (colWidth*2) + 8			
			draw.SimpleText(plinfo.Deaths, ScoreboardFont, px, yPosition, Color(100, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
			
			px = xOffset + boardWidth - (colWidth*1) + 8			
			draw.SimpleText(plinfo.Ping, ScoreboardFont, px, yPosition, Color(0, 0, 100, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
			
			
			yPosition = yPosition + 20
		end
	end
	self.ScoreDesign.Height = (self.ScoreDesign.Height * 2) + (yPosition-yOffset)
	self.ScoreDesign.Height = self.ScoreDesign.Height / 3
end