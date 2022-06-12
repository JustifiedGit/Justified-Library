jlib = jlib or {}
local self = {}
self.font = "Rajdhani"
self.accent = Color(200, 47, 104)
--[[
    Frame
]]
self.frame_header_color = Color(32, 32, 35)
self.frame_base_color = Color(28, 28, 31)
self.frame_secondary_color = Color(26, 26, 29)
self.frame_content_color = Color(23, 23, 26)
self.frame_close_color = Color(184, 52, 52)
self.frame_close_icon_color = Color(220, 220, 220)
self.frame_title_color = Color(233, 233, 233)
self.frame_title_secondarycolor = Color(192, 192, 192)
--[[
    Text Color
]]
self.text_color = Color(220, 220, 220)
--[[
    TextEntry
]]
self.textentry_base_color = Color(30, 30, 33)
self.textentry_text_color = Color(220, 220, 220)
self.textentry_placeholder_color = Color(175, 175, 175)
self.textentry_cursor_color = Color(19, 19, 19)
--[[
    Button
]]
self.button_base_color = Color(30, 30, 33)
self.button_hover_color = Color(37, 37, 40)
self.button_click_color = Color(65, 65, 68)
self.button_hover_alternative = Color(35, 35, 38)
self.button_text_color = Color(220, 220, 220)
--[[
    Scroller
]]
self.scroller_base_color = Color(20, 20, 23)
self.scroller_grip_color = Color(26, 26, 30)
--[[
    ComboBox
]]
self.combobox_base_color = Color(22, 22, 25)
self.combobox_click_color = Color(35, 35, 38)
self.error = Color(184, 64, 64)
self.success = Color(64, 184, 144)
--[[
    Loading
]]
self.loading_background = Color(22, 22, 25)
self.loading_inside = Color(0, 119, 255)
jlib.theme = self