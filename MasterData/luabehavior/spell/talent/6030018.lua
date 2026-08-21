local M = Util.create_class()

function M:_init(npc)
  self.magic_set = 0
  self.skill_set = 0
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if not check_magic(self.npc, 6031032) then
    if 6 == damage_sign or 7 == damage_sign or 1 == damage_sign then
      return
    end
    if 0 == self.magic_set then
      cast_magic(self.npc, self.npc, 6031032, 1)
      cast_magic(self.npc, self.npc, 6031033, 1)
      cast_magic(self.npc, self.npc, 6031034, 1)
      cast_magic(self.npc, self.npc, 6031035, 1)
      cast_magic(self.npc, self.npc, 6031036, 1)
      self.magic_set = 1
      self.skill_set = 1
    end
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if npc ~= self.npc then
    return
  end
  if 1 == self.skill_set then
    if 6 == damage_sign or 7 == damage_sign or 1 == damage_sign then
      return
    end
    abort_magic_by_id(self.npc, 6031032)
    abort_magic_by_id(self.npc, 6031033)
    abort_magic_by_id(self.npc, 6031034)
    abort_magic_by_id(self.npc, 6031035)
    abort_magic_by_id(self.npc, 6031036)
    self.magic_set = 0
    self.skill_set = 0
  end
end

return M
