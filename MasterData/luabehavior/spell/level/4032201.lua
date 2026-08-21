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
  local god = get_god_npc()
  cast_magic(god, god, 4032226)
  Base._init(self)
end

function M:guide_and_hide_hp(guide_id)
  set_all_npc_hp_visible(false, true)
  enter_guide(guide_id)
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill2", false)
    self.do_once = true
    self.remove_missile_list = {
      10010202101,
      10010202201,
      10010202301
    }
    self.abort_magic_list = {
      102061,
      102062,
      102063,
      102064
    }
    self.cast_magic_list = {
      100116,
      4032202,
      4032203,
      4032204,
      4032205
    }
  end
end

local function reset(self)
  for k, v in pairs(self.remove_missile_list) do
    remove_missile_by_id(v, self.npc)
  end
  for k, v in pairs(self.abort_magic_list) do
    for key, value in pairs(self.monster_list) do
      if value then
        abort_magic_by_id(value, v)
      end
    end
  end
  for k, v in pairs(self.cast_magic_list) do
    cast_magic(self.npc, self.npc, v, 1)
  end
  flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2)
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  local step = 11
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:guide_and_hide_hp(100102001)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:guide_and_hide_hp(100102002)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", false)
    self:guide_and_hide_hp(100102003)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:guide_and_hide_hp(100102004)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:guide_and_hide_hp(100102005)
    self:to_next_step(1)
  end)
  g:add_step(function()
    self:guide_and_hide_hp(100102006)
    self:to_next_step(0.4)
  end)
  g:add_step(function()
    self:guide_and_hide_hp(100102007)
    self:to_next_step(0.2)
  end)
  g:add_step(function()
    cast_magic(self.npc, self.monster1, 10001001, 0)
    self:to_next_step(0.95)
  end)
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    self.monster_list = {
      self.monster1
    }
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 1)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(102001)
    else
      start_skill_teach(102001)
      set_scene_tips(62001, true, {})
    end
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z)
    reset(self)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100102021
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - step, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100102006
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - step, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102001 == skill_id then
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102009 == skill_id then
      set_skill_state(g:step_index() - step, true)
      cast_magic(self.npc, self.monster1, 10001001, 0)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    self:to_next_guide("guide2", 1)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  local step = 17
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster2 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster3 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    self.monster_list = {
      self.monster1,
      self.monster2,
      self.monster3
    }
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    cast_magic(self.monster1, self.monster1, 4032207, 1)
    cast_magic(self.monster2, self.monster2, 4032207, 1)
    cast_magic(self.monster3, self.monster3, 4032207, 1)
    reset(self)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:guide_and_hide_hp(100102008)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(0.9)
  end)
  g:add_step(function()
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:guide_and_hide_hp(100102009)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:guide_and_hide_hp(100102010)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:guide_and_hide_hp(100102011)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100102007
    if target_skill_id == skill_id then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_skill_state(g:step_index() - step, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:guide_and_hide_hp(100102012)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    self:guide_and_hide_hp(100102013)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_fight_ui_object_visible("Btn_skill5", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_fight_ui_object_visible("Btn_skill5", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    self:guide_and_hide_hp(100102014)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_fight_ui_object_visible("Btn_skill5", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_fight_ui_object_visible("Btn_skill5", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    self:guide_and_hide_hp(100102015)
    self:to_next_step(1.2)
  end)
  g:add_step(function()
    self:guide_and_hide_hp(100102016)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(102002)
    else
      start_skill_teach(102002)
      set_scene_tips(62002, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    reset(self)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, skill_type)
    local target_skill_id = 100102032
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - step, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100102021
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - step, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100102007
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - step, true)
      self:to_next_step()
    elseif 100102006 ~= skill_id then
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102022 == skill_id then
    elseif 100102023 == skill_id then
    else
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102009 == skill_id then
      set_skill_state(g:step_index() - step, true)
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100102033
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - step, true)
      self:to_next_step(0.2)
    else
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(5, function()
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100102034
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - step, true)
      self:to_next_step(0.2)
    else
      set_skill_state(g:step_index() - step, false)
      self:back_to_step(step, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(62002, false, {})
    self:to_next_guide("guide3", 1.5)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self:to_next_step()
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    cast_magic(self.npc, self.npc, 100116, 0)
    cast_magic(self.npc, self.npc, 4032202, 1)
    cast_magic(self.npc, self.npc, 4032203, 1)
    cast_magic(self.npc, self.npc, 4032204, 1)
    cast_magic(self.npc, self.npc, 4032205, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(1)
  end)
  g:add_step(function()
    show_skill_combo_tips({20}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2)
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

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:on_finish_guide(guide_id)
  set_all_npc_hp_visible(true, true)
end

function M:on_skill_teach_tips_close(tips_id)
  if 102001 == tips_id then
  end
end

function M:search_target()
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.npc, 2)
  if characeter_energy <= 200 then
    cast_magic(self.npc, self.npc, 4032991, 1)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
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
