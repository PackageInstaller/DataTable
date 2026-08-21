local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill08 = {
    20102108,
    0,
    0,
    0,
    10,
    get_skill_cfg(20102108).CastTime,
    get_skill_cfg(20102108).AfterTime,
    0
  }
  self.skill07 = {
    20102107,
    0,
    0,
    0,
    10,
    get_skill_cfg(20102107).CastTime,
    get_skill_cfg(20102107).AfterTime,
    self.skill08
  }
  self.skill06 = {
    20102106,
    0,
    2.1,
    0,
    8,
    get_skill_cfg(20102106).CastTime,
    get_skill_cfg(20102106).AfterTime,
    self.skill07
  }
  self.skill05 = {
    20102105,
    0,
    0,
    0,
    10,
    get_skill_cfg(20102105).CastTime,
    get_skill_cfg(20102105).AfterTime,
    0
  }
  self.skill04 = {
    20102104,
    0,
    0,
    0,
    10,
    get_skill_cfg(20102104).CastTime,
    get_skill_cfg(20102104).AfterTime,
    self.skill05
  }
  self.skill03 = {
    20102103,
    1,
    2.1,
    0,
    10,
    get_skill_cfg(20102103).CastTime,
    get_skill_cfg(20102103).AfterTime,
    self.skill04
  }
  self.skill02 = {
    20102102,
    8.5,
    2.7,
    4.5,
    11,
    get_skill_cfg(20102102).CastTime,
    get_skill_cfg(20102102).AfterTime,
    0
  }
  self.skill01 = {
    20102101,
    6.5,
    2.7,
    0,
    4.5,
    get_skill_cfg(20102101).CastTime,
    get_skill_cfg(20102101).AfterTime,
    0
  }
  self.wander = {4.5, 1}
  self.wander_timer = 4
  self.wander_timer_skill_makeup = 0
  self.target = nil
  self.control = 0
  self.stun_timer = 0
  self.supa_set = 0
  self.max_supa = nil
  self.skill3_set = 0
  self.skill_set = 0
  self.npc_now_time = 0
  self.loop_set = 0
  self.spawn = 0
  self.fx_set = 0
  self.transparent = false
  self.born_skill = 20102110
  self.M201021_skill3_2_sound_set = false
  self.wander_set = true
  self.die_skill = self.skill06[1]
  set_can_searched(npc, false)
  enable_shadow(npc, false)
end

function M:on_magic_begin(npc, target, magic_id)
  Base.on_magic_begin(self, npc, target, magic_id)
  if 201021001 == magic_id then
    set_can_searched(self.npc, true)
    enable_shadow(self.npc, true)
  end
end

function M:spawn_skill()
  if 0 == self.control or 6 == self.control then
  else
    return
  end
  if (get_target_angel(self.npc, self.target, false) > 45 or get_target_angel(self.npc, self.target, false) < -45) and 0 == self.turn_switch then
    self.turn_switch = 1
    cast_skill(self.npc, self.target, 20102109, nil, nil)
    if self.wander_set == false then
      self.wander_set = true
    end
  end
  if 0 == self.spawn then
    set_lock_velocity(self.npc, 2)
    self.spawn = 1
  end
end

function M:cast_skill(skill_instant_ID)
  if 0 ~= self.control then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_ID[5], true) and not check_npc_distance(self.npc, self.target, skill_instant_ID[4], true) then
  else
    return
  end
  local now_angle = get_target_angel(self.npc, self.target, true)
  if 20102103 == skill_instant_ID[1] or 20102106 == skill_instant_ID[1] then
  elseif get_npc_time(self.npc) < self.stun_timer then
    return
  elseif (now_angle > 45 or now_angle < -45) and check_npc_distance(self.npc, self.target, 4, true) then
    if is_cast_skill_time(self.npc) then
      return
    end
    stop_move(self.npc)
    self.turn_switch = 0
    return
  elseif self.wander_set == false then
    self.wander_set = true
  end
  if 20102102 == skill_instant_ID[1] and (now_angle > 30 or now_angle <= -30) then
    return
  end
  if get_npc_time(self.npc) >= skill_instant_ID[3] then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.target, skill_instant_ID[1])
    skill_instant_ID[3] = get_npc_time(self.npc) + skill_instant_ID[2]
    self.wander_timer = get_npc_time(self.npc) + self.wander[2]
    if 20102101 == skill_instant_ID[1] and 0 == self.skill3_set then
      self.stun_timer = get_npc_time(self.npc) + 2
      self.control = 6
    elseif 20102102 == skill_instant_ID[1] and 0 == self.skill3_set then
      self.stun_timer = get_npc_time(self.npc) + 2
      self.control = 6
    end
    if 20102103 == skill_instant_ID[1] and skill_instant_ID[8] then
      local now_time = get_npc_time(self.npc)
      if not check_magic(self.npc, 100454) then
        cast_magic(self.npc, self.npc, 100453, 1)
      end
      play_common_sound("M201021_skill3_1")
      self.skill3_set = 1
      self.npc_now_time = now_time + 0.8
      set_skill_end_to_idle(self.npc, false)
      self.control = 2
    elseif 20102106 == skill_instant_ID[1] and skill_instant_ID[8] then
      local now_time = get_npc_time(self.npc)
      cast_magic(self.npc, self.npc, 100456, 1)
      cast_magic(self.npc, self.npc, 100457, 1)
      if check_magic(self.npc, 100453) then
        abort_magic_by_id(self.npc, 100453)
        abort_magic_by_id(self.npc, 100454)
        abort_magic_by_id(self.npc, 100455)
        abort_magic_by_id(self.npc, 100459)
        abort_magic_by_id(self.npc, 100460)
      end
      self.npc_now_time = now_time + 0.8
      self.control = 4
    end
  else
    return
  end
end

function M:loop_skill()
  local now_time = get_npc_time(self.npc)
  if 2 == self.control and now_time >= self.npc_now_time then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill04[1])
    if self.M201021_skill3_2_sound_set == false then
      play_common_sound("M201021_skill3_2")
      self.M201021_skill3_2_sound_set = true
    end
    if not check_magic(self.npc, 100454) and 0 == self.fx_set then
      cast_magic(self.npc, self.npc, 100454, 1)
    end
    if now_time >= self.npc_now_time + 2 and 0 == self.fx_set then
      cast_magic(self.npc, self.npc, 100459, 1)
      self.fx_set = 1
      self.npc_now_time = now_time
    end
    if now_time >= self.npc_now_time + 2 and 1 == self.fx_set then
      cast_magic(self.npc, self.npc, 100460, 1)
      self.fx_set = 2
      self.npc_now_time = now_time
    end
    self.wander_timer_skill_makeup = self.skill04[6] + self.skill04[7]
    self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
    stop_move(self.npc)
    if now_time >= self.npc_now_time + 2.5 then
      self.npc_now_time = now_time
      set_skill_end_to_idle(self.npc, true)
      self.control = 3
      play_common_sound("M201021_skill3_3")
    end
  end
  if self.control >= 4 and self.control < 5 and now_time >= self.npc_now_time then
    local now_time = get_npc_time(self.npc)
    if 4 == self.control then
      abort_skill(self.npc)
      set_skill_end_to_idle(self.npc, false)
      cast_skill(self.npc, self.target, self.skill07[1])
      self.wander_timer_skill_makeup = self.skill07[6] + self.skill07[7]
      self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
      stop_move(self.npc)
      self.control = 4.1
    elseif now_time >= self.npc_now_time + 1.5 and self.control == 4.1 then
      self.npc_now_time = now_time
      cast_skill(self.npc, self.target, self.skill07[1])
      self.control = 4.2
    elseif now_time >= self.npc_now_time + 1.5 and self.control == 4.2 then
      self.npc_now_time = now_time
      cast_skill(self.npc, self.target, self.skill07[1])
      self.control = 4.3
    elseif now_time >= self.npc_now_time + 1.5 and self.control == 4.3 then
      self.npc_now_time = now_time
      cast_skill(self.npc, self.target, self.skill07[1])
      self.control = 4.4
    elseif now_time >= self.npc_now_time + 1.5 and self.control == 4.4 then
      self.npc_now_time = now_time
      set_skill_end_to_idle(self.npc, true)
      self.control = 5
    end
  end
end

function M:last_skill()
  local now_time = get_npc_time(self.npc)
  if 3 == self.control then
    self.skill_set = 0
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill05[1])
    abort_magic_by_id(self.npc, 100453)
    abort_magic_by_id(self.npc, 100454)
    abort_magic_by_id(self.npc, 100459)
    abort_magic_by_id(self.npc, 100460)
    cast_magic(self.npc, self.npc, 100455, 1)
    self.wander_timer_skill_makeup = self.skill05[6] + self.skill05[7]
    self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 2
    self.npc_now_time = now_time
    self.control = 6
    self.skill3_set = 2
  end
  if 5 == self.control and now_time >= self.npc_now_time then
    self.skill_set = 0
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.skill08[1])
    self.wander_timer_skill_makeup = self.skill08[6] + self.skill08[7]
    self.wander_timer = get_npc_time(self.npc) + self.wander_timer_skill_makeup
    stop_move(self.npc)
    self.stun_timer = get_npc_time(self.npc) + 2
    self.control = 6
    self.skill3_set = 2
  end
end

function M:attack_done_bonus()
  local now_time = get_npc_time(self.npc)
  if not self.target and (not (is_cast_skill_time(self.npc, 20102112, 1) and is_cast_skill_time(self.npc, 20102113)) or not is_cast_skill_time(self.npc, 20102104)) then
    self.control = 0
    return
  end
  if check_npc_status(self.target, 2) then
    self.stun_timer = get_npc_time(self.npc) + 0.5
    return
  end
  if now_time >= self.stun_timer and 6 == self.control then
    self.control = 0
    if self.wander_set == false then
      self.wander_set = true
    else
    end
  end
end

function M:on_superarmor_break(npc, camp)
  if npc ~= self.npc then
    return
  end
  if 1 == self.skill3_set then
    abort_skill(self.npc)
    self.skill_set = 1
    self.control = 0
    self:cast_skill(self.skill06)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and self.wander_set == true and (skill_id == self.skill01[1] or skill_id == self.skill02[1]) then
    self.wander_set = false
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc and 4 == missile_cfg.MissileTypeTag and check_magic(self.npc, 201021007) then
    self.control = 90
    abort_magic_by_id(self.npc, 201021007)
    abort_skill(self.npc)
    set_action_keep_end(self.npc)
    set_skill_end_to_idle(self.npc, false)
    cast_skill(self.npc, self.npc, self.skill06[1])
    self.skill_set = 90
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if get_sync_var("xiandiban") then
  elseif skill_id == self.skill06[1] and 90 == self.skill_set then
    abort_skill(self.npc)
    set_action_keep_end(self.npc)
    set_skill_end_to_idle(self.npc, false)
    cast_skill(self.npc, self.npc, self.skill08[1])
    return
  elseif skill_id == self.skill08[1] and 90 == self.skill_set then
    self.skill_set = 0
    abort_skill(self.npc)
    set_skill_end_to_idle(self.npc, true)
    self.control = 0
    return
  end
  if 20102113 == skill_id then
    set_sync_var("rock_in_daze", 3)
  end
  if 20102101 == skill_id or 20102102 == skill_id or 20102105 == skill_id or 20102108 == skill_id then
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if get_sync_var("xiandiban") then
  elseif skill_id == self.skill06[1] and 90 == self.skill_set then
    abort_skill(self.npc)
    set_action_keep_end(self.npc)
    set_skill_end_to_idle(self.npc, false)
    cast_skill(self.npc, self.npc, self.skill08[1])
    return
  elseif skill_id == self.skill08[1] and 90 == self.skill_set then
    self.skill_set = 0
    abort_skill(self.npc)
    set_skill_end_to_idle(self.npc, true)
    self.control = 0
    return
  end
  if 20102113 == skill_id then
    set_sync_var("rock_in_daze", 3)
  end
  if 20102101 == skill_id or 20102102 == skill_id or 20102105 == skill_id or 20102108 == skill_id then
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  local now_supa = get_npc_attr(self.npc, 69)
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.target, 2) then
    return
  end
  if not get_sync_var("rock_skip") and now_supa / self.max_supa <= 0.5 and now_supa > 0 and 0 == self.skill3_set then
    abort_skill(self.npc)
    self.skill_set = 1
    self:cast_skill(self.skill03)
  end
  if 0 ~= self.control then
    return
  end
  if 90 ~= self.skill_set then
    if 1 == self.skill_set then
      return
    elseif not self:cast_skill(self.skill02) and not self:cast_skill(self.skill01) and check_npc_distance(self.npc, self.target, self.wander[1], true) then
      return
    end
  end
end

function M:move_approch_wander()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  if 0 ~= self.control then
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    return
  end
  if 1 == self.skill_set then
    return
  end
  if not check_activate(self.target) then
    return
  end
  if get_npc_time(self.npc) < self.wander_timer then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if self.wander_set == false then
    return
  end
  if not check_npc_distance(self.npc, self.target, self.wander[1], true) then
    self:move_approch_wander()
  elseif check_npc_distance(self.npc, self.target, self.wander[1], false) then
    stop_move(self.npc)
    self.wander_timer = get_npc_time(self.npc) + self.wander[2]
  end
end

function M:on_frame()
  if is_npc_loaded(self.npc) then
    local now_time = get_npc_time(self.npc)
    if get_sync_var("xiandiban") then
      abort_skill(self.npc)
      self.skill_set = 1
      self.control = 0
      self:cast_skill(self.skill03)
      set_sync_var("xiandiban", false)
    end
    if 0 == get_sync_var("rock_in_daze") and self.v_state_1 == nil then
      if not check_magic(self.npc, 201021006) and is_npc_loaded(self.npc) then
        abort_magic_by_id(self.npc, 201021002)
        cast_magic(self.npc, self.npc, 201021006, 0)
      end
      enable_shadow(self.npc, true)
      if self.born_tag == false then
        self.born_tag = true
      end
      self.control = 9
      abort_skill(self.npc)
      set_action_keep_end(self.npc)
      set_skill_end_to_idle(self.npc, false)
      cast_skill(self.npc, self.npc, 20102112, nil, nil)
      self.v_state_1 = true
    elseif 1 == get_sync_var("rock_in_daze") then
      abort_skill(self.npc)
      abort_magic_by_id(self.npc, 201021006)
      cast_skill(self.npc, self.npc, 20102113, nil, nil)
      set_sync_var("rock_in_daze", 2)
    elseif 4 == get_sync_var("rock_in_daze") then
      set_skill_end_to_idle(self.npc, true)
      self.control = 0
      set_sync_var("rock_in_daze", 5)
    end
  end
  if check_magic(self.npc, 100174) then
    return
  end
  self:wander_main_logic()
  self:skill_main_logic()
  self:loop_skill()
  self:last_skill()
  self:attack_done_bonus()
  self:spawn_skill()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  if 0 == self.supa_set then
    self.max_supa = get_npc_attr(self.npc, 69)
    self.supa_set = 1
  end
  if false == self.transparent then
    mark_transparent(self.npc)
    self.transparent = true
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if npc == self.npc then
    abort_skill(self.npc, true)
    abort_magic_by_id(self.npc, 100453)
    abort_magic_by_id(self.npc, 100454)
    abort_magic_by_id(self.npc, 100455)
    abort_magic_by_id(self.npc, 100456)
    abort_magic_by_id(self.npc, 100457)
    abort_magic_by_id(self.npc, 100459)
    abort_magic_by_id(self.npc, 100460)
  end
end

return M
