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
    2020470107,
    0,
    0,
    1.5,
    3,
    get_skill_cfg(2020470107).CastTime,
    get_skill_cfg(2020470107).AfterTime
  }
  self.Skill02 = {
    2020470112,
    0,
    0,
    1.5,
    3,
    get_skill_cfg(2020470112).CastTime,
    get_skill_cfg(2020470112).AfterTime
  }
  self.Skill03 = {
    2020470109,
    0,
    0,
    1.5,
    3,
    get_skill_cfg(2020470109).CastTime,
    get_skill_cfg(2020470109).AfterTime
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
  self.AllowRun = false
end

function M:on_born_behavior()
  set_npc_ignore_sync_area(self.npc, false)
  set_npc_hp_visible(self.npc, false)
end

function M:CheckPlayerDistance()
  if check_npc_distance_to_pos(self.npc, self.TargetPos6.x, self.TargetPos6.z, 2.1, false) == false and self.AllowRun == true and false == self.ArriveTargetPos6 and true == self.ArriveTargetPos5 and true == self.ArriveTargetPos4 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos6)
    local param = {
      npc = self.npc,
      target = self.target,
      posx = get_npc_pos(self.npc).x,
      posz = get_npc_pos(self.npc).z,
      missile_id = 202047013901,
      missile_level = 1,
      lookat_posx = get_npc_pos(self.npc).x,
      lookat_posz = get_npc_pos(self.npc).z,
      lookat_posy = get_npc_pos(self.npc).y,
      posy = get_npc_pos(self.npc).y,
      born_posx = get_npc_pos(self.npc).x,
      born_posz = get_npc_pos(self.npc).z,
      born_posy = get_npc_pos(self.npc).y
    }
    cast_missile2(param)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos5.x, self.TargetPos5.z, 2.1, false) and self.AllowRun == true and false == self.ArriveTargetPos5 and true == self.ArriveTargetPos4 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos5)
    local param = {
      npc = self.npc,
      target = self.target,
      posx = get_npc_pos(self.npc).x,
      posz = get_npc_pos(self.npc).z,
      missile_id = 202047013901,
      missile_level = 1,
      lookat_posx = get_npc_pos(self.npc).x,
      lookat_posz = get_npc_pos(self.npc).z,
      lookat_posy = get_npc_pos(self.npc).y,
      posy = get_npc_pos(self.npc).y,
      born_posx = get_npc_pos(self.npc).x,
      born_posz = get_npc_pos(self.npc).z,
      born_posy = get_npc_pos(self.npc).y
    }
    cast_missile2(param)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos4.x, self.TargetPos4.z, 2.3, false) and self.AllowRun == true and false == self.ArriveTargetPos4 and true == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos4)
    local param = {
      npc = self.npc,
      target = self.target,
      posx = get_npc_pos(self.npc).x,
      posz = get_npc_pos(self.npc).z,
      missile_id = 202047013901,
      missile_level = 1,
      lookat_posx = get_npc_pos(self.npc).x,
      lookat_posz = get_npc_pos(self.npc).z,
      lookat_posy = get_npc_pos(self.npc).y,
      posy = get_npc_pos(self.npc).y,
      born_posx = get_npc_pos(self.npc).x,
      born_posz = get_npc_pos(self.npc).z,
      born_posy = get_npc_pos(self.npc).y
    }
    cast_missile2(param)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos3.x, self.TargetPos3.z, 2.1, false) and self.AllowRun == true and false == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos3)
    local param = {
      npc = self.npc,
      target = self.target,
      posx = get_npc_pos(self.npc).x,
      posz = get_npc_pos(self.npc).z,
      missile_id = 202047013901,
      missile_level = 1,
      lookat_posx = get_npc_pos(self.npc).x,
      lookat_posz = get_npc_pos(self.npc).z,
      lookat_posy = get_npc_pos(self.npc).y,
      posy = get_npc_pos(self.npc).y,
      born_posx = get_npc_pos(self.npc).x,
      born_posz = get_npc_pos(self.npc).z,
      born_posy = get_npc_pos(self.npc).y
    }
    cast_missile2(param)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 2.1, false) and self.AllowRun == true and false == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos2)
    local param = {
      npc = self.npc,
      target = self.target,
      posx = get_npc_pos(self.npc).x,
      posz = get_npc_pos(self.npc).z,
      missile_id = 202047013901,
      missile_level = 1,
      lookat_posx = get_npc_pos(self.npc).x,
      lookat_posz = get_npc_pos(self.npc).z,
      lookat_posy = get_npc_pos(self.npc).y,
      posy = get_npc_pos(self.npc).y,
      born_posx = get_npc_pos(self.npc).x,
      born_posz = get_npc_pos(self.npc).z,
      born_posy = get_npc_pos(self.npc).y
    }
    cast_missile2(param)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 2.1, false) and self.AllowRun == true and false == self.ArriveTargetPos1 then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos1)
    local param = {
      npc = self.npc,
      target = self.target,
      posx = get_npc_pos(self.npc).x,
      posz = get_npc_pos(self.npc).z,
      missile_id = 202047013901,
      missile_level = 1,
      lookat_posx = get_npc_pos(self.npc).x,
      lookat_posz = get_npc_pos(self.npc).z,
      lookat_posy = get_npc_pos(self.npc).y,
      posy = get_npc_pos(self.npc).y,
      born_posx = get_npc_pos(self.npc).x,
      born_posz = get_npc_pos(self.npc).z,
      born_posy = get_npc_pos(self.npc).y
    }
    cast_missile2(param)
    self.FirstTimeEnter = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 2.1, false) and true == self.FirstTimeBB1 then
    self.FirstTimeBB1 = false
    self.ArriveTargetPos1 = true
    self.AllowCastSkill = true
    self.AllowRun = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 2.1, false) and true == self.FirstTimeBB2 then
    self.FirstTimeBB2 = false
    self.ArriveTargetPos2 = true
    self.AllowRun = true
    self.AllowCastSkill = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos3.x, self.TargetPos3.z, 2.1, false) and true == self.FirstTimeBB3 then
    self.FirstTimeBB3 = false
    self.ArriveTargetPos3 = true
    self.AllowRun = true
    self.AllowCastSkill = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos4.x, self.TargetPos4.z, 2.3, false) and true == self.FirstTimeBB4 then
    self.FirstTimeBB4 = false
    self.ArriveTargetPos4 = true
    self.AllowRun = true
    self.AllowCastSkill = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos5.x, self.TargetPos5.z, 2.1, false) and true == self.FirstTimeBB5 then
    self.FirstTimeBB5 = false
    self.ArriveTargetPos5 = true
    self.AllowRun = true
    self.AllowCastSkill = true
  end
  if check_npc_distance_to_pos(self.npc, self.TargetPos6.x, self.TargetPos6.z, 2.1, false) == true and true == self.FirstTimeBB6 then
    self.FirstTimeBB6 = false
    self.ArriveTargetPos6 = true
    self.AllowRun = false
    self.AllowCastSkill = true
  end
end

function M:on_enter_area(npc, area)
  if npc == self.target and area.Tag == "bear" then
    cast_skill(self.npc, self.npc, 2020470111, nil, nil)
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if npc == self.npc and 2020470111 == skill_id and is_time_out then
    self.AllowRun = true
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 100, 8)
  self:CheckPlayerDistance()
  CommonMonster.monster_on_frame(self)
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
