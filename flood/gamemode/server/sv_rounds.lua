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
		local count = 0
		local winner = nil
		for _, v in pairs(self:GetActivePlayers()) do
			if v:Alive() and IsValid(v) then
				count = count + 1
				winner = v
			end
		end

		if count == 1 and winner != nil then
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
	if case == 1 and IsValid(ply) then
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