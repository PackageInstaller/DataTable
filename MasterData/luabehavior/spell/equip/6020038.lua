local M = Util.create_class()

function M:_init(npc)
  self.magic_set = 0
  self.target = nil
  self.attack_set = 0
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if 1 == self.magic_set and 1 ~= damage_sign then
    cast_magic(self.npc, self.npc, 6021067, 1)
    print("效果加上")
    self.magic_set = 0
    self.attack_set = 0
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= self.npc then
    return
  end
  if 1 == damage_sign then
    self.attack_set = 1
  else
    self.attack_set = 0
  end
end

function M:on_frame()
  self:search_target()
end

function M:on_npc_hp_zero(npc)
  if npc == self.target then
    print(self.attack_set)
    if 1 == self.attack_set then
      self.magic_set = 1
      print("开启普攻击杀伤害加成", self.magic_set)
    end
  end
end

return M
