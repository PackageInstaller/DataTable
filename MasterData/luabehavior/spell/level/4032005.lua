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

function M:_init()
  Base._init(self)
  self.init_guide = nil
  local god = get_god_npc()
  cast_magic(god, god, 4032226)
  self.exercise_rec = false
  self.skill1_energy = 0
  clear_fight_ui_objs()
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    self.monster1_pos = get_npc_pos(self.monster1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "JoystickContent", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_scene_tips(60106, true, {})
    cast_magic(self.npc, self.npc, 4032004, 0)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    start_skill_teach(100105)
    enter_guide(5093)
    self:to_next_step(0)
  end)
  g:add_step(function()
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    set_ui_object_visible("fight", "Btn_skill4", false)
    if 100100121 == skill_id then
      set_skill_state(1, true)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(5063)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100122 == skill_id then
      set_skill_state(2, true)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_scene_tips(60106, false, {})
      cast_magic(self.npc, self.npc, 4032004, 0)
      self:to_next_step(0.5)
      self:to_next_guide("guide2", 2)
    end
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    cast_magic(self.npc, self.npc, 1001991, 1)
    cast_magic(self.npc, self.npc, 4032010, 1)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_scene_tips(60110, true, {})
    start_skill_teach(100111)
    play_ui_fight_button_effect({"Skill_Guid", 4})
    self:to_next_step(0.1)
  end)
  g:add_step(function()
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100121 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100123 == skill_id then
      cast_magic(self.npc, self.npc, 4032014, 1)
      set_skill_state(2, true)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(5067)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100131 == skill_id then
      set_skill_state(3, true)
      cast_magic(self.npc, self.monster1, 10001001, 1)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_guide("guide3", 2)
    end
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    cast_magic(self.npc, self.npc, 1001991, 1)
    self:to_next_step(1)
  end)
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    enter_guide(5070)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100106)
      set_ui_object_visible("fight", "Btn_skill1", true)
      cast_magic(self.npc, self.npc, 4032004, 0)
      cast_magic(self.monster2, self.monster2, 4032008, 1)
      cast_magic(self.monster2, self.monster2, 4032007, 1)
    else
      start_skill_teach(100106)
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_scene_tips(60107, true, {})
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100100104 + g:step_index() - 3
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 3, true)
      cast_magic(self.npc, self.npc, 4032014, 1)
      local delay = 0
      if 100100108 == skill_id then
        delay = 2
        set_ui_object_visible("fight", "JoystickContent", false)
        set_ui_object_visible("fight", "Btn_skill1", false)
      end
      self:to_next_step(delay)
    else
      set_skill_state(g:step_index() - 3, false)
      cast_magic(self.npc, self.npc, 4032014, 1)
      cast_magic(self.monster2, self.monster2, 4032008, 1)
      cast_magic(self.monster2, self.monster2, 4032007, 1)
      self:back_to_step(3, 1)
    end
  end
  
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    cast_magic(self.npc, self.monster2, 10001001, 1)
    self:to_next_step()
  end)
  g:add_step(function()
    abort_magic_by_id(self.npc, 1001310)
    abort_magic_by_id(self.npc, 1001322)
    cast_magic(self.npc, self.monster2, 10001001, 1)
    self:to_next_guide("guide4", 1)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  g:add_step(function()
    self.monster4 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    self.monster5 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    set_scene_tips(60108, true, {})
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(5071)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(5068)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(5066)
    self:to_next_step(1)
  end)
  g:add_step(function()
    cast_magic(self.npc, self.monster4, 10001001, 1)
    cast_magic(self.npc, self.monster5, 10001001, 1)
    cast_magic(self.npc, self.npc, 1999217, 0)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(1)
  end)
  g:add_step(function()
    show_skill_combo_tips({1}, true)
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    create_navigator_effect("end", true, true)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self.finished_teach_guide = true
    set_scene_tips(801019, true, {})
    self:end_teach_guide()
  end)
  g:start()
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.npc, 2)
  if characeter_energy <= 200 then
    cast_magic(self.npc, self.npc, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100103 == tips_id then
    set_scene_tips(60105, true, {})
  end
end

function M:search_target()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
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

function M:on_npc_hp_zero(npc)
  self:call_guide_listen_func("on_npc_hp_zero", npc)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:on_skill_end(npc, skill_id)
  self:call_guide_listen_func("on_skill_end", npc, skill_id)
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
