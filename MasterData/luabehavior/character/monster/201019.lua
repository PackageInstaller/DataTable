local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill04 = {
    20101904,
    5,
    2,
    0,
    3,
    get_skill_cfg(20101904).CastTime,
    get_skill_cfg(20101904).AfterTime,
    0
  }
  self.skill03 = {
    20101903,
    5.2,
    2,
    0,
    3,
    get_skill_cfg(20101903).CastTime,
    get_skill_cfg(20101903).AfterTime,
    0
  }
  self.skill02 = {
    20101902,
    5.1,
    2,
    0,
    3,
    get_skill_cfg(20101902).CastTime,
    get_skill_cfg(20101902).AfterTime,
    0
  }
  self.skill01 = {
    20101901,
    5,
    2,
    0.1,
    99,
    get_skill_cfg(20101901).CastTime,
    get_skill_cfg(20101901).AfterTime,
    self.skill02
  }
  self.used_enemy_pos = nil
  self.wander = {
    6,
    9,
    0.5
  }
  self.wander_timer = 3
  self.wander_timer_skill_makeup = 0
  self.target = nil
  self.control = 0
  self.other_control = 0
  self.side_choice = 0
  self.stun_timer = 0
  self.walk_set = 0
  self.born_skill = 20101905
  self.npc_now_time = 0
end

function M:hurt()
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    cast_magic(self.npc, self.npc, 100438, 1)
    self.stun_timer = get_npc_time(self.npc) + 1
    return
  end
end

function M:on_start()
  listen_missile_collide_obstacle(self.npc, 2010190402, self.on_missile_collide_obstacle, self)
end

function M:on_remove()
  unlisten_missile_collide_obstacle(self.npc, 2010190402, self)
end

function M:on_missile_collide_obstacle(owner, obstacle_type, missile_cfg, missile)
  if owner == self.npc then
    remove_missile(missile)
  end
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
  if 0 ~= self.control and 0 == self.other_control then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, skill_instant_ID[4], false) then
    lookat_npc(self.npc, self.target)
  else
    return
  end
  if cast_now_time >= skill_instant_ID[3] then
    if 20101901 == skill_instant_ID[1] then
      abort_skill(self.npc)
      cast_skill(self.npc, self.npc, self.skill01[1])
      set_can_searched(self.npc, false)
      skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
      self.npc_now_time = get_npc_time(self.npc)
    end
    local random_1 = math.random(1, 13)
    if random_1 < 5 then
      self.control = 2
    elseif random_1 >= 5 and random_1 < 9 then
      self.control = 6
    elseif random_1 >= 9 then
      self.control = 10
    end
    self.npc_now_time = cast_now_time + 0.7
  else
    return
  end
end

function M:loop_skill()
  local loop_now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
    return
  end
  if loop_now_time < self.npc_now_time then
    return
  end
  local xpos_to_go = 0
  local zpos_to_go = 0
  if self.target and (2 == self.control or 6 == self.control or 10 == self.control) then
    set_npc_hp_visible(self.npc, false)
    enable_shadow(self.npc, false)
    abort_skill(self.npc)
    cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
    cast_magic(self.npc, self.npc, 100104, 1)
    local random_pos_x = math.random(4, 5)
    local random_pos_z = math.random(4, 5)
    local now_enemy_pos = get_npc_pos(self.target)
    self.used_enemy_pos = get_npc_pos(self.target)
    if math.random(1, 11) > 6 then
      xpos_to_go = now_enemy_pos.x + random_pos_x
    else
      xpos_to_go = now_enemy_pos.x - random_pos_x
    end
    if math.random(1, 11) > 8 then
      zpos_to_go = now_enemy_pos.z + random_pos_z
    else
      zpos_to_go = now_enemy_pos.z - random_pos_z
    end
    self.used_enemy_pos = now_enemy_pos
    cast_skill(self.npc, nil, self.skill02[1])
    flash_to_pos(self.npc, xpos_to_go, zpos_to_go)
    local random_1 = math.random(1, 13)
    if random_1 < 5 then
      self.control = 3
    elseif random_1 >= 5 and random_1 < 9 then
      self.control = 7
    elseif random_1 >= 9 then
      self.control = 11
    end
    self.npc_now_time = loop_now_time + 0.98
    self.other_control = 1
  end
end

function M:next_skill()
  local next_now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
    return
  end
  if next_now_time < self.npc_now_time then
    return
  end
  if self.target and (3 == self.control or 7 == self.control or 11 == self.control) then
    abort_magic_by_id(self.npc, Const.LOCK_MASK)
    abort_magic_by_id(self.npc, 100104)
    abort_magic_by_id(self.npc, 201019004)
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    set_can_searched(self.npc, true)
    cast_skill(self.npc, self.npc, self.skill03[1])
    local random_1 = math.random(1, 13)
    if random_1 < 5 then
      self.control = 4
    elseif random_1 >= 5 and random_1 < 9 then
      self.control = 8
    elseif random_1 >= 9 then
      self.control = 12
    end
    self.npc_now_time = next_now_time + 0.8
    set_npc_hp_visible(self.npc, true)
    enable_shadow(self.npc, true)
  end
end

function M:last_skill()
  local last_now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
    return
  end
  if last_now_time < self.npc_now_time then
    return
  end
  if not self.target then
    return
  end
  if self.target and (4 == self.control or 8 == self.control or 12 == self.control) then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill04[1])
    CommonMonster.tiktok_timer_func(self, 0.25, function()
      abort_magic_by_id(self.npc, 201019005)
      abort_magic_by_id(self.npc, 201019006)
    end)
    self.wander_timer_skill_makeup = self.skill04[6] + self.skill04[7]
    self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
    stop_move(self.npc)
    self.control = 5
    self.other_control = 0
  end
end

function M:attack_done_bonus()
  local bonus_timer = self.wander_timer + 1
  local bonus_now_time = get_npc_time(self.npc)
  if bonus_timer <= bonus_now_time and 5 == self.control then
    self.control = 0
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if not self:cast_skill(self.skill01) and check_npc_distance(self.npc, self.target, self.wander[1], true) then
    return
  end
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    abort_skill(self.npc, true)
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
end

function M:on_frame()
  if get_sync_var("in_daze") then
    self.control = 9
  end
  if check_magic(self.npc, 100174) then
    return
  end
  if check_npc_status(self.npc, 2) then
    abort_magic_by_id(self.npc, Const.LOCK_MASK)
    abort_magic_by_id(self.npc, 201019004)
    abort_magic_by_id(self.npc, 100104)
    set_npc_hp_visible(self.npc, true)
    enable_shadow(self.npc, true)
  end
  self:last_skill()
  self:loop_skill()
  self:skill_main_logic()
  self:next_skill()
  self:attack_done_bonus()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  self:hurt()
end

return M
