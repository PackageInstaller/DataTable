local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill01 = {
    20104001,
    4,
    1,
    0,
    2,
    get_skill_cfg(20104001).CastTime,
    get_skill_cfg(20104001).AfterTime,
    0
  }
  self.wander = {1.7, 0.5}
  self.wander_timer = 3
  self.wander_timer_skill_makeup = 0
  self.target = nil
  self.control = 0
  self.stun_timer = 0
end

function M:cast_skill(skill_instant_ID)
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
    return
  end
  if 0 ~= self.control then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, skill_instant_ID[4], false) then
    lookat_npc(self.npc, self.target)
  else
    return
  end
  if get_npc_time(self.npc) >= skill_instant_ID[3] then
    cast_skill(self.npc, self.target, skill_instant_ID[1])
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
    self.stun_timer = get_npc_time(self.npc) + 1.5
    self.wander_timer = get_npc_time(self.npc) + self.wander[2]
    self.control = 3
  end
end

function M:attack_done_bonus()
  local bonus_timer = self.wander_timer + 1
  if bonus_timer <= get_npc_time(self.npc) and 3 == self.control then
    self.control = 0
    self:wander_main_logic()
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  local casted = self:cast_skill(self.skill01)
  if not casted and check_npc_distance(self.npc, self.target, self.wander[1], true) then
    stop_move(self.npc)
  end
end

function M:move_approch_wander()
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  switch_move_type(self.npc, 1)
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 1.5
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 0 ~= self.control then
    return
  end
  if get_npc_time(self.npc) < self.wander_timer then
    self.control = 0
    return
  end
  if not check_npc_distance(self.npc, self.target, self.wander[1], true) then
    self:move_approch_wander()
  end
  if check_npc_distance(self.npc, self.target, self.wander[1], false) then
    stop_move(self.npc)
    lookat_npc(self.npc, self.target, 1)
    self.wander_timer = get_npc_time(self.npc) + self.wander[2]
  end
end

function M:on_frame()
  if check_magic(self.npc, 100174) then
    return
  end
  if get_sync_var("in_daze") then
    self.control = 9
  end
  self:wander_main_logic()
  self:skill_main_logic()
  self:attack_done_bonus()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
end

return M
