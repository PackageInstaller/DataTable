local M = Util.create_class()

function M:_init(npc)
  self.skill01 = {
    300104301,
    1.5,
    0,
    0,
    0,
    get_skill_cfg(300104301).CastTime,
    get_skill_cfg(300104301).AfterTime
  }
  self.control = 0
  self.change_balls = 0
  self.reflow_balls_timer = 0
  set_can_searched(npc, false)
  enable_shadow(npc, false)
end

function M:create_balls()
  self.target = search_npc(self.npc, 4, 100, nil, 1)
  if get_npc_time(self.npc) > self.change_balls then
    self.change_balls_random = math.random(0, 30)
    self.change_balls = get_npc_time(self.npc) + 12
  end
  if not self.npc or not self.target then
    return
  end
  local now_time = get_npc_time(self.npc)
  local tar_pos = get_npc_pos(self.target)
  local ran_deg = math.random() * 360
  local ran_len = math.random() * 8
  local pos = get_npc_offset_position(self.target, nil, ran_deg, ran_len)
  if now_time >= self.reflow_balls_timer and 0 == self.control then
    if self.change_balls_random <= 10 then
      cast_missile(self.npc, self.target, pos.x, pos.z, 30010430101, 1)
      self.reflow_balls_timer = now_time + math.random() * 3
    elseif self.change_balls_random > 10 and self.change_balls_random <= 20 then
      cast_missile(self.npc, self.target, pos.x, pos.z, 30010430103, 1)
      self.reflow_balls_timer = now_time + math.random() * 2
    elseif self.change_balls_random > 20 and self.change_balls_random <= 30 then
      cast_missile(self.npc, self.target, pos.x, pos.z, 30010430105, 1)
      self.reflow_balls_timer = now_time + math.random()
    end
  end
end

function M:on_frame()
  self:create_balls()
  if is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
end

return M
