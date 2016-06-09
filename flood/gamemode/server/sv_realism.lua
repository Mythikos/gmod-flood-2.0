function GM:RealismThink()
 	for _, v in pairs(player.GetAll()) do
 		if v:IsOnFire() and v:WaterLevel() > 1 then
 			v:Extinguish()
 		end
	end
end