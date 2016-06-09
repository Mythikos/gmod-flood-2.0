local function PlayerIsFriend(ply, ply2)
	if not IsValid(ply) or not IsValid(ply2) then return end

	for k, v in pairs(ply:CPPIGetFriends()) do
		if v == ply2 then return true end 
	end

	return false 
end

timer.Create("Flood:OffProps", 1, 0, function() 
	if GAMEMODE:GetGameState() == 2 or GAMEMODE:GetGameState() == 3 then
		for _, v in pairs(player.GetAll()) do 
			local ent = v:GetGroundEntity()
			if ent and IsValid(ent) and ent:GetClass() == "prop_physics" and ent:CPPIGetOwner() != v and PlayerIsFriend(ent:CPPIGetOwner(), v) == false then 
				v:SetVelocity(Vector(math.random(1,5000) ,math.random(1,5000) ,math.random(1,5000) ))
			end
		end
	end
end)
