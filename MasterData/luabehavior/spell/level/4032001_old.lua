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
    start_skill_teach(100101)
    set_scene_tips(60101, true, {})
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self.combo_guide = 1
  end
  if self.combo_guide and 9 == self.combo_guide and get_npc_time(self.npc) > self.reterttime + 1 then
    self.combo_guide = 1
    restart_skill_teach(100101)
    set_ui_object_visible("fight", "Btn_skill1", true)
  end
  if self.combo_guide and 4 == self.combo_guide then
    set_sync_var("combo_guide", 4)
    set_scene_tips(60101, false, {})
    self.combo_guide = 5
  end
  if self.combo_guide and 5 == self.combo_guide and 5 == get_sync_var("combo_guide") and self.target then
    set_ui_object_visible("fight", "MainEnemyBloodList", false)
    self.teahctime1 = get_npc_time(self.npc)
    self.combo_guide = 6
  end
  if self.combo_guide and 6 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 1 then
    set_scene_tips(60101, false, {})
    start_skill_teach(100102)
    set_scene_tips(60102, true, {})
    set_ui_object_visible("fight", "Btn_skill3", true)
    self.combo_guide = 20
  end
  if self.combo_guide and 21 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 3 then
    restart_skill_teach(100102)
    self.combo_guide = 20
    self.teahctime1 = get_npc_time(self.npc)
  end
  if self.combo_guide and 22 == self.combo_guide then
    set_sync_var("combo_guide", 23)
    set_scene_tips(60102, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self.combo_guide = 23
    self.teahctime1 = get_npc_time(self.npc)
  end
  if self.combo_guide and 23 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 2 then
    show_skill_teach_tips(100101, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.combo_guide = 24
  end
  if 24 == self.combo_guide and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
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
  if 100101 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(60111, true, {})
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if self.combo_guide >= 1 and self.combo_guide <= 3 and (skill_id == 100100100 + self.combo_guide or 100100150 == skill_id) then
    set_skill_state(self.combo_guide, true)
    self.combo_guide = self.combo_guide + 1
    self.teahctime1 = get_npc_time(self.npc)
  elseif self.combo_guide >= 1 and self.combo_guide <= 3 and skill_id ~= 100100100 + self.combo_guide then
    set_skill_state(self.combo_guide, false)
    self.reterttime = get_npc_time(self.npc)
    self.combo_guide = 9
    set_ui_object_visible("fight", "Btn_skill1", false)
  end
  if 21 == self.combo_guide and 100100113 == skill_id then
    set_skill_state(2, true)
    self.combo_guide = 22
    self.teahctime1 = get_npc_time(self.npc)
  elseif 21 == self.combo_guide and 100100113 ~= skill_id and get_npc_time(self.npc) > self.teahctime1 + 0.1 then
    restart_skill_teach(100102)
    self.combo_guide = 20
    self.teahctime1 = get_npc_time(self.npc)
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if 20 == self.combo_guide and m1_owner == self.npc and 3 == m1_cfg.MissileTypeTag and m2_owner ~= self.npc and not check_magic(m1_owner, 1999125) then
    set_skill_state(1, true)
    self.combo_guide = 21
    self.teahctime1 = get_npc_time(self.npc)
  end
end

return M
