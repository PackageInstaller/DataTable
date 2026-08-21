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

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "center", 0, -1, "tp3", 0, 0, 4, 99)
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
      restart_skill_teach(100405)
      cast_magic(self.npc, self.npc, 4032048, 0)
    else
      start_skill_teach(100405)
      cast_magic(self.npc, self.npc, 4032048, 0)
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    cast_magic(self.npc, self.npc, 4032048, 1)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100408)
      cast_magic(self.npc, self.npc, 4032048, 0)
    else
      start_skill_teach(100408)
      cast_magic(self.npc, self.npc, 4032048, 0)
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    cast_magic(self.npc, self.npc, 4032048, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100421 == skill_id or 100100422 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    else
      set_skill_state(1, false)
      self:back_to_step(2, 1)
    end
    g:add_step(function()
      cast_magic(self.npc, self.npc, 4032048, 0)
      self:to_next_step(1)
    end)
  end)
  g:add_step(function()
    self:guide_timeout(10, function()
      set_skill_state(2, false)
      self:back_to_step(2)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100431 == skill_id or 100100432 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step(0.2)
    else
      set_skill_state(2, false)
      cast_magic(self.npc, self.npc, 4032048, 0)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step()
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step()
  end)
  g:add_step(function()
    set_scene_tips(60431, false, {})
    self:to_next_guide("guide3", 1)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "center", 0, -1, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    cast_magic(self.npc, self.npc, 40320401, 1)
    set_scene_tips(60432, true, {})
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100409)
      cast_magic(self.npc, self.npc, 40320401, 1)
      cast_magic(self.npc, self.npc, 4032048, 0)
    else
      cast_magic(self.npc, self.npc, 40320401, 1)
      start_skill_teach(100409)
    end
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100442 == skill_id then
      set_skill_state(1, true)
      self:to_next_step(2)
    else
      set_skill_state(1, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 1999217, 0)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    show_skill_teach_tips(100403, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    set_scene_tips(60432, false, {})
    self.finished_teach_guide = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  cast_magic(self.npc, self.npc, 4032013, 0)
  cast_magic(self.npc, self.npc, 4032004, 0)
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide2()
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

function M:add_energy()
  local characeter_energy = get_npc_attr(self.npc, 2)
  if characeter_energy <= 200 then
    cast_magic(self.npc, self.npc, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide2()
  end
  if self.finished_teach_guide and not self.quit_scene and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    self.quit_scene = true
    remove_scene_effect("jiaohu")
    remove_npc(self.god1)
    remove_npc(self.monster1)
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    request_end_teach_level(true)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100403 == tips_id then
    set_scene_tips(801019, true, {})
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
