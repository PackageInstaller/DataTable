local M = Util.create_class()

function M:_init()
  self.cast_set = false
  self.target = nil
  self.cd_timer = 0
  self.cast_floor = 0
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  local now_time = get_npc_time(self.npc)
  if check_magic(target, 1999020) and self.cast_set == false then
    self.target = target
    cast_magic(self.npc, self.npc, 60520061, 1)
    cast_magic(self.npc, self.npc, 60520062, 1)
    self.cast_floor = self.cast_floor + 1
    if self.cast_floor > 5 then
      self.cast_floor = 5
    end
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= self.npc then
    return
  end
  if 1 == self.cast_floor then
    cast_magic(npc, self.npc, 60520063, 1)
  elseif 2 == self.cast_floor then
    abort_magic_by_id(self.npc, 60530063, 99)
    cast_magic(self.npc, self.npc, 60520064, 1)
  elseif 3 == self.cast_floor then
    abort_magic_by_id(self.npc, 60530064, 99)
    cast_magic(self.npc, self.npc, 60520065, 1)
  elseif 4 == self.cast_floor then
    abort_magic_by_id(self.npc, 60530065, 99)
    cast_magic(self.npc, self.npc, 60520066, 1)
  elseif 5 == self.cast_floor then
    abort_magic_by_id(self.npc, 60530066, 99)
    cast_magic(self.npc, self.npc, 60520067, 1)
  end
end

function M:on_frame()
  if not check_magic(self.npc, 60520061) then
    self.cast_set = false
    self.cast_floor = 0
  end
end

return M
