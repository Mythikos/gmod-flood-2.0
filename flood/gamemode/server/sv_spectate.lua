local MetaPlayer = FindMetaTable("Player")

function MetaPlayer:CycleSpectator(a)
	if self:Alive() then Error("Can't spectate while alive!") return false end
	if !self.SpecIDX then self.SpecIDX = 0 end 
	
	self.SpecIDX = self.SpecIDX + a

	local Players = {}
	for _, v in pairs(GAMEMODE:GetActivePlayers()) do
		Players[#Players + 1] = v
	end
	
	if self.SpecIDX < 1 then 
		self.SpecIDX = #Players
	end
	
	if self.SpecIDX > #Players then 
		self.SpecIDX = 0
	end
	
	local ply 
	ply = Players[self.SpecIDX]
	
	self:Spectate(OBS_MODE_CHASE)
	self:SpectateEntity(ply)
end