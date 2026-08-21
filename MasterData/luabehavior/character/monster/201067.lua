local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill01 = {
    20106701,
    6,
    0,
    0,
    3,
    get_skill_cfg(20106701).CastTime,
    get_skill_cfg(20106701).AfterTime,
    0
  }
  self.skill02 = {
    20106702,
    4,
    0,
    0,
    3,
    get_skill_cfg(20106702).CastTime,
    get_skill_cfg(20106702).AfterTime,
    0
  }
  self.monster_type = 1
  self.control = 0
  self.target = nil
  self.stun_timer = 0
  self.move_timer = 0
  self.go_drink_water = 20106706
  self.go_drink_water_timer = 0
  self.drink_water = 20106707
  self.drink_water_timer = 0
  self.maniacal_skill = 20106705
  self.maniacal_skill_timer = 0
  self.allow_maniacal = 0
  self.skill_end = 0
  self.random_num_timer = 0
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc then
    CommonMonster.counteratk(self)
  end
end

function M:logic(skill_instant_id)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 2) then
    abort_skill(self.npc)
    stop_move(self.npc)
    self.control = 0
    return
  end
  if 0 ~= self.control then
    return
  end
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if check_npc_status(self.npc, 0) or check_npc_status(self.npc, 9) then
  else
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if self.now_time < skill_instant_id[3] then
    return
  end
  if not check_magic(self.npc, 2010670501) and check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and not check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    abort_skill(self.npc, true)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.target, skill_instant_id[1])
    skill_instant_id[3] = now_time + skill_instant_id[2]
    self.skill_set_time = self.now_time + math.random(10, 30) / 10
    self.skill_set = 0
  elseif check_magic(self.npc, 2010670501) and check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and not check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    abort_skill(self.npc, true)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.target, skill_instant_id[1])
    skill_instant_id[3] = now_time + 1
    self.skill_set_time = self.now_time + math.random(10, 30) / 10
    self.skill_set = 0
  elseif not check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and now_time > self.move_timer then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
    self.move_timer = now_time + 1
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if not check_magic(self.npc, 2010670501) and (20106701 == skill_id or 20106702 == skill_id) then
    self.skill_end = 1
  end
  if check_magic(self.npc, 2010670501) then
    self.skill_end = 0
  end
end

function M:quit()
  if 1 ~= self.skill_end then
    return
  end
  if 1 == self.skill_end then
    self.quit_set = math.random(0, 3)
    self.skill_end = 2
  end
  if self.quit_set <= 1 and 2 == self.skill_end then
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.target, 20106703, nil, nil)
    self.skill_end = 0
  elseif self.quit_set > 1 then
    self.skill_end = 0
  end
end

function M:maniacal()
  local now_time = get_npc_time(self.npc)
  if 0 == self.allow_maniacal and get_npc_time(self.npc) >= self.random_num_timer then
    self.now_hp = get_npc_attr(self.npc, 1)
    self.max_hp = get_npc_attr(self.npc, 4)
    self.random_num = math.random(0, 6)
    self.random_num_timer = get_npc_time(self.npc) + 3
  end
  if 0 == self.allow_maniacal and self.random_num <= 1 and self.now_hp / self.max_hp < 1 and now_time >= self.go_drink_water_timer then
    abort_skill(self.npc, true)
    lookat_position(self.npc, 0, 0, 1)
    cast_skill(self.npc, self.target, self.go_drink_water, 0, 0)
    self.allow_maniacal = 1
    self.go_drink_water_timer = now_time + 30
  elseif 0 == self.allow_maniacal and self.random_num <= 3 and self.now_hp / self.max_hp < 0.7 and now_time >= self.go_drink_water_timer then
    abort_skill(self.npc, true)
    lookat_position(self.npc, 0, 0, 1)
    cast_skill(self.npc, self.target, self.go_drink_water, 0, 0)
    self.go_drink_water_timer = now_time + 30
    self.allow_maniacal = 1
  elseif 0 == self.allow_maniacal and self.random_num <= 6 and self.now_hp / self.max_hp < 0.4 and now_time >= self.go_drink_water_timer then
    abort_skill(self.npc, true)
    lookat_position(self.npc, 0, 0, 1)
    cast_skill(self.npc, self.target, self.go_drink_water, 0, 0)
    self.go_drink_water_timer = now_time + 30
    self.allow_maniacal = 1
  end
  local now_pos = get_npc_pos(self.npc)
  if 1 == self.allow_maniacal and now_pos.x <= 0.5 and now_pos.z <= 0.5 and now_time >= self.drink_water_timer then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, self.drink_water)
    self.drink_water_timer = now_time + 30
    self.allow_maniacal = 2
  end
  if 2 == self.allow_maniacal and now_time >= self.maniacal_skill_timer then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, self.maniacal_skill)
    self.maniacal_skill_timer = now_time + 30
  end
  if now_time < self.maniacal_skill_timer then
    self.allow_maniacal = 99
  end
end

function M:skill_main_logic()
  if self.target and 0 == self.control and not check_npc_status(self.npc, 2) and not is_cast_skill_time(self.npc) then
  else
    return
  end
  if 1 == self.skill_set then
    self:logic(self.skill01)
  elseif 2 == self.skill_set then
    self:logic(self.skill02)
  end
end

function M:on_frame()
  self:skill_main_logic()
  self:quit()
  self:maniacal()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.camp_main_logic(self)
  CommonMonster.attack_wander_logic(self, self.skill01, self.skill02)
  CommonMonster.platform_move(self)
  CommonMonster.Hit_wall(self)
  CommonMonster.skill_change_logic(self)
  CommonMonster.attack_elit_1(self, self.skill01, self.skill02)
  CommonMonster.monster_on_frame(self)
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    abort_skill(self.npc, true)
  end
end

return M
