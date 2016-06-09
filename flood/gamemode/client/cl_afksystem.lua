function CheckAFKTimerInit( )
    if not game.SinglePlayer() then
        timer.Create("CheckAFK", 15, 0, CheckAFK)
    end
end
hook.Add("InitPostEntity", "AfkCheckingHook", CheckAFKTimerInit)

-- CHECK AFK
local afkinfo = {ang = nil, pos = nil, mx = 0, my = 0, t = 0}
function CheckAFK()
    if not IsValid(LocalPlayer()) then return end
    if LocalPlayer():IsAdmin() then return end
    if not afkinfo.ang or not afkinfo.pos then
        afkinfo.ang = LocalPlayer():GetAngles()
        afkinfo.pos = LocalPlayer():GetPos()
        afkinfo.mx = gui.MouseX()
        afkinfo.my = gui.MouseY()
        afkinfo.t = CurTime()
        return
    end

    if LocalPlayer():GetNWInt("flood_afkticks") > 0 then
        if not timer.Exists("AFKCountDecay:"..LocalPlayer():UniqueID()) then 
            timer.Create("AFKCountDecay:"..LocalPlayer():UniqueID(), 600, 1, function()
                LocalPlayer():SetNWInt("flood_afkticks", 0)
                chat.AddText(Color(255, 140, 0), "[AFK System] ", color_white, "AFK count before kick has been reset.")
            end)
        end
    end

    if LocalPlayer():Alive() then
        afk_timer = 30
        if afk_timer <= 0 then afk_timer = 30 end 
        
        if LocalPlayer():GetAngles() != afkinfo.ang then
            afkinfo.ang = LocalPlayer():GetAngles()
            afkinfo.t = CurTime()
        elseif gui.MouseX() != afkinfo.mx or gui.MouseY() != afkinfo.my then
            afkinfo.mx = gui.MouseX()
            afkinfo.my = gui.MouseY()
            afkinfo.t = CurTime()

        elseif LocalPlayer():GetPos():Distance(afkinfo.pos) > 10 then
            afkinfo.pos = LocalPlayer():GetPos()
            afkinfo.t = CurTime()

        elseif CurTime() > (afkinfo.t + afk_timer) then
            if LocalPlayer():GetNWInt("flood_afkticks") >= 5 then
                RunConsoleCommand("kickplayer")
            end
        elseif CurTime() > (afkinfo.t + (afk_timer / 2)) then
            chat.AddText(Color(255, 140, 0), "[AFK System] ", color_white, "You will be slain if you do not regain activity.")
            if timer.Exists("AFKCountDecay:"..LocalPlayer():UniqueID()) then 
                timer.Destroy("AFKCountDecay:"..LocalPlayer():UniqueID())
            end
        end
    end
end