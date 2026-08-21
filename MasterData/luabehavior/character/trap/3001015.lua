local M = Util.create_class()

function M:_init()
  self.skill02 = {
    300101502,
    3,
    0,
    0,
    0,
    get_skill_cfg(300101502).CastTime,
    get_skill_cfg(300101502).AfterTime
  }
  self.skill01 = {
    300101501,
    5,
    0,
    0,
    0,
    get_skill_cfg(300101501).CastTime,
    get_skill_cfg(300101501).AfterTime
  }
  self.control = nil
  self.boom_timer = nil
  self.used_hp = 0
end

function M:cast_skill(skill_instant_ID)
  if 300101501 == skill_instant_ID[1] then
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    self.boom_timer = get_npc_time(self.npc) + 0.75
    self.control = 3
  end
  if 300101502 == skill_instant_ID[1] then
    cast_skill(self.npc, nil, skill_instant_ID[1], nil, nil)
    cast_magic(self.npc, self.npc, 399933, 1)
    cast_magic(self.npc, self.npc, 4010005, 1)
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

function M:search_target()
  self.target = search_npc(self.npc, 7, 1.5, nil, 1)
end

function M:on_frame()
  if is_pass_room() and not get_sync_var("trap_switch_on") then
    abort_skill(self.npc)
    self.control = 9
  end
  self:control_set()
  self:search_target()
  if self.target and self.control == nil then
    self.control = 0
  end
  if 3 == self.control and get_npc_time(self.npc) > self.boom_timer then
    self.control = 1
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

return M
