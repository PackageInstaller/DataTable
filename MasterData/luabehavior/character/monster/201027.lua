local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill03 = {
    20102704,
    5.1,
    0,
    0,
    2,
    get_skill_cfg(20102702).CastTime,
    get_skill_cfg(20102702).AfterTime,
    0
  }
  self.skill02 = {
    20102702,
    5.1,
    0,
    0,
    7,
    get_skill_cfg(20102702).CastTime,
    get_skill_cfg(20102702).AfterTime,
    0
  }
  self.skill01 = {
    20102701,
    5,
    1,
    0,
    7,
    get_skill_cfg(20102701).CastTime,
    get_skill_cfg(20102701).AfterTime,
    self.skill02
  }
  self.Entter_Attack_Range = 10
  self.stun_timer = 0
  self.born_skill = 20100903
  self.control = 0
  self.wander_time = 0
  self.near_attack_time = 0
  self.skill_time = 0
end

function M:on_start()
  self.skill01[4] = math.random(5, 6)
end

function M:Relese_skill(Skill_ID)
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    return
  end
  if check_npc_distance(self.npc, self.target, Skill_ID[5], true) and not check_npc_distance(self.npc, self.target, Skill_ID[4], true) then
    lookat_npc(self.npc, self.target)
  else
    return
  end
  if get_npc_time(self.npc) >= Skill_ID[3] then
    stop_move(self.npc)
    cast_skill(self.npc, self.target, Skill_ID[1])
    cast_magic(self.npc, self.npc, 100458, 1)
    Skill_ID[3] = get_npc_time(self.npc) + Skill_ID[2]
    self.stun_timer = get_npc_time(self.npc) + 1.5
    self.skill_time = get_npc_time(self.npc) + 0.6
    if Skill_ID == self.skill01 then
      self.skill01[4] = math.random(5, 6)
    end
  elseif get_npc_time(self.npc) < Skill_ID[3] then
    self:Wandering()
  end
end

function M:Enter_Attack()
  if not self.target then
    return
  end
  local dis1 = check_npc_distance(self.npc, self.target, self.skill01[4], true)
  local dis2 = check_npc_distance(self.npc, self.target, self.skill01[5], true)
  if 1 == self.control then
  else
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 0.5
    self.skill_number = math.random(1, 2)
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    return
  end
  if get_npc_time(self.npc) < self.wander_time then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if not dis2 then
    self:Move()
  elseif dis2 and not dis1 then
    stop_move(self.npc)
    lookat_npc(self.npc, self.target, 1)
    self:Relese_skill(self.skill01)
  elseif dis1 then
    self:Back()
  end
end

function M:Move()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:Wandering()
  self.wander_randomseed = math.random()
  if self.wander_randomseed > 0.5 then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
    self.wander_time = get_npc_time(self.npc) + 1
  elseif self.wander_randomseed < 0.5 then
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
    self.wander_time = get_npc_time(self.npc) + 1
  end
end

function M:Back()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
  local dis3 = check_npc_distance(self.npc, self.target, self.skill03[5], true)
  local nowTime = get_npc_time(self.npc)
  if dis3 and nowTime > self.near_attack_time then
    stop_move(self.npc)
    lookat_npc(self.npc, self.target, 1)
    cast_skill(self.npc, self.target, self.skill03[1])
    self.near_attack_time = get_npc_time(self.npc) + 6
  end
end

function M:Move_To_Target()
  if not self.target then
    return
  end
  local dis6 = check_npc_distance(self.npc, self.target, self.Entter_Attack_Range, true)
  if not dis6 then
    self.control = 0
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 1
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 0 ~= self.control then
    return
  end
  if not dis6 then
    self:Move()
  elseif dis6 then
    lookat_npc(self.npc, self.target)
    stop_move(self.npc)
    self.control = 1
  end
end

function M:skill_2()
  if not self.target then
    return
  end
  if is_cast_skill_time(self.npc, self.skill01[1]) and get_npc_time(self.npc) > self.skill_time then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill02[1])
    self.stun_timer = get_npc_time(self.npc) + 2
  end
end

function M:on_frame()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  self:Move_To_Target()
  self:Enter_Attack()
  self:skill_2()
end

return M
