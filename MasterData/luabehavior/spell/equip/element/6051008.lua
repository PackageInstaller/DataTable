local M = Util.create_class()

function M:_init()
  self.count_timer = 0
  self.cast_set = false
  self.cd_timer = 0
  self.control = 0
  self.target = nil
end

function M:on_magic_begin(npc, target, magic_id)
  if self.cast_set then
    return
  end
  if 1999010 == magic_id then
    self.count_timer = get_npc_time(self.npc) + 10
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= self.npc then
    return
  end
  self.target = target
  if not check_magic(target, 1999010) then
    return
  end
  if 1 ~= damage_sign and get_npc_time(self.npc) >= self.cd_timer then
    self.cast_set = true
    cast_magic(self.npc, self.npc, 60510081, 1)
    cast_magic(self.target, self.target, 1999010, 1)
    self.cd_timer = get_npc_time(self.npc) + 20
    cast_magic(self.target, self.target, 60510082, 1)
  end
end

function M:extend()
  if not self.target then
    return
  end
  if self.cast_set and get_npc_time(self.npc) > self.count_timer then
    abort_magic_by_id(self.target, 1999010, 1)
    self.count_timer = 0
    self.cast_set = false
  end
end

function M:on_frame()
  self:extend()
end

return M
