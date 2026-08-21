local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:on_click_Btn()
  if self.v_is_lock then
    Util.show_message_tip(2247)
  else
    self.v_parent_ui:refresh_selected(self.v_cfg, self.v_idx, true)
  end
end

function ui:ui_finish_load()
  self:set_button("Btn", function()
    self:on_click_Btn()
  end, true)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:update_selected(selected, is_click)
  if selected then
    self.v_uiobjects.Selected:SetActiveEx(false)
  elseif not is_click then
    self.v_uiobjects.TitleBgUnselected:SetActiveEx(false)
  end
  self.v_uiobjects.Selected:SetActiveEx(selected)
  self.v_uiobjects.TitleBgSelected:SetActiveEx(selected)
  self.v_uiobjects.TitleBgUnselected:SetActiveEx(not selected)
end

function ui:set_data(activity_id, cfg, index, is_lock)
  self.v_activity_id = activity_id
  self.v_cfg = cfg
  self.v_idx = index
  self.v_is_lock = is_lock
  self.v_uicompents.Title_txt.text = Util.format_str("问题{1}", Config.NUMBER_TO_CHINESE[index])
  self.v_uicompents.Desc_txt.text = cfg.QuestionDesc
  self.v_uiobjects.Lock:SetActiveEx(self.v_is_lock)
end

return ui
