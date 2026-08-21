local M = Util.create_class()

function M:_init()
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    return
  end
  if not check_magic(npc, 1999020) then
    return
  end
  change_skill_cd(self.npc, 18, 1, 60520081)
  cast_magic(self.npc, self.npc, 60520082, 1)
end

return M
