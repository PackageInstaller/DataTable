local M = Util.create_class()

function M:_init()
  self.time = 0
  self.nums = 1
end

function M:creat_magic()
  if get_npc_time(self.npc) >= self.time and self.nums <= 8 then
    cast_magic(self.npc, self.npc, 60550042, 1)
    self.time = get_npc_time(self.npc) + 1
    self.nums = self.nums + 1
  end
end

function M:on_frame()
  if self.nums <= 8 then
    self:creat_magic()
  end
end

return M
