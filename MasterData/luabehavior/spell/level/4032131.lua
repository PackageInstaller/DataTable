local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)
local tip = Util.format_str("是否退出关卡")
local sure_btn = Util.format_str("是")
local cancel_btn = Util.format_str("否")

local function sure_callback()
  set_scene_tips(801019, false, {})
  remove_scene_effect("jiaohu")
  set_ui_object_visible("fight", "Main", false)
  request_end_teach_level(true)
end

local function cancel_callback()
  set_ui_object_visible("fight", "Btn_skill5", true)
  set_ui_object_visible("fight", "JoystickContent", true)
  set_ui_object_visible("fight", "Btn_skill4", true)
  set_ui_object_visible("fight", "Btn_skill1", true)
  set_ui_object_visible("fight", "Btn_skill3", true)
  set_ui_object_visible("fight", "Btn_skill7", true)
end

function M:_init()
  Base._init(self)
  local god = get_god_npc()
  cast_magic(god, god, 4032226)
  replace_team_pos_data(1, true)
  self.hefei = get_come_on_hero()
  self.init_guide = false
  clear_fight_ui_objs()
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    self.hefei_pos = get_npc_pos(self.hefei)
    lookat_npc(self.hefei, self.monster1, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100101301)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100101301 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    enter_guide(100101302)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100101302 == guide_id then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      set_ui_object_visible("fight", "Btn_skill7", false)
      self:to_next_step(3.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100101303)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100101303 == guide_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(3)
    end
  end)
  g:add_step(function()
    self:to_next_step(1)
  end)
  g:add_step(function()
    enter_guide(100101304)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100101304 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    enter_guide(100101305)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100101305 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    cast_magic(self.hefei, self.monster1, 10001001, 1)
    self:to_next_guide("guide2", 2)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      print("114514")
      flash_to_pos(self.hefei, self.hefei_pos.x, self.hefei_pos.z, self.hefei_pos.y)
      flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z, self.monster1_pos.y)
      restart_skill_teach(101301)
    else
      self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
      cast_magic(self.monster1, self.monster1, 4032905, 1)
      self.monster1_pos = get_npc_pos(self.monster1)
      set_scene_tips(61301, true, {})
      start_skill_teach(101301)
    end
    remove_missile_by_id(10010136001)
    remove_missile_by_id(10010136004)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(1)
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100101330 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    elseif g:step_elapse() > 60 or 100101330 ~= skill_id then
      set_skill_state(1, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(10, function()
      set_skill_state(2, false)
      self:back_to_step(1)
    end)
  end):listen("on_magic_begin", function(npc, target, magic_id)
    if 1013715 == magic_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_scene_tips(61301, false, {})
    self:to_next_guide("guide3", 2)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z - 1.5, self.monster1_pos.y)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill7", true)
    remove_missile_by_id(10010136001)
    remove_missile_by_id(10010136004)
    cast_magic(self.hefei, self.hefei, 10001006)
    flash_to_pos(self.hefei, self.monster1_pos.x, self.monster1_pos.z - 4)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(100101306)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100101306 == guide_id then
      self:to_next_guide("guide7", 7)
    end
  end)
  g:start()
end

function M:teach_guide7()
  local g = self:create_guide("guide7")
  g:add_step(function()
    set_scene_tips(61301, true, {})
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    self:to_next_step()
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    cast_magic(self.hefei, self.hefei, 4032167, 1)
    cast_magic(self.hefei, self.hefei, 4032168, 1)
    cast_magic(self.hefei, self.hefei, 4032165, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step(function()
    show_skill_combo_tips({13}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.hero = get_come_on_hero()
    create_navigator_effect("end", true, true)
    self.finished_teach_guide = true
    set_scene_tips(801019, true, {})
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if self.finished_teach_guide == true then
    create_navigator_effect("end", true, true)
  end
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.hefei, 2)
  if characeter_energy <= 200 then
    cast_magic(self.hefei, self.hefei, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.hefei, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101803 == tips_id then
  end
end

function M:search_target()
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  self:call_guide_listen_func("on_skill_end", npc, skill_id, is_time_out, is_break)
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  self:call_guide_listen_func("on_missile_begin_pos", owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_input(input_id)
  self:call_guide_listen_func("on_input", input_id)
end

function M:on_touch_up(output_id, iscancel, input_time)
  self:call_guide_listen_func("on_touch_up", output_id, iscancel, input_time)
end

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

function M:check_magic(npc, magic_id)
  self:call_guide_listen_func("check_magic", npc, magic_id)
end

function M:check_npc_status(npc, int)
  self:call_guide_listen_func("check_npc_status", npc, int)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self:call_guide_listen_func("after_damage", npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
end

function M:on_enter_area(npc, area)
  if self.finished_teach_guide == true and area.Key == "end" then
    joystick_end()
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "JoystickContent", false, true)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, tip, sure_btn, cancel_btn)
  end
end

return M
