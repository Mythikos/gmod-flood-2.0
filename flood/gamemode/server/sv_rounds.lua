local function PlayerIsFriend(ply, ply2)
	if not IsValid(ply) or not IsValid(ply2) then return end

	for k, v in pairs(ply:CPPIGetFriends()) do
		if v == ply2 then return true end 
	end

	return false 
end

function GM:GetActivePlayers()
	local players = { }
	for _, v in pairs(player.GetAll()) do
		if IsValid(v) and v:Alive() then
			table.insert(players, v)
		end
	end

	return players
end

function GM:CheckForWinner()
	if self:GetGameState() == 3 then
		local players = self:GetActivePlayers()
		local count = #players
		if count == 1 then winner = players[1] end

		-- Determine team conditions
		local AllAreFriends = true
		for k, ply in pairs(players) do
			for x, ply2 in pairs(players) do
				-- Dont look at the same person
				if ply == ply2 then continue end

				-- Is player one friends with player two, and is player two friends with player one?
				if PlayerIsFriend(ply, ply2) and PlayerIsFriend(ply2, ply) then
					continue
				else
					AllAreFriends = false
					break
				end
			end
		end

		-- Determine if we have winners
		if AllAreFriends == true and #players != 0 then
			self:DeclareWinner(0, players)
			self:SetGameState(4)
			self:LowerAllWaterControllers()
		elseif count == 1 and winner != nil then
			self:DeclareWinner(1, winner)
			self:SetGameState(4)
			self:LowerAllWaterControllers()
		elseif count == 0 and winner == nil then
			self:DeclareWinner(2, winner)
			self:SetGameState(4)
			self:LowerAllWaterControllers()
		end
	end
end

function GM:DeclareWinner(case, ply)
	if case == 0 and type(ply) == "table" then
		for _, v in pairs(ply) do
			if IsValid(v) and v:Alive() and self:GetGameState() == 3 then
				local cash = GetConVar("flood_bonus_cash"):GetInt()
				v:AddCash(cash)

				local ct = ChatText()
				ct:AddText("[Flood] ", Color(132, 199, 29, 255))
				ct:AddText(v:Nick(), self:FormatColor(v:GetPlayerColor()))
				ct:AddText(" won and recieved an additional $"..cash.."!")
				ct:SendAll()
			end
		end
	elseif case == 1 and IsValid(ply) then
		if ply:Alive() and IsValid(ply) and self:GetGameState() == 3 then
			local cash = GetConVar("flood_bonus_cash"):GetInt()
			ply:AddCash(cash)

			local ct = ChatText()
			ct:AddText("[Flood] ", Color(132, 199, 29, 255))
			ct:AddText(ply:Nick(), self:FormatColor(ply:GetPlayerColor()))
			ct:AddText(" won and recieved an additional $"..cash.."!")
			ct:SendAll()
		end
	elseif case == 2 then
		local ct = ChatText()
		ct:AddText("[Flood] ", Color(132, 199, 29, 255))
		ct:AddText("Nobody won!")
		ct:SendAll()
	elseif case == 3 then
		local ct = ChatText()
		ct:AddText("[Flood] ", Color(132, 199, 29, 255))
		ct:AddText("Round time limit reached. Nobody wins.")
		ct:SendAll()
	end
end

local pNextBonus = 0
function GM:ParticipationBonus()
	if self:GetGameState() == 3 and pNextBonus <= CurTime() then
		for _, v in pairs(self:GetActivePlayers()) do
			local cash = GetConVar("flood_participation_cash"):GetInt()
			v:AddCash(cash)
		end

		pNextBonus = CurTime() + 5
	end
end

function GM:RefundAllProps()
	for k, v in pairs(ents.GetAll()) do
		if v:GetClass() == "prop_physics" then
			if v:CPPIGetOwner() ~= nil and v:CPPIGetOwner() ~= NULL and v:CPPIGetOwner() ~= "" then
				local Currenthealth = tonumber(v:GetNWInt("CurrentPropHealth"))
				local Basehealth = tonumber(v:GetNWInt("BasePropHealth"))
				local Currentcash = tonumber(v:CPPIGetOwner():GetNWInt("flood_cash"))
				local Recieve = (Currenthealth / Basehealth) * Basehealth
				if Recieve > 0 then
					v:Remove()
					if v:CPPIGetOwner():IsValid() then 
						v:CPPIGetOwner():AddCash(Recieve)
					end
				else
					v:Remove()
				end	
			else
				v:Remove()
			end
		end
	end
end
