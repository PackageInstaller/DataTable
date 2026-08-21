local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)
local role = get_come_on_hero():get_behavior()
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
  self.init_guide = false
  self.exercise_rec = false
  clear_fight_ui_objs()
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  local step = 5
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(1.5)
  end)
  g:add_step(function(back_form)
    cast_magic(self.npc, self.npc, 4032125, 0)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    enter_guide(100100401)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100100402)
    self:to_next_step(0.2)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 4032125, 0)
      cast_magic(self.npc, self.npc, 4032045, 0)
      cast_magic(self.npc, self.npc, 40320451, 0)
      cast_magic(self.npc, self.npc, 4032048, 0)
      cast_magic(self.npc, self.npc, 40320481, 0)
      cast_magic(self.npc, self.npc, 40320482, 0)
      restart_skill_teach(100404)
    else
      cast_magic(self.npc, self.npc, 4032125, 0)
      start_skill_teach(100404)
      set_scene_tips(60423, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(0.2)
  end)
  
  local function func_skill(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc then
      if 100100421 == skill_id or 100100422 == skill_id then
        set_skill_state(1, true)
        self:to_next_step(0)
      else
        set_skill_state(1, false)
        self:back_to_step(step, 0.2)
      end
    end
  end
  
  g:add_step():listen("on_skill_hit", func_skill)
  
  local function func_skill(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc then
      if 100100431 == skill_id or 100100432 == skill_id or 100100433 == skill_id then
        set_skill_state(2, true)
        set_ui_object_visible("fight", "JoystickContent", false)
        self:to_next_step(1)
      else
        set_skill_state(2, false)
        self:back_to_step(step, 0.2)
      end
    end
  end
  
  g:add_step(function()
    self:guide_timeout(10, function()
      set_skill_state(2, false)
      self:back_to_step(step, 0.2)
    end)
  end):listen("on_skill_hit", func_skill)
  g:add_step(function()
    set_scene_tips(61221, false, {})
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    local role = self.npc:get_behavior()
    if role then
      role.spBarStatus(false, 3)
    end
    abort_magic_by_id(self.npc, Const.INDICATOR.SLOMO)
    abort_magic_by_id(self.npc, Const.INDICATOR.DARKEN)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z)
    remove_npc(self.monster1)
    self:to_next_guide("guide2", 1)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  local step = 4
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    local role = self.npc:get_behavior()
    if role then
      role.spBar:increase(3)
      role.spBarStatus(true, 3)
    end
    enter_guide(100100404)
    self:to_next_step(0)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100100403)
    self:to_next_step(5)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 4032125, 0)
      cast_magic(self.npc, self.npc, 4032045, 0)
      cast_magic(self.npc, self.npc, 40320451, 0)
      cast_magic(self.npc, self.npc, 4032048, 0)
      cast_magic(self.npc, self.npc, 40320481, 0)
      cast_magic(self.npc, self.npc, 40320482, 0)
      restart_skill_teach(100405)
    else
      cast_magic(self.npc, self.npc, 4032125, 0)
      start_skill_teach(100405)
      set_scene_tips(60424, true, {})
    end
    local role = self.npc:get_behavior()
    if role then
      role.spBar:decrease(2)
      role.core_skill_counting = 2
      role.spBarStatus(true, 2)
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(0.5)
  end)
  
  local function func_skill(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc then
      if 100100421 == skill_id or 100100422 == skill_id then
        set_skill_state(1, true)
        self:to_next_step(0)
      else
        set_skill_state(1, false)
        local role = self.npc:get_behavior()
        if role then
          role.spBarStatus(false, 3)
        end
        self:back_to_step(step, 0.2)
      end
    end
  end
  
  g:add_step():listen("on_skill_hit", func_skill)
  
  local function func_skill(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc then
      if 100100431 == skill_id or 100100432 == skill_id or 100100433 == skill_id then
        self:cancel_guide_timeout()
        set_skill_state(2, true)
        self:to_next_step(0.2)
      else
        self:cancel_guide_timeout()
        local role = self.npc:get_behavior()
        if role then
          role.spBarStatus(false, 3)
        end
        set_skill_state(2, false)
        self:back_to_step(step, 0.2)
      end
    end
  end
  
  g:add_step(function()
    self:guide_timeout(10, function()
      set_skill_state(2, false)
      self:back_to_step(step, 0.2)
    end)
  end):listen("on_skill_hit", func_skill)
  
  local function func_skill(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc then
      if 100100442 == skill_id or 100100445 == skill_id then
        self:cancel_guide_timeout()
        set_skill_state(3, true)
        set_ui_object_visible("fight", "JoystickContent", false)
        self:to_next_step(3)
      else
        self:cancel_guide_timeout()
        local role = self.npc:get_behavior()
        if role then
          role.spBarStatus(false, 3)
        end
        set_skill_state(3, false)
        self:back_to_step(step, 0.2)
      end
    end
  end
  
  g:add_step(function()
    self:guide_timeout(10, function()
      set_skill_state(3, false)
      self:back_to_step(step, 0.2)
    end)
  end):listen("on_skill_hit", func_skill)
  g:add_step(function()
    set_scene_tips(61221, false, {})
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    local role = self.npc:get_behavior()
    if role then
      role.spBarStatus(false, 3)
    end
    abort_magic_by_id(self.npc, Const.INDICATOR.SLOMO)
    abort_magic_by_id(self.npc, Const.INDICATOR.DARKEN)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z)
    remove_npc(self.monster1)
    self:to_next_guide("guide3", 1)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  local step = 3
  g:add_step(function()
    set_scene_tips(60433, true, {})
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 2, 3, "tp3", 0, 0, 4, 99)
    self.monster3 = add_npc_by_pos_key(1, 20101502, "bornpoint", -2, 3, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    cast_magic(self.npc, self.npc, 4032016, 0)
    cast_magic(self.npc, self.monster1, 1004088, 0)
    cast_magic(self.npc, self.monster2, 1004088, 0)
    cast_magic(self.npc, self.monster3, 1004088, 0)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    enter_guide(100100405)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self:to_next_step(4)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100100403)
    self:to_next_step(3)
  end)
  g:add_step(function()
    remove_npc(self.monster1)
    remove_npc(self.monster2)
    remove_npc(self.monster3)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_scene_tips(60432, true, {})
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    show_skill_combo_tips({4}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    set_scene_tips(801019, true, {})
    self.finished_teach_guide = true
    self.exercise_rec = true
    flash_to_pos(self.npc, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    create_navigator_effect("end", true, true)
    set_scene_tips(801019, true, {})
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
  if self.exercise_rec and get_npc_attr(self.npc, 2) < 90 then
    cast_magic(self.npc, self.npc, 4032125, 0)
  end
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.npc, 2)
  if characeter_energy <= 100 then
    cast_magic(self.npc, self.npc, 4032991, 1)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100403 == tips_id then
    set_scene_tips(60413, false, {})
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

function M:on_touch_up(output_id, iscancel, input_time)
  self:call_guide_listen_func("on_touch_up", output_id, iscancel, input_time)
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
