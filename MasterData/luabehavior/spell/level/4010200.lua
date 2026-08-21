local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.weak_guide = 0
  self.clear_fx = nil
  self.clear_fx_set = false
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 99 == self.magic_set and hit_target == self.npc and 0 ~= hit_type then
    abort_magic_by_id(npc, 2999001)
    abort_magic_by_id(npc, 201046040)
    self.magic_set = 98
  end
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 10010060904 and self.clear_fx_set == false then
    self.clear_fx = missile
    self.clear_fx_set = true
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 10010060904 and self.clear_fx_set == true then
    self.clear_fx = nil
    self.clear_fx_set = false
  end
end

function M:on_frame()
  if 0 == self.magic_set and 1 == get_sync_var("1001006_guide") and search_npc(self.npc, 4, 12, nil, 1) then
    self.settlementTime = get_npc_time(self.npc) + 0.5
    self.magic_set = 1
  end
  if 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime and search_npc(self.npc, 4, 12, nil, 1) then
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(4003)
    set_sync_var("1001006_guide", 2)
    self.magic_set = 2
  end
  if 2 == self.magic_set and 3 == get_sync_var("1001006_guide") and search_npc(self.npc, 4, 1.5, nil, 1) then
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_sync_var("Dafu_teach", true)
    enter_guide(4002)
    abort_skill(self.npc)
    set_sync_var("1001006_guide", 99)
    self.magic_set = 99
  end
  if 98 == self.magic_set and 99 == get_sync_var("1001006_guide") then
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(4007)
    self.magic_set = 3
    set_sync_var("1001006_guide", 4)
  end
  if 3 == self.magic_set and 5 == get_sync_var("1001006_guide") and search_npc(self.npc, 4, 3, nil, 1) then
    self.settlementTime = get_npc_time(self.npc) + 0.5
    self.magic_set = 4
  end
  if 4 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    abort_skill(self.npc, 1)
    clear_input(20)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    enter_guide(4004)
    self.magic_set = 5
  end
  if 5 == self.magic_set and 6 == get_sync_var("1001006_guide") and get_npc_time(self.npc) > self.settlementTime and not check_npc_status(self.npc, 1) then
    cast_magic(self.npc, self.npc, 4010197, 1)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(4005)
    set_sync_var("1001006_guide", 7)
    self.magic_set = 6
  end
  if 9 == get_sync_var("1001006_guide") then
    force_finish_cur_guide(4006)
    if self.clear_fx_set == true then
      remove_missile(self.clear_fx)
    end
    set_sync_var("1001006_guide", 10)
  end
  if 1 == self.weak_guide and get_npc_time(self.npc) > self.settlementTime then
    enter_guide(4006)
    self.weak_guide = 2
  end
  if 2 == self.weak_guide and not check_magic(self.npc, 1006119) then
    force_finish_cur_guide(4006)
    self.weak_guide = 3
  end
end

function M:on_finish_guide(guide_id)
  if 4002 == guide_id then
    set_ui_object_visible("fight", "Btn_skill4", true)
  end
  if 4004 == guide_id then
    self.settlementTime = get_npc_time(self.npc) + 0.5
    set_sync_var("1001006_guide", 6)
  end
  if 4003 == guide_id then
    set_scene_tips(801018, true, {})
  end
  if 4005 == guide_id then
    self.settlementTime = get_npc_time(self.npc) + 1.5
    self.weak_guide = 1
  end
end

return M
