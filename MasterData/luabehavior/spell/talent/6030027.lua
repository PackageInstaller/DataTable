local M = Util.create_class()

function M:_init()
  self.value_check = 0
  self.battle_value_1 = 0
  self.battle_value_2 = 0
  self.battle_value_3 = 0
  self.target = nil
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 15, 0, 1)
end

function M:on_frame()
  self:search_target()
  if 0 == self.value_check then
    self.battle_value_1 = get_npc_attr(self.npc, 2)
    self.battle_value_2 = get_npc_attr(self.npc, 72)
    self.battle_value_3 = get_npc_attr(self.npc, 74)
    self.value_check = 1
  elseif 1 == self.value_check then
    local value_1_minnor = self.battle_value_1 - get_npc_attr(self.npc, 2)
    local value_2_minnor = self.battle_value_2 - get_npc_attr(self.npc, 72)
    local value_3_minnor = self.battle_value_3 - get_npc_attr(self.npc, 74)
    if value_1_minnor >= 100 or value_2_minnor >= 100 or value_3_minnor >= 100 then
      self.value_check = 2
    end
  elseif 2 == self.value_check then
    local pos = get_npc_pos(self.target)
    cast_missile(self.npc, nil, pos.x, pos.z, 10019010401, 1)
    self.value_check = 0
  end
end

return M
