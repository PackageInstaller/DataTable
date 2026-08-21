local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local INIT_X = 329

function ui:ui_finish_load()
  self.v_init_y = self.v_uicompents.Content_rect.anchoredPosition.y
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(option_index, option_id, is_init)
  self.v_is_confirm_select = false
  self.v_is_select = false
  self.v_option_id = option_id
  self.v_option_index = option_index
  local option_cfg = ShareRes.get_curse_event_option_cfg(self.v_option_id)
  self.v_uicompents.EffectDesc_txt.text = option_cfg.Effect
  self.v_uicompents.Behavior_txt.text = option_cfg.Behavior
  self.v_uiobjects.Choose:SetActive(false)
  self:set_button_listener(self:get_button(), function()
    self:on_click_btn()
  end)
  self.v_uicompents.OptionContentIn_pd:ResetPD()
  if is_init then
    self.v_uicompents.OptionContentIn_pd:Play()
  end
  self.v_uiobjects.Content.transform:SetAnchoredPositionA(0, self.v_init_y)
end

function ui:on_click_btn()
  self.v_parent_ui:on_select_option_item(self.v_option_index, self.v_option_id)
end

function ui:on_select_option(option_id, is_seleced)
  self.v_is_confirm_select = self.v_is_select == true and self.v_option_id == option_id
  local last_select = self.v_is_select
  local cur_select = self.v_option_id == option_id
  self.v_uiobjects.Choose:SetActive(cur_select)
  local dist, pd
  if last_select and not cur_select then
    dist = 0
    pd = self.v_uicompents.OptionOutPd_pd
  elseif not last_select and cur_select then
    pd = self.v_uicompents.OptionInPd_pd
    dist = -30
  end
  if dist then
    self.v_uiobjects.Content.transform:DOLocalMoveX(dist, pd.duration)
  end
  self.v_is_select = cur_select
  if self.v_is_confirm_select then
    self:on_confirm_select()
  end
end

function ui:on_confirm_select()
  self.v_parent_ui:confirm_select_option(self.v_option_index, self.v_option_id)
end

function ui:set_canvas_group_alpha(alpha)
  local cg = self:get_canvas_group()
  cg.alpha = alpha
end

return ui
