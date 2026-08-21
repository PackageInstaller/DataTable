local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill2", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20106016, "center", 0, 0, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032138, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    self:to_next_step(1)
    cast_magic(self.npc, self.npc, 4032134, 1)
    cast_magic(self.npc, self.npc, 40321341, 1)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(101304)
      cast_magic(self.npc, self.npc, 4032136, 1)
      cast_magic(self.npc, self.npc, 4032137, 1)
      set_scene_tips(61304, true, {})
      set_scene_tips(61305, false, {})
    else
      start_skill_teach(101304)
      set_scene_tips(61304, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_touch_up", function(output_id, iscancel, input_time)
    if 19 == output_id and true ~= iscancel then
      set_skill_state(1, true)
      set_scene_tips(61304, false, {})
      set_scene_tips(61305, true, {})
      cast_magic(self.npc, self.npc, 4032136, 1)
      cast_magic(self.npc, self.npc, 4032137, 1)
      self:to_next_step(1)
    else
      set_skill_state(1, false)
      on_up_skill_btn(19, false)
      cast_magic(self.npc, self.npc, 4032136, 1)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:to_next_step(0.5)
  end)
  g:add_step():listen("on_touch_up", function(output_id, iscancel, input_time)
    if 20 == output_id and true ~= iscancel then
      set_skill_state(2, true)
      cast_magic(self.npc, self.npc, 4032136, 1)
      cast_magic(self.npc, self.npc, 4032137, 1)
      self:cancel_guide_timeout()
      self:to_next_step(1)
    else
      set_skill_state(2, false)
      cast_magic(self.npc, self.npc, 4032136, 1)
      cast_magic(self.npc, self.npc, 4032137, 1)
      on_up_skill_btn(20, false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(61305, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(2)
  end)
  g:add_step(function()
    show_skill_teach_tips(101302, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    set_scene_tips(801019, true, {})
    set_scene_tips(61310, true, {})
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
  if 101302 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(61310, true, {})
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

return M
