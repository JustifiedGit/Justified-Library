# JustifiedLibrary

Justified-Library is accessible to the general public, but is predominantly utilised by the Justified.co community.

## Coloring
```lua
jlib.theme.font
jlib.theme.accent
```

**Frame**

```lua
jlib.theme.frame_header_color

jlib.theme.frame_base_color

jlib.theme.frame_secondary_color

jlib.theme.frame_content_color

jlib.theme.frame_close_color

jlib.theme.frame_close_icon_color

jlib.theme.frame_title_color

jlib.theme.frame_title_secondarycolor
```

**Text Color**

```lua
jlib.theme.text_color
```

**TextEntry**

```lua
jlib.theme.textentry_base_color
jlib.theme.textentry_text_color
jlib.theme.textentry_placeholder_color
jlib.theme.textentry_cursor_color
```

**Button**

```lua
jlib.theme.button_base_color
jlib.theme.button_hover_color
jlib.theme.button_click_color
jlib.theme.button_hover_alternative
jlib.theme.button_text_color
```

**Scroller**

```lua
jlib.theme.scroller_base_color
jlib.theme.scroller_grip_color
```

**ComboBox**

```lua
jlib.theme.combobox_base_color
jlib.theme.combobox_click_color
jlib.theme.error
jlib.theme.success
```

**Loading**

```lua
jlib.theme.loading_background
jlib.theme.loading_inside
```

## Messages
```lua
ply:jlib_message(color_red, "[JUSTIFIED] ", color_white, " Test")
jlib.broadcast(color_red, "[JUSTIFIED] ", color_white, " Test")
```

## VGUI
```lua
vgui.Register("jlib.Frame", PANEL, "EditablePanel")
```


