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
  self.init_guide = nil
  self.switch = false
  clear_fight_ui_objs()
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill2", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  local step = 15
  g:add_step(function()
    cast_magic(self.npc, self.npc, 1015310, 0)
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101501)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(100101502)
    self:to_next_step(0.1)
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100101500 + g:step_index() - 4
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 4, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    else
      set_skill_state(g:step_index() - 4, false)
      self:cancel_guide_timeout()
      on_up_skill_btn(15, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(4, 1)
    end
  end
  
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(101501)
    else
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      start_skill_teach(101501)
      set_scene_tips(61501, true, {})
    end
    cast_magic(self.npc, self.npc, 4032157, 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
    enter_guide(100101503)
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:back_to_step(4, 0.5)
    end)
  end):listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(4, 0.5)
    end)
  end):listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(4, 0.5)
    end)
  end):listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(4, 0.5)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100101500 + g:step_index() - 4
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 4, true)
      self:cancel_guide_timeout()
      self:to_next_step(1)
    else
      set_skill_state(g:step_index() - 4, false)
      self:cancel_guide_timeout()
      on_up_skill_btn(15, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(4, 1)
    end
  end)
  g:add_step(function()
    enter_guide(100101504)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(100101505)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", false)
    enter_guide(100101506)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100101521 == skill_id then
      set_ui_object_visible("fight", "Btn_skill5", true)
      cast_magic(self.npc, self.npc, 4032158, 0)
      self:to_next_step(0.5)
    else
      self:back_to_step(11, 1)
    end
  end)
  g:add_step(function()
    enter_guide(100101507)
    self:to_next_step(1.1)
  end)
  g:add_step(function()
    enter_guide(100101508)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(100101509)
    self.switch = true
    self:to_next_step(2)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 100116, 0)
      on_up_skill_btn(15, false)
      restart_skill_teach(101504)
      set_scene_tips(61506, true, {})
    else
      cast_magic(self.npc, self.npc, 100116, 0)
      start_skill_teach(101504)
      set_scene_tips(61506, true, {})
    end
    cast_magic(self.npc, self.npc, 4032158, 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    enter_guide(100101510)
    self:to_next_step()
  end)
  
  local function func_skill_begin2(npc, skill_id, skill_type)
    local target_skill_id = 100101500 + g:step_index() - 12
    if target_skill_id == skill_id then
      self:cancel_guide_timeout()
      set_skill_state(g:step_index() - 16, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - 16, false)
      self:cancel_guide_timeout()
      on_up_skill_btn(15, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(16, 1)
    end
  end
  
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(16, 0.5)
    end)
  end):listen("on_skill_begin", func_skill_begin2)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(16, 0.5)
    end)
  end):listen("on_skill_begin", func_skill_begin2)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(16, 0.5)
    end)
  end):listen("on_skill_begin", func_skill_begin2)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(16, 0.5)
    end)
  end):listen("on_skill_begin", func_skill_begin2)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(16, 0.5)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100101500 + g:step_index() - 12
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 16, true)
      self:cancel_guide_timeout()
      self:to_next_step(2)
    else
      set_skill_state(g:step_index() - 16, false)
      on_up_skill_btn(15, false)
      self:cancel_guide_timeout()
      self:back_to_step(16, 1)
    end
  end)
  g:add_step(function()
    self.switch = false
    enter_guide(100101511)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 100116, 0)
      on_up_skill_btn(15, false)
      restart_skill_teach(101502)
      set_scene_tips(61506, true, {})
    else
      cast_magic(self.npc, self.npc, 100116, 0)
      start_skill_teach(101502)
      set_scene_tips(61506, true, {})
    end
    self:guide_timeout(5, function()
      self:back_to_step(22)
    end)
    cast_magic(self.npc, self.npc, 4032158, 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "JoystickContent", true)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100101574
    if target_skill_id == skill_id then
      self:cancel_guide_timeout()
      set_skill_state(1, true)
      self:to_next_step(0.8)
    else
      self:cancel_guide_timeout()
      set_skill_state(1, false)
      on_up_skill_btn(15, false)
      self:back_to_step(22, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.npc, self.monster1, 10001001, 0)
    cast_magic(self.npc, self.npc, 4032157, 1)
    self:to_next_guide("guide2", 1)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  local step = 4
  g:add_step(function()
    cast_magic(self.npc, self.npc, 1015310, 0)
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    cast_magic(self.npc, self.npc, 4032157, 1)
    self:to_next_step(1)
  end)
  g:add_step(function()
    enter_guide(100101512)
    self:to_next_step(0.9)
  end)
  g:add_step(function()
    enter_guide(100101513)
    self:to_next_step(0.1)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 100116, 0)
      cast_magic(self.npc, self.npc, 4032155, 1)
      cast_magic(self.npc, self.npc, 4032156, 1)
      cast_magic(self.npc, self.npc, 4032157, 1)
      restart_skill_teach(101505)
    else
      cast_magic(self.npc, self.npc, 100116, 0)
      cast_magic(self.npc, self.npc, 4032155, 1)
      cast_magic(self.npc, self.npc, 4032156, 1)
      cast_magic(self.npc, self.npc, 4032157, 1)
      start_skill_teach(101505)
      set_scene_tips(61507, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_fight_ui_object_visible("JoystickContent", false)
    play_ui_fight_button_effect({"Skill_Guid", 4})
    cast_magic(self.npc, self.npc, 4032155, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101521 == skill_id then
      cast_magic(self.npc, self.npc, 4032155, 1)
      cast_magic(self.npc, self.npc, 4032156, 1)
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc and 100101521 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    else
      set_skill_state(1, false)
      self:back_to_step(step, 0.7)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_skill_state(2, false)
      self:back_to_step(step, 0.7)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101522 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step(0.8)
    elseif g:step_elapse() > 1.5 then
      self:cancel_guide_timeout()
      self:back_to_step(step, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(61507, false, {})
    cast_magic(self.npc, self.monster1, 10001001, 0)
    cast_magic(self.npc, self.npc, 4032157, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_guide("guide3", 1)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    set_fight_ui_object_visible("JoystickContent", false)
    set_sync_var("close_counterattack", 1)
    set_sync_var("in_daze", 0)
    self:to_next_step(1.7)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101514)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(100101515)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc then
      cast_magic(self.npc, hit_target, 10001001, 0)
      self:to_next_step(2)
    else
      self:back_to_step(11, 1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    self.monster1 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    set_sync_var("close_counterattack", 1)
    set_sync_var("in_daze", 0)
    self:to_next_step(0.1)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 4032159, 1)
      cast_magic(self.npc, self.npc, 100116, 1)
      cast_magic(self.npc, self.npc, 4032160, 1)
      cast_magic(self.npc, self.npc, 4032157, 1)
      restart_skill_teach(101506)
    else
      cast_magic(self.npc, self.npc, 4032159, 1)
      cast_magic(self.npc, self.npc, 100116, 1)
      cast_magic(self.npc, self.npc, 4032160, 1)
      cast_magic(self.npc, self.npc, 4032157, 1)
      set_scene_tips(61508, true, {})
      start_skill_teach(101506)
    end
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101514 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(2.7, function()
      set_skill_state(2, false)
      self:back_to_step(5, 0.5)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101532 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
    end
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100101532 == skill_id then
      self:to_next_step(1)
      cast_magic(self.npc, hit_target, 10001001, 0)
    end
  end)
  g:add_step(function()
    set_scene_tips(61508, false, {})
    cast_magic(self.npc, self.monster1, 10001001, 0)
    cast_magic(self.npc, self.npc, 4032147, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_guide("guide4", 1)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    set_sync_var("close_counterattack", 1)
    set_sync_var("in_daze", 0)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_fight_ui_object_visible("JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    cast_magic(self.npc, self.npc, 1999217, 0)
    set_scene_tips(61504, false, {})
    show_skill_combo_tips({15}, true)
    cast_magic(self.npc, self.npc, 4032157, 1)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.hero = get_come_on_hero()
    flash_to_pos(self.hero, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    self.finished_teach_guide = true
    self:end_teach_guide()
    set_scene_tips(801019, true, {})
    create_navigator_effect("end", true, true)
  end)
  g:start()
end

function M:on_skill_teach_tips_close(tips_id)
  if 101502 == tips_id then
  end
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.npc, 2)
  local energy = get_npc_attr(self.npc, 74)
  if characeter_energy <= 200 then
    cast_magic(self.npc, self.npc, 4032991, 1)
  end
  if self.switch == true and energy < 500 then
    cast_magic(self.npc, self.npc, 4032158, 1)
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

function M:search_target()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:on_skill_end(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_end", npc, skill_id, skill_type)
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
