local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
end

function M:on_frame()
  self:search_target()
  if 0 == self.magic_set and self.target then
    self.magic_set = 1
    cast_skill(self.npc, self.target, 300101601, nil, nil)
    self.settlementTime = get_npc_time(self.npc) + 0.7
  end
  if 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    set_ui_object_visible("fight", "JoystickContent", false)
    enter_guide(2001)
    self.magic_set = 2
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_input(input_id)
  if 18 == input_id or 19 == input_id and 2 == self.magic_set then
    self.magic_set = 3
    set_ui_object_visible("fight", "JoystickContent", true)
    abort_magic_by_id(self.npc, 4010010)
  end
end

return M
