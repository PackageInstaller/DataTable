local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
end

function M:on_start()
end

function M:on_frame()
  self:search_target()
  if 1 == get_sync_var("looknpc") and self.target then
    self.settlementTime = get_npc_time(self.target) + 3
    set_sync_var("looknpc", 2)
  end
  if 2 == get_sync_var("looknpc") and self.target and get_npc_time(self.target) > self.settlementTime and not check_npc_status(self.target, 1) then
    self.settlementTime = get_npc_time(self.target) + 0.2
    set_sync_var("looknpc", 3)
  end
  if 3 == get_sync_var("looknpc") and get_npc_time(self.target) > self.settlementTime then
    focus_npc(self.npc)
    set_scene_tips(50010, true, {})
    set_sync_var("looknpc", 4)
  end
  if 4 == get_sync_var("looknpc") and check_npc_btn_interact(50000) then
    clear_focal()
    cast_magic(self.target, self.target, 100173, 1)
    cast_magic(self.target, self.target, 100175, 1)
    set_ui_object_visible("fight", "JoystickContent", false)
    stop_skill_joystick_move(self.target)
    clear_input()
    lookat_npc(self.target, self.npc, 0)
    enter_guide(2021)
    self.settlementTime = get_npc_time(self.target)
    set_scene_tips(50010, false, {})
    set_sync_var("looknpc", 5)
  end
  if 5 == get_sync_var("looknpc") and get_npc_time(self.target) > self.settlementTime then
    set_sync_var("looknpc", 6)
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 2, 30, nil, 1)
end

function M:on_finish_guide(guide_id)
  if 2021 == guide_id then
    abort_magic_by_id(self.target, 100173)
    abort_magic_by_id(self.target, 100175)
    set_ui_object_visible("fight", "JoystickContent", true)
  end
end

function M:on_room_change(npc)
  if npc ~= self.npc then
    return
  end
  abort_magic_by_id(self.target, 100173)
  abort_magic_by_id(self.target, 100175)
  set_ui_object_visible("fight", "JoystickContent", true)
end

return M
