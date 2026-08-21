local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_skill_begin(npc, skill_id)
  if 3 == get_skill_cfg(skill_id).SkillType then
    cast_magic(self.npc, self.npc, 6021033, 1)
  end
end

function M:on_frame()
  if get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) < 0.25 and 0 ~= self.magic_set then
    cast_magic(self.npc, self.npc, 6021033, 1)
    self.magic_set = 0
  end
  if get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) >= 0.25 and get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) < 0.5 and 1 ~= self.magic_set then
    cast_magic(self.npc, self.npc, 6021029, 1)
    self.magic_set = 1
  end
  if get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) >= 0.5 and get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) < 0.75 and 2 ~= self.magic_set then
    cast_magic(self.npc, self.npc, 6021033, 1)
    cast_magic(self.npc, self.npc, 6021030, 1)
    self.magic_set = 2
  end
  if get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) >= 0.75 and get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) < 1 and 3 ~= self.magic_set then
    cast_magic(self.npc, self.npc, 6021033, 1)
    cast_magic(self.npc, self.npc, 6021031, 1)
    self.magic_set = 3
  end
  if 1 == get_npc_attr(self.npc, 2) / get_npc_attr(self.npc, 5) and 4 ~= self.magic_set then
    cast_magic(self.npc, self.npc, 6021033, 1)
    cast_magic(self.npc, self.npc, 6021032, 1)
    self.magic_set = 4
  end
end

return M
