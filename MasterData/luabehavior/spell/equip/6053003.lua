local M = Util.create_class()

function M:_init()
  self.time = 0
end

function M:creat_magic(owner, atk_target)
  if get_npc_attr(atk_target, 1) > 0 and check_magic(atk_target, 1999030) then
    cast_magic(atk_target, atk_target, 60530031, 1)
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc == get_come_on_hero() then
    self:creat_magic(npc, target)
  end
end

function M:on_frame()
end

return M
