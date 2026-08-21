local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.target = nil
  self.targetPos = {
    x = 0,
    y = 0,
    z = 0
  }
  self.stun_timer = 0
  self.escapeTimer = 0
  self.control = 0
  self.wander = {6, 0.5}
  self.wander_timer = 3
  self.heroAtTime = nil
  self.heroAtTimePos = {
    x = 0,
    y = 0,
    z = 0
  }
  self.underplatformPos = {
    x = 185.3044,
    y = -25,
    z = 6.151443
  }
  self.finalSecondDestination = {
    x = 188.94,
    y = -25,
    z = 36.9
  }
  self.isTeleport = 0
  self.camp_skill_list = {}
  self.monster_type = 1
  self.skill01 = {
    2010390101,
    0,
    1,
    0,
    9,
    get_skill_cfg(2010390101).CastTime,
    get_skill_cfg(2010390101).AfterTime
  }
  if get_cur_room_id() == 102203 then
    self.targetPos = {
      x = 151,
      y = -10,
      z = 0
    }
  end
  if get_cur_room_id() == 102204 then
    self.targetPos = {
      x = 183.61,
      y = -8.6,
      z = 0.07
    }
  end
  if get_cur_room_id() == 102205 then
    self.targetPos = {
      x = 189.2,
      y = 5,
      z = 93.1
    }
  end
  self.tempSwitch = false
  self.tempSwitch2 = nil
  self.ReduceFindPathTimer = 0
  self.ReduceFindPathTimerInterval = 2
end

function M:on_start()
  cast_magic(self.npc, self.npc, 2010390104, 0)
end

function M:cast_skill(skill_instant_ID)
  local now_time = get_npc_time(self.npc)
  local ran_interval = math.random() * 1.5 + 2
  if CommonMonster.skill_cast_condition(self, skill_instant_ID, now_time, get_npc_group_id(self.npc), self.monster_type, 1, ran_interval) then
    return false
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if 1 == self.escapeTimer then
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
  set_npc_hp_visible(self.npc, false)
  if not self.target then
    return
  end
  if check_npc_distance(self.npc, self.target, self.wander[1], true) then
    if not self:cast_skill(self.skill01) then
      return
    end
  else
    abort_skill(self.npc)
  end
  if not self:cast_skill(self.skill01) then
    return
  end
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  if get_cur_room_id() == 102203 then
    move_to_pos(self.npc, self.targetPos)
  else
    move_to_pos(self.npc, self.targetPos)
  end
end

function M:wander_main_logic()
  if not self.targetPos then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if self.target ~= nil and check_npc_distance(self.npc, self.target, self.wander[1], true) then
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if 0 ~= self.control then
    return
  end
  local CurrentTime = get_npc_time(self.npc)
  if check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 1, true) == false and CurrentTime >= self.ReduceFindPathTimer + self.ReduceFindPathTimerInterval then
    self.ReduceFindPathTimer = CurrentTime
    self:move_approch_wander()
  elseif check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 1, true) then
    stop_move(self.npc)
    self.wander_timer = get_npc_time(self.npc) + self.wander[2]
    if check_npc_status(self.npc, 1) then
      return
    end
  end
end

function M:Teleport_logic()
  self.heroAtTime = get_come_on_hero()
  self.heroAtTimePos = get_npc_pos(self.heroAtTime)
  if get_cur_room_id() == 102204 and 0 == self.isTeleport and self.heroAtTimePos.y <= -10 then
    set_npc_pos(self.npc, "NPC2")
    stop_move(self.npc)
    self.targetPos = {
      x = 189,
      y = -25.3,
      z = 33.2
    }
    self.isTeleport = 1
    return
  end
  if get_cur_room_id() == 102204 and 1 == self.isTeleport and self.heroAtTimePos.y > -10 then
    self.isTeleport = 0
    return
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if npc == self.npc then
    set_sync_var("201111_CheckIsDead", true)
  end
end

function M:on_timeline_begin(timelinename)
  if "timeline_B0206_1" == timelinename then
    stop_move(self.npc)
    lookat_position(self.npc, 189, 33.2, true)
  end
end

function M:on_frame()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.monster_on_frame(self)
  if check_npc_status(self.npc, 5) then
  else
    set_sync_var("201111_CheckIsDead", false)
  end
  if 1 == get_sync_var("in_daze") then
    self.control = 9
  end
  if 0 == get_sync_var("in_daze") then
    self.control = 0
  end
  self:skill_main_logic()
  self:Teleport_logic()
  if check_npc_status(self.npc, 1) then
    return
  end
  if self.targetPos.y > -10 and get_cur_room_id() == 102204 then
  elseif self.tempSwitch == self.tempSwitch2 then
  elseif check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 2, true) then
    set_sync_var("201111_ArriveDestination", true)
    self.tempSwitch2 = get_sync_var("201111_ArriveDestination")
  else
    set_sync_var("201111_ArriveDestination", false)
    self.tempSwitch2 = get_sync_var("201111_ArriveDestination")
  end
  if check_npc_distance_to_pos(self.npc, self.targetPos.x, self.targetPos.z, 2, true) then
    self.tempSwitch = true
    return
  else
    self.tempSwitch = false
  end
  self:wander_main_logic()
  CommonMonster.Hit_wall(self)
  CommonMonster.platform_move(self)
end

return M
