local M = Util.create_class()

function M:_init()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 3 == skill_type then
    cast_magic(self.npc, self.npc, 6031004, 1)
    cast_magic(self.npc, self.npc, 6031022, 1)
  end
end

return M
