local M = Util.create_class()

function M:_init()
  self.target = nil
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:on_frame()
  self:search_target()
  if not self.target then
    return
  end
  local now_hp = get_npc_attr(self.target, 1)
  local max_hp = get_npc_attr(self.target, 4)
  if now_hp / max_hp <= 0.3 then
    cast_magic(self.npc, self.target, 6031005, 1)
    cast_magic(self.npc, self.target, 6031006, 1)
    cast_magic(self.npc, self.target, 6031007, 1)
    cast_magic(self.npc, self.target, 6031008, 1)
    cast_magic(self.npc, self.target, 6031009, 1)
  elseif check_magic(self.target, 6031005) then
    abort_magic_by_id(self.target, 6031005)
    abort_magic_by_id(self.target, 6031006)
    abort_magic_by_id(self.target, 6031007)
    abort_magic_by_id(self.target, 6031008)
    abort_magic_by_id(self.target, 6031009)
  end
end

return M
