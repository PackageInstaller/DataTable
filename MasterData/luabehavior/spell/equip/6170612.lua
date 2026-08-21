local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local current_energy = 0

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  if check_magic(target, 6170691001) then
    cast_magic(self.npc, self.npc, 61706121)
  end
end

function M:on_start()
  listen_attr_change_mq(self.npc, 108, self.on_ultimate_charge, self)
end

function M:on_ultimate_charge(npc, attr_tpe, change_value)
  if change_value > 0 and get_magic_num(self.npc, 61706122) < 10 then
    local level = get_ability_level(20009)
    cast_magic(self.npc, self.npc, 61706122, level)
  end
end

function M:on_remove()
  unlisten_attr_change_mq(self.npc, 108, self)
end

function M:_init(npc)
end

return M
