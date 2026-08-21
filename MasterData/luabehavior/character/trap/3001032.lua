local M = Util.create_class()

function M:_init()
  self.skill01 = {
    300100103,
    1.5,
    0,
    0,
    0,
    get_skill_cfg(300100103).CastTime,
    get_skill_cfg(300100103).AfterTime
  }
  self.skill02 = {
    300100102,
    9999,
    0,
    0,
    0,
    get_skill_cfg(300100102).CastTime,
    get_skill_cfg(300100102).AfterTime
  }
  self.control = 0
end

function M:cast_skill(skill_instant_ID)
  if skill_instant_ID == self.skill01 and 1 ~= self.control then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if npc_time > skill_instant_ID[3] then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    skill_instant_ID[3] = npc_time + skill_instant_ID[2]
  end
end

function M:on_frame()
  self:cast_skill(self.skill01)
  self:cast_skill(self.skill02)
  if is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  if npc == self.npc and 300100102 == skill_id then
    self.control = 1
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 300100103 == skill_id then
    self.skill02[3] = get_npc_time(self.npc) + self.skill01[2]
    self.control = 0
  end
end

return M
