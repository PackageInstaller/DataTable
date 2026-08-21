local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BUILDING_CONFIG = require("uimodule.building.building_config")

function ui:on_click_BgClose()
  self:ui_hide()
end

function ui:on_click_CloseBtn()
  self:ui_hide()
end

function ui:on_click_Unlock()
  if not BuildingMgr:building_level_up_check(self.v_building_type, self.v_target_level, true) then
    return
  end
  self:ui_hide()
  UIMgr:try_show_ui("building_tower_view", nil, self.v_building_type, self.v_target_level)
end

function ui:ui_finish_load()
  self.v_asset_item_info_list = {
    {
      item_id = BUILDING_CONFIG.BUILDING_USE_ITEM.ITEM_31
    }
  }
  self:set_button("BgClose", function()
    self:on_click_BgClose()
  end)
  self:set_button("CloseBtn", function()
    self:on_click_CloseBtn()
  end)
  self:set_button("Unlock", function()
    self:on_click_Unlock()
  end)
end

function ui:ui_on_show(building_type)
  self:refresh_view(building_type)
end

function ui:refresh_view(building_type)
  self.v_target_level = 1
  self.v_building_type = building_type
  local buidling_cfg = ShareRes.get_building_cfg(self.v_building_type)
  self.v_target_level_cfg = ShareRes.get_building_level_cfg(self.v_building_type, self.v_target_level)
  self.v_uicompents.Build_txt.text = buidling_cfg.Name
  self.v_uicompents.Effect_txt.text = self.v_target_level_cfg.UnlockEffectDesc[self.v_target_level]
  self.v_uicompents.Condition_txt.text = ShareRes.get_condition_desc(self.v_target_level_cfg.Condition[self.v_target_level])
  local con_pass = Condition:check_condition(self.v_target_level_cfg.Condition[self.v_target_level])
  self.v_uiobjects.Reached:SetActive(con_pass)
  self.v_uiobjects.NotReached:SetActive(not con_pass)
  local color = con_pass and "8d4b15" or "484243"
  Util.set_color(self.v_uicompents.Condition_txt, color)
  ResMgr:load_set_icon(self.v_uicompents.BuildIcon_img, buidling_cfg.IconPath)
  self:refresh_cost_item()
  self:refresh_button_state()
end

function ui:refresh_cost_item()
  local is_need_cost = Util.is_more_than_zero(self.v_target_level_cfg.ConsumeItemId) and Util.is_more_than_zero(self.v_target_level_cfg.ConsumeItemCount)
  self.v_uiobjects.Curr:SetActive(is_need_cost)
  if is_need_cost then
    local cur_count = BagMgr:get_item_num(self.v_target_level_cfg.ConsumeItemId)
    local cur_count_str = cur_count
    if cur_count < self.v_target_level_cfg.ConsumeItemCount then
      cur_count_str = "<color=#d74343>" .. cur_count .. "</color>"
    end
    self.v_uicompents.CurrNow_txt.text = cur_count_str
    self.v_uicompents.CurrNeed_txt.text = self.v_target_level_cfg.ConsumeItemCount
    local icon_path = ShareRes.get_item_icon_path(self.v_target_level_cfg.ConsumeItemId)
    ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, icon_path)
  end
end

function ui:refresh_button_state()
  local can_level_up = BuildingMgr:building_level_up_check(self.v_building_type, self.v_target_level)
  self.v_uiobjects.Unlock:SetActive(can_level_up)
  self.v_uiobjects.Insufficient:SetActive(not can_level_up)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

return ui
