local TEXTABLE = {}


/*
TEXTABLE LAYOUT
{"Text",Color(),duration,alrgorithm}
*/

surface.CreateFont( "TEXREND", {
	font = "Tehoma",
	size = 70,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "TEXREND_SMALL", {
	font = "Tehoma",
	size = 35,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


for I=0,20 do

surface.CreateFont( "TEXREND" .. I, {
	font = "Tehoma",
	size = 70 + I*1.5,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )





end 


 
function GM:DrawScreenText()
	local icou = 0 
	for k,v in pairs(TEXTABLE) do
		icou = icou + 1
		if !v.__DEX then 
			v.__DEX = {} 
			v.__DEX.STime = CurTime()

		end 
		local dur = v[3]
		local col = v[2]
		local text = v[1]
		local alg = v[4]
		surface.SetFont("TEXREND")
		local wi,hei = surface.GetTextSize("ABCDEFG")
		if alg == "flash" then 

			draw.SimpleText(text, "TEXREND", ScrW() / 2 , (ScrH() / 5) + icou * hei , Color(col.r,col.g,col.b,math.sin(CurTime()^1.144)*100 + 155), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			//print(100 + (  ( (CurTime() - v.__DEX.STime ) ^2) * 155))

		end 

		if alg == "sideside" then 

			draw.SimpleText(text, "TEXREND", (ScrW() / 2 ) + math.sin((CurTime() - v.__DEX.STime )*5) *100 , (ScrH() / 5) + icou * hei , Color(col.r,col.g,col.b,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			//print(100 + (  ( (CurTime() - v.__DEX.STime ) ^2) * 155))

		end 
		if alg == "pulse" then 

			draw.SimpleText(text, "TEXREND" .. math.abs(math.floor(math.sin((CurTime() - v.__DEX.STime )*5) * 20)), (ScrW() / 2 )  , (ScrH() / 5) + icou * hei , Color(col.r,col.g,col.b,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			//print(100 + (  ( (CurTime() - v.__DEX.STime ) ^2) * 155))

		end 
		if alg == "none" then 
			draw.SimpleText(text, "TEXREND" , (ScrW() / 2 )  , (ScrH() / 5) + icou * hei , Color(col.r,col.g,col.b,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end 
		if alg == "small" then 
			draw.SimpleText(text, "TEXREND_SMALL" , (ScrW() / 2 )  , (ScrH() / 5) + icou * hei , Color(col.r,col.g,col.b,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end


		if ((v.__DEX.STime + dur) - CurTime()) < 0 then 

			TEXTABLE[k] = nil
		end
	end 

end


hook.Add("HUDPaint","GMTEXREND",function()

	GAMEMODE:DrawScreenText()
end)

function GM:AddTextRegister(text,col,duration,type)
	for k,v in pairs(TEXTABLE) do
		if col == Color(123,123,123) then
			col = Color(math.random(1,255) ,math.random(1,255) ,math.random(1,255)  )

		end
		if v[1]==text then
			v[2] = col 
			v[3] = duration
		 return 
		end 
	end
	TEXTABLE[#TEXTABLE + 1] = {text,col,duration,type}
end
function GM:RemoveText(text)
	for k,v in pairs(TEXTABLE) do
		if v[1]==text then TEXTABLE[k] = nil end
	end


end

function GM:GetScreenMessage()

	local command = net.ReadString()
	local data = net.ReadTable()

	if command == "SCRTEXT_ADD" then
		GAMEMODE:AddTextRegister(unpack(data))
	end
	if command == "SCRTEXT_REMOVE" then
		GAMEMODE:RemoveText(unpack(data))
	end


end


net.Receive("GAMEMSG",GM.GetScreenMessage)

