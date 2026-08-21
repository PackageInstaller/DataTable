local M = Util.create_class()

function M:_init()
  self.skill01 = {
    300105601,
    0,
    0,
    0,
    3,
    get_skill_cfg(300105601).CastTime,
    get_skill_cfg(300105601).AfterTime
  }
  self.skill02 = {
    300105604,
    0,
    0,
    0,
    3,
    get_skill_cfg(300105604).CastTime,
    get_skill_cfg(300105604).AfterTime
  }
  self.skill_set = 0
  self.state = 0
  self.skill01_timer = 0
  self.target = nil
  self.control = 0
end

function M:skill_logic()
  local now_time = get_npc_time(self.npc)
  if not self.target then
    return
  end
  if 0 == self.state and check_npc_distance(self.npc, self.target, 3, true) and now_time >= self.skill01_timer then
    abort_skill(self.npc)
    abort_magic_by_id(self.npc, 3001056001, 1)
    abort_magic_by_id(self.npc, 3001056002, 1)
    abort_magic_by_id(self.target, 3001056001, 1)
    abort_magic_by_id(self.target, 3001056002, 1)
    cast_skill(self.npc, self.target, 300105601, nil)
    self.skill01_timer = now_time + 0.5
  elseif 1 == self.state and check_npc_distance(self.npc, self.target, 3, true) then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, 300105604, nil)
  end
  if not check_npc_distance(self.npc, self.target, 4, true) then
    abort_magic_by_id(self.target, 3001056001, 1)
    abort_magic_by_id(self.target, 3001056002, 1)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target == self.npc then
    if 0 == self.state then
      self.state = 1
    elseif 1 == self.state then
      self.state = 0
    end
  elseif target ~= self.npc then
    return
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 100, nil, 1)
end

function M:on_frame()
  if is_pass_room() then
    abort_skill(self.npc)
    abort_magic_by_id(self.npc, 3001056001, 1)
    abort_magic_by_id(self.npc, 3001056002, 1)
    abort_magic_by_id(self.target, 3001056001, 1)
    abort_magic_by_id(self.target, 3001056002, 1)
    self.control = 9
  end
  self:skill_logic()
  self:search_target()
  self:before_damage()
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    self.control = 99
    abort_magic_by_id(self.npc, 3001056001, 1)
    abort_magic_by_id(self.npc, 3001056002, 1)
    abort_magic_by_id(self.target, 3001056001, 1)
    abort_magic_by_id(self.target, 3001056002, 1)
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, 300105605)
    self.state = 99
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 300105605 == skill_id then
    cast_skill(self.npc, self.target, 300105602)
  end
  if 300105602 == skill_id then
    remove_npc(self.npc)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
end

return M
