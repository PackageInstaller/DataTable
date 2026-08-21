local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local TASK_STATE = Config.TASK_STATE

function M:init_sys()
  Base.init_sys(self)
  self:sys_mq_bind(Const.MSG_ON_TASK_UPDATE, self.on_shooting_task_update, self)
end

function M:request_activity_shoot(activity_id, shoot_type, shoot_index)
  Network:protect_call("c2gs_activity_shooting_game_shoot", {
    activity_id = activity_id,
    type = shoot_type,
    target_index = shoot_index
  }, nil)
end

function M:request_shooting_game_record(activity_id)
  Network:protect_call("c2gs_activity_shooting_game_record", {activity_id = activity_id}, function(ok, resp)
    if ok and 0 == resp.errcode then
      local ui_activity_daily1 = UIMgr:try_get_visible_ui("ui_activity_daily1")
      if ui_activity_daily1 then
        ui_activity_daily1:store_reward_record(resp.items)
      end
    end
  end)
end

function M:on_gs2c_activity_shooting_game_update(data)
  self.v_shooting_game_cache = {}
  self.v_update_shooting_game_info = data or {}
  self:update_target_info()
  local ui_activity_daily1 = UIMgr:try_get_visible_ui("ui_activity_daily1")
  local ui_activity = UIMgr:try_get_visible_ui("ui_activity")
  if ui_activity_daily1 and ui_activity then
    ui_activity:set_full_mask_active(true)
    ui_activity_daily1:play_shoot_ani(data.shooting_target_list)
    ui_activity_daily1:on_shooting_game_partly_update()
  end
end

function M:set_shooting_game_cache(data)
  self.v_shooting_game_cache = data or {}
end

function M:get_shooting_game_cache()
  return self.v_shooting_game_cache
end

function M:on_gs2c_activity_shooting_game_info(data)
  self.v_shooting_game_info = data or {}
  self:set_shooting_game_cache(self.v_shooting_game_info)
  self:check_activity_task()
  local ui_activity_daily1 = UIMgr:try_get_visible_ui("ui_activity_daily1")
  if ui_activity_daily1 then
    ui_activity_daily1:on_shooting_game_update()
  end
end

function M:check_is_last_target()
  local invalid_num = 0
  for _, v in ipairs(self.v_shooting_game_info.shooting_target_list) do
    if v.is_invalid then
      invalid_num = invalid_num + 1
    end
  end
  return invalid_num == #self.v_shooting_game_info.shooting_target_list
end

function M:get_shooting_game_info()
  return self.v_shooting_game_info
end

function M:update_target_info()
  for i, info in ipairs(self.v_shooting_game_info.shooting_target_list) do
    for _, v in ipairs(self.v_update_shooting_game_info.shooting_target_list) do
      if info.index == v.index then
        self.v_shooting_game_info.shooting_target_list[i] = v
      end
    end
  end
end

function M:check_activity_task()
  self.v_task_cfg = ShareRes.create("routine_activity.shooting_game_task_group")
  self.v_task_list = ShareRes.get_task_group(self.v_task_group_id)
  local show_red = false
  for idx, data in pairs(self.v_task_cfg) do
    for i, task_id in pairs(data.TaskList) do
      local task_state = TaskMgr:get_task_state(task_id)
      if task_state == TASK_STATE.COMPLETE then
        show_red = true
        RedPointMgr:enable_redpoint(RedEnum.ACT_DAILY_01_TASK, show_red)
        goto lbl_41
      end
    end
  end
  ::lbl_41::
end

function M:on_shooting_task_update()
  self:check_activity_task()
end

return M
