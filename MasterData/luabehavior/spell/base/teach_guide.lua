local Step = require("spell.base.guide_step")
local M = Util.create_class()

function M:_init(name, behavior)
  self.v_name = name
  self.v_behavior = behavior
  self.v_step_list = nil
  self.v_listen = {}
  self.v_start_time = nil
  self.v_step_id = 0
  self.v_wait_create_monster = {}
end

function M:name()
  return self.v_name
end

function M:listen(name, func)
  self.v_listen[name] = func
end

function M:start()
  self.v_start_time = self.v_behavior:get_time()
  if self.v_step_list then
    self:to_next_step()
  end
end

function M:start_time()
  return self.v_start_time
end

function M:elapse()
  if not self.v_start_time then
    return 0
  end
  return self.v_behavior:get_time() - self.v_start_time
end

function M:call_listen_func(name, ...)
  local func = self.v_listen[name]
  if func then
    func(...)
  end
  local step = self:get_curr_step()
  if step then
    step:call_listen_func(name, ...)
  end
end

function M:add_step(func)
  if not self.v_step_list then
    self.v_step_list = {}
  end
  local step = Step:new(func)
  self.v_step_list[#self.v_step_list + 1] = step
  return step
end

function M:to_next_step()
  self.v_step_id = self.v_step_id + 1
  self.v_wait_create_monster = {}
  local step = self.v_step_list[self.v_step_id]
  step:start(self.v_behavior:get_time())
end

function M:step_elapse()
  local step = self:get_curr_step()
  if not step then
    return 0
  end
  local start_time = step:start_time()
  if not start_time then
    return 0
  end
  return self.v_behavior:get_time() - start_time
end

function M:step_index()
  return self.v_step_id
end

function M:get_curr_step()
  return self.v_step_list and self.v_step_list[self.v_step_id]
end

function M:back_to_step(index)
  local back_form = self.v_step_id
  self.v_step_id = index
  local step = self:get_curr_step()
  if step then
    step:start(self.v_behavior:get_time(), back_form)
  end
end

function M:wait_create_monster(monster_gruop, func)
  self.v_wait_create_monster[monster_gruop] = func
end

function M:step_finished()
  local step = self:get_curr_step()
  if step then
    step:set_finished()
  end
end

function M:on_frame()
  for monster_group, func in pairs(self.v_wait_create_monster) do
    if self.v_behavior:check_monster_had_created(monster_group) then
      self.v_wait_create_monster[monster_group] = nil
      func()
    end
  end
end

function M:quit()
end

return M
