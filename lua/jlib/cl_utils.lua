local FrameTime = FrameTime
local cam_Start3D2D = cam.Start3D2D
local surface_SetDrawColor = surface.SetDrawColor
local draw_NoTexture = draw.NoTexture
local draw_SimpleText = draw.SimpleText
local surface_SetMaterial = surface.SetMaterial
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local cam_End3D2D = cam.End3D2D
local Lerp = Lerp
local LerpVector = LerpVector
local Vector = Vector
local Color = Color
local math_cos = math.cos
local math_rad = math.rad
local math_sin = math.sin
local surface_DrawPoly = surface.DrawPoly
local ipairs = ipairs
local math_Clamp = math.Clamp
local CurTime = CurTime
local draw_NoTexture = draw.NoTexture
local surface_SetDrawColor = surface.SetDrawColor
local ColorAlpha = ColorAlpha
local table_remove = table.remove
local input_IsMouseDown = input.IsMouseDown
local input_GetCursorPos = input.GetCursorPos
local ScrW = ScrW
local ScrH = ScrH
local sound_Play = sound.Play
local LocalPlayer = LocalPlayer
local math_random = math.random
local hook_Add = hook.Add
local self = {}
self.CircleCache = {}

function self:PLerp(rate, from, to)
    if from / to > 0.998 then
        return to
    else
        return Lerp(rate, from, to)
    end
end

function self:LerpColor(rate, colfrom, colto)
    local newcolor = LerpVector(rate, Vector(colfrom.r, colfrom.g, colfrom.b), Vector(colto.r, colto.g, colto.b))

    return Color(newcolor[1], newcolor[2], newcolor[3])
end

-- Thanks Wiremod.
function self:AdvanceColor(rv1, rv2, rv3)
    rv1 = Vector(rv1.r, rv1.g, rv1.b)
    rv2 = Vector(rv2.r, rv2.g, rv2.b)
    local p = rv1[1] * rv3 + rv2[1] * (1 - rv3)
    local y = rv1[2] * rv3 + rv2[2] * (1 - rv3)
    local r = rv1[3] * rv3 + rv2[3] * (1 - rv3)

    return Color(p, y, r)
end

function self:Circle(x, y, r)
    local circle = {}

    for i = 1, 360 do
        circle[i] = {}
        circle[i].x = x + math_cos(math_rad(i * 360) / 360) * r
        circle[i].y = y + math_sin(math_rad(i * 360) / 360) * r
    end

    surface_DrawPoly(circle)
end

function self:ClickingAnimationHandle(me, size, accent)
    size = size * 2
    me.ClickingAnimationTable = me.ClickingAnimationTable or {}

    for id, data in ipairs(me.ClickingAnimationTable) do
        local progress = 1 - math_Clamp(data.creation + data.duration - CurTime(), 0, 1)
        draw_NoTexture()
        surface_SetDrawColor(ColorAlpha(accent, math_Clamp(255 - progress / 1 * 255, 0, 100)))
        self:Circle(data.x, data.y, progress / 1 * size, 20)

        if CurTime() >= data.creation + data.duration then
            table_remove(me.ClickingAnimationTable, id)
        end
    end
end

function self:DoClickAnimation(me, duration)
    if me.ClickingAnimationTable == nil then return end
    local x, y = me:CursorPos()

    me.ClickingAnimationTable[#me.ClickingAnimationTable + 1] = {
        ["x"] = x,
        ["y"] = y,
        ["creation"] = CurTime(),
        ["duration"] = duration
    }
end

function self:PerformDrag(s, me)
    if s.hovering == nil then
        s.hovering = false
    end

    if me:IsHovered() and input_IsMouseDown(MOUSE_LEFT) then
        s.hovering = true
    end

    if s.hovering then
        if s.offsetPos == nil then
            x, y = s:LocalCursorPos()

            s.offsetPos = {x, y}
        end

        local x, y = input_GetCursorPos()
        local cpx, cpy = s.offsetPos[1], s.offsetPos[2]
        s:SetPos(math_Clamp(x - cpx, 5, ScrW() - s:GetWide() - 5), math_Clamp(y - cpy, 5, ScrH() - s:GetTall() - 5))
    else
        s.offsetPos = nil
    end

    if not input_IsMouseDown(MOUSE_LEFT) then
        s.hovering = false
    end
end

function self.ScaleW(amt)
    if not self.maxWidth then
        self.maxWidth = ScrW()
    end

    return math_Clamp(amt * self.maxWidth / 640.0, 0, self.maxWidth)
end

function self.ScaleH(amt)
    if not self.maxHeight then
        self.maxHeight = ScrH()
    end

    return math_Clamp(amt * self.maxHeight / 340.0, 0, self.maxHeight)
end

function self:InteractSound(hover, pnl)
    if not pnl._JLIB_HELD then
        pnl._JLIB_HELD = false
    end

    if hover and not pnl._JLIB_HELD then
        sound_Play("jlib/hover.wav", LocalPlayer():GetPos(), 75, math_random(130, 145), 1)
        pnl._JLIB_HELD = true
    end

    if not hover and pnl._JLIB_HELD then
        pnl._JLIB_HELD = false
    end
end

local xoffset = -15
local hoffset = 85
local iconSize = 64
local unload_distance = 50000

function self.DrawNPCData(ent, text, icon, extra)
    ent.alphaAnim = ent.alphaAnim or 0
    ent.alphaAnim = Lerp(FrameTime() * 15, ent.alphaAnim, LocalPlayer():GetPos():DistToSqr(ent:GetPos()) > unload_distance and 0 or 255)
    if ent.alphaAnim < 1 then return end
    local ang = ent:GetAngles()
    ang:RotateAroundAxis(ang:Right(), -90)
    ang:RotateAroundAxis(ang:Up(), 90)
    cam_Start3D2D(ent:GetPos() + ent:GetAngles():Up() * (hoffset + 3 - (ent.alphaAnim / 255) * 3), ang, .1)
    local font = jlib.fonts.CreateFont(80, jlib.theme.font)
    local size_w, size_h = jlib.fonts.FontSurface(text, font)
    surface_SetDrawColor(ColorAlpha(jlib.theme.frame_secondary_color, ent.alphaAnim))
    draw_NoTexture()
    draw_SimpleText(text, font, xoffset + (-size_w / 2 + 42), 0, ColorAlpha(jlib.theme.text_color, ent.alphaAnim), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    surface_SetDrawColor(ColorAlpha(jlib.theme.text_color, ent.alphaAnim))
    surface_SetMaterial(jlib.materials.Material(icon))
    surface_DrawTexturedRectRotated(xoffset + (-size_w / 2), size_h / 2 - 3, iconSize, iconSize, 0)

    if extra then
        extra(size_w, size_h, xoffset, ent.alphaAnim)
    end

    cam_End3D2D()
end

hook_Add("OnScreenSizeChanged", "jlib.utils.updateScreenResolution", function(oldWidth, oldHeight)
    self.maxWidth = ScrW()
    self.maxHeight = ScrH()
end)

jlib.utils = self