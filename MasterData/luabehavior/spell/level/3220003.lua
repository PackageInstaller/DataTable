local M = Util.create_class()

function M:_init()
end

function M:on_frame()
  local target = get_come_on_hero()
  if get_npc_attr(target, 1) < get_npc_attr(target, 4) * 0.1 then
    on_level_counter_add("win", 0)
  end
end

return M
