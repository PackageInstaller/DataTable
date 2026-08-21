local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ADVENTURE_TASK_STATE = Config.CommonDefine.ADVENTURE_TASK_STATE
local QUALITY_TO_EFFECT_NAME = {
  "B",
  "A",
  "S"
}
local BUILDING_CONFIG = require("uimodule.building.building_config")

function ui:on_click_btn()
  local task_data = BuildingMgr:get_adventrue_task_data(self.v_task_type, self.v_task_index)
  if not task_data then
    return
  end
  if task_data.state == ADVENTURE_TASK_STATE.COMPLETE then
    if self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BRANCH and not Util.is_more_than_zero(BuildingMgr:get_branch_next_refresh_time()) then
      return
    end
    Util.show_message_tip(2248)
    return
  end
  local can_get_award = BuildingMgr:check_adventrue_task_can_get_award(self.v_task_type, self.v_task_index)
  if self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BRANCH or self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.SPECIAL or self.v_task_type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BOX then
    if self.v_is_special then
      BuildingMgr:close_local_storage_redpoint(task_data.id .. "first")
      local type_cfg = ShareRes.get_building_adventure_type(self.v_task_type)
      if type_cfg.ClueCount <= BuildingMgr:get_all_clue_count() then
        BuildingMgr:close_local_storage_redpoint(task_data.id .. "enough")
      end
    else
      BuildingMgr:close_local_storage_redpoint(task_data.id)
    end
    if not can_get_award then
      BuildingMgr:check_adventrue_task_redpoint()
    end
  end
  if can_get_award then
    local task_id = self.v_task_id
    local task_cfg = ShareRes.get_adventrue_task_cfg(task_id)
    local story_id, chain_centre_event_id
    if task_cfg then
      story_id = task_cfg.StoryId
      chain_centre_event_id = task_cfg.ChainCentreEventId
    end
    
    local function get_cb()
      if self:visible() then
        local function story_end_cb()
          BuildingMgr:try_show_adventrue_task_award()
          
          if Util.is_more_than_zero(chain_centre_event_id) then
            UIMgr:get_ui("building_batch_tips"):ui_show(task_id, true)
          end
        end
        
        if Util.is_more_than_zero(story_id) then
          StoryMgr:on_start(story_id)
          StoryMgr:set_story_end_cb(story_id, story_end_cb)
        else
          story_end_cb()
        end
      end
    end
    
    BuildingMgr:requst_adventure_gain_task_reward(self.v_task_type, self.v_task_index, task_data.is_history, get_cb)
    return
  else
    UIMgr:get_ui("building_adventrue_room"):ui_show(task_data)
  end
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  local task_data = BuildingMgr:get_adventrue_task_data(self.v_task_type, self.v_task_index)
  if not task_data then
    return
  end
  if self.v_is_special then
    BuildingMgr:close_local_storage_redpoint(task_data.id .. "first")
  else
    BuildingMgr:close_local_storage_redpoint(task_data.id)
  end
end

function ui:ui_on_destroy()
end

function ui:set_data(task_data)
  self.v_task_type = task_data.type
  self.v_task_index = task_data.index
  self.v_task_id = task_data.id
  self.v_is_special = task_data.type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.SPECIAL
  self.v_is_batch = task_data.type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BRANCH
  self.v_is_box = task_data.type == BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BOX
  return self:refresh_data(task_data)
end

function ui:refresh_empty_data()
  local uiobjs = self.v_uiobjects
  if uiobjs.Searching then
    uiobjs.Searching:SetActive(true)
  end
  uiobjs.Award:SetActive(false)
  uiobjs.Finish:SetActive(false)
  uiobjs.NorBg:SetActive(false)
  uiobjs.OnGoing:SetActive(false)
  uiobjs.Recive:SetActive(false)
  uiobjs.Red:SetActive(false)
  uiobjs.SpBg:SetActive(true)
  uiobjs.Time:SetActive(false)
  if not Util.is_nil(uiobjs.BoxBg) then
    uiobjs.BoxBg:SetActive(false)
  end
end

function ui:refresh_data(task_data)
  local task_cfg = ShareRes.get_adventrue_task_cfg(self.v_task_id)
  local quality_cfg = ShareRes.get_adventrue_task_quality_cfg(task_cfg.Quality)
  local is_comp, is_dispatching, is_recive, is_can_get_award, need_count_down = false, false, false, false, false
  if task_data.state == ADVENTURE_TASK_STATE.COMPLETE then
    is_comp = true
    if self.v_is_batch then
      if Util.is_more_than_zero(BuildingMgr:get_branch_next_refresh_time()) then
        need_count_down = true
      else
        self:refresh_empty_data()
        return
      end
    end
  elseif task_data.state == ADVENTURE_TASK_STATE.INIT then
    is_recive = true
  elseif task_data.state == ADVENTURE_TASK_STATE.UNDER_WAY then
    if BuildingMgr:check_adventrue_task_explore_time(task_data.id, task_data.explore_time) then
      is_can_get_award = true
    else
      is_dispatching = true
      need_count_down = true
    end
  end
  local show_red = is_can_get_award
  if not show_red and (self.v_is_batch or self.v_is_special) and task_data.state ~= ADVENTURE_TASK_STATE.COMPLETE then
    if self.v_is_special then
      show_red = BuildingMgr:check_local_storage_redpoint(task_data.id .. "first")
      if not show_red then
        local type_cfg = ShareRes.get_building_adventure_type(task_data.type)
        if type_cfg.ClueCount <= BuildingMgr:get_all_clue_count() then
          show_red = BuildingMgr:check_local_storage_redpoint(task_data.id .. "enough")
        end
      end
    else
      show_red = BuildingMgr:check_local_storage_redpoint(task_data.id)
    end
  end
  if need_count_down then
    self:refresh_dispatch_time()
  end
  local uiobjs = self.v_uiobjects
  uiobjs.Award:SetActive(is_can_get_award)
  uiobjs.Finish:SetActive(is_comp)
  uiobjs.NorBg:SetActive(not self.v_is_special)
  uiobjs.OnGoing:SetActive(is_dispatching)
  ResMgr:load_set_icon(self.v_uicompents.Quality_img, quality_cfg.QualityBgPath)
  uiobjs.Recive:SetActive(is_recive)
  uiobjs.Red:SetActive(show_red)
  uiobjs.SpBg:SetActive(self.v_is_special)
  if not Util.is_nil(uiobjs.BoxBg) then
    uiobjs.BoxBg:SetActive(self.v_is_box)
  end
  uiobjs.Time:SetActive(need_count_down)
  if uiobjs.Searching then
    uiobjs.Searching:SetActive(false)
  end
  local max_effect_lv = #QUALITY_TO_EFFECT_NAME
  for quality, effect_name in pairs(QUALITY_TO_EFFECT_NAME) do
    local effect = self:get_child_gameobj(effect_name, uiobjs.Quality)
    if effect then
      effect.gameObject:SetActive(not is_comp and (task_cfg.Quality == quality or max_effect_lv <= task_cfg.Quality and max_effect_lv == quality))
    end
  end
  self:set_button_listener(nil, function()
    self:on_click_btn()
  end)
  return is_can_get_award, show_red
end

function ui:refresh_dispatch_time()
  local task_data = BuildingMgr:get_adventrue_task_data(self.v_task_type, self.v_task_index)
  if not task_data then
    return
  end
  local is_can_get_award, show_red = false
  local quality_cfg = ShareRes.get_adventrue_task_quality_cfg_by_task_id(self.v_task_id)
  local cur_time = Date.server_time()
  local is_count_down, end_time
  if task_data.state == ADVENTURE_TASK_STATE.UNDER_WAY then
    local explore_time = quality_cfg.Time * 3600
    end_time = explore_time + (task_data.explore_time or 0) - cur_time
  elseif self.v_is_batch and task_data.state == ADVENTURE_TASK_STATE.COMPLETE then
    local refresh_time = BuildingMgr:get_branch_next_refresh_time()
    if Util.is_more_than_zero(refresh_time) then
      end_time = refresh_time - cur_time
    end
  end
  is_count_down = end_time and end_time > 0
  if is_count_down then
    self.v_uicompents.Time_txt.text = Date.get_time_formate_4(end_time, true)
  end
  if self.v_last_count_down ~= is_count_down then
    self.v_last_count_down = is_count_down
    is_can_get_award, show_red = self:refresh_data(task_data)
  elseif self.v_is_batch or self.v_is_special or self.v_is_box then
    show_red = task_data.state ~= ADVENTURE_TASK_STATE.COMPLETE and BuildingMgr:check_local_storage_redpoint(task_data.id)
  end
  self.v_uiobjects.Time:SetActiveEx(is_count_down)
  return is_can_get_award, show_red
end

return ui
