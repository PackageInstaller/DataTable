local M = Util.create_class()

function M:_init(npc)
  self.skill02 = {
    300200102,
    0,
    0,
    0,
    0,
    get_skill_cfg(300200102).CastTime,
    get_skill_cfg(300200102).AfterTime
  }
  self.skill01 = {
    300200101,
    0,
    0,
    0,
    0,
    get_skill_cfg(300200101).CastTime,
    get_skill_cfg(300200101).AfterTime
  }
  self.control = nil
  self.boom_timer = nil
  self.used_hp = 0
  enable_shadow(npc, false)
end

function M:cast_skill(skill_instant_ID)
  if 300200101 == skill_instant_ID[1] then
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    self.boom_timer = get_npc_time(self.npc) + 1.5
    self.control = 3
  end
  if 300200102 == skill_instant_ID[1] then
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    self.boom_timer = get_npc_time(self.npc) + 16.3
    cast_magic(self.npc, self.npc, 399931, 1)
    cast_magic(self.npc, self.npc, 399932, 1)
    cast_magic(self.npc, self.npc, 399933, 1)
    cast_magic(self.npc, self.npc, 3001022003, 1)
    set_can_searched(self.npc, false)
    self.control = 4
  end
end

function M:control_set()
  if 0 == self.control then
    self:cast_skill(self.skill01)
  end
  if 1 == self.control then
    self:cast_skill(self.skill02)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc then
    return
  end
  if hit_target == self.npc and self.control == nil and 0 ~= hit_type then
    self.control = 0
  end
end

function M:on_frame()
  if is_pass_room() then
    set_can_searched(self.npc, false)
  end
  if not is_in_challenge() and is_pass_room() then
    abort_skill(self.npc)
    set_can_searched(self.npc, false)
    self.control = 9
  end
  self:control_set()
  if 3 == self.control and get_npc_time(self.npc) > self.boom_timer then
    self.control = 1
  end
  if 4 == self.control and get_npc_time(self.npc) > self.boom_timer then
    cast_magic(self.npc, self.npc, 399934, 1)
    cast_magic(self.npc, self.npc, 3001022004, 1)
    abort_magic_by_id(self.npc, 399931)
    abort_magic_by_id(self.npc, 399932)
    set_can_searched(self.npc, true)
    self.control = nil
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

function M:skill_logic()
  if 0 == self.control then
    cast_skill(self.npc, nil, 300200101, nil, nil)
    self.boom_timer = get_npc_time(self.npc) + 1.5
    self.control = 3
  end
  if 1 == self.control then
    cast_skill(self.npc, nil, 300200102, nil, nil)
    self.boom_timer = get_npc_time(self.npc) + 16.3
    cast_magic(self.npc, self.npc, 399931, 1)
    cast_magic(self.npc, self.npc, 399932, 1)
    cast_magic(self.npc, self.npc, 399933, 1)
    cast_magic(self.npc, self.npc, 3001022003, 1)
    set_can_searched(self.npc, false)
    self.control = 4
  end
end

return M
