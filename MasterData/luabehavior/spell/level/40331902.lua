local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    cast_missile(self.npc, get_come_on_hero(), nil, nil, 30020200103, 1)
  end
end

return M
