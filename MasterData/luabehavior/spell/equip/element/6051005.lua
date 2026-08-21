local M = Util.create_class()

function M:_init()
  self.cost_damage = {}
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= self.npc then
    return
  end
  local target_max_hp = get_npc_attr(target, 4)
  if check_magic(target, 1999010) then
    if self.cost_damage[target] == nil then
      self.cost_damage[target] = 0
    end
    self.cost_damage[target] = self.cost_damage[target] + math.abs(damage_val)
    if self.cost_damage[target] / target_max_hp >= 0.25 then
      cast_magic(target, target, 1999011, 1)
      cast_magic(target, target, 1999012, 1)
      self.cost_damage[target] = 0
    end
  end
end

function M:on_magic_end(npc, target, magic_id)
  if 1999010 == magic_id then
    self.cost_damage = {}
  end
end

function M:on_frame()
end

return M
