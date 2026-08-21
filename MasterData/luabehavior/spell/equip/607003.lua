local M = Util.create_class()

function M:_init(npc)
  self.blood = 0
  self.bleeding_timer = 0
end

function M:on_frame()
  local now_hp = get_npc_attr(self.npc, 1)
  self:get_npc_HP(now_hp)
  self:bleeding(now_hp)
  self:disenagement_from_battle()
end

function M:get_npc_HP(now_hp)
  if get_npc_attr(self.npc, 1) <= 1 then
    self.blood = 0
  end
end

function M:bleeding(now_hp)
  if get_npc_attr(self.npc, 1) > 1 then
    self.blood = 1
  end
  if get_npc_time(self.npc) >= self.bleeding_timer and 1 == self.blood then
    cast_magic(self.npc, self.npc, 6070030, 1)
    self.bleeding_timer = get_npc_time(self.npc) + 1
  end
end

function M:disenagement_from_battle()
  if not is_in_challenge() then
    self.blood = 0
  end
  if is_pass_room() then
    self.blood = 0
  end
end

return M
