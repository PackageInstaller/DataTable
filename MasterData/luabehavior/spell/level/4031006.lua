local M = Util.create_class()
local Aten

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
end

function M:on_start()
end

function M:on_frame()
  if 0 == self.magic_set then
    self.settlementTime = get_npc_time(self.npc) + 1
    self.magic_set = 1
  end
  if 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    self.magic_set = 2
  end
  if 2 == self.magic_set then
    Aten = search_npc(self.npc, 2, 100, nil, 1)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and (500192 == skill_id or 500122 == skill_id or 500122 == skill_id or 500124 == skill_id) then
    cast_magic(self.npc, self.npc, 4010184, 1)
  end
end

return M
