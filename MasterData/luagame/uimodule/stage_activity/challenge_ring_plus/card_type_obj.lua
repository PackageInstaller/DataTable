local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self.v_btn = Util.get_button(nil, self.v_object)
end

function ui:ui_wrap(parent, gameobj)
  self = Base.ui_wrap(self, parent, gameobj)
  self.v_object:SetActive(true)
  return self
end

function ui:set_data(type)
  local card_type_cfg = ShareRes.get_curse_ring_card_type_cfg(type)
  ResMgr:load_set_icon(self.v_uicompents.TypeIcon1_img, card_type_cfg.TypeIcon)
  ResMgr:load_set_icon(self.v_uicompents.TypeIcon2_img, card_type_cfg.TypeIcon)
  self:set_button_listener(self.v_btn, function()
    self.v_parent_ui:on_click_type_icon(type)
  end)
end

function ui:on_select(is_select)
  self.v_uiobjects.Select:SetActive(is_select)
end

return ui
