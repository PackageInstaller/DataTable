local M = Util.create_class()

function M:_init()
  self.immu_set = false
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if (2 == skill_type or 3 == skill_type or 4 == skill_type) and self.inmmu_set == true then
    abort_magic_by_id(self.npc, 6031055, 1)
    abort_magic_by_id(self.npc, 6031057, 1)
    abort_magic_by_id(self.npc, 6031056, 1)
  end
end

function M:on_npc_removed(npc)
  if npc ~= self.npc then
    self.inmmu_set = true
    cast_magic(self.npc, self.npc, 6031055, 1)
    cast_magic(self.npc, self.npc, 6031056, 1)
    cast_magic(self.npc, self.npc, 6031057, 1)
  end
end

return M
