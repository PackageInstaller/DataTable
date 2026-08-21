local M = Util.create_class()
local i = false
local k

function M:_init()
  self.search_list = nil
  self.control = 0
  self.timer = 0
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    return
  end
  self.search_list = search_npc(npc, 2, 8, 0, 1, true)
  if not check_magic(npc, 1999030) then
    return
  end
  if self.search_list == nil then
    return
  end
  for j, v in pairs(self.search_list) do
    if true == i then
      return
    end
    if math.random() * 100 >= 50 then
      cast_magic(v, v, 1999030, 1)
      cast_magic(v, v, 1999032, 1)
      cast_magic(v, v, 60530081, 1)
      i = true
      self.timer = get_npc_time(self.npc) + 1
      break
    else
      k = v
    end
  end
  if not i and nil ~= k then
    cast_magic(k, k, 1999030, 1)
    cast_magic(k, k, 60530081, 1)
    i = true
    k = nil
    self.timer = get_npc_time(self.npc) + 1
  end
end

function M:on_frame()
  if true == i and get_npc_time(self.npc) > self.timer then
    i = false
  end
end

return M
