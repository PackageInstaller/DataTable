local M = Util.create_class()

function M:_init()
  self.cast_set = false
  self.target = nil
  self.CD_timer = false
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  local now_time = get_npc_time(self.npc) + 3
  if check_magic(target, 1999010) and self.cast_set == false then
    self.target = target
    self.cast_set = true
    cast_magic(self.npc, self.npc, 60510011, 1)
    self.CD_timer = now_time + 3
  end
end

function M:on_frame()
  local now_time = get_npc_time(self.npc)
  if not check_magic(self.npc, 60510011) and self.cast_set == true and now_time >= self.CD_timer then
    self.cast_set = false
  end
end

return M
