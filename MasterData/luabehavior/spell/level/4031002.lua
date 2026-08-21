local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
  self.abnormal_now = nil
  self.abnormal_before = nil
  self.attrtyep = 12
end

function M:on_start()
  self.abnormal_before = get_npc_attr(self.npc, self.attrtyep)
  self:search_target()
end

function M:on_frame()
  if 0 == self.magic_set then
    self.settlementTime = get_npc_time(self.npc) + 1
    self.magic_set = 1
  end
  if 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    cast_magic(self.npc, self.npc, 4031004, 0)
    self.magic_set = 2
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  self.abnormal_now = get_npc_attr(self.npc, self.attrtyep)
  if self.abnormal_now < self.abnormal_before then
    cast_magic(self.npc, self.npc, 4031011, 1)
    cast_magic(self.npc, self.npc, 399936, 0)
    cast_magic(self.npc, self.npc, 399937, 0)
    local monster_pos = get_npc_pos(self.npc)
    create_scene_effect("Fx_Common_Death", monster_pos, 10, "podun")
    cast_magic(self.target, self.target, 1999132, 0)
    cast_magic(self.target, self.target, 1999133, 0)
    cast_magic(self.target, self.target, 1999172, 0)
    abort_magic_by_id(self.npc, 4031001)
  end
end

return M
