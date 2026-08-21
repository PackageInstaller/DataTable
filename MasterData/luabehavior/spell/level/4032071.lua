local M = Util.create_class()

function M:_init()
  self.combo_guide = nil
end

function M:on_frame()
  self:search_target()
  if not self.combo_guide and not check_npc_status(self.npc, 1) then
    set_sync_var("combo_guide", 0)
    self.combo_guide = 0
  end
  if self.combo_guide and 0 == self.combo_guide and 1 == get_sync_var("combo_guide") then
    start_skill_teach(100701)
    set_scene_tips(60711, true, {})
    set_ui_object_visible("fight", "Btn_skill1", true)
    self.combo_guide = 1
  end
  if self.combo_guide and 9 == self.combo_guide and get_npc_time(self.npc) > self.reterttime + 1 then
    self.combo_guide = 1
    restart_skill_teach(100701)
    set_ui_object_visible("fight", "Btn_skill1", true)
  end
  if self.combo_guide and 4 == self.combo_guide then
    set_scene_tips(60711, false, {})
    set_ui_object_visible("fight", "Btn_skill1", false)
    self.teahctime1 = get_npc_time(self.npc)
    set_sync_var("combo_guide", 30)
    self.combo_guide = 30
  end
  if self.combo_guide and 30 == self.combo_guide and 32 == get_sync_var("combo_guide") and self.target then
    set_ui_object_visible("fight", "MainEnemyBloodList", false)
    self.teahctime1 = get_npc_time(self.npc)
    self.combo_guide = 32
  end
  if self.combo_guide and 32 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 1 then
    start_skill_teach(100702)
    set_scene_tips(60712, true, {})
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self.combo_guide = 33
  end
  if self.combo_guide and 34 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 3 then
    restart_skill_teach(100702)
    self.combo_guide = 33
    self.teahctime1 = get_npc_time(self.npc)
  end
  if self.combo_guide and 90 == self.combo_guide then
    set_sync_var("combo_guide", 90)
    set_scene_tips(60712, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self.combo_guide = 91
    self.teahctime1 = get_npc_time(self.npc)
  end
  if self.combo_guide and 91 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 2 then
    show_skill_teach_tips(100701, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
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
end

function M:on_skill_teach_tips_close(tips_id)
  if 100701 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(60713, true, {})
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if self.combo_guide >= 1 and self.combo_guide <= 3 and skill_id == 100100700 + self.combo_guide then
    set_skill_state(self.combo_guide, true)
    self.combo_guide = self.combo_guide + 1
    self.teahctime1 = get_npc_time(self.npc)
  elseif self.combo_guide >= 1 and self.combo_guide <= 3 and skill_id ~= 100100700 + self.combo_guide then
    set_skill_state(self.combo_guide, false)
    self.reterttime = get_npc_time(self.npc)
    self.combo_guide = 9
    set_ui_object_visible("fight", "Btn_skill1", false)
  end
  if 34 == self.combo_guide and (100100751 == skill_id or 100100713 == skill_id) then
    set_skill_state(2, true)
    self.combo_guide = 90
    self.teahctime1 = get_npc_time(self.npc)
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_input(input_id)
  if 33 == self.combo_guide and 18 == input_id then
    set_skill_state(1, true)
    self.combo_guide = 34
    self.teahctime1 = get_npc_time(self.npc)
  end
end

return M
