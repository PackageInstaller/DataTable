local M = Util.create_class()
local skill_time = {
  [300103] = get_skill_cfg(300103).CastTime - 0.1,
  [300104] = get_skill_cfg(300104).CastTime - 0.1
}
local now_skill_time = 0
local skill_counting = 0
local wander_counting = 1
local wander_time = 1
local wait_time = 2

function M:_init()
  self.Skill01 = {
    300101,
    6,
    0,
    0,
    3.5
  }
  self.Skill02 = {
    300102,
    8,
    0,
    0,
    3
  }
  self.Skill03 = {
    300103,
    5,
    0,
    4,
    7
  }
  self.Skill04 = {
    300104,
    0,
    0,
    0,
    7
  }
  self.Skill05 = {
    300105,
    0,
    0,
    0,
    7
  }
  self.target = nil
end

function M:Get_Target()
  self.target = search_npc(self.npc, 4, 20, 0, 1)
end

function M:cast_skill(Skill_instant_ID)
  local Nowtime = get_time()
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
    cast_skill(self.npc, self.target, Skill_instant_ID[1])
    Skill_instant_ID[3] = get_time() + Skill_instant_ID[2]
    if 300103 == Skill_instant_ID[1] then
      now_skill_time = get_time() + skill_time[300103]
      skill_counting = 1
    else
      skill_counting = 0
    end
  end
end

function M:abort_skill1()
  local Nowtime = get_time()
  if not is_cast_skill_time(self.npc) then
    return
  end
  if 1 == skill_counting and Nowtime > now_skill_time then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, 300104)
    now_skill_time = get_time() + skill_time[300104]
    skill_counting = 2
  end
end

function M:abort_skill2()
  local Nowtime = get_time()
  if not is_cast_skill_time(self.npc) then
    return
  end
  if 2 == skill_counting and (Nowtime > now_skill_time or check_npc_distance(self.npc, self.target, 1.5, false)) then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, 300105)
    skill_counting = 0
  end
end

function M:Skill_main_logic()
  if self:cast_skill(self.Skill01) then
    return
  end
  if self:cast_skill(self.Skill02) then
    return
  end
  if self:cast_skill(self.Skill03) then
    return
  end
end

function M:Move_main_logic()
  local MinSkillDsitance = math.min(self.Skill01[5], self.Skill02[5])
  if not self.target then
    return
  end
  if not check_npc_distance(self.npc, self.target, 7, false) then
    switch_move_type(self.npc, 0)
    moveto_npc(self.npc, self.target)
  end
  if check_npc_distance(self.npc, self.target, 5, false) and not check_npc_distance(self.npc, self.target, 4, false) then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
  end
  if check_npc_distance(self.npc, self.target, 3, false) and not check_npc_distance(self.npc, self.target, 2.5, false) then
    local Nowtime = get_time()
    if Nowtime < wander_time then
      if 1 == wander_counting then
        switch_move_type(self.npc, 3)
        moveto_npc(self.npc, self.target)
      end
      if 2 == wander_counting then
        switch_move_type(self.npc, 4)
        moveto_npc(self.npc, self.target)
      end
    else
      wander_time = get_time() + 2.5
      wander_counting = wander_counting + 1
      if 3 == wander_counting then
        wander_counting = 1
      end
    end
  end
  if check_npc_distance(self.npc, self.target, 2.5, false) then
    local Nowtime = get_time()
    if Nowtime > wait_time then
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
      wait_time = get_time() + 2
    end
  end
end

function M:on_frame()
  self:Get_Target()
  self:Skill_main_logic()
  self:Move_main_logic()
  self:abort_skill1()
  self:abort_skill2()
end

function M:on_skill()
end

function M:on_behit()
end

return M
