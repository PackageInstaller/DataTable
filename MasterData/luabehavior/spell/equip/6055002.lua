local M = Util.create_class()

function M:_init()
  self.time = 0
end

function M:creat_magic(owner, att_target)
  if check_magic(att_target, 1999050) and get_npc_time(owner) >= self.time then
    cast_magic(owner, owner, 60550021, 1)
    self.time = get_npc_time(owner) + 3
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
