local M = Util.create_class()

function M:_init()
  self.come_on_hero = nil
end

function M:on_start()
  self.come_on_hero = get_come_on_hero()
end

function M:on_hero_showup_or_back(npc, is_showup)
  if true == is_showup then
    self.come_on_hero = get_come_on_hero()
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if target ~= self.npc then
    return
  end
  if damage_val < 0 then
    cast_magic(target, target, 66101801)
  end
end

return M
