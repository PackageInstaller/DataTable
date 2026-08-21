local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CommonDef = require("cs_share.common_define")
local linear_type_key = "linear_type_key"
local item_count = 3

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnTask", function()
    self:on_task_click()
  end)
end

function ui:ui_on_show(activity_id)
  self.v_activity_id = activity_id
  if not self.v_activity_id then
    self.v_activity_id = TimeLimitedActMgr:get_summer_stage_activity_id()
  end
  local is_close = NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
  if is_close then
    return
  end
  self:refresh_item_obj_list()
  self:refresh()
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.TaskRed, RedEnum.SUMMER_ACTIVITY_TASK, RedEnum.SUMMER_ACTIVITY_STAGE)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:refresh_item_obj_list()
  self.v_obj_list = {}
  for i = 1, item_count do
    local obj = Util.get_child_gameobj("SafeArea/Content/Stage" .. i .. "Tem_", self.v_object)
    self.v_obj_list[i] = obj
  end
end

function ui:refresh()
  self:clear_timer()
  self.v_timer_list = {}
  self:refresh_activity_time()
  local server_info_list = TimeLimitedActMgr:get_summer_stage_list()
  for i = 1, item_count do
    local obj = self.v_obj_list[i]
    local info = server_info_list[i]
    self:refresh_item_info(info, obj, i)
  end
end

function ui:refresh_item_info(info, obj, index)
  self:refresh_time(info, obj, index)
  self:refresh_power(info, obj)
  self:refresh_red(obj)
  local btn = Util.get_button("Select_", obj)
  local fight_info = {
    fight_type = Config.CommonDefine.CHALLENGE_TYPE.VERSION_EPISODE,
    point_id = info.episode_id,
    index = info.id,
    entry = info.entry,
    is_pass = info.is_pass
  }
  Global.listener_mgr:add_listener(self.v_object, btn.onClick, function()
    UIMgr:get_ui("ui_activity_summer_stage_info"):ui_show(fight_info)
    TimeLimitedActMgr:hide_summer_stage_red()
    self:hide_all_red()
  end)
end

function ui:refresh_time(info, obj, index)
  local stage_time = Util.get_text("TimeBg/StageTime_", obj)
  local left_time = info.refresh_time - Date.server_time()
  stage_time.text = Date.get_time_format_7(left_time)
  self:add_timer(index, left_time, stage_time)
end

function ui:refresh_red(obj)
  local is_need_show = TimeLimitedActMgr:get_is_need_show_summer_stage_red()
  local red = Util.get_child_gameobj("RedDot_", obj)
  red:SetActive(is_need_show)
end

function ui:hide_all_red()
  for i = 1, item_count do
    local obj = self.v_obj_list[i]
    self:refresh_red(obj)
  end
end

function ui:add_timer(index, left_time, text)
  if not left_time or left_time <= 0 then
    return
  end
  local timer = Global.ct_timer:add_timer("ui_summer_stage_timer" .. index, left_time, function(result_time)
    text.text = Date.get_time_format_7(result_time)
    if result_time <= 0 then
      self:clear_timer()
    end
  end)
  table.insert(self.v_timer_list, timer)
end

function ui:clear_timer()
  if not self.v_timer_list then
    return
  end
  for _, timer in pairs(self.v_timer_list) do
    if timer then
      Global.ct_timer:remove_timer(timer)
    end
  end
  self.v_timer_list = nil
end

function ui:refresh_activity_time()
  local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  local remain_time = NoviceMgr:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_cfg.OpenTime, activity_cfg.SustainTime)
  self.v_uicompents.Time_txt.text = Date.get_time_format_7(remain_time)
  self:add_timer(0, remain_time, self.v_uicompents.Time_txt)
end

function ui:refresh_power(info, obj)
  local epi_cfg = ShareRes.create("chapter.chapter_point", info.episode_id)
  local power_txt = Util.get_text("PowerBg/Power_", obj)
  power_txt.text = epi_cfg.RecomFightVal
end

function ui:on_task_click()
  local group_id = TimeLimitedActMgr:get_summer_stage_task_group_id()
  UIMgr:get_ui("ui_activity_summer_task"):ui_show(group_id)
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
end

function ui:ui_on_hide()
  self:clear_timer()
  TimeLimitedActMgr:hide_summer_stage_red()
end

function ui:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_activity_id
end

return ui
