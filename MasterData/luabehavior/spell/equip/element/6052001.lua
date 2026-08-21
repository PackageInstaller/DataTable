local M = Util.create_class()

function M:_init()
  self.cast_set = false
  self.target = nil
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if check_magic(target, 1999020) and self.cast_set == false then
    local random_choice = math.random() * 100
    if random_choice >= 85 then
      self.target = target
      self.cast_set = true
    end
  end
end

function M:on_frame()
  if self.cast_set == true then
    cast_magic(self.npc, self.target, 60520011, 1)
    self.cast_set = false
  end
end

return M
