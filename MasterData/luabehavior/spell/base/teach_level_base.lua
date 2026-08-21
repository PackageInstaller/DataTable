local Guide = require("spell.base.teach_guide")
local _sformat = string.format
local _tunpack = table.unpack
local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)

function M:_init()
  self.v_curr_guide = nil
  self.v_interval_call = {}
  clear_fight_ui_objs()
end

function M:create_guide(name)
  self.v_curr_guide = Guide:new(name, self)
  return self.v_curr_guide
end

function M:switch_guide(name)
  return self.v_curr_guide and self.v_curr_guide:name() == name
end

function M:to_next_guide(name, delay_time)
  if self.v_curr_guide then
    self.v_curr_guide:quit()
  end
  self.v_curr_guide = nil
  self:cancel_guide_timeout()
  self:cancel_interval_call("next_step")
  self:cancel_interval_call("back_step")
  local guide_func = self["teach_" .. name]
  if not guide_func then
    Log.Error("teach_level ---- the guide_func not exist = ", "teach_" .. name)
    return
  end
  if delay_time then
    self:insert_interval_call("next_guide", delay_time, guide_func, self)
  else
    guide_func(self)
  end
end

function M:to_next_step(delay_time)
  self.v_curr_guide:step_finished()
  if delay_time then
    self:insert_interval_call("next_step", delay_time, function()
      self.v_curr_guide:to_next_step()
    end)
  else
    self.v_curr_guide:to_next_step()
  end
end

function M:back_to_step(index, delay_time)
  self.v_curr_guide:step_finished()
  if delay_time then
    self:insert_interval_call("back_step", delay_time, function()
      self.v_curr_guide:back_to_step(index)
    end)
  else
    self.v_curr_guide:back_to_step(index)
  end
end

function M:get_time()
  return get_npc_time(self.npc)
end

function M:call_guide_listen_func(name, ...)
  if not self.v_curr_guide then
    return
  end
  self.v_curr_guide:call_listen_func(name, ...)
end

function M:guide_timeout(time, func, name)
  if not name then
    name = "guide_timeout"
  else
  end
  self:insert_interval_call(name, time, func)
end

function M:cancel_guide_timeout(name)
  name = name or "guide_timeout"
  self:cancel_interval_call(name)
end

function M:end_teach_guide()
  self.v_curr_guide:quit()
  self.v_interval_call = {}
  self.v_curr_guide = nil
end

function M:check_monster_had_created(monster_group)
  return get_sync_var("had_created_" .. monster_group)
end

function M:insert_interval_call(key, delay, cb, ...)
  if self.v_interval_call[key] ~= nil then
    return
  end
  local elapse = (delay or 0) + self:get_time()
  local args = {
    ...
  }
  self.v_interval_call[key] = {
    elapse = elapse,
    cb = cb,
    args = #args > 0 and args or nil
  }
end

function M:cancel_interval_call(key)
  self.v_interval_call[key] = nil
end

function M:on_frame()
  local curr_time = self:get_time()
  if self.v_curr_guide then
    self.v_curr_guide:on_frame()
  end
  local process_list = {}
  for k, call_info in pairs(self.v_interval_call) do
    if curr_time >= call_info.elapse then
      process_list[#process_list + 1] = call_info
      self.v_interval_call[k] = nil
    end
  end
  for _, call_info in ipairs(process_list) do
    if call_info.args then
      call_info.cb(_tunpack(call_info.args))
    else
      call_info.cb()
    end
  end
end

return M
