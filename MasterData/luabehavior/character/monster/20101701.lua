local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill01 = {
    2010170104,
    5,
    0,
    2,
    8,
    get_skill_cfg(2010170104).CastTime,
    get_skill_cfg(2010170104).AfterTime,
    0
  }
  self.skill02 = {
    2010170105,
    7,
    0,
    0,
    2,
    get_skill_cfg(2010170105).CastTime,
    get_skill_cfg(2010170105).AfterTime,
    0
  }
  self.monster_type = 2
  self.control = 0
  self.infinting_timer = 0
  self.target = nil
  self.stun_timer = 0
  self.move_timer = 0
  self.flash_skill1 = 2010170101
  self.flash_skill2 = 2010170102
  self.flash_skill3 = 2010170103
  self.flash_skill_timer = 0
  self.allow_flash = 0
  self.skill_abort_level = 0
  self.assassinate_flash1 = 2010170106
  self.assassinate_flash2 = 2010170107
  self.assassinate_flash3 = 2010170108
  self.assassinate_timer = 0
  self.allow_assassinate = 0
end

function M:on_input(input_id)
  if not self.target then
    return
  end
  if get_npc_time(self.npc) < self.start_time then
    return
  end
  if not check_npc_distance(self.npc, self.target, 4, false) then
    return
  end
  if get_npc_time(self.npc) < self.flash_skill_timer then
    return
  end
  if 15 == input_id or 17 == input_id or 18 == input_id or 19 == input_id or 20 == input_id then
    if get_npc_time(self.npc) >= self.flash_skill_timer then
      abort_skill(self.npc)
      cast_skill(self.npc, self.npc, self.flash_skill1, nil, nil)
      self.flash_skill_timer = get_npc_time(self.npc) + 5
    end
  elseif 15 ~= input_id or 17 ~= input_id or 18 ~= input_id or 19 ~= input_id or 20 ~= input_id then
    return
  end
end

function M:flash()
  local now_time = get_npc_time(self.npc)
  if not self.target then
    return
  end
  if 1 == self.allow_flash and now_time > self.move_timer then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.flash_skill2)
    enable_shadow(self.npc, false)
    set_npc_hp_visible(self.npc, false)
    self.move_timer = now_time + 2
    local pos1 = get_npc_offset_position(self.target, nil, 180, 10)
    if check_magic(self.npc, 20101701001) then
      switch_move_type(self.npc, 1)
      flash_to_pos(self.npc, pos1.x, pos1.z)
      self.move_timer = now_time + 1
    end
  elseif now_time < self.move_timer then
    return
  end
  if 2 == self.allow_flash then
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.npc, self.flash_skill3)
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(self.npc, 20101701008, 1)
    abort_magic_by_id(self.npc, 20101701009, 1)
    abort_magic_by_id(self.npc, 20101701010, 1)
    abort_magic_by_id(self.npc, 100104, 1)
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    enable_shadow(self.npc, true)
    set_npc_hp_visible(self.npc, true)
    self.allow_flash = 0
  end
  if 1 == self.allow_assassinate and now_time > self.move_timer then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.assassinate_flash2)
    enable_shadow(self.npc, false)
    set_npc_hp_visible(self.npc, false)
    self.move_timer = now_time + 2
    local pos1 = get_npc_offset_position(self.target, nil, 180, 1.5)
    if check_magic(self.npc, 20101701001) then
      switch_move_type(self.npc, 1)
      flash_to_pos(self.npc, pos1.x, pos1.z)
      self.move_timer = now_time + 1
    end
  elseif now_time < self.move_timer then
    return
  end
  if 2 == self.allow_assassinate then
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target)
    cast_skill(self.npc, self.npc, self.assassinate_flash3)
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(self.npc, 20101701008, 1)
    abort_magic_by_id(self.npc, 20101701009, 1)
    abort_magic_by_id(self.npc, 20101701010, 1)
    abort_magic_by_id(self.npc, 100104, 1)
    abort_magic_by_id(self.npc, Const.LOCK_MASK, 1)
    enable_shadow(self.npc, true)
    set_npc_hp_visible(self.npc, true)
    self.allow_assassinate = 0
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.flash_skill1 then
    self.allow_flash = 1
  end
  if skill_id == self.flash_skill2 then
    abort_magic_by_id(self.npc, 20101701001, 1)
    self.allow_flash = 2
  end
  if skill_id == self.flash_skill3 then
    cast_skill(self.npc, self.target, 2010170104)
    self.skill_abort_level = 0
    self.skill01[3] = get_npc_time(self.npc) + self.skill01[2]
  end
  if skill_id == self.assassinate_flash1 then
    self.allow_assassinate = 1
  end
  if skill_id == self.assassinate_flash2 then
    abort_magic_by_id(self.npc, 20101701001, 1)
    self.allow_assassinate = 2
  end
  if skill_id == self.assassinate_flash3 then
    cast_skill(self.npc, self.target, 2010170105)
    self.skill_abort_level = 0
    self.skill02[3] = get_npc_time(self.npc) + self.skill02[2]
    self.skill_set = 0
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
  if self.skill_abort_level >= 2 then
    return
  end
  if check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and not check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    cast_skill(self.npc, self.target, skill_instant_id[1])
    skill_instant_id[3] = now_time + skill_instant_id[2] + math.random(10, 30) / 10
    self.skill_set_time = self.now_time + math.random(50, 90) / 10
    self.skill_set = 0
  elseif check_npc_distance(self.npc, self.target, skill_instant_id[4], false) then
    if now_time > self.move_timer then
      switch_move_type(self.npc, 2)
      moveto_npc(self.npc, self.target)
      self.move_timer = now_time + 1
    end
  elseif not check_npc_distance(self.npc, self.target, skill_instant_id[5], false) and now_time > self.move_timer then
    switch_move_type(self.npc, 1)
    moveto_npc(self.npc, self.target)
    self.move_timer = now_time + 1
  end
  if now_time < self.assassinate_timer then
    return
  end
  if 2010170105 == skill_instant_id[1] and not check_npc_distance(self.npc, self.target, skill_instant_id[5], false) then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.assassinate_flash1, nil, nil)
    self.assassinate_timer = get_npc_time(self.npc) + 15
  end
end

function M:assassinate()
  local now_time = get_npc_time(self.npc)
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
  if now_time < self.skill02[3] then
    return
  end
  if check_npc_distance(self.npc, self.target, 2, false) and now_time >= self.skill02[3] then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.skill02[1], nil, nil)
    self.skill02[3] = now_time + 5
  end
end

function M:skill_main_logic()
  if self.target and 0 == self.control and not check_npc_status(self.npc, 2) and not is_cast_skill_time(self.npc) and not self.hurt_atk_state then
  else
    return
  end
  if 1 == self.skill_set then
    self:logic(self.skill01)
  elseif 2 == self.skill_set then
    self:logic(self.skill02)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
end

function M:on_frame()
  self:assassinate()
  self:flash()
  self:skill_main_logic()
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  CommonMonster.camp_main_logic(self)
  CommonMonster.attack_wander_logic(self, self.skill01, self.skill02)
  CommonMonster.skill_change_logic(self)
  CommonMonster.Hit_wall(self)
  CommonMonster.monster_on_frame(self)
  CommonMonster.platform_move(self)
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    abort_skill(self.npc, true)
  end
end

return M
