AddCSLuaFile();

SWEP.PrintName			= "Prop Seller"
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.ViewModelFOV		= 55
SWEP.ViewModelFlip		= false
SWEP.CSMuzzleFlashes	= true
SWEP.Slot 				= 5
SWEP.SlotPos			= 1


SWEP.Author			= "Mythikos"
SWEP.Contact		= "n/a"
SWEP.Purpose		= "Selling Props back to the shop"
SWEP.Instructions	= "Primary fire: Sell the prop you are aiming at"

SWEP.Weight				= 3
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= true

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.ViewModel			= "models/weapons/v_toolgun.mdl"
SWEP.WorldModel			= "models/weapons/w_toolgun.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:PrimaryAttack()
	local tr = self.Owner:GetEyeTrace()
	if not self:IsTraceValid(tr) then return end
	
	local ent = tr.Entity 
	if SERVER then
		if ent:GetClass() == "prop_physics" then
			if ent:CPPIGetOwner() == self.Owner then
				for _, prop in pairs(Props) do
					print(ent:GetModel())
					print(prop.Model)
					if string.lower(ent:GetModel()) == string.lower(prop.Model) then
						self.Owner:AddCash(prop.Price)
						self:RemoveEnt(ent, self.Owner)
					end	
				end
			end
		end
	end
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
	return false
end 

function SWEP:RemoveEnt(ent, ply)
	if CLIENT then return true end
	
	timer.Simple( 1, function()
		if (ent:IsValid()) then
			ent:Remove()
		end 
	end)
	
	ent:SetNotSolid( true )
	ent:SetMoveType( MOVETYPE_NONE )
	ent:SetNoDraw( true )
	
	local ed = EffectData()
	ed:SetEntity( ent )
	util.Effect( "entity_remove", ed, true, true )
	ply:EmitSound("ambient/levels/labs/coinslot1.wav", 150, 100)
	
	return true
end

function SWEP:IsTraceValid(tr)
	if not tr.Entity:IsValid() then return false end
	if tr.Entity:IsPlayer() then return false end
	if tr.Entity:IsNPC() then return false end
	return true
end

if CLIENT then
	local function DrawScrollingText( text, y, texwide )
		local w, h = surface.GetTextSize( text  )
		w = w + 64

		local x = math.fmod( CurTime() * 400, w ) * -1

		while ( x < texwide ) do
		
			surface.SetTextColor( 0, 0, 0, 255 )
			surface.SetTextPos( x + 3, y + 3 )
			surface.DrawText( text )

			surface.SetTextColor( 255, 255, 255, 255 )
			surface.SetTextPos( x, y )
			surface.DrawText( text )

			x = x + w

		end

	end

	function SWEP:RenderScreen()
		local TEX_SIZE = 256
		local toolName = "Prop Seller"
		local oldW = ScrW()
		local oldH = ScrH()
		
		-- Set the material of the screen to our render target
		Material("models/weapons/v_toolgun/screen"):SetTexture( "$basetexture", GetRenderTarget("GModToolgunScreen", 256, 256))
		
		local OldRT = render.GetRenderTarget()
		
		-- Set up our view for drawing to the texture
		render.SetRenderTarget(GetRenderTarget("GModToolgunScreen", 256, 256))
		render.SetViewPort( 0, 0, TEX_SIZE, TEX_SIZE )
		cam.Start2D()
		
		-- Background
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetTexture(surface.GetTextureID( "models/weapons/v_toolgun/screen_bg" ))
		surface.DrawTexturedRect( 0, 0, TEX_SIZE, TEX_SIZE )

		-- Draw the text
		surface.SetFont( "GModToolScreen" )
		DrawScrollingText( toolName, 64, TEX_SIZE )

		cam.End2D()
		render.SetRenderTarget( OldRT )
		render.SetViewPort( 0, 0, oldW, oldH )
	end
end