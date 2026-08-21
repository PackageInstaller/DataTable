local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.skill04 = {
    20107404,
    9,
    3,
    0,
    8,
    get_skill_cfg(20107405).CastTime,
    get_skill_cfg(20107405).AfterTime,
    1
  }
  self.skill03 = {
    20107403,
    6,
    3,
    0,
    3,
    get_skill_cfg(20107403).CastTime,
    get_skill_cfg(20107403).AfterTime,
    1
  }
  self.skill02 = {
    20107402,
    10,
    3,
    0,
    4,
    get_skill_cfg(20107402).CastTime,
    get_skill_cfg(20107402).AfterTime,
    1
  }
  self.skill01 = {
    20107401,
    8,
    3,
    0,
    7,
    get_skill_cfg(20107401).CastTime,
    get_skill_cfg(20107401).AfterTime,
    1
  }
  self.go_drink_water = 20107405
  self.drink_water = 20107406
  self.maniacal_skill = 20107407
  self.run_skill = 20107408
  self.run_skill_timer = 0
  self.monster_type = 2
  self.wander = {
    3,
    7,
    3.5
  }
  self.wander_timer = 2
  self.wander_backrange = 1
  self.wander_backtimer = 0
  self.wander_state = 0
  self.control = 0
  self.stun_timer = 0
  self.allow_maniacal = 0
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.drink_water then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, 20107407, 1)
    self.allow_maniacal = 99
  end
end

function M:attack_done_bonus()
  if is_cast_skill_time(self.npc) then
    return
  end
  if 99 == self.control then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.stun_timer then
      self.control = 0
    end
  end
end

function M:maniacal()
  if not self.npc then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  local now_hp = get_npc_attr(self.npc, 1)
  local max_hp = get_npc_attr(self.npc, 4)
  if now_hp / max_hp <= 0.5 and 0 == self.allow_maniacal then
    abort_skill(self.npc, true)
    lookat_position(self.npc, 0, 0, 1)
    cast_skill(self.npc, self.npc, self.go_drink_water, 0, 0)
    self.allow_maniacal = 1
    self.skill_set = 99
  elseif 1 == self.allow_maniacal then
    local now_pos = get_npc_pos(self.npc)
    if now_pos.x <= 0.5 and now_pos.z <= 0.5 then
      abort_skill(self.npc, true)
      cast_skill(self.npc, self.npc, self.drink_water)
      self.allow_maniacal = 2
    end
  end
end

function M:cast_skill_logic(skill_instant_id)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    self.control = 0
  end
  if check_magic(self.npc, 201074004) then
    if now_time < skill_instant_id[3] - 4 then
      return
    end
  elseif now_time < skill_instant_id[3] then
    return
  end
  if not check_npc_distance(self.npc, self.target, skill_instant_id[5], true) or not not check_npc_distance(self.npc, self.target, skill_instant_id[4], true) then
    return
  end
  abort_skill(self.npc, true)
  lookat_npc(self.npc, self.target)
  cast_skill(self.npc, self.target, skill_instant_id[1])
  skill_instant_id[3] = now_time + skill_instant_id[2] + math.random() * 2
  self.stun_timer = now_time + math.random() * 2 + 2
  self.skill_set_time = self.now_time + math.random(50, 90) / 10
  self.skill_set = 0
  self.control = 99
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  if 0 ~= self.control then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if not check_npc_distance(self.npc, self.target, 6, true) then
    self.skill_set = math.random(1, 2)
    if 1 == self.skill_set then
      self:cast_skill_logic(self.skill01)
    elseif 2 == self.skill_set then
      self:cast_skill_logic(self.skill04)
    end
  else
    self.skill_set = math.random(3, 4)
    if 3 == self.skill_set then
      self:cast_skill_logic(self.skill03)
    elseif 4 == self.skill_set then
      self:cast_skill_logic(self.skill02)
    end
  end
end

function M:move_normal_wander()
  self.wander_randomseed = math.random()
  if self.wander_randomseed >= 0.5 then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
  else
    switch_move_type(self.npc, 2)
    moveto_npc(self.npc, self.target)
  end
end

function M:move_leave_wander()
  switch_move_type(self.npc, 2)
  moveto_npc(self.npc, self.target)
  self.wander_timer = get_npc_time(self.npc) + 1
end

function M:move_approch_wander()
  local now_time = get_npc_time(self.npc)
  if now_time > self.run_skill_timer then
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.target, self.run_skill)
    self.run_skill_timer = now_time + 2
  end
end

function M:wander_main_logic()
  if not self.target then
    return
  end
  local npc_time = get_npc_time(self.npc)
  if not check_activate(self.target) then
    return
  end
  if npc_time < self.wander_timer then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  local distance_min = check_npc_distance(self.npc, self.target, self.wander[1], true)
  local distance_max = check_npc_distance(self.npc, self.target, self.wander[2], true)
  if distance_max and not distance_min then
    self:move_normal_wander()
  elseif distance_min then
    self:move_leave_wander()
  elseif not distance_max then
    self:move_approch_wander()
  end
  self.wander_timer = npc_time + self.wander[3]
end

function M:on_frame()
  if check_magic(self.npc, 100174) then
    return
  end
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  Util.debug_print("self.skill_on", self.skill_on)
  Util.debug_print("self.allow_maniacal", self.allow_maniacal)
  self:skill_main_logic()
  self:maniacal()
  self:wander_main_logic()
  self:attack_done_bonus()
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 0)
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

return M
