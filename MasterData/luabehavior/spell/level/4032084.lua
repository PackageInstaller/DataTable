local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.init_guide = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "M31", 0, 0, "tp3", 0, 0, 4, 99)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "M32", 3, 0, "tp3", 0, 0, 4, 99)
    self.monster3 = add_npc_by_pos_key(1, 20101502, "M33", -3, 0, "tp3", 0, 0, 4, 99)
    self.monster4 = add_npc_by_pos_key(1, 20101502, "M34", 0, 3, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    cast_magic(self.monster4, self.monster4, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1.2)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 4032175, 1)
      cast_magic(self.npc, self.npc, 4032176, 1)
      restart_skill_teach(100806)
    else
      cast_magic(self.npc, self.npc, 4032175, 1)
      cast_magic(self.npc, self.npc, 4032176, 1)
      start_skill_teach(100806)
    end
    set_scene_tips(60832, true, {})
    cast_magic(self.npc, self.npc, 4032992, 0)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100819 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:to_next_step(2)
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    show_skill_teach_tips(100805, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.finished_teach_guide = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_skill_teach_tips_close(tips_id)
  if 100805 == tips_id then
    set_scene_tips(801019, true, {})
  end
end

function M:on_frame()
  Base.on_frame(self)
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
  if self.init_guide and not self.quit_scene and get_npc_attr(self.npc, 108) < get_npc_attr(self.npc, 109) and not is_cast_skill_time(self.npc, 100100819) and not is_cast_skill_time(self.npc, 100100820) and not is_cast_skill_time(self.npc, 100100821) then
    cast_magic(self.npc, self.npc, 4032992, 0)
  end
  if self.finished_teach_guide and not self.quit_scene and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    self.quit_scene = true
    remove_npc(self.monster1)
    remove_npc(self.monster2)
    remove_npc(self.monster3)
    remove_npc(self.monster4)
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

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_end(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_end", npc, skill_id, skill_type)
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
