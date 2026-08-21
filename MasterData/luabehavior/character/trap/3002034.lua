local M = Util.create_class()

function M:_init(npc)
  enable_shadow(npc, false)
  set_can_searched(npc, false)
  self.skill_attack = 300203401
  self.control = 1
  cast_skill(npc, nil, self.skill_attack)
  play_effect(npc, "Fx_T3001001_idle", "Bip001", false)
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if skill_id == self.skill_attack and -1 ~= self.control then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill_attack)
  end
end

function M:on_self_skill_begin(skill_id, skill_type)
  if skill_id == self.skill_attack then
    self.control = 1
  end
end

return M
