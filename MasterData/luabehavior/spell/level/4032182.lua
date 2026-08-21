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
  self.hero1 = get_come_on_hero()
  self.hero2 = get_scene_hero_by_poskey(21)
  self.init_guide = nil
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
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 7, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    self.hero_pos = get_npc_pos(self.hero1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101801)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", false)
    enter_guide(100101802)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.hero1 then
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101803)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.hero1 then
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(0.8)
    end
  end)
  g:add_step(function()
    enter_guide(100101804)
  end):listen("on_finish_guide", function(guide_id)
    if 100101804 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    enter_guide(100101811)
  end):listen("on_finish_guide", function(guide_id)
    if 100101811 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101805)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.hero1 then
      self:to_next_step(0.5)
      set_ui_object_visible("fight", "Btn_skill5", false)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101810)
  end):listen("on_finish_guide", function(guide_id)
    self:to_next_step()
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100101808)
  end):listen("on_finish_guide", function(guide_id)
    if 100101808 == guide_id then
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100101812)
  end):listen("on_finish_guide", function(guide_id)
    if 100101812 == guide_id then
      set_ui_object_visible("fight", "ChangHero1", false)
      remove_missile_by_id(10010182811)
      remove_missile_by_id(10010182801)
      remove_missile_by_id(10010182802)
      remove_missile_by_id(10010182803)
      remove_missile_by_id(10010182804)
      remove_missile_by_id(10010182805)
      self:to_next_guide("guide4", 1)
    end
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  local step = 1
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.hero1, self.hero1, 4032167, 1)
      cast_magic(self.hero1, self.hero1, 4032168, 1)
      cast_magic(self.hero1, self.hero1, 4032165, 1)
      cast_magic(self.hero1, self.hero1, 100116, 1)
      remove_missile_by_id(10010182811)
      remove_missile_by_id(10010182801)
      remove_missile_by_id(10010182802)
      remove_missile_by_id(10010182803)
      remove_missile_by_id(10010182804)
      remove_missile_by_id(10010182805)
      remove_missile_by_id(10010181124)
      restart_skill_teach(101807)
    else
      cast_magic(self.hero1, self.hero1, 4032167, 1)
      cast_magic(self.hero1, self.hero1, 100116, 1)
      cast_magic(self.hero1, self.hero1, 4032168, 1)
      cast_magic(self.hero1, self.hero1, 4032165, 1)
      start_skill_teach(101807)
      set_scene_tips(61810, true, {})
    end
    abort_magic_by_id(self.hero1, 1018962)
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z, self.monster1_pos.y)
    flash_to_pos(self.hero1, self.hero_pos.x, self.hero_pos.z, self.hero_pos.y)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    cast_magic(self.hero1, self.hero1, 4032184, 1)
    cast_magic(self.hero1, self.hero1, 4032185, 1)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.hero1 and 100101809 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    else
      set_skill_state(1, false)
      self:back_to_step(step, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(4, function()
      set_skill_state(2, false)
      self:back_to_step(step, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.hero1 and 100101815 == skill_id then
      self:cancel_guide_timeout()
      self:to_next_step()
    else
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(step, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      set_skill_state(2, false)
      self:back_to_step(step, 1)
    end)
  end):listen("on_missile_collide", function(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
    if m1_owner == self.hero1 and m2_owner == self.hero1 then
      if m1_cfg.Id == 10010181124 or m2_cfg.Id == 10010181124 then
        set_skill_state(2, true)
        self:cancel_guide_timeout()
        self:to_next_step()
      end
    else
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(step, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      set_skill_state(3, false)
      self:back_to_step(step, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.hero1 and 100101815 == skill_id then
      self:cancel_guide_timeout()
      self:to_next_step()
    else
      set_skill_state(3, false)
      self:cancel_guide_timeout()
      self:back_to_step(step, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      set_skill_state(3, false)
      self:back_to_step(step, 1)
    end)
  end):listen("on_missile_collide", function(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
    if m1_owner == self.hero1 and m2_owner == self.hero1 and (m1_cfg.Id == 10010181139 or m2_cfg.Id == 10010181139) then
      set_skill_state(3, true)
      self:cancel_guide_timeout()
      set_scene_tips(61810, false, {})
      self:to_next_guide("guide2", 3)
    end
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    remove_missile_by_id(10010182811)
    remove_missile_by_id(10010182801)
    remove_missile_by_id(10010182802)
    remove_missile_by_id(10010182803)
    remove_missile_by_id(10010182804)
    remove_missile_by_id(10010182805)
    cast_magic(self.hero1, self.monster1, 10001001, 0)
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 1, 2, "tp3", 0, 0, 4, 99)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
    self.monster3 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 1, "tp3", 0, 0, 4, 99)
    self.monster4 = add_npc_by_pos_key(1, 20101502, "bornpoint", -1, 2, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    cast_magic(self.monster2, self.monster1, 4032905, 1)
    cast_magic(self.monster3, self.monster1, 4032905, 1)
    cast_magic(self.monster4, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    cast_magic(self.hero1, self.hero1, 4032992, 0)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill7", true)
    enter_guide(100101806)
  end):listen("on_skill_hit", function(npc, skill_id, skill_type)
    if 100101826 == skill_id then
      self:to_next_step(3)
    end
  end)
  g:add_step(function()
    self:to_next_guide("guide3", 1)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self:to_next_step()
  end)
  g:add_step(function()
    remove_missile_by_id(10010161103, self.hero1)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    cast_magic(self.hero1, self.hero1, 4032167, 1)
    cast_magic(self.hero1, self.hero1, 4032168, 1)
    cast_magic(self.hero1, self.hero1, 4032165, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    show_skill_combo_tips({18}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.hero = get_come_on_hero()
    flash_to_pos(self.hero, self.monster1_pos.x, self.monster1_pos.z - 8)
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
  self:add_energy()
  self:teach_guide10()
  if not self.init_guide and not check_npc_status(self.hero1, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101803 == tips_id then
    set_scene_tips(801019, true, {})
  end
end

function M:search_target()
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.hero1, 2)
  if characeter_energy <= 100 then
    cast_magic(self.hero1, self.hero1, 4032991, 1)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
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

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
end

function M:on_enter_area(npc, area)
  if self.finished_teach_guide == true and area.Key == "end" then
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip, sure_btn, cancel_btn)
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
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
