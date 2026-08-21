local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_child_mt(Base)
local x, y
local skill3_time = 0
local distance = 0

function M:init_data()
end

function M:_init(npc)
  Base._init(self, npc)
  CommonRole.role_common_init(self)
  self.button_gray_list = {
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true
  }
  self.atk_target = nil
  self.atk_id = {100100151, 100100152}
  self.atk_missile_id = {
    10010015101,
    10010015201,
    10010015301,
    10010015302
  }
  self.atk_type = 1
  self.atk_time = {
    [100100151] = get_skill_cfg(100100151).CastTime + get_skill_cfg(100100151).BeforeTime,
    [100100152] = get_skill_cfg(100100152).CastTime + get_skill_cfg(100100152).BeforeTime,
    [100100153] = get_skill_cfg(100100153).CastTime + get_skill_cfg(100100153).BeforeTime,
    [100100154] = get_skill_cfg(100100153).CastTime + get_skill_cfg(100100153).BeforeTime
  }
  self.atk_combo_time = 0
  self.atk_counting = 1
  self.atk_rebound_numbs = 0
  self.atk_rebound_staty = false
  self.atk_rebound_staty_time = 0
  self.skill_abort_level = 1
  self.hit_numbs = 0
  self.executed_skill = {100100156, 100100157}
  self.executed_skill_switch = false
  self.executed_skill_level = 1
  self.executed_skill_button_effect = false
  self.counter_type = 1
  self.skill01_id = {
    [1] = 100100155,
    [2] = 100100155
  }
  self.isGuide = false
  self.counter_atk_id = {
    [1] = 100100113
  }
  self.counter_sound = 1001406
  self.qte_skill = 100100192
  self.born_skill = 100100141
  self.finish_skill = 100100142
  self.control = true
  self.newbie = {false, true}
  self.press_control = false
  self.posx, self.posz = get_scene_map_pos_postion("M2")
  self.skill02_danmu_pos = {
    {
      x = get_scene_map_pos_postion("M2"),
      z = get_scene_map_pos_postion("M2")
    }
  }
  if get_cur_room_id() == 20531 then
    self.tanfan1_id = 10030
  end
  if get_cur_room_id() == 20532 then
    self.tanfan2_id = 10033
  end
  if get_cur_room_id() == 20533 then
    self.tanfan3_id = 10036
  end
end

function M:on_start()
  Base.on_start(self, "light")
  self.role_on_ground = get_come_on_hero()
  set_ui_object_visible("fight", "Btn_skill4", false)
  set_ui_object_visible("fight", "Btn_skill5", false)
  set_ui_object_visible("fight", "Btn_skill7", false)
  cast_magic(self.npc, self.npc, 201026010169, 1)
end

function M:skill02_danmu_pos()
end

function M:on_born_behavior()
  CommonRole.born_animation(self, self.born_skill)
  self.role_on_ground = get_come_on_hero()
  set_camera_animed_state(false)
end

function M:cast_atk()
  local nowtime = get_npc_time(self.npc)
  if not CommonRole.get_input(self, 15) then
    return
  end
  if CommonRole.role_status_check(self) then
    return
  end
  if is_cast_skill_time(self.npc) and self.skill_abort_level >= 1 then
    return
  end
  if not self.atk_id[self.atk_counting] then
    self.atk_counting = 1
    abort_skill(self.npc)
    self:do_cast_atk()
  elseif nowtime > self.atk_combo_time then
    abort_skill(self.npc)
    self:do_cast_atk()
  end
end

function M:do_cast_atk()
  if self.executed_skill_switch and self.guide_executed then
    set_ui_object_visible("fight", "Right", false)
    set_ui_object_visible("fight", "HeroBlood", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    local flash_pos = get_npc_offset_position(self.atk_target, nil, 0, 7.15)
    flash_to_pos(self.npc, flash_pos.x, flash_pos.z)
    if self.atk_target then
      lookat_npc(self.atk_target, self.npc, 1)
      lookat_npc(self.npc, self.atk_target, 1)
    end
    if 1 == self.executed_skill_level then
      abort_skill(self.npc)
      cast_skill(self.npc, self.atk_target, self.executed_skill[1], nil, nil)
      self.executed_skill_level = self.executed_skill_level + 1
    else
      abort_skill(self.npc)
      cast_skill(self.npc, self.atk_target, self.executed_skill[2], nil, nil)
    end
    stop_ui_fight_button_effect({
      "Skill_Guid1",
      1
    })
    self.skill_abort_level = 9
    return
  end
  if 1 == self.atk_type and self.atk_rebound_numbs >= 2 or 2 == self.atk_type and self.atk_rebound_numbs >= 3 then
    cast_skill(self.npc, self.atk_target, 100100153, nil, nil)
    self.skill_abort_level = 7
    return
  end
  if self.atk_target then
    lookat_npc(self.npc, self.atk_target, 1)
  end
  cast_skill(self.npc, self.atk_target, self.atk_id[self.atk_counting], nil, nil)
  self.atk_combo_time = get_npc_time(self.npc) + self.atk_time[self.atk_id[self.atk_counting]]
  self.atk_counting = self.atk_counting + 1
  CommonRole.clear_output(self, 15)
  CommonRole.clear_input(self, 15)
  self.skill_abort_level = 1
end

function M:cast_counter()
  if not CommonRole.get_input(self, 18) then
    return
  end
  if check_magic(self.npc, 1999171) or self.isGuide then
    return
  end
  if get_npc_cd_charge(self.npc, self.skill01_id[2]) < get_skill_cfg(self.skill01_id[2]).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100159)
    return
  end
  if CommonRole.role_status_check(self) then
    return
  end
  if CommonRole.counter_cutout(self, self.skill01_id[1]) or CommonRole.counter_cutout(self, self.skill01_id[2]) then
  elseif is_cast_skill_time(self.npc) and self.skill_abort_level >= 9 then
    return
  end
  abort_skill(self.npc)
  CommonRole.role_counter_reset(self)
  local joystick_target = get_joystick_target_pos(self.npc)
  if 0 == joystick_target.x and 0 == joystick_target.z then
    cast_skill(self.npc, nil, self.skill01_id[2], nil, nil)
  else
    lookat_position(self.npc, joystick_target.x, joystick_target.z, false)
    cast_skill_to_position(self.npc, self.skill01_id[2], joystick_target.x, joystick_target.z)
  end
  self.skill_abort_level = 9
  self.now_atk_time = get_npc_time(self.npc)
  CommonRole.clear_input(self, 18)
end

function M:cast_skill2()
end

function M:cast_skill3()
end

function M:on_input(input_id)
  CommonRole.role_common_on_input(self, input_id)
end

function M:on_touch_up(input_id, iscancle)
  CommonRole.role_common_on_output(self, input_id, iscancle)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  Base.on_skill_begin(self, npc, skill_id, skill_type)
  if skill_id == self.skill01_id[1] then
    cast_magic(self.npc, self.npc, 1001614, 1)
    cast_magic(self.npc, self.npc, 1001616, 1)
    stop_ui_fight_button_effect("Skill_Guid3", 3)
  end
  if 100100154 == skill_id then
    self.atk_rebound_staty_time = 0
  end
  if 100100156 == skill_id then
    self.atk_type = 2
  end
  if 100100157 == skill_id then
    self.executed_skill_switch = false
  end
  if skill_id == self.born_skill or skill_id == self.finish_skill then
    set_ui_object_visible("fight", "Main", false)
  end
  if 2010260202 == skill_id or 2010260203 == skill_id or 2010260204 == skill_id or 2010260205 == skill_id then
    self.atk_rebound_staty = true
    self.atk_rebound_numbs = 0
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 5 == missile_cfg.Tag then
    if hit_target == self.npc then
      cast_magic(hit_target, hit_target, 201026010161, 1)
      self.atk_counting = 1
      self.atk_rebound_staty_time = 0
    elseif hit_target == self.target then
      cast_magic(hit_target, hit_target, 201026010162, 1)
    end
  end
  if missile_cfg.Id == 10010015704 then
    set_sync_var("aten_2_end", true)
    cast_magic(self.npc, self.npc, 103310, 1)
    auto_forward_move(self.npc, false)
  end
  if missile_cfg.Id == 201026025101 then
    cast_magic(self.npc, self.npc, 1001613, 1)
    cast_magic(self.npc, self.npc, 1001635, 1)
    set_sync_var("replay", true)
    force_finish_cur_guide()
    self.replaying = true
    self.guide_executed = nil
  end
end

function M:on_skill_end(npc, skill_id)
  Base.on_skill_end(self, npc, skill_id)
  if skill_id == self.born_skill or skill_id == self.finish_skill then
    set_ui_object_visible("fight", "Main", true)
  end
  if skill_id == self.executed_skill[1] then
    set_ui_object_visible("fight", "Right", true)
    set_ui_object_visible("fight", "HeroBlood", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self.guide_executed = nil
    self.isGuide = false
  end
  if skill_id == self.executed_skill[2] then
    set_ui_object_visible("fight", "Right", true)
    set_ui_object_visible("fight", "HeroBlood", true)
    set_ui_object_visible("fight", "JoystickContent", true)
  end
  if 2010260251 == skill_id then
    self.replaying = false
  end
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner == self.npc and m2_owner ~= self.npc and self.atk_rebound_staty then
    for k, v in pairs(self.atk_missile_id) do
      if m1_cfg.Id == v then
        local pos = get_npc_pos(m2_owner)
        self.atk_rebound_staty_time = get_time() + 0.8
        self.atk_rebound_numbs = self.atk_rebound_numbs + 1
        if (m2_cfg.Id == 201026020201 or m2_cfg.Id == 201026020301 or m2_cfg.Id == 201026020302 or m2_cfg.Id == 201026020401 or m2_cfg.Id == 201026020402 or m2_cfg.Id == 201026020501 or m2_cfg.Id == 201026020502 or m2_cfg.Id == 201026020503) and m1_cfg.Id ~= self.atk_missile_id[3] then
          remove_missile(m1)
          rebound_missile(m2, self.npc, m2_owner, pos.x, pos.z, 50, false, false, false)
          cast_magic(self.npc, self.npc, 1001600, 0)
          cast_magic(self.npc, self.npc, 1001605, 0)
          cast_magic(self.npc, self.npc, 1001606, 0)
          cast_magic(self.npc, self.npc, 1001607, 0)
          if self.tanfan1_id then
            add_task_progress(self.tanfan1_id, 1)
          end
          if self.tanfan2_id then
            add_task_progress(self.tanfan2_id, 1)
          end
          if self.tanfan3_id then
            add_task_progress(self.tanfan3_id, 1)
          end
        elseif m2_cfg.Id == 201026020403 or m2_cfg.Id == 201026020504 then
          if m1_cfg.Id == self.atk_missile_id[3] then
            remove_missile(m1)
            remove_missile(m2)
            abort_skill(self.npc, 1)
            cast_skill(self.npc, self.atk_target, 100100154, nil, nil)
            cast_magic(self.npc, self.npc, 1001600, 0)
            cast_magic(self.npc, self.npc, 1001603, 0)
            if self.tanfan1_id then
              add_task_progress(self.tanfan1_id, 1)
            end
            if self.tanfan2_id then
              add_task_progress(self.tanfan2_id, 1)
            end
            if self.tanfan3_id then
              add_task_progress(self.tanfan3_id, 1)
            end
          else
            remove_missile(m1)
            rebound_missile(m2, self.npc, m2_owner, pos.x, pos.z, 50, false, false, false)
            cast_magic(self.npc, self.npc, 1001600, 0)
            cast_magic(self.npc, self.npc, 1001605, 0)
            cast_magic(self.npc, self.npc, 1001606, 0)
            cast_magic(self.npc, self.npc, 1001607, 0)
            if self.tanfan1_id then
              add_task_progress(self.tanfan1_id, 1)
            end
          end
        end
      end
    end
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, is_crit)
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
end

local magic_begin_handle_func = {}
local magic_end_handle_func = {}

function M:on_magic_begin(npc, target, magic_id)
  Base.on_magic_begin(self, npc, target, magic_id)
  if npc ~= self.npc then
    return
  end
  local func = magic_begin_handle_func[magic_id]
  if func then
    func(self)
  end
end

function M:on_magic_end(npc, target, magic_id)
  Base.on_magic_end(self, npc, target, magic_id)
  local func = magic_end_handle_func[magic_id]
  if func and npc == self.npc then
    func(self)
  end
end

function M:on_timeline_end(timeline_name)
  if "timeline_Aten_State2_open" == timeline_name then
    auto_forward_move(self.npc, true)
  end
end

function M:on_finish_guide(guide_id)
  if 1033077 == guide_id then
    abort_magic_by_id(self.npc, 103307)
    self.isGuide = true
  end
end

function M:on_frame()
  Base.on_frame(self)
  self.atk_target = search_npc(self.npc, 4, 150, nil, 1)
  CommonRole.role_common_on_frame(self, 1000)
  if self.atk_target then
    distance = check_npc_distance(self.npc, self.atk_target, 10, true)
    if distance and not self.replaying then
      self.executed_skill_switch = true
      if not self.executed_skill_button_effect and (not is_cast_skill_time(self.npc, self.executed_skill[1]) or not is_cast_skill_time(self.npc, self.executed_skill[2])) then
        cast_magic(self.npc, self.npc, 100010101, 1)
        if not self.guide_executed then
          self.guide_executed = true
          cast_magic(self.npc, self.npc, 103307, 0)
          enter_guide(1033077)
        end
        self.executed_skill_button_effect = true
      end
    else
      self.executed_skill_switch = false
      if self.executed_skill_button_effect then
        stop_ui_fight_button_effect({
          "Skill_Guid1",
          1
        })
        self.executed_skill_button_effect = false
      end
    end
  end
  if self.atk_rebound_numbs >= 1 and get_time() > self.atk_rebound_staty_time then
    self.atk_rebound_staty = false
    self.atk_rebound_numbs = 0
    self.atk_counting = 1
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    clear_input()
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  Base.on_hero_showup_or_back(self, npc, is_showup, by_ult_change)
  self.role_on_ground = get_come_on_hero()
  if npc ~= self.npc then
    return
  end
end

function M:on_npc_hp_zero(npc)
end

function M:on_frame_background()
  Base.on_frame_background(self)
end

function M:on_hero_reborn(reborned_hero)
  Base.on_hero_reborn(self, reborned_hero)
  if reborned_hero ~= self.npc then
    return
  end
end

return M
