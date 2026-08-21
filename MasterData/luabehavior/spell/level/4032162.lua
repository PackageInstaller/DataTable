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
  self.init_guide = false
  set_ui_object_visible("fight", "ChangHero1", false)
  clear_fight_ui_objs()
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  local step = 3
  local back_step = 4
  local missile_num = 0
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self:to_next_step()
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101601)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(101609)
      set_ui_object_visible("fight", "Btn_skill4", true)
      remove_missile_by_id(10010161101, self.hero1)
      remove_missile_by_id(10010161102, self.hero1)
      remove_missile_by_id(10010161103, self.hero1)
      cast_magic(self.hero1, self.hero1, 4032167, 1)
      cast_magic(self.hero1, self.hero1, 4032168, 1)
      cast_magic(self.hero1, self.hero1, 4032165, 1)
      cast_magic(self.hero1, self.hero1, 4032144, 1)
      cast_magic(self.hero1, self.hero1, 40321621, 1)
      self:to_next_step(0.5)
    else
      start_skill_teach(101609)
      set_ui_object_visible("fight", "Btn_skill4", true)
      remove_missile_by_id(10010161101, self.hero1)
      remove_missile_by_id(10010161102, self.hero1)
      remove_missile_by_id(10010161103, self.hero1)
      cast_magic(self.hero1, self.hero1, 4032167, 1)
      cast_magic(self.hero1, self.hero1, 4032168, 1)
      cast_magic(self.hero1, self.hero1, 4032165, 1)
      cast_magic(self.hero1, self.hero1, 4032144, 1)
      set_scene_tips(61604, true, {})
      self:to_next_step(0.5)
    end
    cast_magic(self.hero1, self.hero1, 40321622)
  end)
  g:add_step(function()
    enter_guide(100101602)
  end):listen("on_finish_guide", function(guide_id)
    set_skill_state(1, true)
    set_ui_object_visible("fight", "Btn_skill4", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101603)
  end):listen("on_finish_guide", function(guide_id)
    set_skill_state(2, true)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100101604)
  end):listen("on_finish_guide", function(guide_id)
    set_skill_state(3, true)
    set_ui_object_visible("fight", "Btn_skill4", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    enter_guide(100101606)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100101607)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.hero2 then
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    enter_guide(100101608)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(100101609)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.hero1 then
      set_ui_object_visible("fight", "Btn_skill7", false)
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_guide("guide2", 2)
    end
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  local step = 3
  local back_step = 1
  local missile_num = 0
  g:add_step(function(back_form)
    if back_form then
      abort_skill(self.hero1, true)
      restart_skill_teach(101609)
      remove_missile_by_id(10010161101, self.hero1)
      remove_missile_by_id(10010161102, self.hero1)
      remove_missile_by_id(10010161103, self.hero1)
      cast_magic(self.hero1, self.hero1, 4032167, 1)
      cast_magic(self.hero1, self.hero1, 4032168, 1)
      cast_magic(self.hero1, self.hero1, 4032165, 1)
      cast_magic(self.hero1, self.hero1, 4032144, 1)
      cast_magic(self.hero1, self.hero1, 40321621, 1)
    else
      start_skill_teach(101609)
      remove_missile_by_id(10010161101, self.hero1)
      remove_missile_by_id(10010161102, self.hero1)
      remove_missile_by_id(10010161103, self.hero1)
      cast_magic(self.hero1, self.hero1, 4032167, 1)
      cast_magic(self.hero1, self.hero1, 4032168, 1)
      cast_magic(self.hero1, self.hero1, 4032165, 1)
      cast_magic(self.hero1, self.hero1, 4032144, 1)
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    cast_magic(self.hero1, self.hero1, 40321622)
    missile_num = 0
    self:to_next_step(0.5)
  end)
  g:add_step():listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010161103 then
      set_skill_state(1, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(5, function()
      self:back_to_step(back_step)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101612 == skill_id then
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif 100101617 == skill_id then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(back_step, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:back_to_step(back_step)
    end)
  end):listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010161101 then
      self:cancel_guide_timeout()
      set_skill_state(2, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(5, function()
      self:back_to_step(back_step)
    end)
  end):listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010162903 or missile_cfg.Id == 10010162904 then
      self:cancel_guide_timeout()
      set_skill_state(3, true)
      self:to_next_guide("guide3", 2)
    end
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101612 == skill_id then
      set_skill_state(3, false)
      self:cancel_guide_timeout()
      self:back_to_step(back_step, 1)
    end
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z + 2)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    remove_missile_by_id(10010161101, self.hero1)
    remove_missile_by_id(10010161102, self.hero1)
    remove_missile_by_id(10010161103, self.hero1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill7", true)
    cast_magic(self.hero1, self.hero1, 10001006)
    self:to_next_step(0.05)
  end)
  g:add_step(function()
    enter_guide(100101612)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step(5.5)
  end)
  g:add_step(function()
    set_scene_tips(61605, false, {})
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
    show_skill_combo_tips({16}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    create_navigator_effect("end", true, true)
    self.hero = get_come_on_hero()
    flash_to_pos(self.hero, self.monster1_pos.x, self.monster1_pos.z - 2.2)
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
  local characeter_energy = get_npc_attr(self.hero1, 2)
  if characeter_energy <= 200 then
    cast_magic(self.hero1, self.hero1, 4032991, 1)
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

function M:search_target()
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
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
