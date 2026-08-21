local M = Util.create_class()

function M:_init()
  self.timer = 8
  self.trigger_time = get_time() + 3
end

function M:on_frame()
  local nowtime = get_time()
  if nowtime > self.trigger_time then
    local scale = 1
    local pos = get_npc_pos(self.npc)
    local pos_x = pos.x + math.random() * 0.01
    local pos_z = pos.x + math.random() * 0.01
    cast_missile(self.npc, nil, pos_x, pos_z, 60400000105, 0)
    self.trigger_time = nowtime + self.timer
  end
end

return M
