local M = Util.create_class()

function M:_init()
  self.time = 0
end

function M:creat_magic(owner, att_target)
  if math.random(1, 10) <= 2 and check_magic(att_target, 1999050) then
    cast_magic(owner, owner, 60550011, 1)
    self.time = get_npc_time(owner) + 0.5
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
