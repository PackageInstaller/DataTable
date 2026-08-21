local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.TargetPos1X, self.TargetPos1Y, self.TargetPos1Z = get_area_pos("BB1")
  self.TargetPos2X, self.TargetPos2Y, self.TargetPos2Z = get_area_pos("BB2")
  self.TargetPos3X, self.TargetPos3Y, self.TargetPos3Z = get_area_pos("BB3")
  self.TargetPos4X, self.TargetPos4Y, self.TargetPos4Z = get_area_pos("BB4")
  self.TargetPos5X, self.TargetPos5Y, self.TargetPos5Z = get_area_pos("BB5")
  self.TargetPos6X, self.TargetPos6Y, self.TargetPos6Z = get_area_pos("BB6")
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
  self.TargetPos4 = {
    x = self.TargetPos4X,
    y = self.TargetPos4Y,
    z = self.TargetPos4Z
  }
  self.TargetPos5 = {
    x = self.TargetPos5X,
    y = self.TargetPos5Y,
    z = self.TargetPos5Z
  }
  self.TargetPos6 = {
    x = self.TargetPos6X,
    y = self.TargetPos6Y,
    z = self.TargetPos6Z
  }
  self.FirstTimeEnter = true
  self.target = nil
  self.ArriveTargetPos1 = false
  self.ArriveTargetPos2 = false
  self.ArriveTargetPos3 = false
  self.ArriveTargetPos4 = false
  self.ArriveTargetPos5 = false
  self.ArriveTargetPos6 = false
  self.Skill01 = {
    30010050301,
    0,
    0,
    1.5,
    3,
    get_skill_cfg(2020470107).CastTime,
    get_skill_cfg(2020470107).AfterTime
  }
  self.Skill02 = {
    30010050301,
    0,
    0,
    1.5,
    3,
    get_skill_cfg(2020470112).CastTime,
    get_skill_cfg(2020470112).AfterTime
  }
  self.LastTimecastSkillID = 0
  self.ThisTimecastSkillID = 0
  self.FirstTimeBB1 = true
  self.FirstTimeBB2 = true
  self.FirstTimeBB3 = true
  self.FirstTimeBB4 = true
  self.FirstTimeBB5 = true
  self.FirstTimeBB6 = true
  self.AllowCastSkill = false
  self.AllowRun = true
  self.hero = get_come_on_hero()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
end

function M:on_magic_begin(npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  if 30010050204 == magic_id then
    abort_magic_by_id(self.npc, 30010050203, 1)
  end
end

function M:on_born_behavior()
  set_npc_ignore_sync_area(self.npc, false)
  cast_magic(self.npc, self.npc, 30010050106)
  set_npc_hp_visible(self.npc, false)
  cast_magic(self.npc, self.npc, 30010050101)
  cast_magic(self.npc, self.npc, 300100501012)
  cast_magic(self.npc, self.npc, 300100501013)
  set_npc_status(self.npc, 3, true)
  cast_magic(self.npc, self.npc, 4032905, 1)
  cast_magic(self.npc, self.npc, 399001, 1)
end

function M:CheckPlayerDistance()
  if check_npc_distance_to_pos(self.npc, self.TargetPos6.x, self.TargetPos6.z, 2.1, false) == false and self.AllowRun == true and false == self.ArriveTargetPos6 and true == self.ArriveTargetPos5 and true == self.ArriveTargetPos4 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    switch_move_type(self.npc, 0)
    move_to_pos(self.npc, self.TargetPos6)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos5.x, self.TargetPos5.z, 2.1, false) and self.AllowRun == true and false == self.ArriveTargetPos5 and true == self.ArriveTargetPos4 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    switch_move_type(self.npc, 0)
    move_to_pos(self.npc, self.TargetPos5)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos4.x, self.TargetPos4.z, 2.1, false) and self.AllowRun == true and false == self.ArriveTargetPos4 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    switch_move_type(self.npc, 0)
    move_to_pos(self.npc, self.TargetPos4)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos3.x, self.TargetPos3.z, 2.1, false) and self.AllowRun == true and false == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    switch_move_type(self.npc, 0)
    move_to_pos(self.npc, self.TargetPos3)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 2.1, false) and self.AllowRun == true and false == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    switch_move_type(self.npc, 0)
    move_to_pos(self.npc, self.TargetPos2)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 2.1, false) and self.AllowRun == true and false == self.ArriveTargetPos1 then
    switch_move_type(self.npc, 0)
    move_to_pos(self.npc, self.TargetPos1)
    self.FirstTimeEnter = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 2.1, false) and true == self.FirstTimeBB1 then
    self.FirstTimeBB1 = false
    self.ArriveTargetPos1 = true
    self.AllowCastSkill = true
    self.AllowRun = false
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 2.1, false) and true == self.FirstTimeBB2 then
    self.FirstTimeBB2 = false
    self.ArriveTargetPos2 = true
    self.AllowRun = false
    self.AllowCastSkill = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos3.x, self.TargetPos3.z, 2.1, false) and true == self.FirstTimeBB3 then
    self.FirstTimeBB3 = false
    self.ArriveTargetPos3 = true
    self.AllowRun = false
    self.AllowCastSkill = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos4.x, self.TargetPos4.z, 2.1, false) and true == self.FirstTimeBB4 then
    self.FirstTimeBB4 = false
    self.ArriveTargetPos4 = true
    self.AllowRun = false
    self.AllowCastSkill = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos5.x, self.TargetPos5.z, 2.1, false) and true == self.FirstTimeBB5 then
    self.FirstTimeBB5 = false
    self.ArriveTargetPos5 = true
    self.AllowRun = false
    self.AllowCastSkill = true
  end
  if check_npc_distance_to_pos(self.npc, self.TargetPos6.x, self.TargetPos6.z, 2.1, false) == true and true == self.FirstTimeBB6 then
    self.FirstTimeBB6 = false
    self.ArriveTargetPos6 = true
    self.AllowRun = false
    self.AllowCastSkill = true
    set_sync_var("TheEnd", true)
  end
end

function M:castskilllogic()
  self.AllowCastSkill = false
  cast_magic(self.npc, self.npc, 10560201)
  if math.random(0, 100) >= 50 then
    self.ThisTimecastSkillID = self.Skill01[1]
  else
    self.ThisTimecastSkillID = self.Skill02[1]
  end
  if self.LastTimecastSkillID == self.ThisTimecastSkillID then
    if self.ThisTimecastSkillID == self.Skill01[1] then
      cast_skill(self.npc, self.target, self.Skill02[1])
      self.LastTimecastSkillID = self.Skill02[1]
    end
    if self.ThisTimecastSkillID == self.Skill02[1] then
      cast_skill(self.npc, self.target, self.Skill01[1])
      self.LastTimecastSkillID = self.Skill01[1]
    end
    return
  end
  if get_target_angel(self.npc, self.target, true) >= 90 or get_target_angel(self.npc, self.target, true) <= -90 then
    cast_skill(self.npc, self.target, self.ThisTimecastSkillID)
  else
    self.AllowRun = true
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if npc ~= self.npc then
    return
  end
  if 30010050101 ~= skill_id then
    abort_magic_by_id(self.npc, 10560201)
    self:CheckPlayerDistance()
    if self.ArriveTargetPos1 == true then
      remove_area("A1", "")
    end
    if true == self.ArriveTargetPos2 then
      remove_area("A2", "")
    end
    if true == self.ArriveTargetPos3 then
      remove_area("A3", "")
    end
    if true == self.ArriveTargetPos4 then
      remove_area("A4", "")
    end
    if true == self.ArriveTargetPos5 then
      remove_area("A5", "")
    end
  end
  self.AllowCastSkill = false
  self.AllowRun = true
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    return
  end
  if missile_cfg.Id == 2012030101 and self.AllowCastSkill == true then
    cast_magic(self.npc, self.npc, 10560202)
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
    if true == self.ArriveTargetPos1 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos3 and false == self.ArriveTargetPos4 then
      self.AllowCastSkill = false
      cast_skill(self.npc, nil, 30010050101)
    end
    if true == self.ArriveTargetPos1 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos4 and false == self.ArriveTargetPos5 then
      self.AllowCastSkill = false
      cast_skill(self.npc, nil, 30010050101)
    end
    if true == self.ArriveTargetPos1 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos4 and true == self.ArriveTargetPos5 and false == self.ArriveTargetPos6 then
      self.AllowCastSkill = false
      cast_skill(self.npc, nil, 30010050101)
    end
  end
end

function M:on_enter_area(npc, area)
  local areaName = area.Key
  if (npc == self.hero or npc == self.hero_one or npc == self.hero_two) and ("A1" == areaName or "A2" == areaName or "A3" == areaName or "A4" == areaName or "A5" == areaName) then
    self.AllowCastSkill = true
    self:castskilllogic()
  end
  if npc == self.npc and "E1" == areaName then
    set_sceneobj_visible_save_state("/Root/Level/18/L19_/A4", true, true)
    start_stroy(5051105)
  end
  if npc == self.npc and "S1" == areaName then
    set_sync_var("TheEnd", true)
  end
end

function M:on_frame()
  if not self.target then
    CommonMonster.search_target(self, 100, 8)
  end
  self:CheckPlayerDistance()
  CommonMonster.monster_on_frame(self)
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
