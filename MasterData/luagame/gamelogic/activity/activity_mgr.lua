local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local commonDef = require("cs_share.common_define")
local ActivityCfg = require("gamelogic.activity.activity_config")
local ACTY_STATE = ActivityCfg.ACTY_STATE
local TOP_VER_TASK_RED_ID = 27
local TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}

function M:init_sys()
  Base.init_sys(self)
  self.v_activities = {}
end

function M:on_reconnect()
  self.v_activities = {}
end

function M:sync_acty_open_list(data)
  if not data.acty_infos then
    return
  end
  for k, v in pairs(data.acty_infos) do
    self:_create_activity(v)
  end
  self:_refresh_top_ver_redpoint()
end

function M:sync_update_acty_open(data)
  local activity = self.v_activities[data.acty_type]
  if data.is_open then
    if not activity then
      self:_create_activity({
        acty_type = data.acty_type,
        acty_id = data.acty_id
      })
    else
      Log.Error("repeat create activity! activity_id=", data.acty_type)
    end
  elseif activity then
    self:_close_activity(data.acty_type)
  end
end

function M:_create_activity(activity_info)
  local activity_id = activity_info.acty_type
  if ActivityCfg.ACTY_TYPE[activity_id] then
    local class = ActivityCfg.ACTY_TYPE[activity_id].class
    self.v_activities[activity_id] = require(class):new(activity_id, activity_info.acty_id)
    local msg = MsgGame:mq_publish2(Const.MSG_ACTIVITY_OPEN)
    msg.mm_x = activity_id
  end
end

function M:_close_activity(activity_id)
  local activity = self.v_activities[activity_id]
  if not activity then
    return
  end
  activity:close_activity()
  self.v_activities[activity_id] = nil
  local msg = MsgGame:mq_publish2(Const.MSG_ACTIVITY_CLOSE)
  msg.mm_x = activity_id
end

function M:update(delta_time)
  for _, v in pairs(self.v_activities) do
    v:update(delta_time)
  end
end

function M:get_activity_is_open(activity_id)
  local activity = self.v_activities[activity_id]
  if not activity then
    return false
  else
    local state = activity:get_activity_open_state()
    return state == ACTY_STATE.ACTY_OPEN
  end
end

function M:get_game_is_open(activity_id)
  local activity = self.v_activities[activity_id]
  if not activity then
    return false
  end
  return activity:get_game_open_state() == ACTY_STATE.PLAY_OPEN
end

function M:get_activity(activity_id)
  return self.v_activities[activity_id]
end

function M:invoke(activity_id, func_name, ...)
  local activity = self.v_activities[activity_id]
  if not activity then
    return
  end
  if activity[func_name] then
    return activity[func_name](activity, ...)
  end
end

function M:get_top_version_act()
  return self.v_activities[commonDef.ACTY_TYPE.BEST_CONFIG_FIGHT]
end

function M:get_challenge_ring_act()
  return self.v_activities[commonDef.ACTY_TYPE.CHALLENGE_RING]
end

function M:get_online_battle_act()
  return self.v_activities[commonDef.ACTY_TYPE.ONLINE_BATTLE]
end

function M:get_curse_ring_act()
  return self.v_activities[commonDef.ACTY_TYPE.CURSE_CIRCLE]
end

function M:_refresh_top_ver_redpoint()
  local cfg = ShareRes.create("activity.best_config_task")
  local show = false
  local activity_id = commonDef.ACTY_TYPE.BEST_CONFIG_FIGHT
  if self:get_activity_is_open(activity_id) then
    for i, v in pairs(cfg) do
      local state = TaskMgr:get_task_state(v.Id)
      if state == TASK_STATE.COMPLETE then
        show = true
        break
      end
    end
  end
  RedPointMgr:enable_redpoint(TOP_VER_TASK_RED_ID, show)
end

function M:get_skill_teach_act()
  return self.v_activities[commonDef.ACTY_TYPE.BUDDY_TEACH]
end

return M
