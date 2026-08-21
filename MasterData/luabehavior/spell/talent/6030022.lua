local M = Util.create_class()

function M:_init()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if 2 == skill_type then
    cast_magic(self.npc, self.npc, 6031048, 1)
    cast_magic(self.npc, self.npc, 6031049, 1)
    cast_magic(self.npc, self.npc, 6031050, 1)
  end
end

return M
