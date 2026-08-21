local M = Util.create_class()

function M:_init()
  self.nowTime = 0
  self.magicTime = 0
end

function M:on_start()
end

function M:on_frame()
  self.nowTime = get_time()
  if self.nowTime >= self.magicTime then
    self.magicTime = self.nowTime + 1
    cast_magic(self.npc, self.npc, 7000020602, 1)
  end
end

return M
