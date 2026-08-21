local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.init_guide = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "center", 0, 0, "tp3", 0, 0, 4, 99)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1.5)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100401)
    else
      start_skill_teach(100401)
      set_scene_tips(60411, true, {})
    end
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100100400 + g:step_index() - 2
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 2, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - 2, false)
      on_up_skill_btn(15, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(2, 1)
    end
  end
  
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    on_up_skill_btn(15, false)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    set_scene_tips(60411, false, {})
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_guide("guide3", 1)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100402)
    else
      start_skill_teach(100402)
      set_scene_tips(60412, true, {})
    end
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_input", function(input_id)
    if 15 == input_id then
      start_long_click_skill()
    end
  end):listen("on_touch_up", function(output_id, iscancel, input_time)
    if 15 == output_id and input_time >= 0.35 and not iscancel then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill1", false)
      clear_input()
      self:to_next_step(1.5)
    else
      set_skill_state(1, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(60412, false, {})
    on_up_skill_btn(15, false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100402)
    else
      start_skill_teach(100402)
      set_scene_tips(60412, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    cast_magic(self.npc, self.npc, 4032114, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_input", function(input_id)
    if 15 == input_id then
      start_long_click_skill()
    end
  end):listen("on_magic_begin", function(npc, target, magic_id)
    if 1999300 == magic_id then
      enter_guide(5040)
    end
  end):listen("on_touch_up", function(output_id, iscancel, input_time)
    if 15 == output_id and input_time >= 0.5 and not iscancel then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill1", false)
      force_finish_cur_guide(5040)
      self:to_next_step(1)
    else
      set_skill_state(1, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(3, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(60412, false, {})
    remove_npc(self.monster1)
    self:to_next_step(1)
  end)
  g:add_step(function()
    self:to_next_guide("guide3", 1)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    remove_npc(self.monster1)
    self.monster2 = add_npc_by_pos_key(1, 20102802, "center", 0, 3, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    set_sync_var("in_daze", 0)
    set_ui_object_visible("fight", "MainEnemyBloodList", false)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    start_skill_teach(100403)
    set_scene_tips(60413, true, {})
    self:to_next_step(1.5)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100403)
    else
      start_skill_teach(100403)
      set_scene_tips(60413, true, {})
    end
  end):listen("on_missile_collide", function(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
    if m1_owner == self.npc and 3 == m1_cfg.MissileTypeTag and m2_owner ~= self.npc and not check_magic(m1_owner, 1999125) then
      set_skill_state(1, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc then
      if 100100414 == skill_id then
        set_skill_state(2, true)
        self:to_next_step(1.5)
      else
        set_skill_state(2, false)
        self:back_to_step(2, 1)
      end
    end
  end)
  g:add_step(function()
    set_scene_tips(60413, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    show_skill_teach_tips(100401, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.finished_teach_guide = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
  if self.finished_teach_guide and not self.quit_scene and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    self.quit_scene = true
    remove_scene_effect("jiaohu")
    remove_npc(self.god1)
    remove_npc(self.monster2)
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    request_end_teach_level(true)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100401 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(60413, true, {})
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

function M:on_skill_end(npc, skill_id)
  self:call_guide_listen_func("on_skill_end", npc, skill_id)
end

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

function M:on_missile_begin(owner, pos_x, pos_z, missile_cfg, missile)
  self:call_guide_listen_func("on_missile_begin", owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_input(input_id)
  self:call_guide_listen_func("on_input", input_id)
end

function M:on_touch_up(output_id, iscancel, input_time)
  self:call_guide_listen_func("on_touch_up", output_id, iscancel, input_time)
end

return M
