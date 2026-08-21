local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
  self.pos1 = nil
  self.monsternum = 0
  self.born_anim_end = false
end

function M:on_start()
  self.god1 = add_npc_by_pos_key(1, 3001024, "B1", 0, 0, "tp3", 0, 0, 2, 1)
  self.pos1 = get_npc_pos(self.god1)
  stop_touch_swip(true)
  self.settlementTime = get_npc_time(self.npc) + 2
end

function M:on_frame()
  self:search_target()
  if 0 == self.magic_set then
    set_ui_object_visible("fight", "Btn_skill8", false)
  end
  if 0 == self.magic_set and not check_npc_status(self.npc, 1) and (self.born_anim_end or get_npc_time(self.npc) > self.settlementTime) then
    self.magic_set = 11
    self.settlementTime = get_npc_time(self.npc) + 0.1
  end
  if 11 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    self.magic_set = 31
    stop_touch_swip(false)
  end
  if 31 == self.magic_set then
    set_ui_object_visible("fight", "JoystickContent", true)
    enter_guide(2004)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.magic_set = 41
  end
  if 51 == self.magic_set and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    remove_scene_effect("jiaohu")
    remove_npc(self.god1)
    set_sync_var("zeroth", 1)
    self.magic_set = 52
  end
  if 52 == self.magic_set and 2 == get_sync_var("zeroth") and self.target then
    set_scene_camera(9902)
    cast_magic(self.target, self.target, 4010214, 1)
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    cast_magic(self.npc, self.npc, 399933, 1)
    set_ui_object_visible("fight", "JoystickContent", false)
    stop_skill_joystick_move(self.npc)
    clear_input()
    self.magic_set = 61
  end
  if 61 == self.magic_set and 4 == get_sync_var("zeroth") then
    self.settlementTime = get_npc_time(self.npc) + 0.2
    self.magic_set = 71
  end
  if 71 == self.magic_set and self.target and get_npc_time(self.npc) > self.settlementTime then
    set_ui_object_visible("fight", "Btn_skill4", true)
    cast_magic(self.npc, self.npc, 4010158, 1)
    lookat_npc(self.npc, self.target, 1)
    enter_guide(2002)
    self.magic_set = 81
  end
  if 91 == self.magic_set then
    cast_magic(self.npc, self.npc, 4010173, 1)
    self.magic_set = 101
  end
  if 111 == self.magic_set and 5 == get_sync_var("zeroth") then
    cast_magic(self.npc, self.npc, 1999132, 0)
    cast_magic(self.npc, self.npc, 1999133, 0)
    cast_magic(self.npc, self.npc, 1999172, 0)
    enter_guide(2014)
    abort_magic_by_id(self.npc, 4010194)
    self.magic_set = 112
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_click_fight_story(story_id, branch_id)
  if 1104 == story_id then
  end
end

function M:on_finish_guide(guide_id)
  if 2004 == guide_id then
    self.magic_set = 51
  end
  if 2002 == guide_id then
    self.magic_set = 91
  end
  if 2003 == guide_id then
    self.magic_set = 111
  end
end

function M:on_hero_born_anim_end()
  self.born_anim_end = true
end

return M
