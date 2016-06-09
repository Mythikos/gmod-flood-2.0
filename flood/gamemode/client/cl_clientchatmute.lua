local ChatMutePlayers = {}
local MetaPlayer = FindMetaTable("Player")

function ShouldBlockChat(ply, txt, tChat, pIsDead)
	if table.HasValue(ChatMutePlayers, ply) then
		return true
	end
end
hook.Add("OnPlayerChat", "CheckIsChatMuted", ShouldBlockChat)

function MetaPlayer:IsChatMuted()
	if table.HasValue(ChatMutePlayers, self) then
		return true
	end
	return false
end

function MetaPlayer:SetChatMuted()
	local target = self
	if not target then return end

	if target:IsPlayer() and not table.HasValue(ChatMutePlayers, target) then
		table.insert(ChatMutePlayers, target)
	elseif target:IsPlayer() and table.HasValue(ChatMutePlayers, target) then
		for _, v in pairs(ChatMutePlayers) do
			if v == target then
				table.remove(ChatMutePlayers, _)
			end
		end
	end
end