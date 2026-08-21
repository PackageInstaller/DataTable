local M = Util.create_class()
local target_list = {}
local ability = 20006
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 60700001102 or missile_cfg.Id == 60700001103 then
    table.insert(target_list, hit_target)
    if get_come_on_hero() == self.npc then
      cast_magic(self.npc, hit_target, 61701061, level)
    end
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if check_magic(target, 61701061) then
    abort_magic_by_id(target, 61701061)
  end
end

return M
