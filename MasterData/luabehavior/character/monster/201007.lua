local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.Skill01 = {
    20100701,
    4,
    1,
    0,
    3,
    get_skill_cfg(20100701).CastTime,
    get_skill_cfg(20100701).AfterTime
  }
  self.Skill02 = {
    20100702,
    5,
    2,
    4,
    9,
    get_skill_cfg(20100702).CastTime,
    get_skill_cfg(20100702).AfterTime
  }
  self.target = nil
  self.wander = {
    3,
    9,
    1
  }
  self.wander_timer = 0
  self.wander_timer_skill_makeup = 0
  CommonMonster.set_value("线人攻击", 1, 1)
  CommonMonster.set_value("线人攻击计时器", 2, 0)
end

function M:Get_Target()
  self.target = search_npc(self.npc, 4, 14, 0, 1)
end

function M:cast_skill(Skill_instant_ID)
  local Nowtime = get_npc_time(self.npc)
  if not self.target then
    return
  end
  if not check_npc_status(self.npc, 0) then
    return
  end
  if check_npc_distance(self.npc, self.target, Skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, Skill_instant_ID[4], false) then
  else
    return
  end
  if Nowtime > Skill_instant_ID[3] then
    if 1 == CommonMonster.get_value("线人攻击", 1) then
      cast_skill(self.npc, self.target, Skill_instant_ID[1])
      CommonMonster.set_value("线人攻击", 1, 0)
      CommonMonster.set_value("线人攻击计时器", 2, get_npc_time(self.npc) + 2)
    end
    Skill_instant_ID[3] = get_npc_time(self.npc) + Skill_instant_ID[2]
  end
  self.control = 0
  self.wander_timer_skill_makeup = Skill_instant_ID[6] + Skill_instant_ID[7]
end

function M:Skill_main_logic()
  if get_npc_time(self.npc) < self.wander_timer then
    return
  end
  if self:cast_skill(self.Skill01) then
    return
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

function M:move_approch_wander2()
  switch_move_type(self.npc, 0)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if not check_activate(self.target) then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if npc_time < self.wander_timer then
    return
  end
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
  if distance_max and not distance_min then
    self:move_approch_wander()
  elseif not distance_max then
    self:move_approch_wander2()
  elseif distance_min then
    self:move_normal_wander()
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:on_frame()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  self:Skill_main_logic()
  self:wander_main_logic()
  if get_npc_time(self.npc) > CommonMonster.get_value("线人攻击计时器", 2) and 0 == CommonMonster.get_value("线人攻击", 1) then
    CommonMonster.set_value("线人攻击", 1, 1)
  end
end

function M:on_behit()
end

return M
