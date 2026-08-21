local M = Util.create_class()

function M:_init()
  self.nowTime = 0
  self.intervalTime = 2
end

function M:on_frame()
  self.nowTime = get_npc_time(self.npc)
  if self.nowTime >= self.intervalTime then
    self.intervalTime = self.nowTime + 2
    local monster, numb = search_npc(self.npc, 2, 4, nil, true, true)
    for k, v in pairs(monster) do
      cast_magic(v, v, 4033170201, 1)
    end
  end
end

return M
