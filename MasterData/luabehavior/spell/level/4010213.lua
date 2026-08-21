local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
  char_visible(false)
end

function M:on_start()
end

function M:on_frame()
  if 0 == self.magic_set then
    self.magic_set = 1
  end
  if 1 == self.magic_set then
    abort_magic_by_id(self.npc, 4010213, 1)
    self.magic_set = 2
  end
end

return M
