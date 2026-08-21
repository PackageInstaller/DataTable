local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
  self.pos1 = nil
  self.monsternum = 0
end

function M:on_start()
end

function M:on_frame()
  self:search_target()
  if 0 == self.magic_set and self.target then
    self.magic_set = 11
    self.settlementTime = get_npc_time(self.npc) + 0.1
    self.pos1 = get_npc_pos(self.target)
    set_npc_hp_visible(self.target, false)
  end
  if 11 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    self.magic_set = 21
  end
  if 21 == self.magic_set and 3 == get_sync_var("rock_in_daze") and self.target and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 6, 1) then
    abort_magic_by_id(self.target, 399933, 1)
    force_finish_cur_guide(2014)
    cast_magic(self.target, self.target, 4010176, 1)
    set_sync_var("zeroth", 10)
    self.magic_set = 22
  end
  if 22 == self.magic_set and 11 == get_sync_var("zeroth") then
    self.settlementTime = get_npc_time(self.npc) + 0.3
    self.magic_set = 31
  end
  if 31 == self.magic_set and 12 == get_sync_var("zeroth") then
    cast_magic(self.npc, self.npc, 1999132, 0)
    cast_magic(self.npc, self.npc, 1999133, 0)
    cast_magic(self.npc, self.npc, 1999172, 0)
    self.settlementTime = get_npc_time(self.npc) + 0.5
    self.magic_set = 32
  end
  if 32 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    clear_input()
    self.magic_set = 41
    abort_magic_by_id(self.npc, 4010196)
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_click_fight_story(story_id, branch_id)
  if 1203 == story_id then
  end
end

function M:on_finish_guide(guide_id)
end

function M:on_npc_hp_zero(npc)
end

return M
