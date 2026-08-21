local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_child_mt(Base)
local atk_counting
local x, y = 0, 0
local TEMP_POS = {}
local atk_id = {
  [1] = 100100601,
  [2] = 100100602,
  [3] = 100100603,
  [4] = 100100604
}
local splash_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 4
}
local splash_indi_cfg = {
  type = 2,
  res = "Fx_skillarea_N2",
  sizex = 2,
  sizey = 2.5
}
local skill2_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 6
}
local skill2_indi_cfg = {
  type = 2,
  res = "Fx_skillarea_N2",
  sizex = 1.5,
  sizey = 3.4
}
local F_skill2_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 16
}
local F_skill2_indi_cfg = {
  type = 6,
  res = "Fx_skillarea_N2",
  sizex = 3,
  sizey = 6
}
local waycast_id = {
  [15] = 100100613,
  [19] = 100100608
}
local atk_time = {
  [100100601] = get_skill_cfg(100100601).CastTime,
  [100100602] = get_skill_cfg(100100602).CastTime,
  [100100603] = get_skill_cfg(100100603).CastTime,
  [100100604] = get_skill_cfg(100100604).CastTime
}
local splash_atk_id = {
  [1] = 100100613,
  [2] = 100100621
}
local now_splash_atk_id = 100100613
local counter_skill_id = {
  [1] = 100100605,
  [2] = 100100616
}
local skill2_id = {
  [1] = 100100608,
  [2] = 100100619
}
local now_skill2_id = 100100608
local skill3_id = {
  [1] = 100100609,
  [2] = 100100620
}
local now_skill3_id = 100100609
local skill3_id_wavewall = {
  [1] = 10010060902,
  [2] = 10010062002
}
local wave_wall_id = {
  [10010060603] = true,
  [10010060703] = true,
  [10010060902] = true,
  [10010062002] = true,
  [10010061503] = true,
  [10010061602] = true
}
local wave_id = {
  [10010060804] = true,
  [10010061904] = true
}
local wave_area_id = {
  [1] = 10010060806,
  [2] = 10010061906
}
local B_wave_check_id = {
  [10010060812] = true,
  [10010061912] = true
}
local B_wave_wall_check_id = {
  [10010060608] = true,
  [10010060708] = true,
  [10010060910] = true,
  [10010061508] = true,
  [10010062011] = true
}
local born_skill = 100100610
local skill_abort_level = 5

function M:init_data()
  atk_id = {
    [1] = 100100601,
    [2] = 100100602,
    [3] = 100100603,
    [4] = 100100604
  }
end

function M:_init(npc)
  Base._init(self, npc)
  self:init_data()
  CommonRole.role_common_init(self)
  cast_magic(npc, npc, 1001403, 1)
  self.indicator_set = 0
  self.hurt_hp = 0
  self.qte_skill = 100100615
  self.do_counter_in = 0
  self.current_hp = get_npc_attr(npc, 1)
  self.pass_live = nil
  self.pass_live_effect = nil
  self.indicator_input_timer = self.indicator_input_timer or {}
  self.death_set = 0
  self.hurt_hp = 0
  self.now_input_id = nil
  self.indi_grow_set = false
  self.touch_up_set = 1
  self.counter_loop_set = 0
  self.counter_break_set_hit = false
  self.counter_break_set = false
  self.counter_timer = 0
  self.outsider_set = false
  self.weak_set = false
  self.outsider_2 = false
  self.hard_atk_length = 0
  self.personal_set = false
  self.personal_atk_set = 0
  self.personal_castdown_layer = 0
  self.A_hitmiss = 0
  self.A_hitmiss_withhit = false
  self.A_skill2_set = false
  self.A_hardatk_set = false
  self.A_hardatk_timer = 0
  self.A_now_magic_id = 0
  self.B_damagecorrect = false
  self.D_count_times = 0
  self.D_location = {}
  self.E_ww_location = {}
  self.E_circle_location = {}
  self.A_skill2_cd_set = 0
  self.C_debuff_ab_timer = 0
  self.E_ab_set = 0
  self.F_double = false
  self.F_double_indion = false
  self.F_double_location = {}
  self.F_skill2_timer = 0
  self.F_double_skillid = 100100625
  self.F_skill2_wave = 10010062501
  self.F_skill2_wave_area = 10010062503
  self.F_ab_area_set = 0
  self.F_ab_area_location = {}
  self.F_ab_area_location_exskill = {}
  self.hard_atk_set = false
  self.hard_atk_layer = 0
  self.hard_atk_timer = 0
  self.skill3_timer = 0
  self.hard_atk_check = false
  self.press_set = false
  self.indicator_input_timer = self.indicator_input_timer or {}
  self.counter_set = 0
  self.counter_set_timer = 0
  self.self_break_timer_switch = 0
  self.self_timer_switch = 0
  self.self_break_timer = 0
  self.self_timer = 0
  self.kick_timer = 0
  self.battle_res_type = 1
  self.m_check_timer = 0
  self.m_check = false
  self.now_atk_time = 0
  self.test_set = false
end

function M:on_born_behavior()
  CommonRole.born_animation(self, born_skill)
  if self.outsider_set == false then
    local outsider_num = get_magic_num(self.npc, 1006005)
    if outsider_num >= 2 then
      now_skill3_id = skill3_id[2]
      replace_hero_skill(5, skill3_id[2])
      self.outsider_2 = true
      self.outsider_set = true
    end
  end
  if check_magic(self.npc, 1006009) then
    now_skill2_id = skill2_id[2]
    replace_hero_skill(4, skill2_id[2])
    now_splash_atk_id = splash_atk_id[2]
  end
end

function M:on_get_battle_skill(npc, magic_id)
  if npc ~= self.npc then
    return
  end
  if check_magic(self.npc, 1006009) then
    now_skill2_id = skill2_id[2]
    replace_hero_skill(4, skill2_id[2])
    now_splash_atk_id = splash_atk_id[2]
  end
end

function M:cast_counter()
  if not CommonRole.get_input(self, 18) then
    return
  end
  if get_npc_cd_charge(self.npc, counter_skill_id[1]) < get_skill_cfg(counter_skill_id[1]).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100159)
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 2 then
    return
  elseif is_cast_skill_time(self.npc, counter_skill_id[1]) then
    return
  end
  if 0 ~= self.counter_set then
    self.counter_set = 0
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  abort_skill(self.npc)
  CommonRole.role_counter_reset(self)
  local joystick_target = get_joystick_target_pos(self.npc)
  CommonRole.joystick_search_target(self)
  if self.target then
    lookat_npc(self.npc, self.target, 1)
    cast_skill(self.npc, self.target, counter_skill_id[1], nil, nil)
  else
    cast_skill(self.npc, nil, counter_skill_id[1], nil, nil)
  end
  skill_abort_level = 2
  atk_counting = 1
  self.now_atk_time = get_npc_time(self.npc)
  CommonRole.clear_input(self, 18)
end

function M:cast_atk()
  if not CommonRole.get_input(self, 15) then
    return
  end
  if self.hard_atk_set == true and 0 == self.touch_up_set then
    return
  end
  if true == self.A_hardatk_set and 0 == self.touch_up_set then
    return
  end
  if true == self.personal_set and 0 == self.touch_up_set then
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 1 or is_cast_skill_time(self.npc, counter_skill_id[1]) then
    return
  end
  local nowtime = get_npc_time(self.npc)
  if not atk_id[atk_counting] or nowtime > self.now_atk_time + 0.3 then
    if is_cast_skill_time(self.npc) or is_cast_skill_time(self.npc, counter_skill_id[1]) then
      return
    end
    atk_counting = 1
    abort_skill(self.npc)
    CommonRole.skill_setting(self)
    skill_abort_level = 1
    self:do_cast_atk()
  elseif nowtime > self.now_atk_time then
    abort_skill(self.npc)
    CommonRole.skill_setting(self)
    skill_abort_level = 1
    self:do_cast_atk()
  end
end

function M:do_cast_atk()
  cast_skill(self.npc, self.target, atk_id[atk_counting], nil, nil)
  self.now_atk_time = get_npc_time(self.npc) + atk_time[atk_id[atk_counting]]
  atk_counting = atk_counting + 1
  CommonRole.clear_input(self, 15)
end

function M:hard_atk()
  if self.hard_atk_check == true and self.hard_atk_layer <= 0 then
    return
  end
  if self.hard_atk_check ~= true and true ~= self.A_hardatk_set and self.personal_set == false then
    return
  end
  if 0 == self.indicator_set then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  if is_cast_skill_time(self.npc, 100100608) or is_cast_skill_time(self.npc, 100100619) then
    return
  elseif is_cast_skill_time(self.npc) and skill_abort_level > 5 then
    return
  end
  if 0 ~= self.counter_set then
    self.counter_set = 0
  end
  abort_skill(self.npc)
  CommonRole.joystick_search_target(self)
  TEMP_POS = get_npc_pos(self.npc)
  if not check_magic(self.npc, 1006009) then
    change_missile_config(10010061301, "SizeX", self.hard_atk_length * 0.9, 0)
    change_missile_config(10010061302, "SizeX", self.hard_atk_length + 0.8, 0)
  else
    change_missile_config(10010062101, "SizeX", self.hard_atk_length * 0.9, 0)
    change_missile_config(10010062102, "SizeX", self.hard_atk_length + 0.8, 0)
  end
  lookat_position(self.npc, x, y, true)
  cast_skill(self.npc, nil, now_splash_atk_id, x, y)
  skill_abort_level = 6
  CommonRole.clear_input(self, 15)
  self.indicator_set = 0
  if self.hard_atk_check == true then
    self.hard_atk_layer = self.hard_atk_layer - 1
    self.hard_atk_check = false
  elseif true == self.A_hardatk_set then
    self.A_hardatk_set = false
    self.A_skill2_cd_set = 0
    stop_ui_fight_button_effect({
      "Strengthen_skill_1",
      1
    })
  elseif check_magic(self.npc, 1006008) then
    abort_magic_by_id(self.npc, 1006008)
    self.personal_atk_set = 4
    self.personal_set = false
    stop_ui_fight_button_effect({
      "Strengthen_skill_1",
      1
    })
  end
  self.press_set = false
end

function M:cast_skill2()
  if self.F_double == true then
    return
  end
  if 0 == self.indicator_set then
    return
  end
  if get_magic_num(self.npc, 1006006) >= 1 and 0 == self.A_skill2_cd_set and get_npc_cd_charge(self.npc, now_skill2_id) >= get_skill_cfg(now_skill2_id).CdChargePerCost and self.A_hardatk_set == false then
    self.A_hardatk_timer = get_npc_time(self.npc) + 6.5
    cast_magic(self.npc, self.npc, 1006017, 0)
    self.A_hardatk_set = true
    self.A_skill2_cd_set = 1
  end
  if true == self.hard_atk_check then
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 3 then
    return
  elseif is_cast_skill_time(self.npc, counter_skill_id[1]) and false == self.counter_break_set then
    return
  end
  if get_npc_cd_charge(self.npc, now_skill2_id) < get_skill_cfg(now_skill2_id).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100160)
    self.indicator_set = 0
    return
  end
  local now_energy = get_npc_attr(self.npc, 72) + get_npc_temp_blue(self.npc)
  if now_energy < CommonRole.battle_res_cost(self, self.battle_res_type, now_skill2_id) then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100160)
    self.indicator_set = 0
    return
  end
  abort_skill(self.npc)
  CommonRole.role_counter_reset(self)
  if 0 ~= self.counter_set then
    self.counter_set = 0
  end
  CommonRole.joystick_search_target(self)
  if self.target and check_npc_distance(self.npc, self.target, 12, 0) then
    lookat_npc(self.npc, self.target, 1)
  end
  TEMP_POS = get_npc_pos(self.npc)
  if true == self.press_set then
    lookat_position(self.npc, x, y, 1)
    cast_skill(self.npc, nil, now_skill2_id, x, y)
  else
    cast_skill(self.npc, self.target, now_skill2_id, nil, nil)
  end
  if check_magic(self.npc, 1006012) and self.F_double == false then
    self.F_double_indion = true
  end
  skill_abort_level = 4
  CommonRole.clear_input(self, 19)
  self.indicator_set = 0
  self.press_set = false
end

function M:F_double_skill2()
  if self.F_double == false then
    return
  end
  local now_time = get_npc_time(self.npc)
  if now_time >= self.F_skill2_timer then
    self.F_double = false
    clear_skill_btn_charging(19)
    CommonRole.clear_input(self, 19)
    set_indicator_active(19, false)
    self.press_set = false
    self.indicator_set = 0
    replace_hero_skill(4, now_skill2_id)
    return
  elseif now_time < self.F_skill2_timer - 4.8 then
    return
  end
  if 0 == self.indicator_set then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  TEMP_POS = get_npc_pos(self.npc)
  if self.press_set == true then
    if true == self.outsider_set then
      change_missile_config(self.F_skill2_wave_area, "magic", {1006014}, 0)
      cast_missile(self.npc, nil, self.F_double_location.x, self.F_double_location.z, self.F_skill2_wave, 1, x, y)
      cast_magic(self.npc, self.npc, 1006008, 1)
    else
      cast_missile(self.npc, nil, self.F_double_location.x, self.F_double_location.z, self.F_skill2_wave, 1, x, y)
      cast_magic(self.npc, self.npc, 1006008, 1)
    end
  elseif true == self.outsider_set then
    change_missile_config(self.F_skill2_wave_area, "magic", {1006014}, 0)
    cast_missile(self.npc, nil, self.F_double_location.x, self.F_double_location.z, self.F_skill2_wave, 1)
    cast_magic(self.npc, self.npc, 1006008, 1)
  else
    cast_missile(self.npc, nil, self.F_double_location.x, self.F_double_location.z, self.F_skill2_wave, 1)
    cast_magic(self.npc, self.npc, 1006008, 1)
  end
  self.F_double = false
  self.F_double_location.x = nil
  self.F_double_location.z = nil
  clear_skill_btn_charging(19)
  CommonRole.clear_input(self, 19)
  self.press_set = false
  self.indicator_set = 0
  replace_hero_skill(4, now_skill2_id)
end

function M:cast_skill3()
  if not CommonRole.get_input(self, 20) then
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 4 then
    return
  end
  if get_npc_cd_charge(self.npc, now_skill3_id) < get_skill_cfg(now_skill3_id).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100161)
    return
  end
  local now_energy = get_npc_attr(self.npc, 72) + get_npc_temp_blue(self.npc)
  if check_magic(self.npc, 1006015) then
    if now_energy < CommonRole.battle_res_cost(self, self.battle_res_type, now_skill3_id) * (1 - self.personal_castdown_layer * 0.1) then
      CommonRole.magic_with_check(self, self.npc, self.npc, 100161)
      self.indicator_set = 0
      return
    end
  elseif now_energy < CommonRole.battle_res_cost(self, self.battle_res_type, now_skill3_id) then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100161)
    self.indicator_set = 0
    return
  end
  if 0 ~= self.counter_set then
    self.counter_set = 0
  end
  CommonRole.role_counter_reset(self)
  abort_skill(self.npc)
  clear_input()
  CommonRole.joystick_search_target(self)
  if self.target and check_npc_distance(self.npc, self.target, 12, 0) then
    lookat_npc(self.npc, self.target, 1)
  end
  cast_skill(self.npc, self.target, now_skill3_id, nil, nil)
  self.skill3_timer = get_npc_time(self.npc) + 13
  skill_abort_level = 5
  atk_counting = 1
  CommonRole.clear_input(self, 20)
end

function M:on_npc_beattack_collider(npc, hero, collider_npc)
  if hero ~= self.npc then
    return
  end
  if nil ~= collider_npc then
    return
  end
  if check_npc_status(npc, 10) and check_magic(npc, 1006002) then
    cast_missile(self.npc, npc, nil, nil, 10010061202, 1)
    abort_magic_by_id(npc, 1006002)
    if check_magic(npc, 1006201) then
      abort_magic_by_id(npc, 1006201)
    end
  end
end

function M:on_magic_end(npc, target, magic_id)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  Base.on_skill_begin(self, npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  CommonRole.battlesetting_camera_focus(self, skill_type)
  if skill_id == born_skill or skill_id == skill3_id[1] or skill_id == skill3_id[2] then
    set_ui_object_visible("fight", "Main", false)
  end
  if 0 ~= self.A_hitmiss and 3 == skill_type then
    self.A_skill2_set = true
  end
  if 3 == skill_type then
    cast_magic(self.npc, self.npc, 1006903, 1)
  elseif 4 == skill_type and check_magic(self.npc, 1006015) then
    cast_magic(self.npc, self.npc, 1006906, self.personal_castdown_layer)
    abort_magic_by_id(self.npc, 1006015)
    self.personal_castdown_layer = 0
  elseif 4 == skill_type then
    cast_magic(self.npc, self.npc, 1006904, 1)
  end
  if skill_id == now_splash_atk_id and check_magic(self.npc, 1006119) then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.skill3_timer then
      abort_magic_by_id(self.npc, 1006119, 1)
    end
  end
  local F_magic_num = get_magic_num(self.npc, 1006012)
  for key, value in pairs(skill2_id) do
    if skill_id == value then
      if true == self.outsider_2 then
        if skill_id == skill2_id[1] then
          change_missile_config(wave_area_id[1], "magic", {1006014}, 0)
        elseif skill_id == skill2_id[2] then
          change_missile_config(wave_area_id[2], "magic", {1006014}, 0)
        end
      elseif F_magic_num >= 2 then
        if skill_id == skill2_id[1] then
          change_missile_config(wave_area_id[1], "magic", {1006601}, 0)
        elseif skill_id == skill2_id[2] then
          change_missile_config(wave_area_id[2], "magic", {1006601}, 0)
        end
      elseif true == self.outsider_2 and F_magic_num >= 2 then
        if skill_id == skill2_id[1] then
          change_missile_config(wave_area_id[1], "magic", {1006601, 1006014}, 0)
        elseif skill_id == skill2_id[2] then
          change_missile_config(wave_area_id[2], "magic", {1006601, 1006014}, 0)
        end
      end
    end
  end
  if skill_id == self.F_double_skillid then
    change_missile_config(10010061906, "magic", {1006112, 1006014}, 0)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if check_magic(self.npc, 1006703) and missile_cfg.magic[4] == 1006002 and self.B_damagecorrect == false then
    self.B_damagecorrect = true
  end
  if hit_target == self.npc and npc ~= self.npc and check_magic(self.npc, 1006001) then
    CommonRole.common_counter(self, self.npc, hit_target, hit_type, missile_cfg)
    if not self.target then
      return
    end
    if not check_magic(self.npc, 1006102) then
      self.counter_loop_set = 1
      cast_magic(self.npc, self.npc, 1006102, 0)
      self.counter_timer = get_npc_time(self.npc) + 0.6
      self.counter_set = 1
    end
    local target_distance = check_npc_distance(self.npc, npc, 3, true)
    CommonRole.joystick_search_target(self)
    lookat_npc(self.npc, self.target, 1)
  end
  if missile_cfg.Id == 10010061601 then
    local E_magic_num = get_magic_num(self.npc, 1006011)
    local now_time = get_npc_time(self.npc)
    if check_magic(self.npc, 1006011) then
      cast_missile(self.npc, nil, self.E_ww_location.x, self.E_ww_location.z, 10010062402, 1)
    end
    if check_magic(self.npc, 1006012) then
      cast_missile(self.npc, hit_target, nil, nil, 10010062201, 1)
    end
  end
  local check_wavewall_id = wave_wall_id[missile_cfg.Id]
  if check_wavewall_id then
    if npc == self.npc and check_magic(hit_target, 1006101) and missile_cfg.magic[1] ~= 1006111 and missile_cfg.magic[1] ~= 1006502 and missile_cfg.magic[1] ~= 1006114 then
      abort_magic_by_id(hit_target, 1006101)
    end
    if check_npc_status(hit_target, 10) and check_magic(hit_target, 1006002) then
      cast_missile(self.npc, hit_target, nil, nil, 10010061201, 1)
      abort_magic_by_id(hit_target, 1006002)
      abort_magic_by_id(npc, 1006002)
      if check_magic(self.npc, 1006012) then
        cast_missile(self.npc, hit_target, nil, nil, 10010062201, 1)
      end
      if check_magic(self.npc, 1006011) then
        if missile_cfg.magic[3] == 1006120 then
          cast_missile(self.npc, nil, self.E_circle_location.x, self.E_circle_location.z, 10010062404, 1)
          if check_magic(self.npc, 1006010) and self.D_count_times < 9 then
            self.D_count_times = self.D_count_times + 1
          end
        else
          cast_missile(self.npc, nil, self.E_ww_location.x, self.E_ww_location.z, 10010062402, 1)
        end
      end
      if check_magic(hit_target, 1006201) then
        abort_magic_by_id(hit_target, 1006201)
      end
      if check_magic(self.npc, 1006010) and true == self.hard_atk_set and missile_cfg.magic[3] == 1006120 and self.D_count_times < 9 then
        self.D_count_times = self.D_count_times + 1
      end
    end
  end
end

function M:on_skill_end(npc, skill_id)
  Base.on_skill_end(self, npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == born_skill or skill_id == skill3_id[1] or skill_id == skill3_id[2] then
    set_ui_object_visible("fight", "Main", true)
  end
  if skill_id == skill3_id[1] or skill_id == skill3_id[2] then
    cast_magic(self.npc, self.npc, 1006017, 0)
  end
  for id, value in pairs(skill2_id) do
    if skill_id == value and self.A_hardatk_set == true then
      cast_magic(self.npc, self.npc, 1006119, 1)
    end
  end
  if skill_id == counter_skill_id[2] then
    self.counter_set = 0
  end
  if skill_id == counter_skill_id[1] and true == self.counter_break_set then
    self.counter_break_set = false
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == born_skill or skill_id == skill3_id[1] or skill_id == skill3_id[2] then
    set_ui_object_visible("fight", "Main", true)
  end
  if skill_id == skill3_id[1] or skill_id == skill3_id[2] then
    cast_magic(self.npc, self.npc, 1006017, 0)
  end
  if skill_id == counter_skill_id[2] then
    self.counter_set = 0
  end
  if 2 == self.counter_loop_set then
    self.counter_loop_set = 0
  end
  if skill_id == counter_skill_id[1] and self.counter_break_set == true then
    self.counter_break_set = false
  end
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  if owner ~= self.npc or 10 == missile_cfg.IsReceive then
  end
  if 2 == missile_cfg.IsReceive and is_cast_skill_time(self.npc, counter_skill_id[1]) then
    self.counter_break_set = true
  end
  if self.pass_live == nil then
    if 1 == missile_cfg.IsReceive or 8 == missile_cfg.IsReceive then
      self.pass_live = missile
    end
  elseif self.pass_live and (1 == missile_cfg.IsReceive or 8 == missile_cfg.IsReceive) then
    remove_missile(self.pass_live)
    self.pass_live = missile
  end
  if 7 == missile_cfg.IsReceive and nil == self.pass_live_effect then
    self.pass_live_effect = missile
  elseif 7 == missile_cfg.IsReceive and self.pass_live_effect then
    remove_missile(self.pass_live_effect)
    self.pass_live_effect = missile
  end
  if check_magic(self.npc, 1006007) and (2 == missile_cfg.IsReceive or 4 == missile_cfg.IsReceive) then
    cast_magic(self.npc, self.npc, 1006015, 1)
    self.personal_castdown_layer = get_magic_num(self.npc, 1006015)
  end
  local F_magic_num = get_magic_num(self.npc, 1006012)
  if F_magic_num >= 1 and 1 == missile_cfg.IsReceive and true == self.F_double then
    self.F_double_location.x = pos_x
    self.F_double_location.z = pos_z
  end
  if F_magic_num >= 2 and 1 == missile_cfg.IsReceive and 0 == self.F_ab_area_set then
    self.F_ab_area_location.x = pos_x
    self.F_ab_area_location.z = pos_z
    self.F_ab_area_set = 1
  elseif F_magic_num >= 2 and 6 == missile_cfg.IsReceive and 0 == self.F_ab_area_set then
    self.F_ab_area_location_exskill.x = pos_x
    self.F_ab_area_location_exskill.z = pos_z
    self.F_ab_area_set = 2
  end
  if 3 == missile_cfg.IsReceive then
    for id, value in pairs(skill3_id_wavewall) do
      if missile_cfg.Id == value and self.hard_atk_set == false then
        cast_magic(self.npc, self.npc, 1006119, 1)
        self.hard_atk_set = true
        self.hard_atk_layer = 1
        self.hard_atk_timer = get_npc_time(self.npc) + 3
      end
    end
  end
  if check_magic(self.npc, 1006011) then
    if 2 == missile_cfg.IsReceive then
      self.E_ww_location.x = pos_x
      self.E_ww_location.z = pos_z
    elseif 3 == missile_cfg.IsReceive then
      self.E_circle_location.x = pos_x
      self.E_circle_location.z = pos_z
    end
  end
  if check_magic(self.npc, 1006010) and 3 == missile_cfg.IsReceive then
    self.D_location.x = pos_x
    self.D_location.z = pos_z
    self.D_count_times = 0
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  local F_magic_num = get_magic_num(self.npc, 1006012)
  if F_magic_num >= 1 and 1 == missile_cfg.IsReceive then
    self.F_double_indion = false
    self.F_double_location.x = pos_x
    self.F_double_location.z = pos_z
  end
  if 3 == missile_cfg.IsReceive and self.D_count_times > 0 then
    local function element_give(element_ab_magicid)
      local id_count = element_ab_magicid + self.D_count_times
      
      change_missile_config(10010063201, "magic", {id_count}, 0)
    end
    
    if check_magic(self.npc, 1006010) then
      element_give(1006603)
    end
    cast_missile(self.npc, nil, self.D_location.x, self.D_location.z, 10010063201, 1)
  end
  if 3 == missile_cfg.IsReceive then
    for id, value in pairs(skill3_id_wavewall) do
      if missile_cfg.Id == value and self.hard_atk_set == true then
        abort_magic_by_id(self.npc, 1006119)
        stop_ui_fight_button_effect({
          "Strengthen_skill_1",
          1
        })
        self.hard_atk_layer = 0
        self.hard_atk_check = false
      end
    end
  end
  local F_magic_num = get_magic_num(self.npc, 1006012)
  if F_magic_num >= 2 and 0 ~= self.F_ab_area_set and (1 == missile_cfg.IsReceive or 6 == missile_cfg.IsReceive) then
    self.F_ab_area_set = 0
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if self.personal_atk_set > 0 then
    cast_magic(self.npc, self.npc, 1006203, 1)
    self.personal_atk_set = self.personal_atk_set - 1
  end
  if 1 == self.A_hitmiss and (1006331 == magic_id or 1006332 == magic_id) and self.A_skill2_set == true then
    cast_magic(self.npc, self.npc, 1006202, 1)
    abort_magic_by_id(target, 1006201)
    self.A_hitmiss = 2
    self.A_now_magic_id = magic_id
    self.A_skill2_set = false
  end
  if 2 == self.A_hitmiss and magic_id ~= self.A_now_magic_id and self.A_skill2_set == true then
    cast_magic(self.npc, self.npc, 1006202, 1)
    abort_magic_by_id(target, 1006201)
    self.A_hitmiss = 0
    self.A_now_magic_id = 0
    self.A_skill2_set = false
  end
  if check_magic(target, 1006703) and true == self.B_damagecorrect then
    cast_magic(self.npc, self.npc, 1006704, 1)
  end
  if 1006602 == magic_id then
    cast_magic(self.npc, self.npc, 1006603, self.D_count_times)
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc then
    CommonRole.hit_screen_effect(self)
  end
  if 1006331 == magic_id and check_magic(self.npc, 1006005) then
    local monster_list_003 = search_npc(self.npc, 4, 20, 1006003, 1, true)
    local monster_list_004 = search_npc(self.npc, 4, 20, 1006004, 1, true)
    local monster_num_003 = #monster_list_003
    local monster_num_004 = #monster_list_004
    if monster_num_003 < 2 and 0 == monster_num_004 then
      cast_magic(self.npc, target, 1006003, 1)
    elseif monster_num_003 >= 2 and 0 == monster_num_004 then
      for i, v in pairs(monster_list_003) do
        cast_magic(self.npc, v, 1006004, 1)
      end
      cast_magic(self.npc, target, 1006004, 1)
    elseif monster_num_004 <= 2 and 0 == monster_num_003 then
      for i, v in pairs(monster_list_004) do
        cast_magic(self.npc, v, 1006003, 1)
      end
      cast_magic(self.npc, target, 1006003, 1)
    elseif monster_num_004 > 2 then
      cast_magic(self.npc, target, 1006004, 1)
    else
      cast_magic(self.npc, target, 1006003, 1)
    end
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner ~= self.npc then
    return
  end
  Base.on_missile_collide(self, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if 3 == m1_cfg.MissileTypeTag and 0 == self.counter_set and not check_magic(self.npc, 1006102) then
    self.counter_loop_set = 1
    cast_magic(self.npc, self.npc, 1006102, 1)
    cast_magic(self.npc, self.npc, 1006124, 1)
    self.counter_timer = get_npc_time(self.npc) + 0.6
    self.counter_set = 1
  end
  local B_magic_num = get_magic_num(self.npc, 1006013)
  if 3 == B_magic_num and m1_cfg.magic[4] == 1006402 and 0 ~= m2_cfg.LineType and 5 ~= m2_cfg.LineType then
    if m2_cfg.Id == 2010210201 then
      return
    else
      remove_missile(m2)
    end
  end
end

function M:effect_aborn_magic(npc, target, element)
  if target == self.npc then
    return
  end
  local C_magic_num = get_magic_num(self.npc, 1006009)
  if check_magic(target, 1006404) and C_magic_num >= 2 then
    if 2 == element then
      cast_magic(self.npc, target, 1999010, 1)
    elseif 3 == element then
      cast_magic(self.npc, target, 1999020, 1)
    elseif 4 == element then
      cast_magic(self.npc, target, 1999030, 1)
    elseif 5 == element then
      cast_magic(self.npc, target, 1999040, 1)
    elseif 6 == element then
      cast_magic(self.npc, target, 1999050, 1)
    end
  end
  if 1 == self.F_ab_area_set then
    cast_missile(self.npc, nil, self.F_ab_area_location.x, self.F_ab_area_location.z, 10010062505, 1)
    self.F_ab_area_set = 0
  elseif 2 == self.F_ab_area_set then
    cast_missile(self.npc, nil, self.F_ab_area_location.x, self.F_ab_area_location.z, 10010062506, 1)
    self.F_ab_area_set = 0
  end
end

function M:grey_mask()
  local now_energy = get_npc_attr(self.npc, 72) + get_npc_temp_blue(self.npc)
  if now_energy < CommonRole.battle_res_cost(self, self.battle_res_type, now_skill2_id) then
    play_ui_fight_button_effect({
      "gray",
      nil,
      now_skill2_id,
      1
    })
  elseif now_energy >= CommonRole.battle_res_cost(self, self.battle_res_type, now_skill2_id) then
    play_ui_fight_button_effect({
      "gray",
      nil,
      now_skill2_id,
      0
    })
  end
  if check_magic(self.npc, 1006015) then
    if now_energy < CommonRole.battle_res_cost(self, self.battle_res_type, now_skill3_id) * (1 - self.personal_castdown_layer * 0.1) then
      play_ui_fight_button_effect({
        "gray",
        nil,
        now_skill3_id,
        1
      })
    elseif now_energy >= CommonRole.battle_res_cost(self, self.battle_res_type, now_skill3_id) * (1 - self.personal_castdown_layer * 0.1) then
      play_ui_fight_button_effect({
        "gray",
        nil,
        now_skill3_id,
        0
      })
    end
  elseif now_energy < CommonRole.battle_res_cost(self, self.battle_res_type, now_skill3_id) then
    play_ui_fight_button_effect({
      "gray",
      nil,
      now_skill3_id,
      1
    })
  elseif now_energy >= CommonRole.battle_res_cost(self, self.battle_res_type, now_skill3_id) then
    play_ui_fight_button_effect({
      "gray",
      nil,
      now_skill3_id,
      0
    })
  end
end

function M:on_frame()
  Base.on_frame(self)
  local now_time = get_npc_time(self.npc)
  for id, value in pairs(self.indicator_input_timer) do
    if 15 ~= id or self.hard_atk_set == true or true == self.A_hardatk_set or true == self.personal_set then
    else
      self.indicator_input_timer[id] = nil
      return
    end
    if now_time > self.indicator_input_timer[id] then
      self:on_press(id)
      self.press_set = true
      self.indicator_input_timer[id] = nil
    end
  end
  if check_magic(self.npc, 1006007) and check_magic(self.npc, 1006008) then
    cast_magic(self.npc, self.npc, 1006119, 1)
    cast_magic(self.npc, self.npc, 1006017, 0)
    self.personal_set = true
  end
  local now_time = get_npc_time(self.npc)
  if 0 ~= self.counter_set then
    local now_my_status = check_npc_status(self.npc, 1)
    if not now_my_status then
      self.counter_set = 0
    end
  end
  if self.hard_atk_set == true then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.hard_atk_timer then
      self.hard_atk_layer = self.hard_atk_layer + 1
      self.hard_atk_timer = now_time + 3
    end
    if now_time >= self.skill3_timer then
      self.hard_atk_layer = 0
      set_indicator_active(15, false)
      self.hard_atk_set = false
      self.press_set = false
    end
  end
  if true == self.A_hardatk_set then
    local now_time = get_npc_time(self.npc)
    if now_time >= self.A_hardatk_timer then
      if check_magic(self.npc, 1006119) then
        abort_magic_by_id(self.npc, 1006119)
      end
      set_indicator_active(15, false)
      self.A_hardatk_set = false
      splash_area.sizex = 4
      splash_indi_cfg.sizey = 2.3
      self.A_skill2_cd_set = 0
      self.press_set = false
      self.indi_grow_set = false
      stop_ui_fight_button_effect({
        "Strengthen_skill_1",
        1
      })
    end
  end
  if true == self.indi_grow_set and splash_area.sizex <= 5.9 then
    splash_area.sizex = splash_area.sizex + 0.1
    splash_indi_cfg.sizey = splash_indi_cfg.sizey + 0.055
  end
  CommonRole.role_common_on_frame(self)
  self:grey_mask()
end

function M:on_frame_background()
  Base.on_frame_background(self)
end

function M:on_press(input_id)
  if not waycast_id[input_id] then
    return
  end
  local now_npc_time = get_npc_time(self.npc)
  local now_cd_charge = get_npc_cd_charge(self.npc, waycast_id[input_id])
  if input_id ~= self.now_input_id then
    return
  end
  if 19 == input_id and self.F_double == true then
    if self.target and check_npc_distance(self.npc, self.target, 12, 0) then
      update_skill_indicator(input_id, F_skill2_area, F_skill2_indi_cfg, 0.5)
      set_indicator_active(input_id, true, true, self.F_double_location.x, self.F_double_location.z)
    else
      update_skill_indicator(input_id, F_skill2_area, F_skill2_indi_cfg, 0.5)
      set_indicator_active(input_id, true, false, self.F_double_location.x, self.F_double_location.z)
    end
  elseif 19 == input_id and self.F_double == false then
    if get_npc_attr(self.npc, 72) < CommonRole.battle_res_cost(self, self.battle_res_type, now_skill2_id) then
      return
    end
    local now_cd_charge = get_npc_cd_charge(self.npc, waycast_id[input_id])
    if now_cd_charge < get_skill_cfg(waycast_id[input_id]).CdChargePerCost then
      return
    end
    if self.target and check_npc_distance(self.npc, self.target, 6, 0) then
      update_skill_indicator(input_id, skill2_area, skill2_indi_cfg, 0.5)
      set_indicator_active(input_id, true, true)
    else
      update_skill_indicator(input_id, skill2_area, skill2_indi_cfg, 0.5)
      set_indicator_active(input_id, true, false)
    end
  end
  
  local function splash_indi_par(input_id)
    if self.target and check_npc_distance(self.npc, self.target, 3, 0) then
      update_skill_indicator(input_id, splash_area, splash_indi_cfg, 0.5)
      set_indicator_active(input_id, true, true)
      self.indi_grow_set = true
    else
      update_skill_indicator(input_id, splash_area, splash_indi_cfg, 0.5)
      set_indicator_active(input_id, true, false)
      self.indi_grow_set = true
    end
  end
  
  if 15 == input_id and self.hard_atk_set == true and self.hard_atk_layer > 0 then
    splash_indi_par(input_id)
  end
  if self.hard_atk_set == true then
    return
  elseif 15 == input_id and true == self.A_hardatk_set then
    splash_indi_par(input_id)
  end
  if self.hard_atk_set == true or true == self.A_hardatk_set then
    return
  elseif 15 == input_id and true == self.personal_set then
    splash_indi_par(input_id)
  end
end

function M:on_hero_showup_or_back(npc, is_showup)
  Base.on_hero_showup_or_back(self, npc, is_showup)
  if npc == self.npc and false == is_showup then
    clear_skill_btn_charging(19)
    replace_hero_skill(19, now_skill2_id)
    CommonRole.role_counter_reset(self)
    stop_ui_fight_button_effect({
      "Strengthen_skill_1",
      1
    })
  end
  if npc == self.npc and true == is_showup then
    self.indicator_set = 0
    update_skill_indicator(19, skill2_area, skill2_indi_cfg, 0.5)
    update_skill_indicator(15, splash_area, splash_indi_cfg, 0.5)
    if true == self.hard_atk_set or true == self.A_hardatk_set or true == self.personal_set then
      cast_magic(self.npc, self.npc, 1006017, 1)
    end
  end
end

function M:on_input(input_id)
  if 15 == input_id or 19 == input_id then
    if self.now_input_id == nil then
      self.now_input_id = input_id
    elseif 21 == self.now_input_id or 22 == self.now_input_id then
      self.now_input_id = input_id
    end
  end
  if self.press_set == true and input_id ~= self.now_input_id then
    return
  end
  CommonRole.role_common_on_input(self, input_id)
  self.touch_up_set = 0
  local now_time = get_npc_time(self.npc)
  if self.press_set == false and 15 == input_id and 1 == self.counter_set and not is_cast_skill_time(self.npc, counter_skill_id[2]) and CommonRole.counter_out_check(self) then
    CommonRole.counter_out(self)
    abort_skill(self.npc)
    abort_magic_by_id(self.npc, 1006102)
    abort_magic_by_id(self.npc, 1006103)
    CommonRole.role_counter_reset(self)
    if self.target then
      lookat_npc(self.npc, self.target, 1)
      cast_skill(self.npc, self.target, counter_skill_id[2], 1)
    else
      cast_skill(self.npc, nil, counter_skill_id[2], 1)
    end
    cast_magic(self.npc, self.npc, 1006123, 1)
  end
  self.indicator_input_timer[input_id] = get_npc_time(self.npc) + 0.15
  self.now_input_id = input_id
end

function M:on_touch_up(input_id, iscancle)
  self.touch_up_set = 1
  self.indicator_input_timer[input_id] = nil
  if 22 == self.now_input_id or 21 == self.now_input_id then
    self.now_input_id = nil
  end
  if check_npc_status(self.npc, 2) then
    self.press_set = false
    return
  end
  if self.press_set == true and input_id ~= self.now_input_id then
    self.press_set = false
    self.now_input_id = nil
    clear_input()
    return
  end
  if true == iscancle then
    self.press_set = false
    self.now_input_id = nil
    self.indi_grow_set = false
    splash_area.sizex = 4
    splash_indi_cfg.sizey = 2.3
  end
  if 15 == input_id and self.press_set == true then
    set_indicator_active(input_id, false)
    x, y = get_indicator_pos(input_id)
  elseif 19 == input_id and self.press_set == true then
    set_indicator_active(input_id, false)
    x, y = get_indicator_pos(input_id)
  end
  if input_id ~= self.now_input_id then
    return
  end
  
  local function hard_atk_common()
    self.indicator_set = 1
    self.indi_grow_set = false
    self.hard_atk_length = splash_indi_cfg.sizey
    splash_area.sizex = 4
    splash_indi_cfg.sizey = 2.3
    self:hard_atk()
    self.now_input_id = nil
  end
  
  if 15 == input_id and self.press_set == true and false == iscancle and true == self.hard_atk_set and self.hard_atk_layer > 0 and true == self.indi_grow_set then
    if not is_cast_skill_time(self.npc, now_splash_atk_id) then
      self.hard_atk_check = true
      hard_atk_common()
    end
  elseif 15 == input_id and self.press_set == true and false == iscancle and true == self.A_hardatk_set then
    hard_atk_common()
  elseif 15 == input_id and self.press_set == true and true == self.personal_set then
    hard_atk_common()
  elseif 15 == input_id and false == iscancle then
    self.now_input_id = nil
    self.press_set = false
  elseif 19 == input_id and false == iscancle and self.press_set == true then
    self.indicator_set = 1
    self.now_input_id = nil
  elseif 19 == input_id and true == self.F_double and false == iscancle and self.press_set == true then
    self.indicator_set = 1
    self.now_input_id = nil
  elseif 19 == input_id and true == self.F_double and false == iscancle and self.press_set == false then
    if not self.F_double_location.x then
      self.indicator_set = 1
    elseif check_npc_distance_to_pos(self.npc, self.F_double_location.x, self.F_double_location.z, 8, true) then
      self.indicator_set = 1
      self.now_input_id = nil
    end
  elseif 19 == input_id and false == iscancle and false == self.F_double_indion then
    self.indicator_set = 1
    self.now_input_id = nil
    self.press_set = false
  elseif 19 == input_id and false == iscancle and false == self.F_double and true == self.F_double_indion and self.press_set == false then
    self.indicator_set = 1
    self.now_input_id = nil
  elseif self.press_set == true and true == iscancle then
    self.now_input_id = nil
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    abort_skill(self.npc, 1)
    clear_input()
  end
end

function M:on_hero_reborn(reborned_hero)
  Base.on_hero_reborn(self, reborned_hero)
  if reborned_hero ~= self.npc then
    return
  end
  set_ui_object_visible("fight", "Btn_skill4", true)
  cast_magic(self.npc, self.npc, 1001403, 1)
  self.press_set = false
  self.counter_loop_set = 0
end

function M:on_npc_removed(npc)
  CommonRole.role_common_on_npc_removed(self, npc)
end

function M:on_npc_hp_zero(npc)
  if npc ~= self.npc then
    return
  end
  self:init_data()
  back_to_scene_camera(true)
  CommonRole.on_dead_hero_common(self)
  set_ui_object_visible("fight", "Btn_skill4", true)
  set_ui_object_visible("fight", "Btn_skill5", true)
  create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 10)
  set_npc_dead(self.npc, "die1", false)
end

return M
