
-- Credit to Mechanical Mind
util.AddNetworkString("SendChatMessage")

local meta = {}
meta.__index = meta

function meta:AddText(string, color)
	local t = {}
	t.string = string
	t.color = color or color_white
	table.insert(self.msgs, t)
	return self
end

function meta:SendAll()
	self:NetConstructMsg()
	net.Broadcast()
	return self
end

function meta:Send(ply)
	self:NetConstructMsg()
	net.Send(ply)
	return self
end

function meta:NetConstructMsg()
	net.Start("SendChatMessage")
	for k, msg in pairs(self.msgs) do
		net.WriteUInt(1,8)
		net.WriteString(msg.string)
		net.WriteVector(Vector(msg.color.r, msg.color.g, msg.color.b))
	end
	net.WriteUInt(0,8)
end

function ChatText()
	local t = {}
	t.msgs = {}
	setmetatable(t, meta)
	return t
end