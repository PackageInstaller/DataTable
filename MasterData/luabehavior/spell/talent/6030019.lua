local M = Util.create_class()

function M:_init(npc)
  self.magic_set = 0
  self.magic_timer = 0
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  local now_time = get_npc_time(self.npc)
  if not check_magic(self.npc, 6031037) and 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 6031037, 1)
    cast_magic(self.npc, self.npc, 6031038, 1)
    cast_magic(self.npc, self.npc, 6031039, 1)
    cast_magic(self.npc, self.npc, 6031040, 1)
    cast_magic(self.npc, self.npc, 6031041, 1)
    self.magic_set = 1
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= self.npc then
    return
  end
  if 1 == self.magic_set then
    abort_magic_by_id(self.npc, 6031037)
    abort_magic_by_id(self.npc, 6031038)
    abort_magic_by_id(self.npc, 6031039)
    abort_magic_by_id(self.npc, 6031040)
    abort_magic_by_id(self.npc, 6031041)
    self.magic_timer = get_npc_time(self.npc) + 5
    self.magic_set = 2
  end
end

function M:on_frame()
  if 0 == self.magic_timer then
    self.magic_timer = get_npc_time(self.npc)
  end
  if 2 == self.magic_set then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.magic_timer then
      self.magic_set = 0
    end
  end
end

return M
