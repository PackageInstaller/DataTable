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
  self.init_guide = false
  clear_fight_ui_objs()
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    set_ui_object_visible("fight", "Btn_skill4", true)
    add_fight_ui_to_table("fight", "JoystickContent")
    self:to_next_step()
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100100801)
    self:to_next_step(0.4)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100100802)
    self:to_next_step(0.4)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", false)
    self:to_next_step(1.4)
  end)
  g:add_step(function()
    enter_guide(100100803)
    self:to_next_guide("guide2", 1.4)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      set_scene_tips(60823, true, {})
      remove_missile_by_id(10010080905)
      remove_missile_by_id(10010080913)
      remove_missile_by_id(10010081509)
      restart_skill_teach(100803)
    else
      set_scene_tips(60823, true, {})
      start_skill_teach(100803)
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    cast_magic(self.npc, self.npc, 4032085, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100809 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    elseif g:step_elapse() > 60 or 100100809 ~= skill_id then
      set_skill_state(1, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(2.5, function()
      self:back_to_step(1)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100807 == skill_id or 100100806 == skill_id or 100100808 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      set_scene_tips(60823, false, {})
      self:to_next_step(0.5)
    elseif 100100809 ~= skill_id then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    cast_magic(self.npc, self.monster1, 10001001, 1)
    self:to_next_guide("guide3", 2)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", -1, 2, "tp3", 0, 0, 4, 1)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", -0.5, 2, "tp3", 0, 0, 4, 1)
    self.monster3 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0.5, 2, "tp3", 0, 0, 4, 1)
    self.monster4 = add_npc_by_pos_key(1, 20101502, "bornpoint", 1, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    cast_magic(self.monster4, self.monster4, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self.monster2_pos = get_npc_pos(self.monster2)
    cast_magic(self.npc, self.npc, 4032087, 1)
    cast_magic(self.npc, self.npc, 4032085, 1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    flash_to_pos(self.npc, self.monster2_pos.x, self.monster2_pos.z - 2)
    self:to_next_step(0.5)
  end)
  g:add_step(function(back_form)
    cast_magic(self.npc, self.npc, 4032087, 1)
    cast_magic(self.npc, self.npc, 4032085, 1)
    set_ui_object_visible("fight", "Btn_skill5", true)
    if back_form then
      enter_guide(100100811)
    else
      enter_guide(100100811)
    end
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100810 == skill_id then
      self:to_next_step(1.8)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100100806)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step()
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100100813)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100100813 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100100804)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100805 == skill_id or 100100806 == skill_id or 100100807 == skill_id or 100100808 == skill_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    enter_guide(100100812)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100100812 == guide_id then
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100100805)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100805 == skill_id or 100100806 == skill_id or 100100807 == skill_id or 100100808 == skill_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(0.9)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100100805)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100805 == skill_id or 100100806 == skill_id or 100100807 == skill_id or 100100808 == skill_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    enter_guide(100100810)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100833 == skill_id then
      self:to_next_step(1.2)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100100814)
    self:to_next_step(0.7)
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    cast_magic(self.monster2, self.monster2, 10001001, 1)
    cast_magic(self.monster3, self.monster3, 10001001, 1)
    cast_magic(self.monster4, self.monster4, 10001001, 1)
    cast_magic(self.npc, self.npc, 4032087, 1)
    cast_magic(self.npc, self.npc, 4032085, 1)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_guide("guide4", 0.5)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", -1, 2, "tp3", 0, 0, 4, 1)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", -0.5, 2, "tp3", 0, 0, 4, 1)
    self.monster3 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0.5, 2, "tp3", 0, 0, 4, 1)
    self.monster4 = add_npc_by_pos_key(1, 20101502, "bornpoint", 1, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    cast_magic(self.monster4, self.monster4, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self.monster2_pos = get_npc_pos(self.monster2)
    flash_to_pos(self.npc, self.monster2_pos.x, self.monster2_pos.z - 2)
    abort_magic_by_id(self.npc, 1008312)
    cast_magic(self.npc, self.npc, 4032087, 1)
    cast_magic(self.npc, self.npc, 4032085, 1)
    set_scene_tips(60831, true, {})
    self:to_next_step(0.5)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 4032087, 1)
      cast_magic(self.npc, self.npc, 4032085, 1)
      restart_skill_teach(100804)
    else
      cast_magic(self.npc, self.npc, 4032087, 1)
      cast_magic(self.npc, self.npc, 4032085, 1)
      start_skill_teach(100804)
    end
    local role = self.npc:get_behavior()
    local area = role.icons.area
    local sk2 = role.btns.sk2
    sk2:setIcon(area)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", false)
    cast_magic(self.npc, self.npc, 4032087, 1)
    cast_magic(self.npc, self.npc, 4032085, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100810 == skill_id then
      set_skill_state(1, true)
      self:to_next_step(1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100805 == skill_id or 100100806 == skill_id or 100100807 == skill_id or 100100808 == skill_id then
      set_skill_state(2, true)
      self:to_next_step(0.5)
    else
      set_skill_state(2, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100805 == skill_id or 100100806 == skill_id or 100100807 == skill_id or 100100808 == skill_id then
      set_skill_state(3, true)
      self:to_next_step(0.5)
    else
      set_skill_state(3, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100805 == skill_id or 100100806 == skill_id or 100100807 == skill_id or 100100808 == skill_id then
      set_skill_state(4, true)
      self:to_next_step(0.5)
    else
      set_skill_state(4, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100833 == skill_id then
      set_skill_state(5, true)
      self:to_next_step(0.7)
    else
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      set_skill_state(5, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    cast_magic(self.monster2, self.monster2, 10001001, 1)
    cast_magic(self.monster3, self.monster3, 10001001, 1)
    cast_magic(self.monster4, self.monster4, 10001001, 1)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_scene_tips(60831, false, {})
    self:to_next_guide("guide5", 2)
  end)
  g:start()
end

function M:teach_guide5()
  local g = self:create_guide("guide5")
  g:add_step(function()
    local role = self.npc:get_behavior()
    if role then
      role.spBar:decrease(1)
    end
    local area = role.icons.area
    local arashi = role.icons.arashi
    local sk2 = role.btns.sk2
    local sk1 = role.btns.sk1
    sk2:setIcon(area)
    sk1:setIcon(arashi)
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", -2, 3, "tp3", 0, 0, 4, 1)
    self.monster2 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.npc, self.monster1, 4032119, 1)
    cast_magic(self.npc, self.monster2, 4032119, 1)
    cast_magic(self.npc, self.npc, 4032992, 0)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self.monster2_pos = get_npc_pos(self.monster2)
    flash_to_pos(self.npc, self.monster2_pos.x, self.monster2_pos.z - 0.5)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill7", true)
    enter_guide(100100807)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100821 == skill_id then
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self:to_next_guide("guide7", 0.5)
  end)
  g:start()
end

function M:teach_guide7()
  local g = self:create_guide("guide7")
  g:add_step(function()
    cast_magic(self.npc, self.npc, 4032125, 0)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 1999217, 0)
    set_ui_object_visible("fight", "Btn_skill7", true)
    clear_fight_ui_objs()
    show_skill_combo_tips({8}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    create_navigator_effect("end", true, true)
    self.hero = get_come_on_hero()
    flash_to_pos(self.hero, self.monster2_pos.x, self.monster2_pos.z - 2)
    set_scene_tips(60831, true, {})
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
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100802 == tips_id then
  end
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.npc, 2)
  if characeter_energy <= 100 then
    cast_magic(self.npc, self.npc, 4032991, 1)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
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
