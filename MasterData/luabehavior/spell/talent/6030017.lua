local M = Util.create_class()

function M:_init(npc)
  self.magic_set = 0
  self.magic_layer = 0
  self.magic_timer = 0
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc == self.npc then
    return
  end
  local now_time = get_npc_time(self.npc)
  if now_time < self.magic_timer then
    return
  end
  if 0 == self.magic_set and 0 == self.magic_layer then
    cast_magic(self.npc, npc, 6031029, 1)
    self.magic_layer = self.magic_layer + 1
  elseif 0 == self.magic_set and 1 == self.magic_layer then
    cast_magic(self.npc, npc, 6031030, 1)
    self.magic_layer = self.magic_layer + 1
  elseif 0 == self.magic_set and 2 == self.magic_layer then
    cast_magic(self.npc, npc, 6031031, 1)
    cast_magic(self.npc, self.npc, 6031027, 1)
    cast_magic(self.npc, self.npc, 6031028, 1)
    self.magic_timer = now_time + 5
    self.magic_layer = 0
    self.magic_set = 1
  end
end

function M:on_frame()
  if 1 == self.magic_set then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.magic_timer then
      self.magic_set = 0
    end
  end
end

return M
