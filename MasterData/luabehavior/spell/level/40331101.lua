local M = Util.create_class()

function M:_init()
end

function M:on_npc_born(npc)
  local kind = get_role_kind(npc)
  if 2 == kind then
    cast_magic(npc, npc, 40331102, 1)
  end
end

return M
