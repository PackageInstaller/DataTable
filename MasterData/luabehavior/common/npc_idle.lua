local M = Util.create_class()

function M:_init()
end

function M:on_frame()
  if check_magic(self.npc, 100174) or check_magic(self.npc, 100175) then
    stop_move(self.npc)
    abort_skill(self.npc)
  end
end

return M
