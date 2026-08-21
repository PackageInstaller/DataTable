local M = Util.create_class()

function M:_init()
end

function M:before_heal(npc, target, magic_id)
  if target ~= self.npc then
    return
  end
  if 5001001 == magic_id or 5001002 == magic_id or 5001003 == magic_id or 5001004 == magic_id then
    cast_magic(self.npc, self.npc, 6031054, 1)
  end
end

return M
