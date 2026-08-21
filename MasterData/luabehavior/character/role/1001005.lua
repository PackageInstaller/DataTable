local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_child_mt(Base)
local atk_counting
local atk_base_counting = 1
local skill2_counting
local counter_skill_count = 3
local atk_id = {
  [1] = 100100501,
  [2] = 100100502,
  [3] = 100100503,
  [4] = 100100504,
  [11] = 100100505
}
local atk_time = {
  [100100501] = get_skill_cfg(100100501).CastTime,
  [100100502] = get_skill_cfg(100100502).CastTime,
  [100100503] = get_skill_cfg(100100503).CastTime,
  [100100504] = get_skill_cfg(100100504).CastTime
}
local counter_skill_id = {
  [1] = 100100506,
  [2] = 100100508,
  [3] = 100100509
}
local skill2_id = {
  [1] = 100100510
}
local skill3_id = {
  [1] = 100100513,
  [2] = 100100514,
  [3] = 100100515,
  [4] = 100100518,
  [5] = 100100520,
  [6] = 100100521,
  [7] = 100100522,
  [8] = 100100523,
  [9] = 100100524,
  [10] = 100100525,
  [11] = 100100526,
  [12] = 100100527,
  [13] = 100100528,
  [14] = 100100529,
  [15] = 100100530
}
local snipe_count_id = {
  [0] = 100100513,
  [1] = 100100520,
  [2] = 100100521,
  [3] = 100100522,
  [4] = 100100523,
  [5] = 100100524,
  [6] = 100100525,
  [7] = 100100526,
  [8] = 100100527,
  [9] = 100100528,
  [10] = 100100529
}
local qte_id = 100100519
local exskill_energy_cost = {100}
local born_skill = 100100516
local skill_abort_level = 4
local x, y
local skill1_area = {
  type = 1,
  res = "FX_text_kong",
  sizex = 10
}
local skill1_indi_cfg = {
  type = 2,
  res = "Fx_skillarea_N2",
  sizex = 1,
  sizey = 3
}
local skill2_area = {
  type = 1,
  res = "FX_text_kong",
  sizex = 10
}
local skill2_indi_cfg = {
  type = 2,
  res = "Fx_skillarea_N2",
  sizex = 1,
  sizey = 5
}
local skill3_area = {
  type = 1,
  res = "Fx_H101005_exskill_2_1",
  sizex = 22
}
local skill3_indi_cfg = {
  type = 4,
  res = "Fx_H101005_exskill_2_6",
  sizex = 1
}
local skill3_lock_cfg = {
  tar_camp = 4,
  range_ratio = 0.2,
  lerp_ratio = 0.2
}
local skill3_charge_cfg = {
  param_type = 1,
  param1 = 3,
  param2 = 6
}

function M:_init(npc)
  CommonRole.role_common_init(self)
  self.death_set = 0
  self.now_atk_time = 0
  cast_magic(npc, npc, 1005820, 0)
  cast_magic(npc, npc, 1005014, 0)
  self.battle_res_type = 2
  self.current_hp = get_npc_attr(npc, 1)
  self.qte_skill = 100100519
  self.hurt_hp = 0
  self.atk_state = 1
  self.check_weapon_switch = 0
  self.weapon_state = 1
  self.snipe_state = 0
  self.snipe_count = 0
  self.skill2_cast_state = 0
  self.skill2_cast_state_now = 0
  self.skill3_cast_state = {
    [0] = 1,
    [1] = 1,
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 1,
    [6] = 1,
    [7] = 1,
    [8] = 1,
    [9] = 1,
    [10] = 1
  }
  self.skill3_missile_id = 100100512
  self.snipe_energy_timer = 0
  self.snipe_full_tag = 0
  self.snipe_charge_timer = 99999999
  self.snipe_charge_tag = 0
  self.snipe_mode = 0
  self.snipe_count_max = 7
  self.mastery_b_tag = 0
  self.hook_tag_magic_id = 1005024
  self.counter_missile = 10010050701
  self.hook_missile = 10010051101
  self.snipe_missile = 10010051201
  self.snipe_missile_effect_boom = 10010051213
  self.snipe_missile_effect_screen = 10010051214
  self.mastery_e_count = 0
  self.mastery_e_tag = false
  self.mastery_f_count = 0
  self.skill2_hit_count = 0
end

function M:cast_counter()
  if not CommonRole.get_input(self, 18) then
    return
  end
  if get_npc_cd_charge(self.npc, counter_skill_id[1]) < get_skill_cfg(counter_skill_id[1]).CdChargePerCost or get_npc_attr(self.npc, 2) < get_skill_cfg(counter_skill_id[1]).BattleResCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100159)
    return
  end
  update_skill_indicator(18, skill1_area, skill1_indi_cfg, 0.5)
  set_indicator_active(18, true)
  CommonRole.clear_input(self, 18)
end

function M:cast_atk()
  local nowtime = get_npc_time(self.npc)
  if not CommonRole.get_input(self, 15) then
    return
  end
  if CommonRole.counter_out_check(self) then
    CommonRole.counter_out(self)
    if 1 == self.atk_state then
      cast_missile(self.npc, self.npc, nil, nil, self.counter_missile, 0)
      cast_magic(self.npc, self.npc, 1005020, 0)
      cast_magic(self.npc, self.npc, 1005021, 0)
      if self.snipe_count < self.snipe_count_max then
        self.snipe_count = self.snipe_count + 1
        replace_hero_skill(5, snipe_count_id[self.snipe_count])
        cast_magic(self.npc, self.npc, 100168, 0)
      end
    end
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return false
  end
  if 2 == self.atk_state then
    if is_cast_skill_time(self.npc) and skill_abort_level > 1 then
      return false
    end
    if 0 == self.snipe_count then
      return
    end
    local x, y = get_aim_pos()
    lookat_position(self.npc, x, y, 1)
    abort_skill(self.npc)
    cast_skill(self.npc, nil, atk_id[11], x, y)
    cast_missile(self.npc, nil, x, y, self.snipe_missile, 0)
    cast_missile(self.npc, nil, x, y, self.snipe_missile_effect_boom, 0)
    cast_missile(self.npc, nil, x, y, self.snipe_missile_effect_screen, 0)
    skill_abort_level = 2
    set_skill_end_to_idle(self.npc, false)
    CommonRole.clear_input(self, 15)
  else
    if is_cast_skill_time(self.npc) and skill_abort_level > 1 then
      return false
    end
    CommonRole.joystick_search_target(self)
    if not atk_id[atk_counting] or nowtime > self.now_atk_time + 0.3 then
      atk_counting = atk_base_counting
      replace_hero_skill(1, atk_id[atk_counting])
      if self.target and check_npc_distance(self.npc, self.target, 15, 0) then
        lookat_npc(self.npc, self.target, 1)
      end
      self:do_cast_atk()
    elseif nowtime > self.now_atk_time then
      abort_skill(self.npc)
      if self.target and check_npc_distance(self.npc, self.target, 15, 0) then
        lookat_npc(self.npc, self.target, 1)
      end
      self:do_cast_atk()
    end
  end
end

function M:do_cast_atk()
  abort_skill(self.npc)
  cast_skill(self.npc, self.target, atk_id[atk_counting], nil, nil)
  self.now_atk_time = get_npc_time(self.npc) + atk_time[atk_id[atk_counting]]
  atk_counting = atk_counting + 1
  if not atk_id[atk_counting] then
    atk_counting = atk_base_counting
  end
  skill_abort_level = 1
  replace_hero_skill(1, atk_id[atk_counting])
  set_skill_end_to_idle(self.npc, true)
  CommonRole.clear_input(self, 15)
end

function M:cast_skill2()
  if not CommonRole.get_input(self, 19) then
    return
  end
  if get_npc_cd_charge(self.npc, skill2_id[1]) < get_skill_cfg(skill2_id[1]).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100160)
    return false
  end
  if get_npc_attr(self.npc, 2) < CommonRole.battle_res_cost(self, self.battle_res_type, skill2_id[1]) then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100160)
    return false
  end
  update_skill_indicator(19, skill2_area, skill2_indi_cfg, 0.5)
  set_indicator_active(19, true, true)
  CommonRole.clear_input(self, 19)
end

function M:cast_skill3()
  if not CommonRole.get_input(self, 20) then
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return false
  end
  if get_npc_cd_charge(self.npc, skill3_id[1]) < get_skill_cfg(skill3_id[1]).CdChargePerCost or self.snipe_count < 4 or 2 == self.atk_state then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100161)
    return
  end
  if get_npc_attr(self.npc, 2) < CommonRole.battle_res_cost(self, self.battle_res_type, skill3_id[1]) then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100161)
    return false
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 3 then
    return false
  end
  CommonRole.role_counter_reset(self)
  abort_skill(self.npc)
  CommonRole.joystick_search_target(self)
  if self.target and check_npc_distance(self.npc, self.target, 15, 0) then
    lookat_npc(self.npc, self.target, 1)
  end
  cast_skill(self.npc, self.target, skill3_id[1], nil, nil)
  set_skill_end_to_idle(self.npc, false)
  skill_abort_level = 4
  atk_counting = atk_base_counting
  replace_hero_skill(1, atk_id[atk_counting])
  CommonRole.clear_input(self, 20)
end

local timer_tag = 1

function M:skill_state_change_check()
  local now_energy = get_npc_attr(self.npc, 2)
  local now_gun_power = get_npc_attr(self.npc, 3)
  if 1 == self.mastery_b_tag and check_magic(self.npc, 1005234) then
    abort_magic_by_id(self.npc, 1005234)
    if check_magic(self.npc, 1005131) then
      cast_magic(self.npc, self.npc, 1005231, 0)
      if self.snipe_count < self.snipe_count_max then
        self.snipe_count = self.snipe_count + 1
        replace_hero_skill(5, snipe_count_id[self.snipe_count])
        cast_magic(self.npc, self.npc, 100168, 0)
      end
    end
  end
  if 2 == self.atk_state and 0 == self.snipe_state then
    local x, y = get_aim_pos()
    lookat_position(self.npc, x, y, false)
    if 1 == self.weapon_state then
      self:weapon_switch(2)
    end
    if check_magic(self.npc, 1005018) then
      self:weapon_switch(1)
      self.atk_state = 1
    end
    if 0 == now_gun_power then
      self.snipe_state = 2
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, skill3_id[3], nil, nil)
      set_left_joystick_skill_mode_active(false, false)
      set_skill_end_to_idle(self.npc, true)
      atk_counting = atk_base_counting
      skill_abort_level = 2
    end
  end
  if 2 == self.atk_state then
    if self.snipe_energy_timer < get_npc_time(self.npc) then
      self.snipe_energy_timer = get_npc_time(self.npc) + 0.05
      cast_magic(self.npc, self.npc, 1005022, 0)
    end
    if 1 == self.snipe_mode and 0 == self.snipe_charge_tag and self.snipe_charge_timer < get_time() then
      self.snipe_charge_tag = 1
      CommonRole.magic_with_check(self, self.npc, self.npc, 1005201)
    end
  end
  if 0 == self.snipe_count and 2 == self.atk_state then
    cast_magic(self.npc, self.npc, 1005820, 0)
  end
  if 2 == self.snipe_state and check_magic(self.npc, 1005018) then
    self:weapon_switch(1)
    self.atk_state = 1
    self.snipe_state = 0
    self.snipe_count = 0
  end
  if 1 == self.atk_state and now_gun_power >= 100 and self.snipe_count < self.snipe_count_max then
    self.snipe_count = self.snipe_count + 1
    replace_hero_skill(5, snipe_count_id[self.snipe_count])
    cast_magic(self.npc, self.npc, 1005820, 0)
    cast_magic(self.npc, self.npc, 100168, 0)
  end
  if 1 == self.atk_state and self.snipe_count < 4 and 1 == self.skill3_cast_state[self.snipe_count] then
    play_ui_fight_button_effect({
      "gray",
      nil,
      snipe_count_id[self.snipe_count],
      1
    })
    self.skill3_cast_state[self.snipe_count] = 0
  elseif 1 == self.atk_state and self.snipe_count >= 4 and 0 == self.skill3_cast_state[self.snipe_count] then
    play_ui_fight_button_effect({
      "gray",
      nil,
      snipe_count_id[self.snipe_count],
      0
    })
    self.skill3_cast_state[self.snipe_count] = 1
  elseif 2 == self.atk_state and 0 == self.skill3_cast_state[self.snipe_count] then
    play_ui_fight_button_effect({
      "gray",
      nil,
      snipe_count_id[self.snipe_count],
      0
    })
    self.skill3_cast_state[self.snipe_count] = 1
  end
  if now_energy < CommonRole.battle_res_cost(self, self.battle_res_type, skill2_id[1]) then
    self.skill2_cast_state_now = 1
  else
    self.skill2_cast_state_now = 0
  end
  if self.skill2_cast_state_now ~= self.skill2_cast_state then
    play_ui_fight_button_effect({
      "gray",
      nil,
      skill2_id[1],
      self.skill2_cast_state_now
    })
    self.skill2_cast_state = self.skill2_cast_state_now
  end
  if 1 == self.atk_state and self.snipe_count == self.snipe_count_max and get_npc_cd_charge(self.npc, skill3_id[11]) >= get_skill_cfg(skill3_id[11]).CdChargePerCost then
    if 0 == self.snipe_full_tag then
      play_ui_fight_button_effect({
        "Strengthen_skill_5",
        5
      })
      self.snipe_full_tag = 1
    end
  elseif 1 == self.snipe_full_tag then
    stop_ui_fight_button_effect({
      "Strengthen_skill_5",
      5
    })
    self.snipe_full_tag = 0
  end
  if check_npc_status(self.npc, 0) and 2 == self.weapon_state then
    self:weapon_switch(1)
  end
  if check_magic(self.npc, 1005010) and 2 == self.weapon_state then
    self:weapon_switch(1)
  end
end

function M:clear_focal_condition(distance)
  if not self.npc:is_active() then
    return
  end
  if self.target == nil then
    clear_focal()
  elseif not check_npc_distance(self.npc, self.target, distance, 1) then
    clear_focal()
  end
end

function M:on_frame()
  Base.on_frame(self)
  CommonRole.role_common_on_frame(self, 11.5)
  self:skill_state_change_check()
end

function M:on_frame_background()
  Base.on_frame_background(self)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if npc ~= self.npc then
    return
  end
  if check_magic(self.npc, 1005201) then
    abort_magic_by_id(self.npc, 1005201)
    cast_magic(self.npc, self.npc, 1005202, 0)
  end
  if 3 == damage_sign then
    if check_magic(self.npc, 1005191) then
      cast_magic(self.npc, self.npc, 1005291, 0)
    end
    if check_magic(self.npc, 1005121) then
      cast_magic(self.npc, self.npc, 1005221, 0)
    end
  end
  if 4 == damage_sign then
    if check_magic(self.npc, 1005191) then
      cast_magic(self.npc, self.npc, 1005291, 0)
    end
    if check_magic(self.npc, 1005171) and self.mastery_f_count > 1 then
      cast_magic(self.npc, self.npc, 1005271, 0)
    end
  end
end

function M:on_born_behavior()
  CommonRole.born_animation(self, born_skill)
  if check_magic(self.npc, 1005101) then
    self.snipe_mode = 1
    skill3_indi_cfg.res = "Fx_H101005_exskill_2_2"
  end
  if check_magic(self.npc, 1005111) then
    self.snipe_count_max = 10
  end
  if is_hero_in_ground(self.npc) then
    set_skill_btn_charging(20, 1, skill3_charge_cfg)
  end
  if check_magic(self.npc, 1005131) then
    self.mastery_b_tag = 1
  end
  if check_magic(self.npc, 1005141) then
    self.hook_tag_magic_id = 1005241
    self.hook_missile = 10010051102
  end
  if check_magic(self.npc, 1005151) then
    self.snipe_missile_effect_boom = 10010051219
    self.snipe_missile_effect_screen = 10010051220
    if check_magic(self.npc, 1005171) then
      self.snipe_missile = 10010051212
    else
      self.snipe_missile = 10010051204
    end
  elseif check_magic(self.npc, 1005171) then
    if check_magic(self.npc, 1005151) then
      self.snipe_missile = 10010051212
      self.snipe_missile_effect_boom = 10010051219
      self.snipe_missile_effect_screen = 10010051220
    else
      self.snipe_missile = 10010051206
    end
  end
end

function M:on_get_battle_skill(npc, magic_id)
  if npc ~= self.npc then
    return
  end
  if 1005131 == magic_id then
    self.mastery_b_tag = 1
  end
  if 1005141 == magic_id then
    self.hook_tag_magic_id = 1005241
    self.hook_missile = 10010051102
  end
  if 1005151 == magic_id then
    self.snipe_missile_effect_boom = 10010051219
    self.snipe_missile_effect_screen = 10010051220
    if check_magic(self.npc, 1005171) then
      self.snipe_missile = 10010051212
    else
      self.snipe_missile = 10010051204
    end
  elseif 1005171 == magic_id then
    if check_magic(self.npc, 1005151) then
      self.snipe_missile = 10010051212
      self.snipe_missile_effect_boom = 10010051219
      self.snipe_missile_effect_screen = 10010051220
    else
      self.snipe_missile = 10010051206
    end
  end
end

function M:on_npc_removed(npc)
  CommonRole.role_common_on_npc_removed(self, npc)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  Base.on_skill_begin(self, npc, skill_id, skill_type)
  if npc == self.npc then
    if skill_id == skill3_id[1] or skill_id == born_skill then
      set_ui_object_visible("fight", "Main", false)
    end
    CommonRole.battlesetting_camera_focus(self, skill_type)
    if skill_id == skill2_id[1] or skill_id == qte_id then
      self:weapon_switch(2)
      self.skill2_hit_count = 0
      if check_magic(self.npc, 1005121) then
        cast_magic(self.npc, self.npc, 1005224, 0)
      end
    end
    if skill_id == skill3_id[1] then
      self:weapon_switch(2)
      local hook_list = search_npc(self.npc, 4, 30, self.hook_tag_magic_id, 1, true)
      for k, target in pairs(hook_list) do
        abort_magic_by_id(target, self.hook_tag_magic_id)
        self.mastery_e_count = self.mastery_e_count + 1
      end
    end
    if skill_id == skill3_id[3] then
      back_to_scene_camera()
      set_ui_object_visible("fight", "Btn_skill4", true)
      set_ui_object_visible("fight", "Btn_lock7", true)
      replace_hero_skill(5, snipe_count_id[1])
      abort_magic_by_id(self.npc, 1005023)
      play_ui_fight_button_effect({
        "gray",
        nil,
        snipe_count_id[self.snipe_count],
        1
      })
      self.skill3_cast_state[self.snipe_count] = 0
      self.atk_state = 1
      if 1 == self.snipe_mode then
        skill3_indi_cfg.res = "Fx_H101005_exskill_2_2"
      end
      skill_abort_level = 5
    end
    if skill_id == skill3_id[2] or skill_id == skill3_id[4] then
      self.snipe_charge_timer = get_time() + 0.8
    end
    if skill_id == skill3_id[15] then
      self.mastery_e_tag = true
    end
    if skill_id == atk_id[11] then
      if 1 == self.snipe_mode then
        skill3_indi_cfg.res = "Fx_H101005_exskill_2_3"
        update_skill_indicator(49, skill3_area, skill3_indi_cfg, 0.5)
      end
      self.snipe_charge_tag = 0
      self.mastery_f_count = 0
    end
    if skill_id == skill3_id[15] then
      self.snipe_charge_tag = 0
    end
    if skill_id == atk_id[11] then
      self.snipe_count = self.snipe_count - 1
      if 0 ~= self.snipe_count then
        replace_hero_skill(5, snipe_count_id[self.snipe_count])
      end
      self.snipe_state = 3
    end
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc then
    CommonRole.hit_screen_effect(self)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc then
    if skill_id == skill2_id[1] or skill_id == qte_id then
      self.skill2_hit_count = self.skill2_hit_count + 1
      if 1 == self.skill2_hit_count then
        if self.snipe_count + 3 <= self.snipe_count_max then
          self.snipe_count = self.snipe_count + 3
          replace_hero_skill(5, snipe_count_id[self.snipe_count])
          cast_magic(self.npc, self.npc, 100168, 0)
        else
          self.snipe_count = self.snipe_count_max
          replace_hero_skill(5, snipe_count_id[self.snipe_count])
        end
      end
    end
    if skill_id == skill2_id[1] or missile_cfg.Id == self.counter_missile or skill_id == atk_id[4] and get_npc_attr(self.npc, 2) > 0 then
      local a, b = search_npc_magic_count(self.npc, 4, 30, self.hook_tag_magic_id, true)
      local hook_num = 2
      if check_magic(self.npc, 1005141) then
        hook_num = 3
      end
      if a < hook_num then
        CommonRole.magic_with_check(self, npc, hit_target, self.hook_tag_magic_id)
      end
    end
    if skill_id == self.skill3_missile_id then
      self.mastery_f_count = self.mastery_f_count + 1
      if self.mastery_e_tag and check_magic(self.npc, 1005161) then
        if 0 == self.mastery_e_count then
          cast_magic(self.npc, hit_target, 1005261, 0)
        elseif 1 == self.mastery_e_count then
          cast_magic(self.npc, hit_target, 1005262, 0)
        elseif 2 == self.mastery_e_count then
          cast_magic(self.npc, hit_target, 1005263, 0)
        elseif 3 == self.mastery_e_count then
          cast_magic(self.npc, hit_target, 1005264, 0)
        end
      end
      self.mastery_e_count = 0
    end
    if missile_cfg.Id ~= self.hook_missile then
      local hook_list = search_npc(self.npc, 4, 30, self.hook_tag_magic_id, 1, true)
      for k, target in pairs(hook_list) do
        if not check_magic(target, 1005032) and target ~= hit_target then
          cast_missile(self.npc, target, nil, nil, self.hook_missile, 0)
        end
      end
    end
  end
end

function M:on_skill_end(npc, skill_id)
  Base.on_skill_end(npc, skill_id)
  if npc == self.npc then
    if skill_id == skill3_id[1] then
      self.atk_state = 2
      set_camera(1005001)
      set_ui_object_visible("fight", "Main", true)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_lock7", false)
      abort_skill(self.npc)
      left_joystick_skill_mode(skill3_area, skill3_indi_cfg, 0.5, skill3_lock_cfg)
      local now_skill = skill3_id[15]
      if check_magic(self.npc, 1005161) then
        cast_missile(self.npc, self.target, nil, nil, self.snipe_missile, 0)
        cast_missile(self.npc, self.target, nil, nil, self.snipe_missile_effect_boom, 0)
        cast_missile(self.npc, self.target, nil, nil, self.snipe_missile_effect_screen, 0)
        set_left_joystick_skill_mode_active(true, true)
      else
        now_skill = skill3_id[2]
        set_left_joystick_skill_mode_active(true, false)
      end
      cast_skill(self.npc, self.target, now_skill, nil, nil)
      set_skill_end_to_idle(self.npc, false)
      atk_counting = atk_base_counting
      skill_abort_level = 1
    end
    if skill_id == skill3_id[2] or skill_id == skill3_id[4] then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, skill3_id[3], nil, nil)
      set_left_joystick_skill_mode_active(false, false)
      set_skill_end_to_idle(self.npc, true)
      atk_counting = atk_base_counting
      skill_abort_level = 2
    end
    if skill_id == atk_id[11] or skill_id == counter_skill_id[2] or skill_id == counter_skill_id[3] or skill_id == skill3_id[15] then
      self.snipe_state = 0
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, skill3_id[4], nil, nil)
      set_skill_end_to_idle(self.npc, false)
      atk_counting = atk_base_counting
      skill_abort_level = 1
    end
    if skill_id == skill3_id[3] then
      skill_abort_level = 1
    end
    if skill_id == born_skill then
      set_ui_object_visible("fight", "Main", true)
    end
    if skill_id == skill2_id[1] then
      self:weapon_switch(1)
    end
    if skill_id == skill3_id[15] then
      self.mastery_e_tag = false
    end
  end
end

function M:on_skill_break(npc, skill_id)
  if npc == self.npc then
    if skill_id == skill2_id[1] then
      self:weapon_switch(1)
    end
    if skill_id == skill3_id[3] then
      skill_abort_level = 1
    end
    if skill_id == born_skill then
      set_ui_object_visible("fight", "Main", true)
    end
    if skill_id == skill3_id[15] then
      self.mastery_e_tag = false
    end
  end
end

function M:on_superarmor_break(npc, camp)
  if npc ~= self.npc then
    cast_magic(self.npc, self.npc, 100114, 0)
    if self.target then
      cast_magic(self.npc, self.target, 100114, 0)
    end
    cast_magic(self.npc, self.npc, 100115, 0)
  end
end

function M:on_input(input_id)
  CommonRole.role_common_on_input(self, input_id)
end

function M:on_touch_up(input_id, iscancle)
  CommonRole.role_common_on_output(self, input_id)
  if 19 == input_id then
    if false == iscancle then
      local x, y = get_indicator_pos(19)
      set_indicator_active(input_id, false)
      if not x then
        return
      end
      if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) or get_npc_cd_charge(self.npc, skill2_id[1]) < get_skill_cfg(skill2_id[1]).CdChargePerCost then
        return
      end
      if get_npc_attr(self.npc, 2) < CommonRole.battle_res_cost(self, self.battle_res_type, skill2_id[1]) then
        return
      end
      if is_cast_skill_time(self.npc) and skill_abort_level > 1 then
        return false
      end
      CommonRole.role_counter_reset(self)
      abort_skill(self.npc)
      lookat_position(self.npc, x, y, 1)
      cast_skill(self.npc, nil, skill2_id[1], x, y)
      set_skill_end_to_idle(self.npc, true)
      skill_abort_level = 2
    else
      set_indicator_active(input_id, false)
    end
  end
  if 18 == input_id and false == iscancle then
    local x, y = get_indicator_pos(18)
    local skill_count = 1
    set_indicator_active(input_id, false)
    if not x then
      return
    end
    if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) or get_npc_cd_charge(self.npc, counter_skill_id[1]) < get_skill_cfg(counter_skill_id[1]).CdChargePerCost then
      return
    end
    if is_cast_skill_time(self.npc) and skill_abort_level > 2 then
      return
    end
    CommonRole.role_counter_reset(self)
    if 1 == self.atk_state then
      abort_skill(self.npc)
      lookat_position(self.npc, x, y, 1)
      cast_skill(self.npc, nil, counter_skill_id[1], x, y)
      self:weapon_switch(1)
      set_skill_end_to_idle(self.npc, true)
    else
      if get_dir_offset(self.npc, x, y) <= 90 then
        skill_count = 2
        lookat_position(self.npc, x, y, 1)
      else
        local self_pos = get_npc_pos(self.npc)
        x = self_pos.x + self_pos.x - x
        y = self_pos.z + self_pos.z - y
        skill_count = 3
        lookat_position(self.npc, x, y, 1)
      end
      self.snipe_state = 1
      abort_skill(self.npc)
      cast_skill_to_position(self.npc, counter_skill_id[skill_count], x, y)
      set_skill_end_to_idle(self.npc, false)
    end
    skill_abort_level = 3
    atk_counting = atk_base_counting
  end
end

function M:weapon_switch(state)
  if 1 == state then
    cast_magic(self.npc, self.npc, 1005014, 0)
    cast_magic(self.npc, self.npc, 1005015, 0)
    self.weapon_state = 1
  else
    cast_magic(self.npc, self.npc, 1005012, 0)
    cast_magic(self.npc, self.npc, 1005013, 0)
    cast_magic(self.npc, self.npc, 1005016, 0)
    self.weapon_state = 2
  end
end

function M:on_hero_showup_or_back(npc, is_showup)
  Base.on_hero_showup_or_back(self, npc, is_showup)
  skill_abort_level = 4
  if npc == self.npc then
    if false == is_showup then
      abort_magic_by_id(self.npc, 1003034)
      clear_skill_btn_charging(20)
      stop_ui_fight_button_effect({
        "Strengthen_skill_5",
        5
      })
      if 2 == self.atk_state then
        self:quit_snipe()
      end
      CommonRole.role_counter_reset(self)
    else
      set_skill_btn_charging(20, 1, skill3_charge_cfg)
      update_skill_indicator(19, skill2_area, skill2_indi_cfg, 0.5)
    end
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    abort_skill(self.npc, 1)
    clear_input()
    if 2 == self.atk_state then
      self:quit_snipe()
    end
  end
end

function M:on_npc_hp_zero(npc)
  if npc ~= self.npc then
    return
  end
  if (check_magic(self.npc, 6020017) or check_magic(self.npc, 6020032)) and 0 == self.death_set then
    self.death_set = 1
    return
  end
  self:quit_snipe()
  CommonRole.on_dead_hero_common(self)
  create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 10)
  set_npc_dead(self.npc, "die1", false)
end

function M:on_hero_reborn(reborned_hero)
  Base.on_hero_reborn(self, reborned_hero)
  if reborned_hero ~= self.npc then
    return
  end
  self:quit_snipe()
end

function M:quit_snipe()
  self.atk_state = 1
  self.check_weapon_switch = 0
  self.weapon_state = 1
  self:weapon_switch(1)
  self.snipe_state = 0
  self.snipe_count = 0
  self.now_atk_time = 0
  back_to_scene_camera()
  set_ui_object_visible("fight", "Btn_skill4", true)
  set_ui_object_visible("fight", "Btn_lock7", true)
  abort_magic_by_id(self.npc, 1005023)
  play_ui_fight_button_effect({
    "gray",
    nil,
    snipe_count_id[self.snipe_count],
    1
  })
  self.skill3_cast_state[self.snipe_count] = 0
  replace_hero_skill(5, snipe_count_id[self.snipe_count])
  set_left_joystick_skill_mode_active(false, false)
  cast_magic(self.npc, self.npc, 1003059, 0)
  set_skill_end_to_idle(self.npc, true)
  if 1 == self.snipe_mode then
    skill3_indi_cfg.res = "Fx_H101005_exskill_2_2"
  end
  skill_abort_level = 1
end

return M
