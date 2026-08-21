local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
end

function M:on_frame()
end

function M:on_input(input_id)
  if 18 == input_id then
    cast_magic(self.npc, self.npc, 4010193, 1)
  end
end

return M
