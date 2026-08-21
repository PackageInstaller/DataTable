local M = Util.create_class()

function M:_init()
  self.skill01 = {
    300104201,
    3,
    0,
    0,
    0,
    get_skill_cfg(300100501).CastTime,
    get_skill_cfg(300100501).AfterTime
  }
  self.skill02 = {
    300104202,
    5,
    0,
    0,
    0,
    get_skill_cfg(300100502).CastTime,
    get_skill_cfg(300100502).AfterTime
  }
  self.skill03 = {
    300104203,
    0,
    0,
    0,
    0,
    get_skill_cfg(300104203).CastTime,
    get_skill_cfg(300104203).AfterTime
  }
  self.skill03 = {
    300104204,
    0,
    0,
    0,
    0,
    get_skill_cfg(300104204).CastTime,
    get_skill_cfg(300104204).AfterTime
  }
  self.control = nil
  self.target = nil
  self.splash_timer = nil
end

function M:skill_logic()
  if 0 == self.control then
    cast_skill(self.npc, self.target, 300104201, nil, nil)
    self.splash_timer = get_npc_time(self.npc) + 0.75
    self.control = 3
  end
  if 1 == self.control then
    cast_skill(self.npc, self.target, 300104202, nil, nil)
    self.splash_timer = get_npc_time(self.npc) + 6
    self.control = 4
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 10, nil, 1)
end

function M:on_frame()
  if is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
  self:skill_logic()
  self:search_target()
  if self.target and self.control == nil then
    self.control = 0
  end
  if 3 == self.control and get_npc_time(self.npc) > self.splash_timer then
    self.control = 1
  end
  if 4 == self.control and get_npc_time(self.npc) > self.splash_timer then
    self.control = nil
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  if missile_cfg.Id == 30010420201 and npc == self.npc then
    cast_missile(self.npc, self.target, nil, nil, 30010420405, 1, nil, nil, nil)
  end
end

return M
