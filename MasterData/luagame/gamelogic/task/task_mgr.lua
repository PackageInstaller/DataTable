local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local _tsort = table.sort
local M = Util.create_child_mt(Base)
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local commonDef = require("cs_share.common_define")
local date_time = require("utils.date")
local TASK_CONFIG = require("gamelogic.task.task_config")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local UnityTime = UnityEngine.Time
local ACT_DEFINE = Config.ACT_DEFINE
local TaskState = Config.CommonDefine.TaskState
local Red_ID = {Daily_Task = 10, Weekly_Task = 11}
local passport_id = {
  Daily = RedEnum.PASSPORT_DAILY_TASK,
  Weekly = RedEnum.PASSPORT_WEEKLY_TASK,
  PassPort = RedEnum.PASSPORT_RANDOM_TASK
}
local TASK_RED_ID = 1102
local TOP_VER_TASK_RED_ID = 27
local PASSPORT_SYS_ID = 54
local TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}
local TASK_STATE_PRO = {
  [TASK_STATE.COMPLETE] = 1,
  [TASK_STATE.CAN_RECEIVE] = 2,
  [TASK_STATE.NOT_RECEIVE] = 3,
  [TASK_STATE.RECEIVE] = 4,
  [TASK_STATE.GET_REWARD] = 5
}

function M:init_sys()
  Base.init_sys(self)
  self.cur_chapter_finish_task = {}
  self.v_task_group = {}
  self.v_novice_days = ShareRes.get_comm_value("NewbieSignInPeriod")
  self.is_need_check_bird_red = true
  self.v_is_first_open_bird_event = true
end

function M:get_is_first_open_bird_event()
  return self.v_is_first_open_bird_event
end

function M:on_bird_event_open()
  self.v_is_first_open_bird_event = false
end

function M:on_reconnect()
  self.v_task_group = {}
  self.v_task_list = {}
end

local function _arrange_task(task_info)
  local task_cfg = ShareRes.create("condition.task", task_info.id)
  task_info.task_cfg = task_cfg
  local progress = task_info.progress
  local condition = {}
  for _, data in pairs(progress) do
    condition[data.id] = data.progress
  end
  task_info.condition = condition
end

function M:on_ret_task_list(task_list)
  self.v_task_list = {}
  for _, data in pairs(task_list.ltask) do
    local task_id = data.id
    _arrange_task(data)
    self.v_task_list[data.id] = data
  end
  self:_refresh_novice_redpoint()
  self:refresh_summer_epi_redpoint()
  self:refresh_maze_game_red_point()
end

function M:update_task(task_data)
  _arrange_task(task_data.task)
  self.v_task_list[task_data.task.id] = task_data.task
  if ShareRes.get_achievement_map().TaskIdToGroupId[task_data.task.id] then
    local state = self.v_task_list[task_data.task.id].state
    if state == TaskState.Complete then
      self.v_task_list[task_data.task.id].complete_time = os.date("!%Y.%m.%d", date_time.server_time())
      local data = {
        task_id = task_data.task.id
      }
      UIMgr:get_ui("common_battle_tips"):ui_show(data)
    elseif state == TaskState.GotAward then
      PlayerMgr:refresh_achievement_red_point()
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_TASK_UPDATE)
  self:_refresh_novice_redpoint()
  self:_refresh_top_ver_redpoint()
  self:refresh_summer_epi_redpoint()
  self:refresh_maze_game_red_point()
  self:record_cur_chapter_finish_task(task_data)
end

function M:update_task_group_list(data)
  for _, v in pairs(data.task_group_list) do
    self.v_task_group[v.id] = v
  end
end

function M:update_task_group_info(data)
  local group = data.task_group
  self.v_task_group[group.id] = group
  MsgGame:mq_publish2(Const.MSG_ON_TASK_GROUP_UPDATE)
end

function M:update_task_group_award_list(data)
  self.v_task_group_award_list = data.group_ids
  MsgGame:mq_publish2(Const.MSG_ON_TASK_GROUP_AWARD_LIST_UPDATE)
end

function M:is_task_group_award_received(task_group_id)
  for _, received_id in ipairs(self.v_task_group_award_list) do
    if received_id == task_group_id then
      return true
    end
  end
  return false
end

function M:receive_task_group_submit(task_group_id)
  Network:call("c2gs_task_group_submit", {id = task_group_id}, nil)
end

function M:check_task_cfg_state(task_cfg)
  for key, cfg in pairs(task_cfg) do
    local task_id = cfg.TaskId
    local state = self:get_task_state(task_id)
    if state == TaskState.Complete then
      return true
    end
  end
  return false
end

function M:get_task_state(task_id)
  local task_info = self:get_task_by_id(task_id)
  if task_info then
    return task_info.state
  end
  return 0
end

function M:get_task_group_state(group_id)
  if self.v_task_group[group_id] then
    return self.v_task_group[group_id].state
  end
  return 0
end

function M:get_task_group_count(group_id)
  local task_list = ShareRes.get_task_group_cfg(group_id)
  local suc_count, total_count = 0, 0
  if task_list then
    for task_id in pairs(task_list) do
      local state = self:get_task_state(task_id)
      if state == TaskState.Complete or state == TaskState.GotAward then
        suc_count = suc_count + 1
      end
      total_count = total_count + 1
    end
  end
  return suc_count, total_count
end

function M:submit_task(task_id, callback)
  if self:check_award_full(task_id) then
    Util.show_message_tip(2362)
    return
  end
  Network:protect_call("c2gs_task_submit", {id = task_id}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:submit_task_list(task_id_list, callback)
  if self:check_award_full(nil, task_id_list) then
    Util.show_message_tip(2362)
    return
  end
  Network:protect_call("c2gs_task_submit_list", {id_list = task_id_list}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:get_task_by_id(task_id)
  return self.v_task_list and self.v_task_list[task_id]
end

function M:get_sort_task_list(task_group_id)
  local task_list = ShareRes.get_task_group_cfg(task_group_id)
  local task_id_list = {}
  local task_id_state_list = {}
  local all_task_got = true
  local is_have_task_receive = false
  for task_id in pairs(task_list) do
    local task_state = TaskMgr:get_task_state(task_id)
    if task_state ~= Config.CommonDefine.TaskState.GotAward then
      all_task_got = false
    end
    local state = 2
    if task_state == Config.CommonDefine.TaskState.Complete then
      is_have_task_receive = true
      state = 1
    elseif task_state == Config.CommonDefine.TaskState.GotAward then
      state = 3
    end
    task_id_list[#task_id_list + 1] = task_id
    task_id_state_list[task_id] = state
  end
  table.sort(task_id_list, function(a, b)
    if task_id_state_list[a] == task_id_state_list[b] then
      return a < b
    end
    return task_id_state_list[a] < task_id_state_list[b]
  end)
  task_id_state_list = nil
  return task_id_list, all_task_got, is_have_task_receive
end

function M:get_task_group(group_id)
  return self.v_task_group[group_id]
end

function M:check_group_task(group_id)
  if not self.v_task_group[group_id] then
    return false
  end
  return self.v_task_group[group_id] == TaskState.Complete
end

function M:get_active_point_reward(task_cfg)
  local task_config = ShareRes.create("condition.task")
  local award_group = ShareRes.create("award.award_group")
  local award_config = ShareRes.create("award.award")
  local active_point = 0
  for key, cfg in pairs(task_cfg) do
    local task_id = cfg.TaskId
    local task_item_config = task_config[task_id]
    local award_id = award_group[task_item_config.Award][1]
    local award_num = award_config[award_id].Num
    local state = self:get_task_state(task_id)
    if state == TaskState.GotAward then
      active_point = active_point + award_num
    end
  end
  return active_point
end

function M:get_daily_active_point_reward()
  local daily_task_list = ShareRes.create("task.daily_task")
  return self:get_active_point_reward(daily_task_list)
end

function M:get_weekly_active_point_reward()
  local weekly_task_list = ShareRes.create("task.weekly_task")
  return self:get_active_point_reward(weekly_task_list)
end

function M:get_chapter_task_red(chapter_id)
  local chapter_cfg = ShareRes.get_chapter_cfg(chapter_id)
  if not chapter_cfg then
    return
  end
  local task_group_id = chapter_cfg.TaskGroupId
  if not task_group_id or task_group_id <= 0 then
    return false
  end
  local task_list = ShareRes.get_chapter_task_cfg(task_group_id)
  if not task_list then
    Log.Error("task_group_id", task_group_id)
  end
  for _, task in pairs(task_list) do
    local task_data = self:get_task_by_id(task.Id)
    if task_data and task_data.state == TaskState.Complete then
      return true
    end
  end
  return false
end

function M:get_chapter_task_red(chapter_id)
  local chapter_cfg = ShareRes.get_chapter_cfg(chapter_id)
  if not chapter_cfg then
    return
  end
  local task_group_id = chapter_cfg.TaskGroupId
  if not task_group_id or task_group_id <= 0 then
    return false
  end
  local task_list = ShareRes.get_chapter_task_cfg(task_group_id)
  if not task_list then
    Log.Error("task_group_id", task_group_id)
  end
  return self:check_task_list_red(task_list)
end

function M:check_task_list_red(task_list)
  if not task_list then
    return false
  end
  for _, task in pairs(task_list) do
    local task_data = self:get_task_by_id(task.Id)
    if task_data and task_data.state == TaskState.Complete then
      return true
    end
  end
  return false
end

function M:check_task_list_all_received(task_group_id)
  local is_all_received = true
  local task_list = ShareRes.get_task_group(task_group_id)
  for _, task in pairs(task_list) do
    local task_data = self:get_task_by_id(task.Id)
    if task_data and task_data.state ~= TaskState.GotAward then
      is_all_received = false
      break
    end
  end
  return is_all_received
end

function M:get_task_group_red(task_group_id)
  local task_list = ShareRes.get_task_group(task_group_id)
  return self:check_task_list_red(task_list)
end

function M:can_get_dp_award(dp_group_id, dp_id, chapter_id)
  local chapter_data = ChapterMgr:get_chapter_data_by_chapter_id(chapter_id)
  for _, id in pairs(chapter_data.dp_list) do
    if id == dp_id then
      return TaskState.GotAward
    end
  end
  return TaskState.Complete
end

function M:_refresh_novice_redpoint()
  local group_list = ShareRes.create("newbie.newbie_task_group")
  table.sort(group_list, function(a, b)
    return a.Priority > b.Priority
  end)
  for idx = 1, self.v_novice_days do
    local task_cfg = group_list[idx]
    local list = ShareRes.get_task_group(task_cfg.TaskGroupId)
    if list then
      local show_daily_red = false
      local unlock = true
      for _, t in pairs(list) do
        local state = self:get_task_state(t.Id)
        if state == TaskState.Complete then
          show_daily_red = true
        end
        unlock = unlock and (state == TaskState.Complete or state == TaskState.GotAward)
      end
      local phase_reddot = true
      if unlock then
        if self:is_task_group_award_received(task_cfg.TaskGroupId) then
          phase_reddot = false
        end
      else
        phase_reddot = false
      end
      show_daily_red = show_daily_red or phase_reddot
      RedPointMgr:enable_dynamic_redpoint(RedEnum.NOVICE_DAILY_TASK + idx, RedEnum.NOVICE_DAILY_TASK, show_daily_red)
    end
  end
end

function M:_refresh_top_ver_redpoint()
  local cfg = ShareRes.create("activity.best_config_task")
  local show = false
  local activity_id = commonDef.ACTY_TYPE.BEST_CONFIG_FIGHT
  if ActivityMgr:get_activity_is_open(activity_id) then
    for i, v in pairs(cfg) do
      local state = self:get_task_state(v.Id)
      if state == TaskState.Complete then
        show = true
        break
      end
    end
  end
  RedPointMgr:enable_redpoint(TOP_VER_TASK_RED_ID, show)
end

function M:refresh_summer_epi_redpoint()
  if 0 == TimeLimitedActMgr:get_summer_stage_task_group_id() then
    return
  end
  local show = false
  local task_list = ShareRes.get_task_group_cfg(TimeLimitedActMgr:get_summer_stage_task_group_id())
  for task_id, _ in pairs(task_list) do
    local state = self:get_task_state(task_id)
    if state == TaskState.Complete then
      show = true
      break
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.SUMMER_ACTIVITY_TASK, show)
end

function M:refresh_maze_game_red_point()
  local version_activity_cfg = TimeLimitedActMgr:get_activity_cfg_with_activity_type(TimeLimitedActMgr.Type.MazeGame)
  if not version_activity_cfg then
    return
  end
  local is_open = TimeLimitedActMgr:is_activity_open(version_activity_cfg.Id)
  if not is_open then
    return
  end
  local activity_id = tonumber(version_activity_cfg.Param[1])
  local maze_activity_cfg = ShareRes.get_ponder_maze_activity_cfg(activity_id)
  if not maze_activity_cfg then
    return
  end
  local task_group_id = maze_activity_cfg.TaskGroup
  local _, _, is_have_task_receive = TaskMgr:get_sort_task_list(task_group_id)
  RedPointMgr:enable_dynamic_redpoint(RedEnum.MAZE_ACT_TASK, RedEnum.TIME_LIMITED_ACTIVITY_BTN_5_1_2, is_have_task_receive)
end

function M:record_cur_chapter_finish_task(task_data)
  local task = task_data.task
  if TowerMgr and TowerMgr:get_tower() and task.state > TaskState.None then
    self.cur_chapter_finish_task[task.id] = task
  end
end

function M:clear_cur_chapter_finish_task()
  self.cur_chapter_finish_task = {}
end

function M:get_cur_chapter_finish_task(task_id)
  return self.cur_chapter_finish_task[task_id]
end

function M:check_task_can_receive(task_id)
  local state = self:get_task_state(task_id)
  return state == TaskState.Complete
end

function M:check_task_received(task_id)
  local state = self:get_task_state(task_id)
  return state == TaskState.GotAward
end

function M:get_task_cfg_list(task_group_id)
  local task_list = ShareRes.get_task_group_cfg(task_group_id)
  local cfg_list = {}
  for task_id, _ in pairs(task_list) do
    table.insert(cfg_list, ShareRes.get_task_cfg(task_id))
  end
  table.sort(cfg_list, function(a, b)
    local task_state_a = self:get_task_state(a.Id)
    local task_state_b = self:get_task_state(b.Id)
    local task_state_a_pro = TASK_STATE_PRO[task_state_a] or 0
    local task_state_b_pro = TASK_STATE_PRO[task_state_b] or 0
    local a_priority = a.Priority
    local b_priority = b.Priority
    if task_state_a_pro ~= task_state_b_pro then
      return task_state_a_pro < task_state_b_pro
    elseif a_priority ~= b_priority then
      return a_priority < b_priority
    elseif a.Id ~= b.Id then
      return a.Id < b.Id
    else
      return false
    end
  end)
  return cfg_list
end

M.all_task_event_red_id = 1111
M.task_event_all_list = {}
M.task_event_type_list = {}
M.task_buddy_event_list = {}

function M:get_all_task_event_red_id()
  return self.all_task_event_red_id
end

function M:on_update_chain_cenre_event_data(data)
  self.task_event_all_list = {}
  self.task_event_type_list = {}
  self.task_buddy_event_list = {}
  for i, task_info in pairs(data.event_list) do
    local task_data = self:get_new_task_data_with_task_info(task_info)
    if task_data then
      _tinsert(self.task_event_all_list, task_data)
    end
  end
  self:sort_task_event_list()
  self:init_buddy_event_list(data.buddy_event)
  self:init_mascot_event_list(data.mascot_event)
end

function M:on_update_task_event_data(data)
  local is_have = false
  local curr_task_data
  for i, task_data in pairs(self.task_event_all_list) do
    if task_data.task_info.task_id == data.event_data.task_id then
      is_have = true
      task_data.task_info = data.event_data
      curr_task_data = task_data
      if task_data.task_info.state == commonDef.CENTRE_EVENT_TYPE.Accept then
        task_data.pop_win_type = commonDef.TASK_POP_TYPE.Jump
      elseif task_data.task_info.state == commonDef.CENTRE_EVENT_TYPE.Complete then
        self:set_pop_win_type_with_finished(task_data)
      end
    end
  end
  if false == is_have then
    local task_data = self:get_new_task_data_with_task_info(data.event_data)
    if task_data then
      curr_task_data = task_data
      self:check_need_remove_task_data(curr_task_data)
      _tinsert(self.task_event_all_list, curr_task_data)
    end
  end
  self:sort_task_event_list()
  if curr_task_data then
    if curr_task_data.task_cfg.Deliver ~= commonDef.TASK_EVENT_DELIVERY_TYPE.Auto and curr_task_data.task_info.state == commonDef.CENTRE_EVENT_TYPE.GotAward then
      return
    end
    MsgGame:mq_publish2(Const.MSG_ON_CENTER_TASK_UPDATE)
    local show_data = {task_event_data = curr_task_data}
    UIMgr:add_ui_queue_no_repeat(Config.UI_QUEUE_GROUP.Task_Notice, "common_battle_tips", show_data)
  end
  MsgGame:mq_publish2(Const.MSG_ON_MAIN_MASCOT_RED_UPDATE)
end

function M:set_pop_win_type_with_finished(task_data)
  if task_data.task_cfg.Deliver == commonDef.TASK_EVENT_DELIVERY_TYPE.Auto then
    task_data.pop_win_type = commonDef.TASK_POP_TYPE.AutoFinished
  else
    task_data.pop_win_type = commonDef.TASK_POP_TYPE.Finished
  end
end

function M:get_new_task_data_with_task_info(add_task_info)
  local is_task_open = self:get_task_event_is_open(add_task_info)
  if not is_task_open then
    return nil
  end
  local add_task_cfg = ShareRes.create("chain_centre.centre_event", add_task_info.task_id)
  if not add_task_cfg then
    return nil
  end
  for i, task_data in pairs(self.task_event_all_list) do
    local task_group_id = task_data.task_cfg.GroupId
    local task_sort = task_data.task_cfg.Sort
    if add_task_cfg.GroupId == task_group_id and task_sort > add_task_cfg.Sort then
      return nil
    end
  end
  local add_task_data = {}
  add_task_data.task_info = add_task_info
  add_task_data.task_cfg = add_task_cfg
  if add_task_info.state == commonDef.CENTRE_EVENT_TYPE.Complete then
    self:set_pop_win_type_with_finished(add_task_data)
  else
    add_task_data.pop_win_type = commonDef.TASK_POP_TYPE.Check
  end
  return add_task_data
end

function M:get_task_event_is_open(task_info)
  if not task_info.progress or 0 == #task_info.progress then
    return false
  end
  return true
end

function M:get_task_event_list(type)
  if not type or 0 == type then
    return self.task_event_all_list
  end
  return self.task_event_type_list[type]
end

function M:get_task_event_by_group_id(group_id)
  for _, data in pairs(self.task_event_all_list) do
    if data.task_cfg.GroupId == group_id then
      return data.task_cfg.Id
    end
  end
end

function M:sort_task_event_list()
  if not self.task_event_all_list or 0 == #self.task_event_all_list then
    return
  end
  local task_desc_cfg = ShareRes.create("chain_centre.centre_event_group_desc")
  self:check_need_remove_task_data()
  _tsort(self.task_event_all_list, function(a, b)
    if a.task_info.state ~= b.task_info.state then
      return a.task_info.state > b.task_info.state
    end
    if a.task_cfg.TaskType == b.task_cfg.TaskType then
      return a.task_cfg.Sort < b.task_cfg.Sort
    else
      local task_type_a = task_desc_cfg[a.task_cfg.TaskType]
      local task_type_b = task_desc_cfg[b.task_cfg.TaskType]
      return task_type_a.LabelNum < task_type_b.LabelNum
    end
  end)
  self.task_event_type_list = {}
  self.task_buddy_event_list = {}
  self.task_mascot_event_list = {}
  for i, task_data in ipairs(self.task_event_all_list) do
    if not self.task_event_type_list[task_data.task_cfg.TaskType] then
      self.task_event_type_list[task_data.task_cfg.TaskType] = {}
    end
    _tinsert(self.task_event_type_list[task_data.task_cfg.TaskType], task_data)
    local task_buddy_event_id = task_data.task_info.buddy_event_id
    if task_buddy_event_id and task_buddy_event_id > 0 then
      self.task_buddy_event_list[task_buddy_event_id] = task_data.task_info
    end
    local task_mascot_event_id = task_data.task_info.mascot_event_id
    if task_mascot_event_id and task_mascot_event_id > 0 then
      self.task_mascot_event_list[task_mascot_event_id] = task_data
    end
  end
  self:refresh_task_event_red()
end

function M:refresh_task_event_red()
  self.all_red_count = 0
  local task_desc_cfg = ShareRes.create("chain_centre.centre_event_group_desc")
  for i, cfg in pairs(task_desc_cfg) do
    local red_id = self:get_all_task_event_red_id() + cfg.TaskType
    local type_list = self.task_event_type_list[cfg.TaskType]
    local red_count = 0
    if type_list then
      for i, task_data in pairs(type_list) do
        if task_data.task_info.state == commonDef.CENTRE_EVENT_TYPE.Complete then
          red_count = red_count + 1
          self.all_red_count = self.all_red_count + 1
        end
      end
    end
    RedPointMgr:enable_dynamic_redpoint(red_id, 1101, red_count > 0)
  end
  RedPointMgr:enable_dynamic_redpoint(self:get_all_task_event_red_id(), 1101, self.all_red_count > 0)
  MsgGame:mq_publish2(Const.MSG_ON_TASK_UPDATE)
end

function M:get_task_event_red_count()
  if not self.all_red_count then
    self.all_red_count = 0
  end
  return self.all_red_count
end

function M:check_need_remove_task_data(add_task_data)
  local remove_list = {}
  local add_task_group_id
  if add_task_data then
    add_task_group_id = add_task_data.task_cfg.GroupId
  end
  for index, task_data in pairs(self.task_event_all_list) do
    if not add_task_group_id then
      if task_data.task_info.state == commonDef.CENTRE_EVENT_TYPE.GotAward then
        _tinsert(remove_list, index)
      end
    else
      local task_group_id = task_data.task_cfg.GroupId
      local add_task_sort = add_task_data.task_cfg.Sort
      local task_sort = task_data.task_cfg.Sort
      if add_task_group_id == task_group_id and add_task_sort > task_sort then
        _tinsert(remove_list, index)
      end
    end
  end
  if #remove_list > 1 then
    _tsort(remove_list, function(a, b)
      return b < a
    end)
  end
  for i, v in ipairs(remove_list) do
    table.remove(self.task_event_all_list, v)
  end
end

function M:get_task_progress_value_by_id(task_id)
  local finish_value = 0
  local all_value = 0
  local task_data = self:get_task_by_id(task_id)
  if task_data then
    for i, progress_info in pairs(task_data.progress) do
      local condition_id = progress_info.id
      local condition_cfg = ShareRes.get_condition_cfg(condition_id)
      all_value = all_value + condition_cfg.Value
      finish_value = finish_value + progress_info.progress
    end
  end
  return finish_value, all_value
end

function M:get_task_progress_by_id(task_id)
  local finish_count = 0
  local all_count = 0
  local task_data = self:get_task_by_id(task_id)
  if task_data then
    for i, progress_info in pairs(task_data.progress) do
      all_count = all_count + 1
      if self:get_condition_state(progress_info) == commonDef.CONDITION_STATE.Finished then
        finish_count = finish_count + 1
      end
    end
  end
  return finish_count, all_count
end

function M:get_task_progress(task_data)
  local finish_count = 0
  local all_count = 0
  for i, progress_info in pairs(task_data.task_info.progress) do
    all_count = all_count + 1
    if self:get_condition_state(progress_info) == commonDef.CONDITION_STATE.Finished then
      finish_count = finish_count + 1
    end
  end
  return finish_count, all_count
end

function M:get_condition_state(progress_info)
  local condition = ShareRes.create("condition.condition", progress_info.id)
  if 0 == progress_info.progress then
    return commonDef.CONDITION_STATE.DidNotStart
  elseif progress_info.progress < condition.Value then
    return commonDef.CONDITION_STATE.InProgress
  else
    return commonDef.CONDITION_STATE.Finished
  end
end

function M:get_need_jump_id(task_data)
  local need_jump_id = 0
  local cfg = task_data.task_cfg
  for index, condition_id in pairs(cfg.Condition) do
    for _, progress_info in ipairs(task_data.task_info.progress) do
      if progress_info.id == condition_id then
        local condition_state = self:get_condition_state(progress_info)
        if 0 == need_jump_id and condition_state ~= commonDef.CONDITION_STATE.Finished then
          need_jump_id = cfg.stepJump[index]
          break
        end
      end
    end
    if 0 ~= need_jump_id then
      break
    end
  end
  return need_jump_id
end

function M:set_task_type_icon(icon, type)
  local cfg = ShareRes.create("chain_centre.centre_event_group_desc", type)
  ResMgr:load_set_icon(icon, cfg.TypeIMG)
  Util.set_color(icon, cfg.TypeIconColor)
end

function M:set_common_battle_tips_icon(icon, type)
  local cfg = ShareRes.create("chain_centre.centre_event_group_desc", type)
  ResMgr:load_set_icon(icon, cfg.TypeIMG)
end

function M:get_task_type_color(type)
  local cfg = ShareRes.create("chain_centre.centre_event_group_desc", type)
  local color = Util.get_unity_color_by_hex(tonumber(cfg.TypeIconColor, 16))
  return color
end

function M:get_task_type_cfg(type)
  local cfg = ShareRes.create("chain_centre.centre_event_group_desc", type)
  return cfg
end

function M:is_need_show_delivery_with_buddy_event_id(buddy_event_id)
  local task_info = self.task_buddy_event_list[buddy_event_id]
  if not task_info then
    return false
  end
  local state = task_info.state
  local task_id = task_info.task_id
  return state == commonDef.CENTRE_EVENT_TYPE.Complete, task_id
end

function M:get_task_finished_with_mascot_event_id(mascot_event_id)
  if not self.task_mascot_event_list then
    return false
  end
  local task_data = self.task_mascot_event_list[mascot_event_id]
  if not task_data then
    return false
  end
  local state = task_data.task_info.state
  local award_id = task_data.task_cfg.Award
  local task_id = task_data.task_cfg.Id
  return state == commonDef.CENTRE_EVENT_TYPE.Complete, award_id, task_id
end

function M:get_task_data_with_mascot_event_id(mascot_event_id)
  if not self.task_mascot_event_list then
    return nil
  end
  local task_data = self.task_mascot_event_list[mascot_event_id]
  return task_data
end

function M:get_no_accept_mascot_task_award_id(mascot_cfg)
  if 2 ~= mascot_cfg.EventType then
    return 0
  end
  local cfg = ShareRes.create("chain_centre.centre_event_group", mascot_cfg.Arg[1])
  return cfg[1].Award
end

M.buddy_data_list = {}
M.need_show_buddy_model_list = {}
M.buddy_max_show_count = 5
M.bird_board_id = ShareRes.get_comm_value("BirdBoardId")
M.zoom_bird_board_id = ShareRes.get_comm_value("BirdZoomBoardId")
M.bird_model_id = "H1001001_1"
M.journey_board_id = ShareRes.get_comm_value("JourneyBoardId")
M.loading_npc_list = {}
M.buddy_bubble_enum = {
  Available = 1,
  InProgress = 2,
  Complete = 3
}

function M:is_need_direct_trigger(event_type)
  if 1 == event_type or 3 == event_type then
    return true
  end
  return false
end

function M:init_buddy_event_list(list)
  self.buddy_data_list = {}
  self.need_show_buddy_model_list = {}
  for index, buddy_info in pairs(list) do
    self:refresh_buddy_data_with_buddy_info(buddy_info)
  end
  self:refresh_need_show_buddy_data_list()
end

function M:on_update_buddy_event_data(data)
  self:refresh_buddy_data_with_buddy_info(data.buddy_event)
  self:refresh_need_show_buddy_data_list()
  GuideMgr:check_sys_guide()
end

function M:get_buddy_event_complete(event_id)
  if not self.v_buddy_comp_event then
    return false
  end
  return self.v_buddy_comp_event[event_id] or false
end

function M:refresh_buddy_data_with_buddy_info(buddy_info)
  self.v_buddy_comp_event = self.v_buddy_comp_event or {}
  self.v_buddy_comp_event[buddy_info.event_id] = buddy_info.state == commonDef.BUDDY_EVENT_TYPE.Complete
  local buddy_event_id = buddy_info.event_id
  local buddy_data = self.buddy_data_list[buddy_event_id]
  if not buddy_data and buddy_info.state == commonDef.BUDDY_EVENT_TYPE.Complete then
    return
  end
  local buddy_cfg, board_id, story_id, npc_id, bubble_state = self:get_board_and_story_id_with_buddy_info(buddy_info)
  if not npc_id then
    self.buddy_data_list[buddy_event_id] = nil
    return
  end
  local refresh_type = 0
  if not buddy_data then
    refresh_type = 1
    buddy_data = {}
    self.buddy_data_list[buddy_event_id] = buddy_data
  end
  local is_need_refresh_model_pos = false
  buddy_data.buddy_info = buddy_info
  buddy_data.buddy_cfg = buddy_cfg
  if buddy_data.board_id and buddy_data.board_id ~= board_id then
    is_need_refresh_model_pos = true
  end
  buddy_data.board_id = board_id
  buddy_data.story_id = story_id
  buddy_data.npc_id = npc_id
  buddy_data.bubble_state = bubble_state
  if buddy_info.state == commonDef.BUDDY_EVENT_TYPE.Complete then
    refresh_type = 2
    self.buddy_data_list[buddy_event_id] = nil
  elseif is_need_refresh_model_pos then
    self:refresh_model_pos(npc_id, board_id)
  end
end

function M:refresh_need_show_buddy_data_list()
  self.sorted_buddy_data_list = {}
  for i, buddy_data in pairs(self.buddy_data_list) do
    self.sorted_buddy_data_list[#self.sorted_buddy_data_list + 1] = buddy_data
  end
  _tsort(self.sorted_buddy_data_list, function(a, b)
    local weight_group_a = a.buddy_cfg.WeightGroup
    local weight_group_b = b.buddy_cfg.WeightGroup
    if weight_group_a ~= weight_group_b then
      return weight_group_a < weight_group_b
    end
    local id_a = a.buddy_info.event_id
    local id_b = b.buddy_info.event_id
    return id_a < id_b
  end)
  self.need_show_buddy_model_list = {}
  local add_finish_group_id_list = {}
  for _, buddy_data in ipairs(self.sorted_buddy_data_list) do
    local weight_group = buddy_data.buddy_cfg.WeightGroup
    if not add_finish_group_id_list[weight_group] then
      add_finish_group_id_list[weight_group] = true
      self.need_show_buddy_model_list[#self.need_show_buddy_model_list + 1] = buddy_data
      if #self.need_show_buddy_model_list >= self.buddy_max_show_count then
        break
      end
    end
  end
  self:refresh_role_model()
end

function M:refresh_need_show_npc_list()
  UIMainBubbleMgr:release_all_bubble_obj_state()
  local model_view = self:get_ui_main_model_view()
  if not model_view then
    return
  end
  self.need_show_npc_list = {}
  for index, buddy_data in ipairs(self.need_show_buddy_model_list) do
    local data = {}
    local npc_head = model_view:get_npc_head_trans_with_npc_id(buddy_data.npc_id)
    data.npc_head = npc_head
    data.npc_id = buddy_data.npc_id
    data.bubble_state = buddy_data.bubble_state
    data.board_id = buddy_data.board_id
    self.need_show_npc_list[#self.need_show_npc_list + 1] = data
  end
  return self.need_show_npc_list
end

function M:set_head_data(buddy_data)
  local model_view = self:get_ui_main_model_view()
  if not model_view then
    return
  end
  local npc_head = model_view:get_npc_head_trans_with_npc_id(buddy_data.npc_id)
  buddy_data.npc_head = npc_head
end

function M:get_need_show_npc_list()
  return self.need_show_npc_list
end

function M:get_board_and_story_id_with_buddy_info(buddy_info)
  local buddy_cfg = ShareRes.create("chain_centre.buddy_event", buddy_info.event_id)
  if not buddy_cfg then
    return
  end
  local board_id, story_id, bubble_state
  if buddy_info.state == commonDef.BUDDY_EVENT_TYPE.None then
    board_id = buddy_cfg.baseNPC
    story_id = buddy_cfg.baseTalk
    bubble_state = self.buddy_bubble_enum.Available
  elseif buddy_info.state == commonDef.BUDDY_EVENT_TYPE.Accept then
    local is_delivery = self:is_need_show_delivery_with_buddy_event_id(buddy_info.event_id)
    if is_delivery then
      board_id = buddy_cfg.doneNPC
      story_id = buddy_cfg.doneTalk
      bubble_state = self.buddy_bubble_enum.Complete
    else
      board_id = buddy_cfg.taskingNPC
      story_id = buddy_cfg.taskingTalk
      bubble_state = self.buddy_bubble_enum.InProgress
    end
  end
  local board_cfg = ShareRes.create("signboard_girl.signboard_girl_param", board_id)
  local npc_id
  if board_cfg then
    npc_id = board_cfg.BuddyId
  end
  return buddy_cfg, board_id, story_id, npc_id, bubble_state
end

function M:init_model_to_main_ui()
  self:load_bird(function()
    self:refresh_need_show_npc_list()
  end)
end

function M:refresh_role_model(board_npc_id_index)
  local model_view = self:get_ui_main_model_view()
  if not model_view then
    return
  end
  local curr_show_npc_list = model_view:get_npc_loaded_map()
  local need_remove_model_list = self:get_need_remove_list(curr_show_npc_list, board_npc_id_index)
  local need_add_model_list = self:get_need_add_list(curr_show_npc_list)
  if #need_remove_model_list > 1 then
    _tsort(need_remove_model_list, function(a, b)
      return b < a
    end)
  end
  for i, need_remove_data in ipairs(need_remove_model_list) do
    local function cb()
      model_view:remove_npc_by_index(need_remove_data.index)
    end
    
    self:play_buddy_event_delivery_anim(need_remove_data.npc_id, model_view, need_remove_data.index, cb)
  end
  for i, buddy_data in pairs(need_add_model_list) do
    self:load_npc(model_view, buddy_data.npc_id, buddy_data.board_id)
  end
  if #need_remove_model_list >= 0 and 0 == #need_add_model_list then
    self:refresh_need_show_npc_list()
  end
end

function M:refresh_model_pos(npc_id, board_id)
  local model_view = self:get_ui_main_model_view()
  if not model_view then
    return
  end
  local total_buddy_param_cfg = ShareRes.create("signboard_girl.signboard_girl_param")
  local board_cfg = total_buddy_param_cfg[board_id]
  model_view:refresh_model_pos(npc_id, board_cfg.ModelPos)
end

function M:get_need_remove_list(curr_show_npc_list, board_npc_id_index)
  local need_remove_model_list = {}
  for index, npc in pairs(curr_show_npc_list) do
    if npc.is_journey_event then
    else
      local npc_id = npc:get_npc_id()
      local is_can_remove_npc, is_must_remove = self:is_can_remove_npc(index, npc, board_npc_id_index)
      if is_must_remove then
        do
          local data = {}
          data.index = index
          data.npc_id = npc_id
          need_remove_model_list[#need_remove_model_list + 1] = data
        end
      elseif not is_can_remove_npc then
      else
        local is_have = false
        for _, buddy_data in ipairs(self.need_show_buddy_model_list) do
          local need_show_npc_id = buddy_data.npc_id
          if npc_id == need_show_npc_id then
            is_have = true
            break
          end
        end
        if false == is_have then
          local data = {}
          data.index = index
          data.npc_id = npc_id
          need_remove_model_list[#need_remove_model_list + 1] = data
        end
      end
    end
  end
  return need_remove_model_list
end

function M:is_can_remove_npc(index, npc, board_npc_id_index)
  if not npc then
    return false
  end
  local npc_id = npc:get_npc_id()
  local player_board_npc_id = PlayerMgr:get_signboard_girl_id()
  if npc_id == self:get_bird_npc_id() then
    return false
  end
  if npc_id == player_board_npc_id then
    if not board_npc_id_index then
      return false
    end
    if index ~= board_npc_id_index then
      return true, true
    end
    return false
  end
  return true
end

function M:get_bird_npc_id()
  local total_buddy_param_cfg = ShareRes.create("signboard_girl.signboard_girl_param")
  local buddy_param_cfg = total_buddy_param_cfg[self.bird_board_id]
  local bird_npc_id = buddy_param_cfg.BuddyId
  return bird_npc_id
end

function M:get_need_add_list(curr_show_npc_list)
  local need_add_model_list = {}
  for _, buddy_data in ipairs(self.need_show_buddy_model_list) do
    local is_have = false
    local need_show_npc_ic = buddy_data.npc_id
    for index, npc in pairs(curr_show_npc_list) do
      local npc_id = npc:get_npc_id()
      if need_show_npc_ic == npc_id then
        is_have = true
        break
      end
    end
    if false == is_have then
      need_add_model_list[#need_add_model_list + 1] = buddy_data
    end
  end
  return need_add_model_list
end

function M:get_ui_main_model_view()
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return nil
  end
  return ui_main:get_model_view()
end

function M:load_bird(callback)
  local model_view = self:get_ui_main_model_view()
  if not model_view then
    return
  end
  local model_fashion_id = self.bird_model_id
  local board_id = self.bird_board_id
  local total_buddy_param_cfg = ShareRes.create("signboard_girl.signboard_girl_param")
  local buddy_param_cfg = total_buddy_param_cfg[board_id]
  local npc_id = buddy_param_cfg.BuddyId
  local npc_pos = buddy_param_cfg.ModelPos
  local npc_rot = buddy_param_cfg.ModelRot
  local scale = buddy_param_cfg.ModelScale
  local npc_param = {
    pos_x = npc_pos[1],
    pos_y = npc_pos[2],
    pos_z = npc_pos[3],
    rot_x = npc_rot[1],
    rot_y = npc_rot[2],
    rot_z = npc_rot[3],
    scale_x = scale[1],
    scale_y = scale[2],
    scale_z = scale[3]
  }
  local params = {
    model_id = model_fashion_id,
    npc_id = npc_id,
    npc_param = npc_param,
    hide_weapon = true,
    cb = function()
      local npc = model_view:get_npc_with_npc_id(npc_id)
      if not npc then
        return
      end
      local obj = npc:get_gameobj()
      if not obj then
        return
      end
      self:on_mascot_create_finish(npc)
      obj:SetActive(false)
      obj:SetActive(true)
      self:refresh_mascot_reel_state()
      if callback then
        callback()
      end
    end
  }
  model_view:load_npc(params)
end

function M:load_npc(model_view, npc_id, board_id, is_journey_event_model, create_finish_callback, init_anim_finish_callback)
  if not model_view then
    return
  end
  if self.loading_npc_list[npc_id] then
    return
  end
  local player_board_npc_id = PlayerMgr:get_signboard_girl_id()
  if player_board_npc_id == npc_id and not is_journey_event_model then
    return
  end
  local model_fashion_id = FashionMgr:get_fashion_model_id(npc_id)
  if not model_fashion_id then
    local character_cfg = ShareRes.create("character.character", npc_id)
    if character_cfg then
      model_fashion_id = character_cfg.ModelId
    end
  end
  local total_buddy_param_cfg = ShareRes.create("signboard_girl.signboard_girl_param")
  local buddy_param_cfg = total_buddy_param_cfg[board_id]
  local npc_pos = buddy_param_cfg.ModelPos
  local npc_rot = buddy_param_cfg.ModelRot
  local scale = buddy_param_cfg.ModelScale
  local npc_param2 = {
    pos_x = npc_pos[1],
    pos_y = npc_pos[2],
    pos_z = npc_pos[3],
    rot_x = npc_rot[1],
    rot_y = npc_rot[2],
    rot_z = npc_rot[3],
    scale_x = scale[1],
    scale_y = scale[2],
    scale_z = scale[3]
  }
  
  local function cb(model_index)
    if not is_journey_event_model then
      local ui_main_close_new = UIMgr:try_get_visible_ui("uimain_close_new")
      if ui_main_close_new then
        model_view:hide_other_model(self:get_bird_npc_id())
      end
      self:refresh_need_show_npc_list()
      model_view:hide_model_node(true)
    end
    self.loading_npc_list[npc_id] = nil
    if create_finish_callback then
      create_finish_callback(model_index)
    end
  end
  
  local function init_anim_cb(model_index)
    if init_anim_finish_callback then
      init_anim_finish_callback()
    end
    model_view:play_anim(ACT_DEFINE.UIMainIdle, model_index, nil, true)
  end
  
  local entrance_anim = self:get_entrance_anim(npc_id)
  local is_loop
  if entrance_anim then
    is_loop = false
  end
  local params = {
    model_id = model_fashion_id,
    npc_id = npc_id,
    npc_param = npc_param2,
    hide_weapon = true,
    init_anim = entrance_anim,
    init_anim_cb = init_anim_cb,
    cb = cb,
    is_loop = is_loop,
    is_journey_event = is_journey_event_model
  }
  self.loading_npc_list[npc_id] = true
  local index = model_view:load_npc(params)
  return index
end

function M:play_buddy_event_entrance_anim(npc_id, model_view, model_index, callback)
  local action_cfg = self:get_buddy_action_with_param(npc_id, commonDef.BUDDY_EVENT_ANIM_TYPE.Entrance)
  if not action_cfg then
    if callback then
      callback()
    end
    model_view:play_anim(ACT_DEFINE.UIMainIdle, model_index, nil, true)
    return
  end
  model_view:play_anim(action_cfg.Action, model_index, callback, false)
end

function M:get_entrance_anim(npc_id)
  local action_cfg = self:get_buddy_action_with_param(npc_id, commonDef.BUDDY_EVENT_ANIM_TYPE.Entrance)
  if not action_cfg then
    return nil
  end
  return action_cfg.Action
end

function M:play_buddy_event_delivery_anim(npc_id, model_view, model_index, cb)
  local action_cfg = self:get_buddy_action_with_param(npc_id, commonDef.BUDDY_EVENT_ANIM_TYPE.Departure)
  if not action_cfg then
    cb()
    return
  end
  model_view:play_anim(action_cfg.Action, model_index, cb, false)
end

function M:get_story_id_with_npc_id(npc_id)
  local story_id, board_id, event_id
  for buddy_event_id, buddy_data in pairs(self.buddy_data_list) do
    if buddy_data.npc_id == npc_id then
      story_id = buddy_data.story_id
      board_id = buddy_data.board_id
      event_id = buddy_event_id
      break
    end
  end
  return story_id, board_id, event_id
end

function M:get_buddy_data_with_npc_id(npc_id)
  for _, buddy_data in ipairs(self.need_show_buddy_model_list) do
    if buddy_data.npc_id == npc_id then
      return buddy_data
    end
  end
  return nil
end

function M:get_buddy_event_data_with_player_board_npc_id()
  local player_board_npc_id = PlayerMgr:get_signboard_girl_id()
  for _, buddy_data in ipairs(self.need_show_buddy_model_list) do
    local need_show_npc_id = buddy_data.npc_id
    if need_show_npc_id == player_board_npc_id then
      return buddy_data
    end
  end
  return nil
end

M.mascot_data_list = {}
M.sorted_mascot_data_list = {}
M.mascot_max_show_count = 9999
M.reel_parent_name = "Bip001 Prop1"
M.bird_anim_type = {
  event_accept = 6,
  event_idle = 7,
  event_touch = 8,
  no_event = 9
}
M.bird_animator = nil

function M:init_mascot_event_list(list)
  self.mascot_data_list = {}
  self.sorted_mascot_data_list = {}
  for index, mascot_info in pairs(list) do
    self:refresh_mascot_data_with_mascot_info(mascot_info)
  end
  self:sort_mascot_list()
end

function M:on_update_mascot_event_data(data)
  self:refresh_mascot_data_with_mascot_info(data.mascot_event)
  self:sort_mascot_list()
  MsgGame:mq_publish2(Const.MSG_ON_MAIN_MASCOT_RED_UPDATE)
end

function M:refresh_mascot_data_with_mascot_info(mascot_info)
  local mascot_event_id = mascot_info.event_id
  local mascot_data = self.mascot_data_list[mascot_event_id]
  if not mascot_data and mascot_info.state == commonDef.MASCOT_EVENT_TYPE.Complete then
    return
  end
  local mascot_cfg, story_id = self:get_story_id_with_mascot_info(mascot_info)
  local refresh_type = 0
  if not mascot_data then
    refresh_type = 1
    mascot_data = {}
    self.mascot_data_list[mascot_event_id] = mascot_data
  end
  mascot_data.mascot_info = mascot_info
  mascot_data.mascot_cfg = mascot_cfg
  mascot_data.story_id = story_id
  if mascot_info.state == commonDef.MASCOT_EVENT_TYPE.Complete then
    refresh_type = 2
    self.mascot_data_list[mascot_event_id] = nil
  end
end

function M:get_story_id_with_mascot_info(mascot_info)
  local mascot_cfg = ShareRes.create("chain_centre.mascot_event", mascot_info.event_id)
  if not mascot_cfg then
    return nil
  end
  local story_id = mascot_cfg.baseTalk
  return mascot_cfg, story_id
end

function M:sort_mascot_list()
  self.sorted_mascot_data_list = {}
  for event_id, mascot_data in pairs(self.mascot_data_list) do
    self.sorted_mascot_data_list[#self.sorted_mascot_data_list + 1] = mascot_data
  end
  _tsort(self.sorted_mascot_data_list, function(a, b)
    local rank_a = a.mascot_cfg.Rank
    local rank_b = b.mascot_cfg.Rank
    if rank_a ~= rank_b then
      return rank_a < rank_b
    end
    local id_a = a.mascot_cfg.Id
    local id_b = b.mascot_cfg.Id
    return id_a < id_b
  end)
  self:refresh_mascot_reel_state()
  MsgGame:mq_publish2(Const.MSG_ON_CENTER_MASCOT_UPDATE)
end

function M:get_mascot_max_show_count()
  return self.mascot_max_show_count
end

function M:get_show_mascot_list()
  local need_show_list = {}
  local group_list = {}
  for index, mascot_data in ipairs(self.sorted_mascot_data_list) do
    if #need_show_list >= self.mascot_max_show_count then
      break
    end
    if not mascot_data.mascot_cfg then
    else
      local weigh_group = mascot_data.mascot_cfg.WeightGroup
      if group_list[weigh_group] then
      else
        group_list[weigh_group] = true
        need_show_list[#need_show_list + 1] = mascot_data
      end
    end
  end
  return need_show_list
end

function M:get_mascot_need_show_story_id()
  if not self.sorted_mascot_data_list or 0 == #self.sorted_mascot_data_list then
    return nil
  end
  local mascot_data = self.sorted_mascot_data_list[1]
  local story_id = mascot_data.story_id
  local mascot_event_id = mascot_data.mascot_info.event_id
  return story_id, self.bird_board_id, mascot_event_id
end

function M:get_mascot_board_id()
  return self.bird_board_id
end

function M:get_journey_board_id()
  return self.journey_board_id
end

function M:get_zoom_bird_board_id()
  return self.zoom_bird_board_id
end

function M:get_mascot_agency_list()
  local mascot_cfg = ShareRes.create("chain_centre.mascot_agency")
  local need_tips_list = {}
  for id, cfg in pairs(mascot_cfg) do
    local is_finish, ia_all_zero = self:get_condition_is_reach(cfg.DoneCondition)
    if is_finish or ia_all_zero then
    else
      local is_reach = self:get_condition_is_reach(cfg.OpenCondition)
      if is_reach then
        need_tips_list[#need_tips_list + 1] = cfg
      end
    end
  end
  _tsort(need_tips_list, function(a, b)
    local rank_a = a.Rank
    local rank_b = b.Rank
    if rank_a ~= rank_b then
      return rank_a < rank_b
    end
    local id_a = a.Id
    local id_b = b.Id
    return id_a < id_b
  end)
  return need_tips_list
end

function M:get_bird_icon_path()
  local list = self:get_mascot_agency_list()
  if not list or 0 == #list then
    return nil
  end
  local level = 3
  for _, cfg in pairs(list) do
    if level > cfg.HindLevel then
      level = cfg.HindLevel
    end
  end
  if 3 == level then
    return nil
  end
  return 2 == level and "UIMain/New/Main_icon_qp_6" or "UIMain/New/mine_bird_rktb"
end

function M:get_mascot_dialog(count)
  local dialog_cfg = ShareRes.create("chain_centre.mascot_dialog")
  local need_tips_list = {}
  for id, cfg in pairs(dialog_cfg) do
    if count < cfg.Num then
    else
      local is_finish = self:get_condition_is_reach(cfg.Condition)
      if is_finish then
        need_tips_list[#need_tips_list + 1] = cfg
      end
    end
  end
  _tsort(need_tips_list, function(a, b)
    local rank_a = a.Rank
    local rank_b = b.Rank
    if rank_a ~= rank_b then
      return rank_a > rank_b
    end
    local id_a = a.Id
    local id_b = b.Id
    return id_a < id_b
  end)
  if need_tips_list and #need_tips_list > 0 then
    return need_tips_list[1]
  end
  return nil
end

function M:get_mascot_story_cfg_list(group_id)
  local all_story_cfg = ShareRes.create("chain_centre.mascot_story")
  local result_list = {}
  for i, story_cfg in pairs(all_story_cfg) do
    if story_cfg.GroupId == group_id then
      table.insert(result_list, story_cfg)
    end
  end
  table.sort(result_list, self.sort_mascot_story_cfg_list)
  return result_list
end

function M.sort_mascot_story_cfg_list(a, b)
  return a.Order > b.Order
end

function M:refresh_mascot_reel_state()
  local model_view = self:get_ui_main_model_view()
  if not model_view then
    return
  end
  local bird_npc_id = self:get_bird_npc_id()
  local npc = model_view:get_npc_with_npc_id(bird_npc_id)
  if not npc then
    return
  end
  local trans = npc.attach_point:GetPoint(self.reel_parent_name)
  local need_show_list = self:get_show_mascot_list()
  trans:SetActive(#need_show_list > 0)
end

function M:get_condition_is_reach(condition_list)
  local is_reach = true
  local is_all_zero = true
  for index, condition_id in ipairs(condition_list) do
    if condition_id > 0 then
      is_all_zero = false
      local state = Condition:check_condition(condition_id, false)
      if not state then
        is_reach = false
        break
      end
    end
  end
  return is_reach, is_all_zero
end

function M:on_mascot_create_finish(npc)
  self.bird_animator = npc:get_animator()
  if self:is_bird_animator_nil() then
    return
  end
  self:play_mascot_idle_anim()
end

function M:is_bird_animator_nil()
  if not self.bird_animator or self.bird_animator:IsNull() then
    return true
  end
  return false
end

function M:on_mascot_event_click()
  self:change_mascot_anim(self.bird_anim_type.event_accept)
end

function M:on_mascot_click()
  if not self:get_bird_can_change_animation() then
    return
  end
  local need_show_list = self:get_show_mascot_list()
  local event_type
  if #need_show_list > 0 then
    event_type = self.bird_anim_type.event_touch
  else
    event_type = self.bird_anim_type.no_event
  end
  self:set_bird_can_change_animation(false)
  self:change_mascot_anim(event_type, true)
end

function M:play_mascot_idle_anim()
  local need_show_list = self:get_show_mascot_list()
  local event_type
  if #need_show_list > 0 then
    event_type = self.bird_anim_type.event_idle
  else
    event_type = self.bird_anim_type.no_event
  end
  self:change_mascot_anim(event_type)
end

function M:change_mascot_anim(event_type, is_need_show_dialog)
  local model_view = self:get_ui_main_model_view()
  if not model_view then
    self:set_bird_can_change_animation(true)
    return
  end
  local bird_npc_id = self:get_bird_npc_id()
  local index = model_view:get_npc_index_with_npc_id_and_active_state(bird_npc_id)
  if not index then
    self:set_bird_can_change_animation(true)
    return
  end
  if not event_type then
    local need_show_list = self:get_show_mascot_list()
    if #need_show_list > 0 then
      event_type = self.bird_anim_type.event_touch
    else
      event_type = self.bird_anim_type.no_event
    end
  end
  local bird_action_list = {}
  local all_cfg = ShareRes.create("signboard_girl.signboard_girl_action")
  for id, cfg in pairs(all_cfg) do
    if cfg.BuddyId == bird_npc_id and event_type == cfg.ConditionId and cfg.Action ~= "born" then
      table.insert(bird_action_list, cfg)
    end
  end
  local action_cfg = SignBoardGirlMgr:get_board_random_action(bird_action_list)
  if not action_cfg then
    self:set_bird_can_change_animation(true)
    return
  end
  if is_need_show_dialog then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_MASCOT_CLICK)
    msg.mm_x = action_cfg.Text
  end
  local anim_name = action_cfg.Action
  model_view:play_anim(anim_name, index, function()
    if is_need_show_dialog then
      MsgGame:mq_publish2(Const.MSG_ON_MASCOT_CLICK)
    end
    self:set_bird_can_change_animation(true)
    self:play_mascot_idle_anim()
  end, nil, nil, nil, true)
end

function M:set_bird_can_change_animation(value)
  self.bird_can_change_animation = value
  if not value then
    self.last_click_time = UnityTime.realtimeSinceStartup
  end
end

function M:get_bird_can_change_animation()
  if self.bird_can_change_animation == nil then
    self.bird_can_change_animation = true
  end
  return self.bird_can_change_animation or UnityTime.realtimeSinceStartup - self.last_click_time > 5
end

function M:get_npc_story_is_played(buddy_event_data)
  local bubble_state = buddy_event_data.bubble_state
  if bubble_state == self.buddy_bubble_enum.InProgress then
    local event_id = buddy_event_data.buddy_info.event_id
    local npc_id = buddy_event_data.npc_id
    local story_id = buddy_event_data.story_id
    local is_played = PlayerPrefsMgr:get_board_story_played(event_id, npc_id, story_id)
    return is_played, true
  end
  return false, false
end

function M:set_npc_story_is_played(buddy_event_data)
  local bubble_state = buddy_event_data.bubble_state
  if bubble_state == self.buddy_bubble_enum.InProgress then
    local event_id = buddy_event_data.buddy_info.event_id
    local npc_id = buddy_event_data.npc_id
    local story_id = buddy_event_data.story_id
    PlayerPrefsMgr:set_board_story_played(event_id, npc_id, story_id, 1)
  end
end

function M:get_main_bird_red()
  local red_type = commonDef.MASCOT_TASK_RED_TYPE.None
  local mascot_event_list = self:get_show_mascot_list()
  for _, mascot_data in pairs(mascot_event_list) do
    if mascot_data.mascot_info.state == commonDef.MASCOT_EVENT_TYPE.None then
      red_type = commonDef.MASCOT_TASK_RED_TYPE.CanAccept
    end
    local ic_can_receive = self:get_task_finished_with_mascot_event_id(mascot_data.mascot_info.event_id)
    if ic_can_receive then
      red_type = commonDef.MASCOT_TASK_RED_TYPE.CanReceive
      break
    end
  end
  return red_type
end

function M:get_buddy_action_with_param(buddy_id, buddy_event_anim_type)
  return SignBoardGirlMgr:get_action_by_param(buddy_id, Config.CONDITION_ACTION.BUDDY_EVENT, buddy_event_anim_type)
end

function M:request_get_event_reward_with_task_data(task_data, callback)
  self:request_get_event_reward(task_data.task_info.task_id, nil, callback)
end

function M:request_get_event_reward(task_id, buddy_event_id, callback)
  Network:call("c2gs_get_event_reward", {task_id = task_id, buddy_event_id = buddy_event_id}, function(ok, resp)
    if ok and callback then
      callback(resp)
    end
  end)
end

function M:request_each_center_event(event_type, event_id, callback)
  local body = {event_type = event_type, event_id = event_id}
  Network:call("c2gs_each_centre_event", body, function(ok, resp)
    if ok and callback then
      callback(resp)
    end
  end)
end

function M:check_award_full(task_id, task_id_list)
  if not PuzzleMgr:is_puzzle_bag_full() then
    return
  end
  if task_id then
    return self:check_task_award_include_puzzle(task_id)
  elseif task_id_list then
    for _, id in ipairs(task_id_list) do
      if self:check_task_award_include_puzzle(id) then
        return true
      end
    end
  end
  return false
end

function M:check_task_award_include_puzzle(task_id)
  local task_cfg = ShareRes.get_task_cfg(task_id)
  local award_group_id = task_cfg and task_cfg.Award
  if not award_group_id then
    return false
  end
  local award_data = ShareRes.get_award_item_data(award_group_id)
  if not award_data then
    return false
  end
  for _, data in ipairs(award_data) do
    if PuzzleMgr:is_puzzle_item(data[1]) then
      return true
    end
  end
  return false
end

return M
