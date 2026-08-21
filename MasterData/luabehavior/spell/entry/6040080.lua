local M = Util.create_class()

function M:_init(npc)
  self.timer = 15
  self.trigger_time = get_time() + 5
end

function M:on_frame()
  local nowtime = get_time()
  if nowtime > self.trigger_time then
    cast_magic(self.npc, self.npc, 6040081, 0)
    self.trigger_time = nowtime + self.timer
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc and check_magic(self.npc, 6040081) then
    cast_magic(self.npc, npc, 6040082, 0)
  end
end

return M
