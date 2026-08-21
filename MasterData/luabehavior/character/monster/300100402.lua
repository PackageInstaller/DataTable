local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.TargetPos1X, self.TargetPos1Y, self.TargetPos1Z = get_area_pos("BB4")
  self.TargetPos2X, self.TargetPos2Y, self.TargetPos2Z = get_area_pos("BB5")
  self.TargetPos3X, self.TargetPos3Y, self.TargetPos3Z = get_area_pos("BB6")
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
  self.FirstTimeEnter = true
  self.target = nil
  self.ArriveTargetPos1 = false
  self.ArriveTargetPos2 = false
  self.ArriveTargetPos3 = false
  self.AllowRun = true
  self.DistanceMoreThan10 = true
  self.DistanceMoreThan15 = true
  self.DistanceMoreThan20 = true
  self.FirstTimeBB4 = true
  self.FirstTimeBB5 = true
  self.FirstTimeBB6 = true
  self.FirstTimeBB4 = true
  self.FirstTimeBB5 = true
  self.BeHitTime = 0
  self.BehitInterval = 2
end

function M:on_born_behavior()
  cast_magic(self.npc, self.npc, 30010050101, 1)
  cast_magic(self.npc, self.npc, 300100501012, 1)
  cast_magic(self.npc, self.npc, 300100501013, 1)
end

function M:CheckPlayerDistance()
  if check_npc_distance_to_pos(self.npc, self.TargetPos3.x, self.TargetPos3.z, 0.5, false) == false and self.AllowRun == true and false == self.ArriveTargetPos3 and true == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    self.AllowRun = false
    switch_move_type(self.npc, 0)
    move_to_pos(self.npc, self.TargetPos3)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 0.5, false) and self.AllowRun == true and false == self.ArriveTargetPos2 and true == self.ArriveTargetPos1 then
    self.AllowRun = false
    switch_move_type(self.npc, 0)
    move_to_pos(self.npc, self.TargetPos2)
    self.FirstTimeEnter = true
  end
  if false == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 0.5, false) and self.AllowRun == true and false == self.ArriveTargetPos1 then
    self.AllowRun = false
    switch_move_type(self.npc, 0)
    move_to_pos(self.npc, self.TargetPos1)
    self.FirstTimeEnter = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos1.x, self.TargetPos1.z, 0.5, false) and true == self.FirstTimeBB4 then
    self.FirstTimeBB4 = false
    self.ArriveTargetPos1 = true
    self.AllowRun = true
  end
  if true == check_npc_distance_to_pos(self.npc, self.TargetPos2.x, self.TargetPos2.z, 0.5, false) and true == self.FirstTimeBB5 then
    self.FirstTimeBB5 = false
    self.ArriveTargetPos2 = true
    self.AllowRun = true
  end
  if check_npc_distance_to_pos(self.npc, self.TargetPos3.x, self.TargetPos3.z, 0.5, false) == true and true == self.FirstTimeBB6 then
    self.FirstTimeBB6 = false
    cast_magic(self.npc, self.npc, 30010040201, 1)
    self.ArriveTargetPos3 = true
    self.AllowRun = true
  end
end

function M:CheckCurrentStatus()
  if search_npc(self.npc, 2, 8, nil, false, false, nil, 1) == nil then
    stop_move(self.npc)
    return
  end
  if search_npc(self.npc, 2, 3, nil, false, false, nil, 1) == nil then
    return
  end
  if check_npc_distance(self.npc, search_npc(self.npc, 2, 3, nil, false, false, nil, 1), 5, 1) == true then
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
