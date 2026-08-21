local M = Util.create_class()

function M:_init()
  Base._init(self)
  self.init_guide = false
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill2", false)
    self.do_once = true
  end
end

function M:on_frame()
  self:search_target()
  if not self.combo_guide and not check_npc_status(self.npc, 1) then
    set_sync_var("combo_guide", 0)
    self.combo_guide = 0
  end
  if self.combo_guide and 0 == self.combo_guide and 1 == get_sync_var("combo_guide") then
    set_scene_tips(60821, true, {})
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(5011)
    self.combo_guide = 1
  end
  if self.combo_guide and 2 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 1 then
    set_scene_tips(60812, false, {})
    enter_guide(5012)
    self.combo_guide = 3
  end
  if self.combo_guide and 4 == self.combo_guide then
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(50121)
    self.combo_guide = 5
  end
  if self.combo_guide and 20 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 2 then
    set_ui_object_visible("fight", "Btn_skill4", true)
    cast_magic(self.npc, self.npc, 4032084, 1)
    start_skill_teach(100803)
    set_ui_object_visible("fight", "JoystickContent", true)
    self.combo_guide = 21
  end
  if self.combo_guide and 22 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 3 then
    restart_skill_teach(100803)
    cast_magic(self.npc, self.npc, 4032084, 1)
    cast_magic(self.npc, self.npc, 4032086, 1)
    self.combo_guide = 21
    self.teahctime1 = get_npc_time(self.npc)
  end
  if self.combo_guide and 30 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 1.5 then
    set_ui_object_visible("fight", "JoystickContent", false)
    self.combo_guide = 31
  end
  if self.combo_guide and 90 == self.combo_guide then
    set_sync_var("combo_guide", 91)
    set_scene_tips(60822, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self.combo_guide = 91
    self.teahctime1 = get_npc_time(self.npc)
  end
  if self.combo_guide and 91 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 then
    show_skill_teach_tips(100802, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    set_sync_var("combo_guide", 92)
    self.combo_guide = 92
  end
  if 92 == self.combo_guide and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    remove_scene_effect("jiaohu")
    remove_npc(self.god1)
    set_sync_var("combo_guide", 99)
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    self.combo_guide = 99
  end
  if 92 == self.combo_guide and get_npc_attr(self.npc, 2) < 100 then
    cast_magic(self.npc, self.npc, 4032085, 1)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100802 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(60823, true, {})
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    cast_magic(self.npc, self.npc, 4032085, 1)
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_finish_guide(guide_id)
  if 5011 == guide_id then
    self.teahctime1 = get_npc_time(self.npc)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_scene_tips(60811, false, {})
    self.combo_guide = 2
  end
  if 5012 == guide_id then
    self.teahctime1 = get_npc_time(self.npc)
    self.combo_guide = 4
  end
  if 50121 == guide_id then
    self.teahctime1 = get_npc_time(self.npc)
    set_ui_object_visible("fight", "Btn_skill4", false)
    self.combo_guide = 20
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 21 == self.combo_guide and 100100809 == skill_id then
    set_skill_state(1, true)
    self.combo_guide = 22
    self.teahctime1 = get_npc_time(self.npc)
  end
  if 22 == self.combo_guide and (100100805 == skill_id or 100100806 == skill_id or 100100807 == skill_id) then
    set_skill_state(2, true)
    self.combo_guide = 30
    self.teahctime1 = get_npc_time(self.npc)
  end
end

function M:on_skill_end(npc, skill_id)
end

function M:on_input(input_id)
end

function M:on_touch_up(output_id, iscancel)
end

return M
