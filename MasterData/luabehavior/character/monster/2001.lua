local M = Util.create_class()
local atk_counting

function M:_init()
  self.skill01 = {
    200105,
    1,
    0,
    0,
    2.5,
    get_skill_cfg(200105).CastTime,
    get_skill_cfg(200105).AfterTime
  }
  self.skill02 = {
    200106,
    6,
    0,
    0,
    2.5,
    get_skill_cfg(200106).CastTime,
    get_skill_cfg(200106).AfterTime
  }
  self.skill03 = {
    200107,
    6,
    0,
    0,
    2.5,
    get_skill_cfg(200107).CastTime,
    get_skill_cfg(200107).AfterTime
  }
  self.skill04 = {
    200108,
    0,
    0,
    0,
    0,
    get_skill_cfg(200108).CastTime,
    get_skill_cfg(200108).AfterTime
  }
  self.skill05 = {
    200109,
    0,
    0,
    0,
    0,
    get_skill_cfg(200109).CastTime,
    get_skill_cfg(200109).AfterTime
  }
  self.skill_rush = 200120
  self.target = nil
  self.wander = {
    3,
    8,
    2
  }
  self.wander_timer = 0
  self.wander_timer_skill_makeup = 0
  self.control = 0
end

function M:get_target()
  if self.target == nil or check_npc_status(self.npc, 5) then
    self.target = search_npc(self.npc, 4, 25, 0, 1)
    print("123123")
    return
  end
  self.target_insant = search_npc(self.npc, 4, 25, 0, 1)
  if check_npc_distance(self.npc, self.target, 8, 0) and self.target ~= self.target_insant and not check_npc_distance(self.npc, self.target_insant, 8, 0) then
    self.target = self.target_insant
  end
end

function M:cast_skill(skill_instant_ID)
  if check_npc_distance(self.npc, self.target, skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, skill_instant_ID[4], false) then
  else
    return
  end
  if get_time() > skill_instant_ID[3] then
    cast_skill(self.npc, self.target, skill_instant_ID[1])
    skill_instant_ID[3] = get_time() + skill_instant_ID[2]
  else
    return
  end
  self.control = 0
  self.wander_timer_skill_makeup = skill_instant_ID[6] + skill_instant_ID[7]
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if not check_npc_status(self.npc, 0) then
    return
  end
  if get_time() < self.wander_timer then
    return
  end
  local ret = self:cast_skill(self.skill03) or self:cast_skill(self.skill02) or self:cast_skill(self.skill01)
  if not ret then
    switch_move_type(self.npc, 0)
    moveto_npc(self.npc, self.target, 1)
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
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 0 == self.control then
  else
    return
  end
  if get_time() < self.wander_timer then
    return
  end
  if check_npc_distance(self.npc, self.target, self.wander[2], true) and not check_npc_distance(self.npc, self.target, self.wander[1], true) then
    self:move_normal_wander()
  end
  if check_npc_distance(self.npc, self.target, self.wander[1], true) then
    self:move_leave_wander()
  end
  if not check_npc_distance(self.npc, self.target, self.wander[2], true) then
    self:move_approch_wander()
  end
  if math.random() > 0.5 then
    self.control = 1
    self.wander_timer = get_time() + self.wander[3] + self.wander_timer_skill_makeup
  end
end

function M:on_frame()
  self:get_target()
  self:skill_main_logic()
  self:wander_main_logic()
end

function M:on_skill()
end

function M:on_behit()
end

return M
