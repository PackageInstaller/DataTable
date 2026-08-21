local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.prick = {
    20106502,
    5,
    0,
    0,
    99,
    get_skill_cfg(20106502).CastTime,
    get_skill_cfg(20106502).AfterTime,
    0
  }
  self.water_impact = {
    20106503,
    9,
    0,
    3,
    99,
    get_skill_cfg(20106503).CastTime,
    get_skill_cfg(20106503).AfterTime,
    0
  }
  self.water_jet = {
    20106504,
    0,
    0,
    0,
    99,
    get_skill_cfg(20106504).CastTime,
    get_skill_cfg(20106504).AfterTime,
    0
  }
  self.water_jet_continued = {
    20106505,
    0,
    0,
    0,
    99,
    get_skill_cfg(20106505).CastTime,
    get_skill_cfg(20106505).AfterTime,
    0
  }
  self.water_jet_end = {
    20106506,
    0,
    0,
    0,
    99,
    get_skill_cfg(20106506).CastTime,
    get_skill_cfg(20106506).AfterTime,
    0
  }
  self.water_jet_down = {
    20106507,
    0,
    0,
    0,
    99,
    get_skill_cfg(20106507).CastTime,
    get_skill_cfg(20106507).AfterTime,
    0
  }
  self.move_1 = {
    20106508,
    5,
    0,
    2,
    99,
    get_skill_cfg(20106508).CastTime,
    get_skill_cfg(20106508).AfterTime,
    0
  }
  self.move_2 = {
    20106509,
    7,
    0,
    2,
    10,
    get_skill_cfg(20106509).CastTime,
    get_skill_cfg(20106509).AfterTime,
    0
  }
  self.move_3 = {
    20106510,
    7,
    0,
    2,
    99,
    get_skill_cfg(20106510).CastTime,
    get_skill_cfg(20106510).AfterTime,
    0
  }
  self.break_begin = {
    20106511,
    7,
    0,
    1,
    3,
    get_skill_cfg(20106511).CastTime,
    get_skill_cfg(20106511).AfterTime,
    0
  }
  self.break_begin_1 = {
    20106512,
    7,
    0,
    1,
    3,
    get_skill_cfg(20106512).CastTime,
    get_skill_cfg(20106512).AfterTime,
    0
  }
  self.break_continued = {
    20106513,
    7,
    0,
    1,
    3,
    get_skill_cfg(20106513).CastTime,
    get_skill_cfg(20106513).AfterTime,
    0
  }
  self.break_end = {
    20106514,
    7,
    0,
    1,
    3,
    get_skill_cfg(20106514).CastTime,
    get_skill_cfg(20106514).AfterTime,
    0
  }
  self.counter_break_begin = {
    20106515,
    7,
    0,
    1,
    3,
    get_skill_cfg(20106515).CastTime,
    get_skill_cfg(20106515).AfterTime,
    0
  }
  self.counter_break_begin_1 = {
    20106516,
    7,
    0,
    1,
    3,
    get_skill_cfg(20106516).CastTime,
    get_skill_cfg(20106516).AfterTime,
    0
  }
  self.counter_break_continued = {
    20106517,
    7,
    0,
    1,
    3,
    get_skill_cfg(20106517).CastTime,
    get_skill_cfg(20106517).AfterTime,
    0
  }
  self.counter_break_end = {
    20106518,
    7,
    0,
    1,
    3,
    get_skill_cfg(20106518).CastTime,
    get_skill_cfg(20106518).AfterTime,
    0
  }
  self.Enter_Attack_Range = 20
  self.stun_timer = 0
  self.control = 0
  self.wander_time = 0
  self.birth_time = 0
  self.is_birth = false
  self.born_skill = 20106501
  self.die_skill = 20106519
  self.wandering = false
  self.move_timer = 0
  self.move_timer_far = 0
  self.is_Move = false
  self.water_jet_timer = 0
  self.water_impact_count = 0
  self.behit_count = 0
  self.skill_count = 0
  self.water_jet_down_timer = 0
  self.break_time = 0
  self.break_time1 = 0
  self.camera_time = 0
end

function M:on_start()
  self.birth_time = get_npc_time(self.npc) + 3
  cast_skill(self.npc, self.npc, self.born_skill)
end

function M:Relese_Skill(Skill_ID)
  if not self.target then
    return
  end
  local dis0 = check_npc_distance(self.npc, self.target, Skill_ID[4], true)
  local dis1 = check_npc_distance(self.npc, self.target, Skill_ID[5], true)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    return
  end
  if get_npc_time(self.npc) <= self.stun_timer then
    lookat_npc(self.target, self.npc)
    return
  end
  if 1 ~= self.control then
    return
  end
  if get_npc_time(self.npc) >= Skill_ID[3] then
    if not dis1 then
      self:Move_Forward()
    elseif dis1 and not dis0 then
      lookat_npc(self.npc, self.target)
      cast_skill(self.npc, self.target, Skill_ID[1])
      Skill_ID[3] = get_npc_time(self.npc) + Skill_ID[2]
      self.wandering = false
    elseif dis0 then
      self:Move_Bcakward()
    end
  end
end

function M:Move_Forward()
  switch_move_type(self.npc, 1)
  moveto_npc(self.npc, self.target)
end

function M:Wandering()
  if not self.target then
    return
  end
  self.wander_randomseed = math.random()
  if self.wander_randomseed < 0.3 and get_npc_time(self.npc) >= self.wander_time then
    switch_move_type(self.npc, 3)
    moveto_npc(self.npc, self.target)
    self.wander_time = get_npc_time(self.npc) + 1
  elseif self.wander_randomseed < 0.6 and get_npc_time(self.npc) >= self.wander_time then
    switch_move_type(self.npc, 4)
    moveto_npc(self.npc, self.target)
    self.wander_time = get_npc_time(self.npc) + 1
  elseif self.wander_randomseed < 1 and get_npc_time(self.npc) >= self.wander_time then
    stop_move(self.npc)
    self.wander_time = get_npc_time(self.npc) + 1
  end
  if not self.wandering then
    self.wandering = true
  end
end

function M:Move_Bcakward()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
end

function M:Enter_Attack()
  local now_time = get_npc_time(self.npc)
  if not self.target then
    return
  end
  if 1 ~= self.control then
    return
  end
  if get_npc_time(self.npc) < self.stun_timer then
    self:Wandering()
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if 1 == self.skill_set then
    if not self.is_Move then
      cast_skill(self.npc, self.npc, self.move_1[1])
      self.move_timer = now_time + 0.8
      cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
      cast_magic(self.npc, self.npc, 201055002, 1)
      enable_shadow(self.npc, false)
      self.is_Move = true
    end
  elseif 2 == self.skill_set then
    self:Relese_Skill(self.water_impact)
  elseif 3 == self.skill_set then
    if not self.is_Move then
      cast_skill(self.npc, self.npc, self.move_1[1])
      self.move_timer = now_time + 0.8
      cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
      cast_magic(self.npc, self.npc, 201055002, 1)
      enable_shadow(self.npc, false)
      self.is_Move = true
    end
  elseif 4 == self.skill_set and not self.is_Move then
    cast_skill(self.npc, self.npc, self.move_1[1])
    self.move_timer = now_time + 0.8
    cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
    cast_magic(self.npc, self.npc, 201055002, 1)
    enable_shadow(self.npc, false)
    self.is_Move = true
  end
end

function M:Move()
  if 1 ~= self.control then
    return
  end
  local now_time = get_npc_time(self.npc)
  if is_cast_skill_time(self.npc, self.move_1[1]) and now_time > self.move_timer then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.move_2[1])
    cast_magic(self.npc, self.npc, 201055003, 1)
    cast_magic(self.npc, self.npc, 201055004, 1)
    cast_magic(self.npc, self.npc, 201065001, 1)
  end
  if is_cast_skill_time(self.npc, self.move_2[1]) and now_time > self.move_timer then
    if 1 == self.skill_set or 4 == self.skill_set then
      local pos1 = get_npc_offset_position(self.target, nil, 90, 1.5)
      local pos2 = get_npc_offset_position(self.target, nil, 30, 1.5)
      switch_move_type(self.npc, 1)
      if math.random(1, 10) > 5 then
        move_to_pos(self.npc, pos1)
      else
        move_to_pos(self.npc, pos2)
      end
      self.move_timer = now_time + 3
      self.move_timer_far = now_time + 0.5
    elseif 3 == self.skill_set then
      local pos1 = get_npc_offset_position(self.target, nil, 90, 5)
      switch_move_type(self.npc, 1)
      move_to_pos(self.npc, pos1)
      self.move_timer = now_time + 3
      self.move_timer_far = now_time + 0.5
    end
  end
  if is_cast_skill_time(self.npc, self.move_2[1]) and now_time >= self.move_timer_far and (1 == self.skill_set or 4 == self.skill_set) then
    abort_skill(self.npc)
    stop_move(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.npc, self.move_3[1])
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(self.npc, 201065001, 1)
    abort_magic_by_id(self.npc, 201055002, 1)
    abort_magic_by_id(self.npc, 201055003, 1)
    abort_magic_by_id(self.npc, 201055004, 1)
    abort_magic_by_id(self.npc, 201055005, 1)
    enable_shadow(self.npc, true)
  elseif is_cast_skill_time(self.npc, self.move_2[1]) and now_time >= self.move_timer_far and 3 == self.skill_set then
    abort_skill(self.npc)
    stop_move(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.npc, self.move_3[1])
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(self.npc, 201065001, 1)
    abort_magic_by_id(self.npc, 201055002, 1)
    abort_magic_by_id(self.npc, 201055003, 1)
    abort_magic_by_id(self.npc, 201055004, 1)
    abort_magic_by_id(self.npc, 201055005, 1)
    enable_shadow(self.npc, true)
  end
end

function M:on_magic_end(npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  if 201065011 == magic_id then
    abort_magic_by_id(self.npc, 201065012, 1)
  end
end

function M:Water_Jet()
  if self.behit_count >= 7 then
    if math.random(1, 100) > 40 then
      self.skill_set = 3
      self.behit_count = 0
    else
      self.skill_set = 1
      self.behit_count = 0
    end
  end
  if 3 ~= self.skill_set then
    return
  end
  local now_time = get_npc_time(self.npc)
  if is_cast_skill_time(self.npc, self.water_jet[1]) and now_time >= self.water_jet_timer then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.water_jet_continued[1])
    self.water_jet_timer = now_time + 2.5
  end
  if is_cast_skill_time(self.npc, self.water_jet_continued[1]) and now_time >= self.water_jet_timer then
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.water_jet_end[1])
  end
end

function M:Water_Jet_Down()
  if 1 ~= self.control then
    return
  end
  local now_time = get_npc_time(self.npc)
  if now_time > self.water_jet_down_timer and not is_cast_skill_time(self.npc) then
    self.skill_set = 4
  end
end

function M:on_magic_begin(npc, target, magic_id)
  if 1999127 == magic_id then
    cast_magic(self.npc, self.npc, 20102601010, 1)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.water_jet_down[1] then
    self.water_jet_down_timer = get_npc_time(self.npc) + 25
  end
  if skill_id == self.move_1[1] then
    set_can_searched(self.npc, false)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if not self.target then
    return
  end
  if hit_target == self.npc and not is_cast_skill_time(self.npc) and math.random(1, 100) > 60 then
    self.behit_count = self.behit_count + 1
  end
  if hit_target == self.npc and 4 == missile_cfg.MissileTypeTag and check_magic(self.npc, 20102601010) then
    self.control = 2
    change_follow_target(1, self.npc, {
      8,
      4.5,
      {
        x = 0,
        y = -0.2,
        z = 2
      },
      1.3,
      0.55
    })
    cast_magic(self.npc, self.npc, 20101201014, 1)
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.npc, self.counter_break_begin[1], 1)
    self.break_time1 = get_npc_time(self.npc) + 0.4
    abort_magic_by_id(self.npc, 20102601010, 1)
    self.camera_time = get_npc_time(self.npc) + 0.2
    change_focus_follow_speed(2)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  local now_time = get_npc_time(self.npc)
  if not self.target then
    return
  end
  if skill_id == self.move_3[1] then
    set_can_searched(self.npc, true)
    if 1 == self.skill_set then
      lookat_npc(self.npc, self.target)
      self:Relese_Skill(self.prick)
    elseif 3 == self.skill_set then
      self:Relese_Skill(self.water_jet)
      self.water_jet_timer = now_time + 0.4
    elseif 4 == self.skill_set then
      self:Relese_Skill(self.water_jet_down)
    end
  end
  if skill_id == self.prick[1] then
    self.stun_timer = now_time + 3
    self.is_Move = false
    self.skill_set = 2
  end
  if skill_id == self.water_jet_end[1] then
    self.stun_timer = now_time + 3
    self.is_Move = false
    self.skill_set = 2
  end
  if skill_id == self.water_impact[1] then
    self.water_impact_count = self.water_impact_count + 1
    self.stun_timer = now_time + 3
    self.is_Move = false
    if self.water_impact_count >= 2 then
      self.skill_set = 1
      self.water_impact_count = 0
    end
  end
  if skill_id == self.water_jet_down[1] then
    self.stun_timer = now_time + 4
    self.is_Move = false
    self.skill_set = 2
  end
end

function M:on_superarmor_break(npc, camp)
  if npc == self.npc then
    self.control = 2
    cast_magic(self.npc, self.npc, Const.MONSTER_BE_HIT.FX, 1)
    change_follow_target(1, self.npc, {
      8,
      4.5,
      {
        x = 0,
        y = -0.2,
        z = 2
      },
      1.3,
      0.55
    })
    cast_magic(self.npc, self.npc, 20101201014, 1)
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.break_begin[1], 1)
    self.break_time = get_npc_time(self.npc) + 0.4
    self.camera_time = get_npc_time(self.npc) + 0.2
    change_focus_follow_speed(2)
  end
end

function M:Break()
  local now_time = get_npc_time(self.npc)
  if is_cast_skill_time(self.npc, self.break_begin[1]) and now_time > self.break_time then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.break_begin_1[1], 1)
    self.break_time = self.break_time + 0.4
  end
  if is_cast_skill_time(self.npc, self.break_begin_1[1]) and now_time > self.break_time then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.break_continued[1], 1)
    self.break_time = self.break_time + 4.5
  end
  if is_cast_skill_time(self.npc, self.break_continued[1]) and now_time > self.break_time then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.break_end[1], 1)
    self.control = 1
    self.stun_timer = now_time + 3
    self.skill_set = 2
  end
end

function M:Break_counter()
  if is_cast_skill_time(self.npc, self.counter_break_begin[1]) and get_npc_time(self.npc) > self.break_time1 then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.counter_break_begin_1[1], 1)
    self.break_time1 = self.break_time1 + 0.4
  end
  if is_cast_skill_time(self.npc, self.counter_break_begin_1[1]) and get_npc_time(self.npc) > self.break_time1 then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.counter_break_continued[1], 1)
    self.break_time1 = self.break_time1 + 2
  end
  if is_cast_skill_time(self.npc, self.counter_break_continued[1]) and get_npc_time(self.npc) > self.break_time1 then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.counter_break_end[1], 1)
    self.control = 1
    self.stun_timer = now_time + 3
    self.skill_set = 2
  end
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, self.die_skill)
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if npc == self.target and 2 ~= self.control then
    abort_skill(self.npc)
    self.control = 0
    self.birth_time = get_npc_time(self.npc) + 2
    self.is_birth = false
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 50, 30)
  CommonMonster.remove_timer(self)
  CommonMonster.block_hit_stun(self)
  local now_time = get_npc_time(self.npc)
  self:Enter_Attack()
  self:Move()
  self:Water_Jet()
  self:Break()
  self:Break_counter()
  self:Water_Jet_Down()
  if now_time > self.birth_time and not self.is_birth and self.target and 0 == self.control then
    self.control = 1
    self.is_Move = false
    lookat_npc(self.npc, self.target)
    self.skill_set = 2
    self.water_jet_down_timer = now_time + 25
    self.is_birth = true
  end
  if get_npc_time(self.npc) > self.camera_time then
    change_follow_target(0)
  end
  if check_magic(self.target, Const.DEFEND.DASH.PERFECT.TRY) then
    abort_magic_by_id(self.target, 201065011)
    abort_magic_by_id(self.target, 201065012)
  end
end

return M
