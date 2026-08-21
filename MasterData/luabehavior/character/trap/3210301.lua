local M = Util.create_class()

function M:_init(npc)
  enable_shadow(npc, false)
  set_can_searched(npc, false)
  set_npc_status(npc, 3, true)
  self.skill_attack = 321030101
end

function M:on_npc_born(npc)
  if npc == self.npc then
    cast_skill(self.npc, nil, self.skill_attack)
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break)
  if skill_id == self.skill_attack then
    cast_skill(self.npc, nil, self.skill_attack)
  end
end

return M
