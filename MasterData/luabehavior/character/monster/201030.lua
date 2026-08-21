local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill03 = {
    20103003,
    5.1,
    1,
    0,
    99,
    get_skill_cfg(20103003).CastTime,
    get_skill_cfg(20103003).AfterTime,
    0
  }
  self.skill02 = {
    20103002,
    5.1,
    1,
    0,
    3,
    get_skill_cfg(20103002).CastTime,
    get_skill_cfg(20103002).AfterTime,
    0
  }
  self.skill01 = {
    20103001,
    0.2,
    1,
    2,
    99,
    get_skill_cfg(20103001).CastTime,
    get_skill_cfg(20103001).AfterTime,
    0
  }
  self.wander = {
    2,
    6,
    0.5
  }
  self.wander_timer = 3
  self.wander_timer_skill_makeup = 0
  self.target = nil
  self.control = 0
  self.side_choice = 0
  self.stun_timer = 0
  self.dead_set = 0
  self.dead_timer = 0
  self.walk_timer = 0
  self.npc_now_time = 0
  self.is_M201030 = true
end

function M:cast_skill(skill_instant_ID)
  local cast_now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if cast_now_time < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if not self.target then
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
    lookat_npc(self.npc, self.target)
  else
    return
  end
  if cast_now_time >= skill_instant_ID[3] then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, skill_instant_ID[1])
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
  end
end

function M:attack_done_bonus()
  local now_time = get_npc_time(self.npc)
  if now_time >= self.stun_timer and 3 == self.control then
    self.control = 0
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if not self:cast_skill(self.skill02) then
    return
  end
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  local now_time = get_npc_time(self.npc)
  if not self.target then
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 1.5
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    stop_move(self.npc)
    return
  end
  if not check_activate(self.target) then
    return
  end
  if 0 ~= self.control then
    return
  end
  if get_npc_time(self.npc) < self.wander_timer then
    return
  end
  if not check_npc_distance(self.npc, self.target, self.wander[1], true) then
    self:move_approch_wander()
    if now_time >= self.walk_timer then
      cast_missile(self.npc, self.npc, nil, nil, 2010300101, 1)
      self.walk_timer = now_time + 1.5
    end
  end
  if check_npc_distance(self.npc, self.target, self.wander[1], false) then
    stop_move(self.npc)
  end
end

function M:on_npc_hp_zero(npc)
  local now_time = get_npc_time(self.npc)
  if npc == self.npc and 0 == self.dead_set then
    abort_skill(self.npc, true)
    cast_missile(self.npc, self.npc, nil, nil, 2010300301, 1)
    self.dead_timer = now_time + 1
    self.dead_set = 1
    self.control = 9
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 30, 8)
  if not self.target then
    return
  end
  local now_time = get_npc_time(self.npc)
  if 1 == self.dead_set and now_time >= self.dead_timer then
    self.dead_timer = now_time + 0.1
    self.dead_set = 2
  end
  if 2 == self.dead_set and now_time >= self.dead_timer then
    set_npc_dead(self.npc, nil, true)
    create_scene_effect("Fx_Common_Death", self.npc:get_pos_vec3(), 0)
    enable_shadow(self.npc, true)
    cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
    cast_magic(self.npc, self.npc, 201030003, 1)
    cast_magic(self.npc, self.npc, 201030004, 1)
    cast_magic(self.npc, self.npc, 201030006, 1)
    cast_magic(self.npc, self.npc, 201030005, 1)
    self.dead_timer = now_time + 3
    self.dead_set = 3
  end
  if 3 == self.dead_set and now_time >= self.dead_timer then
    remove_npc(self.npc)
    self.dead_set = 4
  end
  self:wander_main_logic()
  self:skill_main_logic()
  self:attack_done_bonus()
  if check_magic(self.npc, 4010008) then
    self.control = 9
    if self.level_stun_set == false then
      self.level_stun_set = true
    end
  elseif not check_magic(self.npc, 4010008) and self.level_stun_set == true then
    self.control = 0
    self.level_stun_set = false
  end
  if get_sync_var("in_daze") then
    self.control = 9
  end
  CommonMonster.remove_timer(self)
end

return M
