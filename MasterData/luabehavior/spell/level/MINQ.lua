local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.init_guide = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    request_teach_scene_create_monster("monster_group1")
    g:wait_create_monster("monster_group1", function()
      self:to_next_step()
    end)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100101)
    else
      start_skill_teach(100101)
      set_scene_tips(60101, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100100100 + g:step_index() - 2
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 2, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - 2, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(2, 1)
    end
  end
  
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    set_scene_tips(60101, false, {})
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_guide("guide2", 2)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100108)
    else
      start_skill_teach(100108)
      set_scene_tips(60141, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_input", function(input_id)
    if 15 == input_id then
      start_long_click_skill()
    end
  end):listen("on_touch_up", function(output_id, iscancel, input_time)
    if 15 == output_id and input_time >= 0.35 then
      set_skill_state(g:step_index() - 1, true)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - 1, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(60141, false, {})
    self:to_next_guide("guide3", 2)
  end)
  g:add_step(function()
    show_skill_teach_tips(100101, true)
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
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    request_end_teach_level(true)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100101 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(60111, true, {})
  end
end

function M:search_target()
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

function M:on_input(input_id)
  self:call_guide_listen_func("on_input", input_id)
end

function M:on_touch_up(output_id, iscancel, input_time)
  self:call_guide_listen_func("on_touch_up", output_id, iscancel, input_time)
end

return M
