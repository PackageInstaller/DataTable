local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.init_guide = nil
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill7", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "M5", 0, -1, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100104)
      set_scene_tips(60103, true, {})
      cast_magic(self.npc, self.npc, 4032004, 0)
      cast_magic(self.npc, self.npc, 4032010, 0)
    else
      start_skill_teach(100104)
      set_scene_tips(60103, true, {})
      cast_magic(self.npc, self.npc, 4032004, 0)
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    cast_magic(self.npc, self.npc, 4032010, 0)
    cast_magic(self.npc, self.npc, 4032003, 0)
    cast_magic(self.npc, self.npc, 4032004, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100121 == skill_id or 100100123 == skill_id then
      set_skill_state(1, true)
      set_scene_tips(60104, true, {})
      cast_magic(self.npc, self.npc, 4032004, 0)
      self:to_next_step()
    else
      set_skill_state(1, false)
      cast_magic(self.npc, self.npc, 4032004, 0)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(5, function()
      self:back_to_step(2)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100122 ~= skill_id then
    end
    set_skill_state(2, true)
    self:cancel_guide_timeout()
    self:to_next_step(1)
    goto lbl_34
    if g:step_elapse() > 5 or 100100122 ~= skill_id then
      self:cancel_guide_timeout()
      set_skill_state(2, false)
      self:back_to_step(2, 1)
    end
    ::lbl_34::
  end)
  g:add_step(function()
    set_scene_tips(60104, false, {})
    cast_magic(self.npc, self.npc, 4032125, 0)
    self:to_next_step(1)
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(1)
  end)
  g:add_step(function()
    show_skill_teach_tips(100102, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.finished_teach_guide = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  cast_magic(self.npc, self.npc, 4032004, 0)
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
  if self.finished_teach_guide and not self.quit_scene and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    self.quit_scene = true
    remove_scene_effect("jiaohu")
    remove_npc(self.god1)
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    remove_npc(self.monster1)
    request_end_teach_level(true)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100102 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(60121, true, {})
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

return M
