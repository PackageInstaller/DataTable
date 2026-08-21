local M = Util.create_class()
local PLAY_PARAM_INDEX = 1
local NEXT_PARAM_INDEX = 2
local PLAY_INDEX = 0
local PLAY_STATE = {
  WAIT = 0,
  PLAY = 1,
  ON_ABORT = 2,
  ABORT = 3
}
local DEBUG_MODE = false

function M:clear_all()
  local first_param = self.v_skill_effect_queue[PLAY_PARAM_INDEX]
  if first_param then
    self:stop_effect(first_param.play_index, true)
  end
  self.v_skill_effect_queue = {}
  self.v_skill_effect_count = 0
end

function M:on_destroy()
  self.v_skill_effect_queue = {}
  self.v_skill_effect_count = 0
  Util.unbind_all_msg(self)
end

function M:_init()
  Util.bind_msg(self, Const.MSG_SCENE_RELOAD_END, self.clear_all, self)
  self.v_skill_effect_queue = {}
  self.v_skill_effect_count = 0
end

function M:update()
  local first_param = self.v_skill_effect_queue[PLAY_PARAM_INDEX]
  if not first_param then
    return
  end
  if first_param.play_state ~= PLAY_STATE.WAIT then
    self:update_effect_time()
    return
  end
end

function M:effect_enqueue(param)
  self.v_skill_effect_count = self.v_skill_effect_count + 1
  local length = #self.v_skill_effect_queue
  self.v_skill_effect_queue[length + 1] = param
  if DEBUG_MODE then
    local temp_param = UtilTable.copy_table(param)
    temp_param.owner = param.uuid
    Log.Error("effect_enqueue", length + 1, temp_param, debug.traceback())
  end
end

function M:stop_effect(play_index, stop_magic)
  local param
  for index = 1, #self.v_skill_effect_queue do
    param = self.v_skill_effect_queue[index]
    if param.play_index == play_index then
      if not Util.is_destroy(param.owner) and stop_magic then
        for i = 1, #param.magic_list do
          param.owner.magic_mgr:remove_first_magic(param.magic_list[i])
        end
        for i = 1, #param.abort_magic_list do
          param.owner.magic_mgr:remove_first_magic(param.abort_magic_list[i])
        end
      end
      table.remove(self.v_skill_effect_queue, index)
      self.v_skill_effect_count = self.v_skill_effect_count - 1
      if DEBUG_MODE then
        local temp_param = UtilTable.copy_table(param)
        temp_param.owner = param.uuid
        Log.Error("stop_effect", play_index, temp_param, debug.traceback())
      end
      break
    end
  end
end

function M:add_skill_effect(owner, magic_list, abort_magic_list, abort_time, start_abort_time, abort_duration, magic_duration, left_send_msg_time)
  if Util.is_destroy(owner) or owner:is_die() then
    return
  end
  PLAY_INDEX = PLAY_INDEX + 1
  local play_index = PLAY_INDEX
  local param = {
    owner = owner,
    magic_list = magic_list,
    abort_magic_list = abort_magic_list,
    abort_time = abort_time,
    start_abort_time = start_abort_time,
    play_state = PLAY_STATE.WAIT,
    play_index = play_index,
    left_time = abort_duration,
    magic_duration = magic_duration,
    left_send_msg_time = left_send_msg_time,
    send_left_msg_suc = nil,
    send_start_msg_suc = nil
  }
  self:effect_enqueue(param)
  self:check_skill_effect_play()
end

function M:check_skill_effect_play()
  local first_param = self.v_skill_effect_queue[PLAY_PARAM_INDEX]
  if not first_param then
    return
  end
  if first_param.play_state ~= PLAY_STATE.WAIT then
    return
  end
  self:play_skill_effect()
end

function M:play_skill_effect()
  local first_param = self.v_skill_effect_queue[PLAY_PARAM_INDEX]
  local owner = first_param.owner
  if Util.is_destroy(owner) or owner:is_die() then
    self:play_next_effect(first_param.play_index, true)
    return
  end
  if DEBUG_MODE then
    local temp_param = UtilTable.copy_table(first_param)
    temp_param.owner = first_param.uuid
    Log.Error("play_skill_effect", temp_param, debug.traceback())
  end
  first_param.play_state = PLAY_STATE.PLAY
  first_param.left_duration = 0
  local magic_list = first_param.magic_list
  local length = #magic_list
  for index = 1, length do
    owner.magic_mgr:add_magic(owner, magic_list[index])
  end
  if not first_param.send_start_msg_suc then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_SKILL_LINK_START, first_param.owner)
    first_param.send_start_msg_suc = true
  end
end

function M:stop_skill_effect()
  local first_param = self.v_skill_effect_queue[PLAY_PARAM_INDEX]
  local owner = first_param.owner
  if Util.is_destroy(owner) or owner:is_die() then
    self:play_next_effect(first_param.play_index, true)
    return
  end
  if DEBUG_MODE then
    local temp_param = UtilTable.copy_table(first_param)
    temp_param.owner = first_param.uuid
    Log.Error("stop_skill_effect", temp_param, debug.traceback())
  end
  for i = 1, #first_param.magic_list do
    first_param.owner.magic_mgr:remove_first_magic(first_param.magic_list[i])
  end
end

function M:play_abort_effect()
  local first_param = self.v_skill_effect_queue[PLAY_PARAM_INDEX]
  local owner = first_param.owner
  if Util.is_destroy(owner) or owner:is_die() then
    self:play_next_effect(first_param.play_index, true)
    return
  end
  if DEBUG_MODE then
    local temp_param = UtilTable.copy_table(first_param)
    temp_param.owner = first_param.uuid
    Log.Error("play_abort_effect", temp_param, debug.traceback())
  end
  local abort_magic_list = first_param.abort_magic_list
  local length = #abort_magic_list
  for index = 1, length do
    owner.magic_mgr:add_magic(owner, abort_magic_list[index])
  end
end

function M:stop_abort_effect()
  local first_param = self.v_skill_effect_queue[PLAY_PARAM_INDEX]
  local owner = first_param.owner
  if Util.is_destroy(owner) or owner:is_die() then
    self:play_next_effect(first_param.play_index, true)
    return
  end
  if DEBUG_MODE then
    local temp_param = UtilTable.copy_table(first_param)
    temp_param.owner = first_param.uuid
    Log.Error("stop_abort_effect", temp_param, debug.traceback())
  end
  local abort_magic_list = first_param.abort_magic_list
  local length = #abort_magic_list
  for index = 1, length do
    owner.magic_mgr:remove_first_magic(owner, abort_magic_list[index])
  end
end

function M:update_effect_time()
  local first_param = self.v_skill_effect_queue[PLAY_PARAM_INDEX]
  if Util.is_destroy(first_param.owner) then
    self:play_next_effect(first_param.play_index, true)
    return
  end
  local dt = Global.delta_time
  first_param.left_duration = first_param.left_duration + dt
  local left_duration = first_param.left_duration
  if self.v_skill_effect_queue[NEXT_PARAM_INDEX] then
    if first_param.send_left_msg_suc then
      self:play_next_effect(first_param.play_index, false)
    elseif first_param.play_state == PLAY_STATE.PLAY and left_duration >= first_param.start_abort_time then
      first_param.left_duration = 0
      first_param.play_state = PLAY_STATE.ON_ABORT
      self:play_abort_effect()
    elseif first_param.play_state == PLAY_STATE.ON_ABORT and left_duration >= first_param.abort_time then
      first_param.left_duration = 0
      first_param.play_state = PLAY_STATE.ABORT
      self:stop_skill_effect()
    elseif first_param.play_state == PLAY_STATE.ABORT and left_duration >= first_param.left_time then
      self:stop_abort_effect()
      self:play_next_effect(first_param.play_index, true)
    end
  else
    local left_send_msg_time = first_param.left_send_msg_time
    local send_left_msg_suc = first_param.send_left_msg_suc
    if not send_left_msg_suc and left_send_msg_time > first_param.magic_duration - left_duration then
      BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_BEFORE_SKILL_LINK_END, first_param.owner)
      first_param.send_left_msg_suc = true
    end
    if left_duration >= first_param.magic_duration then
      self:stop_effect(first_param.play_index, true)
    end
  end
end

function M:play_next_effect(play_index, stop_magic)
  self:stop_effect(play_index, stop_magic)
  self:check_skill_effect_play()
end

return M
