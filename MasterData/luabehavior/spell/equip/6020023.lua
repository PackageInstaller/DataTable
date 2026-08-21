local M = Util.create_class()

function M:_init(npc)
  self.magic_timer = 0
end

function M:on_frame()
  local now_time = get_npc_time(self.npc)
  if now_time >= self.magic_timer + 1 then
    cast_skill(self.npc, self.npc, 100190102, 1)
    self.magic_timer = now_time
  end
end

return M
