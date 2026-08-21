local M = Util.create_class()

function M:_init(npc)
end

function M:on_start()
  self:play_DBM_ani(11)
end

return M
