local M = Util.create_class()

function M:_init()
  self.skill01 = {
    300102501,
    0,
    0,
    0,
    0,
    get_skill_cfg(300102501).CastTime,
    get_skill_cfg(300102501).AfterTime
  }
  self.control = 0
  self.shoot_timer = 3
  self.check_set = false
end

function M:on_frame()
  if not is_in_challenge() and is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
  local now_time = get_npc_time(self.npc)
  if now_time >= self.shoot_timer and 0 == self.control then
    cast_skill(self.npc, nil, self.skill01[1])
    self.shoot_timer = self.shoot_timer + 5
  end
  if get_sync_var("Trap_3001025_set", true) and 0 == self.control then
    self.shoot_timer = self.shoot_timer + 0.3
    cast_magic(self.npc, self.npc, 3001025002, 1)
    set_sync_var("Trap_3001025_set", false)
  end
end

return M
