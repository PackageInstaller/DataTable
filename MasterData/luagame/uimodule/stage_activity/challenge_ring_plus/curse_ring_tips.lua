local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(content_pos, show_info, callback)
  self.v_uicompents.ItemDescTem_txt.text = show_info.desc
  self.v_uicompents.ItemName_txt.text = show_info.name
  if show_info.effect_desc then
    self.v_uicompents.ItemEffctTem_txt.text = show_info.effect_desc
  end
  self.v_uicompents.Content_rect:SetAnchoredPositionA(content_pos.pos_x, content_pos.pos_y)
  self.v_uiobjects.EffctObj:SetActive(not show_info.is_hide_effct_desc)
  ResMgr:load_set_icon(self.v_uicompents.CurseIcon_img, show_info.icon_path)
  self.v_cb = callback
end

function ui:ui_on_hide()
  local cb = self.v_cb
  if cb then
    cb()
  end
end

function ui:ui_on_destroy()
end

return ui
