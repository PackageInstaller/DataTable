local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.TargetPos1X, self.TargetPos1Y, self.TargetPos1Z = get_area_pos("BB1")
  self.TargetPos2X, self.TargetPos2Y, self.TargetPos2Z = get_area_pos("BB2")
  self.TargetPos3X, self.TargetPos3Y, self.TargetPos3Z = get_area_pos("BB3")
  self.TargetPos1 = {
    x = self.TargetPos1X,
    y = self.TargetPos1Y,
    z = self.TargetPos1Z
  }
  self.TargetPos2 = {
    x = self.TargetPos2X,
    y = self.TargetPos2Y,
    z = self.TargetPos2Z
  }
  self.TargetPos3 = {
    x = self.TargetPos3X,
    y = self.TargetPos3Y,
    z = self.TargetPos3Z
  }
  self.target = nil
  self.ArriveTargetPos1 = false
  self.ArriveTargetPos2 = false
  self.ArriveTargetPos3 = false
  self.Skill01 = {
    30010050101,
    8,
    0,
    1.5,
    3,
    get_skill_cfg(30010050101).CastTime,
    get_skill_cfg(30010050101).AfterTime
  }
  self.AllowCastSkill = true
  self.AllowRun = true
  self.DistanceMoreThan10 = true
  self.DistanceMoreThan15 = true
  self.DistanceMoreThan20 = true
end

function M:on_born_behavior()
  set_npc_status(self.npc, 1, true)
  set_npc_status(self.npc, 4, true)
  set_npc_status(self.npc, 3, true)
  cast_magic(self.npc, self.npc, 4032905, 1)
  cast_magic(self.npc, self.npc, 399001, 1)
  set_npc_hp_visible(self.npc, false)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  if missile_cfg.Id == 2012030101 and self.AllowCastSkill == true then
    if self.ArriveTargetPos1 == false then
      self.AllowCastSkill = false
      cast_skill(self.npc, nil, 30010050101)
    end
    if true == self.ArriveTargetPos1 and false == self.ArriveTargetPos2 then
      self.AllowCastSkill = false
      cast_skill(self.npc, nil, 30010050101)
    end
    if true == self.ArriveTargetPos1 and true == self.ArriveTargetPos2 and false == self.ArriveTargetPos3 then
      self.AllowCastSkill = false
      cast_skill(self.npc, nil, 30010050101)
    end
  end
end

function M:RunToTargetPos1()
  if self.ArriveTargetPos1 == true then
    return
  end
  switch_move_type(self.npc, 0)
  move_to_pos(self.npc, self.TargetPos1)
end

function M:RunToTargetPos2()
  if self.ArriveTargetPos2 == true then
    return
  end
  switch_move_type(self.npc, 0)
  move_to_pos(self.npc, self.TargetPos2)
end

function M:RunToTargetPos3()
  if self.ArriveTargetPos3 == true then
    return
  end
  switch_move_type(self.npc, 0)
  move_to_pos(self.npc, self.TargetPos3)
end

function M:CheckCurrentPos()
  if check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 2, false) == true then
    self.AllowRun = true
    self.ArriveTargetPos1 = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 2, false) then
    self.AllowRun = true
    self.ArriveTargetPos2 = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos3.x, self.TargetPos3.z, 2, false) then
    self.ArriveTargetPos3 = true
    stop_move(self.npc)
  end
end

function M:CheckPlayerDistance()
  local DistanceToPlayer = get_npc_distance(self.npc, 1, self.target, true)
  if DistanceToPlayer <= 4 then
    cast_magic(self.npc, self.npc, 30010050103, 1)
  end
  if DistanceToPlayer > 8 and check_magic(self.npc, 30010050103) == true then
    cast_magic(self.npc, self.npc, 30010050105, 1)
  end
  if DistanceToPlayer >= 10 and true == self.DistanceMoreThan10 and DistanceToPlayer <= 15 then
    self.DistanceMoreThan10 = false
    play_DBM_ani(18)
    self.Timerbool = true
    self.TimerStart = get_npc_time(self.npc)
  end
  if true == self.Timerbool and get_npc_time(self.npc) >= self.TimerStart + 5 then
    self.DistanceMoreThan10 = true
    self.DistanceMoreThan15 = true
  end
  if DistanceToPlayer >= 15 and true == self.DistanceMoreThan15 and DistanceToPlayer <= 20 then
    self.DistanceMoreThan15 = false
    play_DBM_ani(19)
    self.Timerbool = true
    self.TimerStart = get_npc_time(self.npc)
  end
  if DistanceToPlayer >= 30 and true == self.DistanceMoreThan20 and DistanceToPlayer <= 100 then
    self.DistanceMoreThan20 = false
    play_DBM_ani(20)
    set_sync_var("RunOut", true)
  end
end

function M:on_magic_end(npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  if 30010050103 == magic_id then
    cast_magic(self.npc, self.npc, 30010050105, 1)
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if npc ~= self.npc then
    return
  end
  if 30010050101 == skill_id then
    self.AllowCastSkill = true
    self.AllowRun = true
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if target ~= self.npc then
    return
  end
  self.AllowRun = true
  abort_skill(self.npc, true)
end

function M:on_frame()
  self:CheckCurrentPos()
  self:CheckPlayerDistance()
  if self.ArriveTargetPos1 == false and self.AllowRun == true then
    self.AllowRun = false
    self:RunToTargetPos1()
  end
  if self.ArriveTargetPos1 == true and false == self.ArriveTargetPos2 and self.AllowRun == true then
    self.AllowRun = false
    self:RunToTargetPos2()
  end
  if self.ArriveTargetPos1 == true and true == self.ArriveTargetPos2 and false == self.ArriveTargetPos3 and self.AllowRun == true then
    self.AllowRun = false
    self:RunToTargetPos3()
  end
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.monster_on_frame(self)
end

return M
