-- Give Cash
local function Flood_GiveCash(ply, txt)
	local command = string.Explode(" ", txt)
	if command[1] == "!givecash" then
		local ct = ChatText()
		local ct2 = ChatText()
		if ply:IsAdmin() then
			local target_player = FindPlayer(ply, command[2])
			local target_amount = command[3]
			local commandname = command[1]
			if CheckInput(ply, target_amount, commandname) then
				if IsValid(target_player) then	
					target_player:AddCash(command[3])

					ct:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct:AddText("You gave "..target_player:Nick().." $"..target_amount..".")
					ct:Send(ply)

					ct2:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct2:AddText("You were given $"..target_amount.." by "..ply:Nick()..".")
					ct2:Send(target_player)
				else
					ct:AddText("[Flood] ", Color(158, 49, 49, 255))
					ct:AddText("Target player could not be found.")
					ct:Send(ply)
				end
			end
		else
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText("You don't have permission to use this command.")
			ct:Send(ply)
		end
	end
end
hook.Add("PlayerSay", "Flood_GiveCash", Flood_GiveCash)

-- Check Cash
local function Flood_CheckCash(ply, txt)
	local command = string.Explode(" ", txt)
	if command[1] == "!checkcash" then
		local ct = ChatText()
		if ply:IsAdmin() then
			local target_player = FindPlayer(ply, command[2])
			if IsValid(target_player) then	
				ct:AddText("[Flood] ", Color(132, 199, 29, 255))					
				ct:AddText(target_player:Nick().." has $"..target_player:GetCash()..".")
				ct:Send(ply)
			else
				ct:AddText("[Flood] ", Color(158, 49, 49, 255))
				ct:AddText("Target player could not be found.")
				ct:Send(ply)
			end
		else
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText("You don't have permission to use this command.")
			ct:Send(ply)
		end
	end
end
hook.Add("PlayerSay", "Flood_CheckCash", Flood_CheckCash)

-- Set Cash
local function Flood_SetCash(ply, txt)
	local command = string.Explode(" ", txt)
	if command[1] == "!setcash" then
		local ct = ChatText()
		local ct2 = ChatText()
		if ply:IsAdmin() then
			local target_player = FindPlayer(ply, command[2])
			local target_amount = command[3]
			local commandname = command[1]
			if CheckInput(ply, target_amount, commandname) then
				if IsValid(target_player) then
					target_player:SetCash(target_amount)

					ct:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct:AddText("You set "..target_player:Nick().."'s cash to $"..target_amount..".")
					ct:Send(ply)

					ct2:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct2:AddText("Your cash has been set to $"..target_amount.." by "..ply:Nick()..".")
					ct2:Send(target_player)
				else
					ct:AddText("[Flood] ", Color(158, 49, 49, 255))
					ct:AddText("Target player could not be found.")
					ct:Send(ply)
				end
			end
		else
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText("You don't have permission to use this command.")
			ct:Send(ply)
		end
	end
end
hook.Add("PlayerSay", "Flood_SetCash", Flood_SetCash)

-- Take Cash
local function Flood_TakeCash(ply, txt)
	local command = string.Explode(" ", txt)
	if command[1] == "!takecash" then
		local ct = ChatText()
		local ct2 = ChatText()
		if ply:IsAdmin() then
			local target_player = FindPlayer(ply, command[2])
			local target_amount = command[3]
			local commandname = command[1]
			if CheckInput(ply, target_amount, commandname) then
				if IsValid(target_player) then	
					target_player:SubCash(target_amount)	

					ct:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct:AddText("You have taken $"..target_amount.." from "..target_player:Nick()..".")
					ct:Send(ply)

					ct2:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct2:AddText("You had  $"..target_amount.." taken by "..ply:Nick()..".")
					ct2:Send(target_player)
				else
					ct:AddText("[Flood] ", Color(158, 49, 49, 255))
					ct:AddText("Target player could not be found.")
					ct:Send(ply)
				end
			end
		else
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText("You don't have permission to use this command.")
			ct:Send(ply)
		end
	end
end
hook.Add("PlayerSay", "Flood_TakeCash", Flood_TakeCash)

-- Set Time
local function Flood_SetTime(ply, txt)
	local command = string.Explode(" ", txt)
	if command[1] == "!settime" then
		local ct = ChatText()
		if ply:IsAdmin() then
			if command[2] == "build" then
				if Flood_buildTime then
					Flood_buildTime = tonumber(command[3])

					ct:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct:AddText("You have set the build time for this round to "..command[3])
					ct:Send(ply)
				else
					ct:AddText("[Flood] ", Color(158, 49, 49, 255))
					ct:AddText("Build timer couldn't be found.")
					ct:Send(ply)
				end
			elseif command[2] == "flood" then
				if Flood_floodTime then
					Flood_floodTime = tonumber(command[3])
					ct:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct:AddText("You have set the flood time for this round to "..command[3])
					ct:Send(ply)
				else
					ct:AddText("[Flood] ", Color(158, 49, 49, 255))
					ct:AddText("Flood timer couldn't be found.")
					ct:Send(ply)
				end
			elseif command[2] == "fight" then
				if Flood_fightTime then
					Flood_fightTime = tonumber(command[3])
					ct:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct:AddText("You have set the fight time for this round to "..command[3])
					ct:Send(ply)
				else
					ct:AddText("[Flood] ", Color(158, 49, 49, 255))
					ct:AddText("Fight timer couldn't be found.")
					ct:Send(ply)
				end
			elseif command[2] == "reset" then
				if Flood_resetTime then
					Flood_resetTime = tonumber(command[3])
					ct:AddText("[Flood] ", Color(132, 199, 29, 255))					
					ct:AddText("You have set the reset time for this round to "..command[3])
					ct:Send(ply)
				else
					ct:AddText("[Flood] ", Color(158, 49, 49, 255))
					ct:AddText("Reset timer couldn't be found.")
					ct:Send(ply)
				end
			end			
		else
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText("You don't have permission to use this command.")
			ct:Send(ply)
		end
	end
end
hook.Add("PlayerSay", "Flood_SetTime", Flood_SetTime)

-- Returns string
function FindPlayer(ply, target)
	name = string.lower(target)
	for _,v in ipairs(player.GetHumans()) do
		if(string.find(string.lower(v:Name()), name, 1, true) != nil) then 
			return v
		end
	end
end

-- Returns boolean
function CheckInput(ply, num, commandname)
	local numeric_num = tonumber(num)
	local string_num = tostring(num)
	local commandname = tostring(commandname)
	local ct = ChatText()

	if numeric_num or string_num then
		if string_num == "nan" or string_num == "inf" then 
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText("Attempted to pass illegal characters as command argument.")
			ct:Send(ply)
			return false
		elseif numeric_num == nil or string_num == nil then 
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText("Invalid parameters specified.")
			ct:Send(ply)
			return false
		elseif numeric_num < 0 then
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText("Invalid number specified. Negatives not allowed.")
			ct:Send(ply)
			return false
		else 
			return true
		end
	elseif commandname then
		ct:AddText("[Flood] ", Color(158, 49, 49, 255))
		ct:AddText("Invalid number specified.\nCommand: "..commandname)
		ct:Send(ply)
		return false
	else
		ct:AddText("[Flood] ", Color(158, 49, 49, 255))
		ct:AddText("Invalid number specified.")
		ct:Send(ply)
		return false
	end
end