local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "center", 0, -1, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 4032184, 1)
      cast_magic(self.npc, self.npc, 4032185, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      restart_skill_teach(101805)
    else
      cast_magic(self.npc, self.npc, 4032184, 1)
      cast_magic(self.npc, self.npc, 4032185, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      start_skill_teach(101805)
      set_scene_tips(61807, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_touch_up", function(output_id, iscancel, input_time)
    if 20 == output_id and true ~= iscancel then
      set_skill_state(1, true)
      set_scene_tips(61807, false, {})
      self:to_next_step(1)
    else
      cast_magic(self.npc, self.npc, 4032185, 1)
      set_skill_state(1, false)
      on_up_skill_btn(20, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(61805, false, {})
    on_up_skill_btn(20, false)
    self:to_next_guide("guide3", 1.5)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      remove_missile_by_id(10010161103, self.npc)
      remove_missile_by_id(10010161102, self.npc)
      remove_missile_by_id(10010161101, self.npc)
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      restart_skill_teach(101807)
    else
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      start_skill_teach(101807)
      set_scene_tips(61809, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    cast_magic(self.npc, self.npc, 4032184, 1)
    cast_magic(self.npc, self.npc, 4032185, 1)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010181101 or missile_cfg.Id == 10010181123 or missile_cfg.Id == 10010181124 then
      set_skill_state(1, true)
      cast_magic(self.npc, self.npc, 4032185, 1)
      set_scene_tips(61811, true, {})
      self:to_next_step(0)
    elseif missile_cfg.Id == 10010181126 then
      self:back_to_step(1, 1)
    else
      set_skill_state(1, false)
      cast_magic(self.npc, self.npc, 4032184, 1)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
  end):listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010181103 or missile_cfg.Id == 10010181104 or missile_cfg.Id == 10010181105 then
      set_skill_state(2, true)
      self.missile_begin_time = get_time()
      self:to_next_step()
    elseif missile_cfg.Id == 10010181126 then
      set_skill_state(2, false)
      self:back_to_step(1, 1)
    else
      set_skill_state(2, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
  end):listen("on_missile_end_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    self.missile_end_time = get_time()
    local missile_life_time = self.missile_end_time - self.missile_begin_time
    if (missile_cfg.Id == 10010181103 or missile_cfg.Id == 10010181104 or missile_cfg.Id == 10010181105) and missile_life_time < 0.4 and 0 ~= missile_life_time then
      set_skill_state(3, true)
      set_scene_tips(61810, true, {})
      self:to_next_step(6)
    elseif (missile_cfg.Id == 10010181103 or missile_cfg.Id == 10010181104 or missile_cfg.Id == 10010181105) and missile_life_time > 0.45 then
      remove_missile_by_id(10010181107, self.npc, false)
      remove_missile_by_id(10010181117, self.npc, false)
      remove_missile_by_id(10010181118, self.npc, false)
      remove_missile_by_id(10010181101, self.npc, false)
      set_skill_state(3, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    show_skill_teach_tips(101803, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "JoystickContent", true)
    self.finished_teach_guide = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
  if self.finished_teach_guide and not self.quit_scene and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    self.quit_scene = true
    remove_scene_effect("jiaohu")
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    request_end_teach_level(true)
    remove_npc(self.monster1)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101803 == tips_id then
    set_scene_tips(801019, true, {})
  end
end

function M:search_target()
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

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  self:call_guide_listen_func("on_missile_end_pos", owner, pos_x, pos_z, missile_cfg, missile)
end

return M
