local whTick = 0
function GM:WaterHurts()
	if GetConVar("flood_wh_enabled"):GetBool() then
		if whTick < CurTime() then
			for _, v in pairs(self:GetActivePlayers()) do
				if v:WaterLevel() >= 1 then
					local dmginfo = DamageInfo()
				    dmginfo:SetDamageType(DMG_GENERIC)
					dmginfo:SetDamage(GetConVar("flood_wh_damage"):GetFloat())
				    dmginfo:SetAttacker(game.GetWorld())
				    dmginfo:SetInflictor(game.GetWorld())
				    v:TakeDamageInfo(dmginfo)
				end
			end	
			whTick = CurTime() + 0.5
		end
	end
end
hook.Add("Tick", "flood waterhurt function", function() hook.Call("WaterHurts", GAMEMODE) end)