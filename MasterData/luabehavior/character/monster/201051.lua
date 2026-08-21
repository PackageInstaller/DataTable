local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill04 = {
    20105104,
    2,
    1,
    1,
    99,
    get_skill_cfg(20105103).CastTime,
    get_skill_cfg(20105103).AfterTime,
    0
  }
  self.skill03 = {
    20105103,
    2,
    1,
    1,
    99,
    get_skill_cfg(20105103).CastTime,
    get_skill_cfg(20105103).AfterTime,
    0
  }
  self.skill02 = {
    20105102,
    3,
    1,
    1,
    99,
    get_skill_cfg(20105102).CastTime,
    get_skill_cfg(20105102).AfterTime,
    0
  }
  self.skill01 = {
    20105101,
    2,
    1,
    1,
    99,
    get_skill_cfg(20105101).CastTime,
    get_skill_cfg(20105101).AfterTime,
    0
  }
  self.hit_timer = 0
  self.target = nil
  self.control = 0
  self.now_hp = 0
  self.hurt_by_hp = 0
  self.used_enemy_pos = nil
  self.test_set = 0
  self.TEMP_POS = {}
  self.roll_set = false
  self.dis_timer = 0
  self.dis_check_set = false
  self.gogo_steal = math.random(0, 30) + math.random()
  self.gogo_steal_set = false
  self.gogo_timer = 99999
  self.steal_pretime = 0
  self.seya_timer = 999999
end

function M:on_start()
  self.now_hp = get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4)
end

function M:walk_skill()
  if check_npc_status(self.npc, 2) and self.gogo_steal_set == false then
    self.control = 0
    return
  end
  local xpos_to_go = 0
  local zpos_to_go = 0
  if self.target and 0 == self.control then
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
    self.TEMP_POS.x = xpos_to_go
    self.TEMP_POS.z = zpos_to_go
    self.used_enemy_pos = now_enemy_pos
    switch_move_type(self.npc, 1)
    lookat_position(self.npc, self.TEMP_POS.x, self.TEMP_POS.z, true)
    move_to_pos(self.npc, self.TEMP_POS)
    self.control = 1
  elseif not self.target and self.used_enemy_pos then
    self.TEMP_POS.x = xpos_to_go
    self.TEMP_POS.z = zpos_to_go
    switch_move_type(self.npc, 1)
    move_to_pos(self.npc, self.TEMP_POS)
    self.control = 1
  end
end

function M:steeeeeeeeeeal()
  if not self.target then
    return
  end
  local now_time = get_npc_time(self.npc)
  if 4 == self.control then
    cast_skill(self.npc, self.target, self.skill01[1])
    self.control = 5
  elseif 5 == self.control and check_npc_distance(self.npc, self.target, 2, true) then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.target, self.skill02[1])
    cast_magic(self.npc, self.target, 201051001, 1)
    cast_magic(self.npc, self.npc, 201051002, 1)
    self.steal_pretime = now_time + 1.6
    self.control = 6
  elseif 6 == self.control and now_time >= self.steal_pretime then
    self.gogo_steal_set = true
    self.roll_set = true
    self.gogo_timer = now_time + 4
  end
end

function M:rolling()
  if self.roll_set == true then
    local xpos_to_go = 0
    local zpos_to_go = 0
    local random_pos_x = math.random(5, 7)
    local random_pos_z = math.random(5, 7)
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
    lookat_position(self.npc, xpos_to_go, zpos_to_go, 0)
    cast_skill(self.npc, nil, self.skill03[1], xpos_to_go, zpos_to_go)
    self.roll_set = false
    if true == self.gogo_steal_set then
      self.control = 0
      self.gogo_timer = get_npc_time(self.npc) + 4
    end
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc then
    return
  end
  if hit_target == self.npc then
    self.hurt_by_hp = get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4)
    if self.now_hp - self.hurt_by_hp >= 0.3 then
      self.roll_set = true
      self.now_hp = self.hurt_by_hp
    end
  end
end

function M:distance_check()
  if not self.target then
    return
  end
  if check_npc_distance(self.npc, self.target, 2, true) and self.dis_check_set == false then
    self.dis_timer = get_npc_time(self.npc) + 1
    self.dis_check_set = true
  elseif not check_npc_distance(self.npc, self.target, 2, true) and self.dis_check_set == true then
    self.dis_check_set = false
  end
  local now_time = get_npc_time(self.npc)
  if self.dis_check_set == true and now_time >= self.dis_timer then
    self.roll_set = true
  end
end

function M:on_frame()
  self:steeeeeeeeeeal()
  self:walk_skill()
  self:rolling()
  self:distance_check()
  CommonMonster.monster_on_frame(self)
  CommonMonster.search_target(self, 30, 8)
  local now_time = get_npc_time(self.npc)
  if check_npc_status(self.npc, 0) and 1 == self.control then
    self.control = 2
  elseif check_npc_status(self.npc, 0) and 2 == self.control then
    local make_choice = math.random(50, 100) + math.random()
    if make_choice >= self.gogo_steal and self.gogo_steal_set == false then
      self.control = 4
    elseif make_choice < self.gogo_steal and self.gogo_steal_set == false then
      self.gogo_steal = self.gogo_steal + math.random(5, 15)
      self.control = 0
    elseif self.gogo_steal_set == true then
      self.control = 20
    end
  elseif self.gogo_steal_set == true and now_time >= self.gogo_timer then
    self.control = 20
    self.gogo_timer = 99999
  end
  local now_time = get_npc_time(self.npc)
  if 20 == self.control then
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, self.skill04[1])
    self.seya_timer = get_npc_time(self.npc) + 1.5
    self.control = 21
  end
  if now_time >= self.seya_timer and self.gogo_steal_set == true and 21 == self.control then
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if npc == self.npc then
    abort_magic_by_id(self.npc, 201051002)
  end
end

return M
