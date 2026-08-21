local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.init_guide = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20101502, "M7", 0, -2, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_scene_tips(60932, true, {})
    self:to_next_step(1)
  end)
  g:add_step(function()
    enter_guide(5077)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100901 == skill_id then
      set_ui_object_visible("fight", "Btn_skill3", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    enter_guide(5078)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100905 == skill_id then
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(5036)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100100920 == skill_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(1.7)
    end
  end)
  g:add_step(function()
    set_scene_tips(60934, true, {})
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100913)
    else
      start_skill_teach(100913)
    end
    self:to_next_step()
  end)
  g:add_step():listen("on_input", function(input_id)
    if 20 == input_id then
      start_long_click_skill()
    end
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc then
      if 100100913 == skill_id or 100100914 == skill_id or 100100931 == skill_id then
        self:to_next_step()
      else
        self:back_to_step(9, 1)
      end
    end
  end)
  g:add_step():listen("on_touch_up", function(output_id, iscancel, input_time)
    if 20 == output_id and input_time >= 0.7 and true ~= iscancel then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(2)
    else
      set_skill_state(1, false)
      self:back_to_step(9, 1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_scene_tips(60932, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    remove_npc(self.monster2)
    self.monster3 = add_npc_by_pos_key(1, 20101502, "M7", 0, 0, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    self:to_next_step()
  end)
  g:add_step(function()
    show_skill_teach_tips(100903, true)
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
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    request_end_teach_level(true)
    remove_npc(self.monster3)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100903 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(60934, true, {})
  end
end

function M:on_input(input_id)
  self:call_guide_listen_func("on_input", input_id)
end

function M:on_touch_up(output_id, iscancel, input_time)
  self:call_guide_listen_func("on_touch_up", output_id, iscancel, input_time)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

return M
