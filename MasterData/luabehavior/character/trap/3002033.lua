local M = Util.create_class()

function M:_init(npc)
  enable_shadow(npc, false)
  set_can_searched(npc, false)
  self.skill_standby = 300203301
  self.skill_attack = 300203302
  self.control = 0
  play_effect(npc, "Fx_T3001001_idle", "Bip001", false)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if skill_id == self.skill_attack and -1 ~= self.control then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill_standby)
  end
end

function M:on_self_skill_begin(skill_id, skill_type)
  if skill_id == self.skill_attack then
    self.control = 1
  elseif skill_id == self.skill_standby then
    self.control = 0
  end
end

function M:on_room_pass(room_id)
  if not get_sync_var("trap_switch_on") then
    abort_skill(self.npc)
    self.control = -1
  end
end

return M
