local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LoopListClass = require("ui.widget.infinite_loop_list")
local StageItemClass = require("uimodule.activity.fish_game.fish_game_stage_item")
local _tinsert = table.insert
local _sort = table.sort
local CT_Timer = Global.ct_timer
local TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnTask", function()
    UIMgr:get_ui("fish_game_task"):ui_show()
  end)
  self.v_stage_view = LoopListClass:new(self, self.v_uiobjects.StageList, StageItemClass)
end

function ui:ui_on_show(activity_id)
  self.v_activity_id = activity_id
  if not self.v_activity_id then
    self.v_activity_id = NoviceMgr:get_fish_game_act_id()
  end
  local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  self.v_end_time = activity_cfg.PlayStopTime and Date.get_time_stamp_by_scheme_id(activity_cfg.PlayStopTime) or 0
  self:_set_time()
  self.v_stage_list_cfg = {}
  local temp_stage = ShareRes.get_fish_game_stage_list()
  for idx, temp_cfg in pairs(temp_stage) do
    if self.v_activity_id == temp_cfg.ActivityId then
      self.v_stage_list_cfg[temp_cfg.Id] = temp_cfg
    end
  end
  _sort(self.v_stage_list_cfg, function(a, b)
    return a.Id < b.Id
  end)
  self.v_stage_view:refresh_data(self.v_stage_list_cfg)
  self:bind_auto_mq(Const.ON_FISH_GAME_REFRESH, self.refresh_epi, self)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_red, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close2, self)
  self:refresh_task_red()
end

function ui:refresh_epi()
  self.v_stage_view:refresh_data(self.v_stage_list_cfg)
end

function ui:ui_on_hide()
  self:clear_reset_timer()
  self.v_stage_view:ui_on_hide()
  local task_tip_ui = UIMgr:try_get_visible_ui("fish_game_task")
  if nil ~= task_tip_ui then
    task_tip_ui:ui_hide()
  end
end

function ui:ui_on_destroy()
  self:clear_reset_timer()
  self.v_stage_view:ui_on_destroy()
end

function ui:_set_time()
  self.v_is_end = false
  local has_time = self.v_end_time > 0
  self.v_uiobjects.Time:SetActive(has_time)
  if not has_time then
    return
  end
  self:clear_reset_timer()
  local total_sec = self.v_end_time - Date.server_time()
  if total_sec <= 0 then
    self.v_uiobjects.Time:SetActive(false)
    self.v_is_end = true
    return
  end
  self.v_uicompents.Time_txt.text = Date.get_time_formate_2(total_sec)
  self.v_reset_timer = CT_Timer:add_timer("fish_game_sate_timer", total_sec, function(sec)
    if sec > 0 and self:visible() then
      self.v_uicompents.Time_txt.text = Date.get_time_formate_2(sec)
      self:update_item_time()
      self:update_red_state()
    else
      self.v_is_end = true
      self:clear_reset_timer()
    end
  end)
end

function ui:is_time_end()
  return self.v_is_end
end

function ui:update_item_time()
  local all_itmes = self.v_stage_view:get_all_uis()
  for _, ui_item in pairs(all_itmes) do
    ui_item:refresh_stage_info()
  end
end

function ui:update_red_state()
  NoviceMgr:update_fish_game_red_data()
end

function ui:clear_reset_timer()
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
end

function ui:refresh_task_red()
  local cfg = ShareRes.get_fish_game_fish_game_cfg(self.v_activity_id)
  local hold_data_map = ShareRes.get_task_group(cfg.TaskGroupId)
  self.v_uiobjects.TaskRed:SetActive(false)
  for _, data in pairs(hold_data_map) do
    local task_id = data.Id
    local task_state = TaskMgr:get_task_state(task_id)
    if task_state == TASK_STATE.COMPLETE then
      self.v_uiobjects.TaskRed:SetActive(true)
    end
  end
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name, false, true)
end

function ui:check_close2()
  if UIMgr:try_get_visible_ui("fish_game_battle") then
    return
  end
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name, false, true)
end

return ui
