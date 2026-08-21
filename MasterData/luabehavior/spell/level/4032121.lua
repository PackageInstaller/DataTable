local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.init_guide = false
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
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "center", 0, 0, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(101201)
    else
      start_skill_teach(101201)
      set_scene_tips(61211, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100101200 + g:step_index() - 2
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 2, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - 2, false)
      self:back_to_step(2, 1)
    end
  end
  
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    local target_skill_id = 100101204
    if target_skill_id == skill_id then
      set_skill_state(4, true)
      self:to_next_step(2)
    else
      set_skill_state(4, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(2, 1)
    end
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100101204 == skill_id then
      cast_magic(hit_target, hit_target, 4032124, 0)
    end
  end):listen("on_skill_end", function(npc, skill_id)
    if 100101204 == skill_id then
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    set_scene_tips(61211, false, {})
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_guide("guide2")
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    remove_npc(self.monster1)
    self.monster2 = add_npc_by_pos_key(1, 20102802, "center", 0, 0, "tp1", 0, 0, 4, 99)
    set_sync_var("in_daze", 0)
    start_skill_teach(101403)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    set_scene_tips(61404, true, {})
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(101202)
    else
      start_skill_teach(101202)
      set_scene_tips(61212, true, {})
      set_ui_object_visible("fight", "Btn_skill1", true)
      set_ui_object_visible("fight", "Btn_skill3", true)
      set_ui_object_visible("fight", "JoystickContent", true)
    end
  end):listen("on_missile_collide", function(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
    if m1_owner == self.npc and 3 == m1_cfg.MissileTypeTag and m2_owner ~= self.npc and not check_magic(m1_owner, 1999125) then
      set_skill_state(1, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      self:back_to_step(2)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, skill_type)
    if 100101221 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 0.2 then
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(61212, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    show_skill_teach_tips(101201, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
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
    remove_npc(self.god1)
    remove_npc(self.monster2)
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    request_end_teach_level(true)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101201 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(61213, true, {})
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

return M
