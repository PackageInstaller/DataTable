local M = Util.create_class()

function M:_init()
  self.skill01 = {
    300100701,
    3,
    0,
    0,
    0,
    get_skill_cfg(300100701).CastTime,
    get_skill_cfg(300100602).AfterTime
  }
  self.control = 0
  self.first_timer = 2
  self.cast_timer = 0
end

function M:control_set()
  if 0 == self.control then
    cast_skill(self.npc, self.npc, self.skill01[1], nil, nil)
    self.control = 1
  end
  if 2 == self.control then
    self.cast_timer = get_npc_time(self.npc) + 3
    self.control = 3
  end
end

function M:on_frame()
  local now_time = get_npc_time(self.npc)
  if now_time <= self.first_timer then
    return
  end
  self:control_set()
  if now_time >= self.cast_timer and 3 == self.control then
    self.control = 0
  end
end

function M:on_skill_end(npc, skill_id)
  if npc == self.npc and skill_id == self.skill01[1] then
    self.control = 2
  end
end

return M
