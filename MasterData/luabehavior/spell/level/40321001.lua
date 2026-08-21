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
  self.teammateyilei = get_scene_hero_by_poskey(21)
  self.teammateling = get_come_on_hero()
  self.init_guide = nil
  clear_fight_ui_objs()
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill7", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "ChangHero2", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    add_fight_ui_to_table("fight", "JoystickContent")
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100101)
    else
      start_skill_teach(100101)
    end
    cast_magic(self.teammateling, self.teammateling, 403210011)
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(10010007)
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100100100 + g:step_index() - 2
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 2, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - 2, false)
      self:back_to_step(2, 1)
    end
  end
  
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    enter_guide(100100161)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    cast_magic(self.teammateling, self.monster1, 10001001, 1)
    self:to_next_step()
  end)
  g:add_step(function()
    on_up_skill_btn(15, false)
    set_scene_tips(60101, false, {})
    self:to_next_guide("guide2", 2)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.teammateling, self.monster2, 4032119, 1)
    set_sync_var("in_daze", 0)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    set_ui_object_visible("fight", "MainEnemyBloodList", false)
    self:to_next_step(0)
  end)
  g:add_step(function()
    self.monster2_pos = get_npc_pos(self.monster2)
    flash_to_pos(self.teammateling, self.monster2_pos.x, self.monster2_pos.z - 1.8)
    set_scene_tips(60102, true, {})
    set_ui_object_visible("fight", "Btn_skill1", false)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 2010280101 == skill_id then
      self:to_next_step(0.75)
    end
  end)
  g:add_step(function()
    enter_guide(10010011)
    set_ui_object_visible("fight", "Btn_skill3", true)
  end):listen("on_magic_begin", function(npc, target, magic_id)
    if 1999126 == magic_id then
      set_ui_object_visible("fight", "Btn_skill3", false)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    enter_guide(10010012)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100113 == skill_id then
      self:to_next_step(2)
    end
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100102)
      abort_magic_by_id(self.teammateling, 1999258, 1)
      abort_magic_by_id(self.teammateling, 1999259, 1)
      flash_to_pos(self.teammateling, self.monster2_pos.x, self.monster2_pos.z - 1.8)
      flash_to_pos(self.monster2, self.monster2_pos.x, self.monster2_pos.z)
      restart_skill_teach(100102)
    else
      self.monster2_pos = get_npc_pos(self.monster2)
      flash_to_pos(self.teammateling, self.monster2_pos.x, self.monster2_pos.z - 1.8)
      abort_magic_by_id(self.teammateling, 1999258, 1)
      abort_magic_by_id(self.teammateling, 1999259, 1)
      start_skill_teach(100102)
      set_scene_tips(60102, true, {})
      set_ui_object_visible("fight", "JoystickContent", true)
    end
  end):listen("on_missile_collide", function(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
    if m1_owner == self.teammateling and 3 == m1_cfg.MissileTypeTag and m2_owner ~= self.teammateling then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill1", true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(6)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100113 == skill_id then
      set_skill_state(2, true)
      set_ui_object_visible("fight", "JoystickContent", false)
      self:cancel_guide_timeout()
      self:to_next_step(0.5)
    elseif g:step_elapse() > 0.2 then
      print("114514")
      self:cancel_guide_timeout()
      set_skill_state(2, false)
      self:back_to_step(6, 0)
    end
  end)
  g:add_step(function()
    cast_magic(self.teammateling, self.monster2, 10001001, 1)
    cast_magic(self.teammateling, self.teammateling, 4032014, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    self:to_next_step()
  end)
  g:add_step(function()
    set_scene_tips(60102, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self:to_next_guide("guide3", 2)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster4 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster4, self.monster4, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "JoystickContent", false)
    self.monster4_pos = get_npc_pos(self.monster4)
    flash_to_pos(self.teammateling, self.monster4_pos.x, self.monster4_pos.z - 2.2)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(10010008)
    start_skill_teach(100104)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100121 == skill_id then
      set_skill_state(1, true)
      cast_magic(self.teammateling, self.teammateling, 4032004, 0)
      self:to_next_step(0.58)
    end
  end)
  g:add_step(function()
    enter_guide(10010015)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100123 == skill_id then
      set_skill_state(2, true)
      self:to_next_step(1.2)
    end
  end)
  g:add_step(function()
    enter_guide(10010010)
    self:to_next_step(2)
  end)
  g:add_step(function()
    enter_guide(10010009)
    self:to_next_step(1)
  end)
  g:add_step(function()
    flash_to_pos(self.teammateling, self.monster2_pos.x, self.monster2_pos.z - 1.8)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    set_dead_ball_count(self.monster4, 5)
    print("114514")
    abort_magic_by_id(self.teammateling, 4032994, 1)
    abort_magic_by_id(self.teammateling, 4032993, 1)
    cast_magic(self.teammateling, self.teammateling, 4032995, 1)
    enter_guide(10010013)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_hit", function(npc, skill_id, skill_type)
    if 100100804 == skill_id then
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    enter_guide(10010016)
    self:to_next_step(2)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", false)
    self:to_next_step()
  end)
  g:add_step(function()
    cast_magic(self.monster4, self.monster4, 10001001, 1)
    self:to_next_step(1.4)
  end)
  g:add_step(function()
    cast_magic(self.teammateling, self.teammateyilei, 4032992, 1)
    cast_magic(self.teammateling, self.teammateling, 4032992, 1)
    self.monster5 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster5, self.monster5, 4032905, 1)
    self.monster6 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster6, self.monster6, 4032905, 1)
    self.monster7 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster7, self.monster7, 4032905, 1)
    self.monster8 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster8, self.monster8, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill7", true)
    enter_guide(5107)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100821 == skill_id or 100100192 == skill_id then
      set_ui_object_visible("fight", "JoystickContent", false)
      self:to_next_step(1.3)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster5, self.monster5, 10001001, 1)
    cast_magic(self.monster6, self.monster6, 10001001, 1)
    cast_magic(self.monster7, self.monster7, 10001001, 1)
    cast_magic(self.monster8, self.monster8, 10001001, 1)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(2.75)
  end)
  g:add_step(function()
    cast_magic(self.teammateling, self.teammateyilei, 4032992, 1)
    cast_magic(self.teammateling, self.teammateling, 4032992, 1)
    self.monster5 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster5, self.monster5, 4032905, 1)
    self.monster6 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster6, self.monster6, 4032905, 1)
    self.monster7 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster7, self.monster7, 4032905, 1)
    self.monster8 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster8, self.monster8, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "JoystickContent", false)
    self.monster5_pos = get_npc_pos(self.monster5)
    flash_to_pos(self.teammateyilei, self.monster4_pos.x, self.monster4_pos.z - 2.2)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "JoystickContent", false)
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(10010014)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100821 == skill_id or 100100192 == skill_id then
      self:to_next_step(4)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster5, self.monster5, 10001001, 1)
    cast_magic(self.monster6, self.monster6, 10001001, 1)
    cast_magic(self.monster7, self.monster7, 10001001, 1)
    cast_magic(self.monster8, self.monster8, 10001001, 1)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self:to_next_step(2.75)
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step()
  end)
  g:add_step(function()
    show_skill_combo_tips({40321001}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    create_navigator_effect("end", true, true)
    flash_to_pos(self.teammateling, self.monster2_pos.x, self.monster2_pos.z - 1.8)
    self.finished_teach_guide = true
    self.monster9 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster9, self.monster9, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_scene_tips(801019, true, {})
    self:end_teach_guide()
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    clear_fight_ui_objs()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  if not self.init_guide and not check_npc_status(self.teammateling, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if self.finished_teach_guide == true then
    create_navigator_effect("end", true, true)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100001 == tips_id then
    set_scene_tips(801019, true, {})
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_skill_end(npc, skill_id)
  self:call_guide_listen_func("on_skill_end", npc, skill_id)
end

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

function M:on_magic_end(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_end", npc, target, magic_id)
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  self:call_guide_listen_func("on_missile_begin_pos", owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_input(input_id)
  self:call_guide_listen_func("on_input", input_id)
end

function M:check_magic(npc, magic_id)
  self:call_guide_listen_func("check_magic", npc, magic_id)
end

function M:on_touch_up(output_id, iscancel, input_time)
  self:call_guide_listen_func("on_touch_up", output_id, iscancel, input_time)
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
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
