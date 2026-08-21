local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.target = nil
  self.stun_timer = 0
  self.control = 0
  self.wander = {
    3,
    10,
    1
  }
  self.wander_timer = 2
  self.monster_type = 1
  self.camp_skill_list = {}
end

function M:cast_skill(skill_instant_ID)
  local ran_interval = math.random() * 1.5 + 2
  local now_time = get_npc_time(self.npc)
  if CommonMonster.skill_cast_condition(self, skill_instant_ID, now_time, get_npc_group_id(self.npc), self.monster_type, 1, ran_interval) then
    return false
  end
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
  else
    return
  end
  if get_npc_time(self.npc) >= skill_instant_ID[3] then
    cast_skill(self.npc, self.target, skill_instant_ID[1])
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
    self.stun_timer = get_npc_time(self.npc) + 1.5
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
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
end

function M:look_at()
  if not self.target then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if not is_cast_skill_time(self.npc) then
    lookat_npc(self.npc, self.target, false)
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

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
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
  if 9 == self.control then
    return
  end
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
  if distance_max and not distance_min then
    self:move_normal_wander()
  elseif not distance_max then
    self:move_approch_wander()
  elseif distance_min then
    self:move_normal_wander()
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:on_frame()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.monster_on_frame(self)
end

return M
