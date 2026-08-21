local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local WEEKLY_CFG = require("gamelogic.weekly.weekly_config")

function ui:ui_finish_load()
  self:set_button("BtnEffectDetail", function()
    UIMgr:get_ui("weekly_pvp_stage_tip"):ui_show(self.v_group_cfg.StageDesc)
  end)
end

function ui:ui_update()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  if self.v_effect_obj then
    self.v_parent_ui:give_back_effect_obj(self.v_element_id, self.v_effect_obj)
    self.v_effect_obj = nil
  end
end

function ui:click_effect()
  local battle_type = WeeklyMgr:get_battle_type()
  local cur_team = WeeklyMgr:get_pvp_stage_buddy_team(self.v_stage, false)
  WeeklyMgr:set_weekly_stage(self.v_stage)
  if cur_team and next(cur_team) then
    UIMgr:get_ui("weekly_pvp_stage"):ui_show()
  else
    UIMgr:get_ui("team"):ui_show(nil, self.v_first_episode_data.epi_id, battle_type)
  end
end

function ui:set_data(data, is_right, stage)
  self.v_stage_data = data
  local _, first_episode_data = next(self.v_stage_data.epi_data)
  self.v_first_episode_data = first_episode_data
  self.v_stage = stage
  self:update_hurdle_info(is_right)
  self:update_team_view()
  self:refresh_curr_star()
end

function ui:update_hurdle_info(is_right)
  local cur_fraction = WeeklyMgr:get_pvp_stage_total_score(self.v_stage)
  self.v_uicompents.Score_txt.text = cur_fraction
  local data = self.v_stage_data
  local epi_group_id = data.epi_group_id
  local stage = data.epi_stage
  if not epi_group_id then
    Log.Error("获取关卡库ID失败", debug.traceback())
    return
  end
  local group_cfg = ShareRes.get_weekly_pvp_epi_pool_cfg(epi_group_id)
  self.v_group_cfg = group_cfg
  self.v_uicompents.StageName_txt.text = group_cfg.StageName
  self.v_element_id = group_cfg.EffectJoint
  local element_icon = is_right and group_cfg.ElementRightPicture or group_cfg.ElementLeftPicture
  ResMgr:load_set_icon(self.v_uicompents.StageIcon_img, element_icon, nil, true, self)
  local child_cout = self.v_uiobjects.StageIcon.transform.childCount
  local path
  for index = 1, child_cout do
    path = group_cfg.ElementDebrisPrefix .. index
    ResMgr:load_set_icon(self.v_uicompents["Icon" .. index .. "_img"], path, nil, true, self)
  end
  if not self.v_effect_obj then
    self.v_effect_obj = self.v_parent_ui:get_effect_obj(self.v_element_id)
  end
  if self.v_effect_obj then
    self.v_effect_obj.transform:SetParent(self:get_object_transform(), false)
    self.v_effect_obj.transform.localPosition = UnityVector3.zero
  end
  self:set_button("BtnReset", function()
    local cancel_btn = Util.format_str("取消")
    local sure_btn = Util.format_str("确认")
    
    local function sure_fun()
      WeeklyMgr:request_week_acty_pvp_epi_reset(stage)
    end
    
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_fun, nil, WEEKLY_CFG.pvp_reset_tips, sure_btn, cancel_btn)
  end)
end

function ui:update_team_view()
  local cur_team = WeeklyMgr:get_pvp_stage_buddy_team(self.v_stage, false)
  local pos_data = {}
  if cur_team then
    for _, data in pairs(cur_team) do
      pos_data[data.buddy_pos] = data
    end
  end
  local have_buddy
  for i = 1, 3 do
    local item = self.v_parent_ui:get_team_buddy_item()
    item.transform:SetParent(self.v_uiobjects.CharList.transform)
    item.transform:SetLocalScaleA(1)
    local data = pos_data[i]
    self:update_buddy_info(data, item)
    have_buddy = have_buddy or nil ~= data and Util.is_more_than_zero(data.buddy_id)
  end
  self.v_uiobjects.BtnReset.gameObject:SetActive(have_buddy)
end

function ui:update_buddy_info(data, item)
  local buddy_id = 0
  if data then
    buddy_id = data.buddy_id
  end
  local char_icon_obj = Util.get_child_gameobj("CharIcon", item)
  char_icon_obj:SetActive(false)
  local no_char_obj = Util.get_child_gameobj("NoChar", item)
  no_char_obj:SetActive(false)
  if buddy_id and 0 ~= buddy_id then
    char_icon_obj:SetActive(true)
    local img = Util.get_image("CharIcon", item)
    local path = CharacterMgr:get_buddy_icon_path(buddy_id, true)
    ResMgr:load_set_icon(img, path)
  else
    no_char_obj:SetActive(true)
  end
end

function ui:refresh_curr_star()
  local curr_star = WeeklyMgr:get_pvp_curr_star(self.v_stage_data.epi_stage)
  local total_star = WeeklyMgr:get_pvp_total_star(self.v_stage_data.epi_stage)
  self.v_uicompents.StarNow_txt.text = curr_star
  self.v_uicompents.StarMax_txt.text = total_star
end

return ui
