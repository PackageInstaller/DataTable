local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.init_guide = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "center", 0, 1, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1.2)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 4032175, 1)
      cast_magic(self.npc, self.npc, 4032176, 1)
      restart_skill_teach(101705)
    else
      cast_magic(self.npc, self.npc, 4032175, 1)
      cast_magic(self.npc, self.npc, 4032176, 1)
      start_skill_teach(101705)
      set_scene_tips(61711, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    cast_magic(self.npc, self.npc, 4032992, 1)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101781 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:to_next_step(2.5)
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(1)
  end)
  g:add_step(function()
    show_skill_teach_tips(101703, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.finished_teach_guide = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_skill_teach_tips_close(tips_id)
  if 101703 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(61711, true, {})
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
    self:teach_guide1()
  end
  if self.finished_teach_guide and not self.quit_scene and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    self.quit_scene = true
    remove_scene_effect("jiaohu")
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    cast_magic(self.npc, self.npc, 1014404, 1)
    remove_npc(self.monster1)
    request_end_teach_level(true)
  end
end

function M:search_target()
end

function M:on_input(input_id)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_end(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_end", npc, skill_id, skill_type)
  if 100101781 == skill_id then
    cast_magic(self.npc, self.npc, 4032992, 1)
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

function M:on_magic_end(npc, target, magic_id)
  self:call_guide_listen_func("on_on_magic_end", npc, target, magic_id)
end

return M
