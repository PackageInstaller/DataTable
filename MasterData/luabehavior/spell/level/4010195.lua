local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
  self.pos1 = nil
  self.monsternum = 0
end

function M:on_start()
  self.god1 = add_npc_by_pos_key(1, 3001024, "B2", 0, 0, "tp3", 0, 0, 2, 1)
  self.pos1 = get_npc_pos(self.god1)
end

function M:on_frame()
  self:search_target()
  if 0 == self.magic_set then
    self.magic_set = 11
    self.settlementTime = get_npc_time(self.npc) + 0.1
  end
  if 11 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.magic_set = 21
  end
  if 21 == self.magic_set and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    remove_scene_effect("jiaohu")
    remove_npc(self.god1)
    force_finish_cur_guide(2014)
    set_sync_var("zeroth", 6)
    self.settlementTime = get_npc_time(self.npc) + 0.3
    self.magic_set = 31
  end
  if 31 == self.magic_set and 7 == get_sync_var("zeroth") and get_npc_time(self.npc) > self.settlementTime then
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(2007)
    self.magic_set = 32
  end
  if 33 == self.magic_set and get_npc_time(self.npc) > self.settlementTime and not check_magic(self.npc, 1001305) then
    force_finish_cur_guide(2012)
    self.magic_set = 34
  end
  if 34 == self.magic_set and 8 == get_sync_var("zeroth") then
    self.settlementTime = get_npc_time(self.npc) + 0.2
    self.magic_set = 41
  end
  if 41 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    self.magic_set = 42
  end
  if 42 == self.magic_set then
    if self.target then
      set_ui_object_visible("fight", "Btn_skill5", true)
      lookat_npc(self.npc, self.target, 1)
      enter_guide(2008)
    end
    self.magic_set = 51
  end
  if 51 == self.magic_set and 9 == get_sync_var("zeroth") then
    cast_magic(self.npc, self.npc, 1999132, 0)
    cast_magic(self.npc, self.npc, 1999133, 0)
    cast_magic(self.npc, self.npc, 1999172, 0)
    enter_guide(2014)
    abort_magic_by_id(self.npc, 4010195)
    self.magic_set = 52
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_click_fight_story(story_id, branch_id)
end

function M:on_finish_guide(guide_id)
  if 2007 == guide_id then
    set_ui_object_visible("fight", "Btn_skill5", false)
    enter_guide(2012)
    self.magic_set = 33
    self.settlementTime = get_npc_time(self.npc) + 0.5
  end
  if 2012 == guide_id then
    self.magic_set = 34
  end
end

return M
