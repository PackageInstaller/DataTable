local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:check_perfect()
  if check_magic(self.npc, 1999198) or check_magic(self.npc, 1999187) then
    cast_magic(get_god_npc(), get_god_npc(), 66605501)
  end
end

function M:on_frame()
  self:check_perfect()
end

return M
