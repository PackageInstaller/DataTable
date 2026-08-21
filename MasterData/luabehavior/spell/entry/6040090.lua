local M = Util.create_class()

function M:_init(npc)
  self.hp_max = get_npc_attr(npc, 4)
  self.hp_trigger = self.hp_max * 0.4
  self.damage_store = 0
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc then
    self.damage_store = self.damage_store - damage_val
  end
end

function M:on_frame()
  local hp_max_now = get_npc_attr(self.npc, 4)
  if hp_max_now ~= self.hp_max then
    self.damage_store = hp_max_now / self.hp_max * self.damage_store
    self.hp_max = hp_max_now
    self.hp_trigger = self.hp_max * 0.4
  end
  if self.damage_store >= self.hp_trigger then
    cast_magic(self.npc, self.npc, 6040091, 0)
    self.damage_store = 0
  end
end

return M
