local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.TargetPos1X, self.TargetPos1Y, self.TargetPos1Z = get_area_pos("BB2")
  self.TargetPos2X, self.TargetPos2Y, self.TargetPos2Z = get_area_pos("Resident8")
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
  self.FirstTimeEnter = true
  self.target = nil
  self.ArriveTargetPos1 = false
  self.ArriveTargetPos2 = false
  self.Skill01 = {
    30010031102,
    0,
    0,
    1.5,
    3,
    get_skill_cfg(30010031102).CastTime,
    get_skill_cfg(30010031102).AfterTime
  }
  self.Skill02 = {
    30010031101,
    0,
    0,
    1.5,
    3,
    get_skill_cfg(30010031102).CastTime,
    get_skill_cfg(30010031102).AfterTime
  }
  self.AllowRun = false
  self.FirstTimeBB1 = true
  self.FirstTimeBB2 = true
  self.BeHitTime = 0
  self.BehitInterval = 2
end

function M:on_born_behavior()
  cast_magic(self.npc, self.npc, 30010050101, 1)
  cast_magic(self.npc, self.npc, 300100501012, 1)
  cast_magic(self.npc, self.npc, 300100501013, 1)
  set_npc_hp_visible(self.npc, false)
  stop_move(self.npc)
end

function M:on_frame()
end

function M:CheckPlayerDistance()
  if check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 1, false) == false and self.AllowRun == true and false == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 and self.BeHitTime + self.BehitInterval < get_npc_time(self.npc) and true == get_sync_var("walk") then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos2)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 1, false) and self.AllowRun == true and false == self.ArriveTargetPos1 and self.BeHitTime + self.BehitInterval < get_npc_time(self.npc) and true == get_sync_var("walk") then
    self.AllowRun = false
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TargetPos1)
    self.FirstTimeEnter = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 1, false) and true == self.FirstTimeBB1 then
    self.FirstTimeBB1 = false
    self.ArriveTargetPos1 = true
    self.AllowRun = true
  end
  if check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 1, false) == true and true == self.FirstTimeBB2 then
    self.FirstTimeBB2 = false
    self.ArriveTargetPos2 = true
    self.AllowRun = true
    set_sync_var("ToEnd", true)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc then
    self.BeHitTime = get_npc_time(self.npc)
  end
end

function M:CheckCurrentStatus()
  if self.BeHitTime + self.BehitInterval > get_npc_time(self.npc) and self.FirstTimeEnter == true then
    self.FirstTimeEnter = false
    stop_move(self.npc)
    self.AllowRun = true
  end
end

function on_magic_end(npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  if 20120302 == magic_id then
    self.AllowRun = true
  end
end

function M:on_frame()
  self:CheckCurrentStatus()
  self:CheckPlayerDistance()
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.monster_on_frame(self)
end

return M
