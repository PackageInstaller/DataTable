local M = Util.create_class()

function M:_init(npc)
  local COPY_ATTR_MAP = {
    [4] = 40000,
    [20] = 50000
  }
  copy_attr_to_npc(npc, npc, COPY_ATTR_MAP)
end

return M
