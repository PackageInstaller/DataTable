local M = Util.create_class()

function M:_init()
  self.counter_set = 0
  self.counter_timer = nil
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if 0 == self.counter_set and 2 == get_skill_cfg(skill_id).SkillType then
    self.counter_set = 1
    self.counter_timer = get_npc_time(self.npc) + 3
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 1 == self.counter_set and 1 == get_skill_cfg(skill_id).SkillType then
    self.counter_set = 0
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 1 == self.counter_set and 1 == get_skill_cfg(skill_id).SkillType then
    self.counter_set = 0
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if npc ~= self.npc then
    return
  end
  if self.counter_timer == nil then
    return
  end
  if get_npc_time(self.npc) > self.counter_timer then
    self.counter_set = 0
    return
  end
  if 1 == self.counter_set and 1 == damage_sign then
    cast_magic(self.npc, self.npc, 6021070, 1)
  end
end

return M
