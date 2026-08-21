local M = Util.create_class()

function M:_init(npc)
end

function M:on_input(input_id)
  if 62 == input_id and get_cur_room_id() == 1002 then
    if check_npc_die(self.npc) then
      return
    end
    local curHp = get_npc_attr(self.npc, 1)
    local maxHp = get_npc_attr(self.npc, 4)
    local percent = curHp / maxHp
    if percent > 0.01 then
      cast_magic(self.npc, self.npc, 403210037, 1, 1)
    else
      return
    end
  end
end

return M
