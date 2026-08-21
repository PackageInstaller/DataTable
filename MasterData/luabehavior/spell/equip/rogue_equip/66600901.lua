local M = Util.create_class()

function M:_init()
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    return
  end
  local kind = get_role_kind(npc)
  if (2 == kind or 3 == kind or 4 == kind) and not check_npc_die(self.npc) then
    cast_magic(self.npc, self.npc, 66600902, 0)
  end
end

return M
