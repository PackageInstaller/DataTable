local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_npc_born(npc)
  if self.npc == get_come_on_hero() and 1 ~= get_role_kind(npc) then
    cast_magic(self.npc, npc, 40336302, 1)
  end
end

return M
