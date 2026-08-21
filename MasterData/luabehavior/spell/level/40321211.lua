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
  replace_team_pos_data(1, true)
  local god = get_god_npc()
  cast_magic(god, god, 4032226)
  self.teammateling = get_scene_hero_by_poskey(21)
  self.teammateazi = get_come_on_hero()
  self.init_guide = false
  clear_fight_ui_objs()
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3.5, "tp3", 0, 0, 4, 99)
    self.monster2_pos = get_npc_pos(self.monster2)
    cast_magic(self.npc, self.monster2, 4032119, 1)
    lookat_npc(self.teammateazi, self.monster2, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100102111)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102111 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    enter_guide(100102101)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102101 == guide_id then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    enter_guide(100102105)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102105 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100102109)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102109 == guide_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100102103)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102103 == guide_id then
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102151 == skill_id then
      cast_magic(self.teammateazi, self.monster2, 10211022)
      self:to_next_step(0.7)
    end
  end)
  g:add_step(function()
    cast_magic(self.teammateazi, self.teammateazi, 40321212)
    self:to_next_step(0.3)
  end)
  g:add_step(function()
    enter_guide(100102112)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102112 == guide_id then
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100102104)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102104 == guide_id then
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100102107)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102107 == guide_id then
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_guide("guide2", 1)
    end
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      remove_missile_by_id(10010212102, nil, false)
      remove_missile_by_id(10010212103, nil, false)
      remove_missile_by_id(10010212106, nil, false)
      remove_missile_by_id(10010212107, nil, false)
      remove_missile_by_id(10010216135, nil, false)
      remove_missile_by_id(10010216133, nil, false)
      restart_skill_teach(102103)
    else
      set_scene_tips(62103, true, {})
      start_skill_teach(102103)
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    cast_magic(self.npc, self.npc, 4032085, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102121 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    elseif g:step_elapse() > 60 or 100102121 ~= skill_id then
      set_skill_state(1, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102122 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step(0.5)
    elseif 100102121 ~= skill_id then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102151 == skill_id then
      self:cancel_guide_timeout()
      self:to_next_step()
    else
      set_skill_state(3, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:back_to_step(1)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102151 == skill_id then
      set_skill_state(3, true)
      self:cancel_guide_timeout()
      cast_magic(self.npc, self.monster2, 10001001, 1)
      self:to_next_step(0.5)
    elseif 100102121 ~= skill_id then
      set_skill_state(3, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(62103, false, {})
    self:to_next_guide("guide3", 2)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self.monster1_pos = get_npc_pos(self.monster1)
    flash_to_pos(self.teammateazi, self.monster1_pos.x, self.monster1_pos.z - 4)
    cast_magic(self.teammateazi, self.teammateazi, 10001006)
    self:to_next_step(0.2)
  end)
  g:add_step(function()
    enter_guide(100102106)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102106 == guide_id then
      self:to_next_guide("guide7", 5)
    end
  end)
  g:start()
end

function M:teach_guide7()
  local g = self:create_guide("guide7")
  g:add_step(function()
    set_scene_tips(62103, true, {})
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("figh  t", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    self:to_next_step()
  end)
  g:add_step(function()
    remove_missile_by_id(10010161103, self.teammateazi)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    cast_magic(self.teammateazi, self.teammateazi, 4032167, 1)
    cast_magic(self.teammateazi, self.teammateazi, 4032168, 1)
    cast_magic(self.teammateazi, self.teammateazi, 4032165, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step(function()
    show_skill_combo_tips({21}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.hero = get_come_on_hero()
    flash_to_pos(self.hero, self.monster2_pos.x, self.monster2_pos.z - 4)
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
  local characeter_energy = get_npc_attr(self.teammateazi, 2)
  if characeter_energy <= 200 then
    cast_magic(self.teammateazi, self.teammateazi, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.teammateazi, 1) then
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
