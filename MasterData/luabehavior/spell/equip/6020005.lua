local M = Util.create_class()

function M:_init()
  self.atk_count = 0
  self.atk_set = 0
  self.now_input_id = nil
  self.reset_cooldown = 0
end

function M:hurt()
  if check_npc_status(self.npc, 2) then
    self.atk_count = 0
    self.reset_cooldown = 0
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if damage_val > 0 then
    self.atk_count = self.atk_count + 1
    if 1 == self.atk_count then
      self.atk_set = 1
    end
  end
  if 5 == self.atk_count then
    cast_magic(self.npc, hit_target, 6021002, 1)
    self.atk_count = 0
  end
end

function M:reset_CD()
  if 1 == self.atk_count and 1 == self.atk_set then
    self.reset_cooldown = get_npc_time(self.npc) + 5
    self.atk_set = 0
  end
end

function M:on_frame()
  self:reset_CD()
  local now_time = get_npc_time(self.npc)
  if now_time > self.reset_cooldown then
    self.atk_count = 0
  end
end

function M:on_input(input_id)
  self.now_input_id = input_id
end

return M
