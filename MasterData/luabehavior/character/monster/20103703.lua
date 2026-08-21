local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill01 = {
    2010370101,
    4,
    1,
    0,
    2,
    get_skill_cfg(2010370101).CastTime,
    get_skill_cfg(2010370101).AfterTime,
    0
  }
  self.skill02 = {
    2010370102,
    5,
    1,
    0,
    2,
    get_skill_cfg(2010370102).CastTime,
    get_skill_cfg(2010370102).AfterTime,
    0
  }
  self.skill03 = {
    2010370103,
    6,
    1,
    2,
    7,
    get_skill_cfg(2010370103).CastTime,
    get_skill_cfg(2010370103).AfterTime,
    0
  }
  self.allow_boom_time = 0
  self.control = 0
  self.wander = {
    1,
    2,
    1
  }
  self.wander_timer = 2
  self.stun_timer = 0
  self.move_timer = 0
  self.born_state = 0
  self.power_2 = 0
  self.camp_skill_list = {
    self.skill02,
    self.skill03
  }
end

function M:skill_main_logic()
  local now_time = get_npc_time(self.npc)
  if 0 ~= self.control then
    return
  end
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if not check_npc_distance(self.npc, self.target, self.skill01[4], false) and check_npc_distance(self.npc, self.target, self.skill01[5], false) and now_time >= self.skill01[3] then
    lookat_npc(self.npc, self.target, false)
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill01[1])
    self.skill01[3] = now_time + self.skill01[2]
    self.control = 99
  elseif not check_npc_distance(self.npc, self.target, self.skill02[4], false) and check_npc_distance(self.npc, self.target, self.skill02[5], false) and now_time >= self.skill02[3] and 1 == CommonMonster.get_value("二阶段狂暴", 1) then
    lookat_npc(self.npc, self.target, false)
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill02[1])
    self.skill02[3] = now_time + self.skill02[2]
    self.control = 99
  elseif not check_npc_distance(self.npc, self.target, self.skill03[4], false) and check_npc_distance(self.npc, self.target, self.skill03[5], false) and now_time >= self.skill03[3] and 1 == CommonMonster.get_value("二阶段狂暴", 1) then
    lookat_npc(self.npc, self.target, false)
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill03[1])
    self.skill03[3] = now_time + self.skill03[2]
    self.control = 99
  end
end

function M:move_normal_wander()
  self.wander_randomseed = math.random()
  if self.wander_randomseed >= 0.5 then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
  else
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
  end
end

function M:move_leave_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
  self.wander_timer = get_npc_time(self.npc) + 1
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
  self.wander_timer = get_npc_time(self.npc) + 1
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if not check_activate(self.target) then
    return
  end
  if npc_time < self.wander_timer then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
  if distance_max and not distance_min then
    self:move_normal_wander()
  elseif distance_min then
    self:move_leave_wander()
  elseif not distance_max then
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:attack_done_bonus()
  if is_cast_skill_time(self.npc) then
    return
  end
  if 99 == self.control then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.skill_set_time then
      self.control = 0
    end
  end
end

function M:on_frame()
  if not self.npc then
    return
  end
  self:skill_main_logic()
  self:wander_main_logic()
  self:attack_done_bonus()
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

return M
