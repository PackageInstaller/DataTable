local M = Util.create_class()

function M:_init()
  self.att_target_lists = {}
end

function M:creat_magic(owner, att_target, magic)
  if check_magic(att_target, 1999050) then
    cast_magic(owner, att_target, 60550032, 1)
    local att_target_list = {
      1,
      0,
      0,
      att_target
    }
    table.insert(self.att_target_lists, att_target_list)
  end
end

function M:creat_magic_loop()
  for k, v in pairs(self.att_target_lists) do
    if v then
      if v[1] <= 8 and 0 == v[2] and get_npc_time(self.npc) >= v[3] then
        cast_magic(self.npc, v[4], 60550031, 1)
        v[3] = get_npc_time(self.npc) + 1
        v[1] = v[1] + 1
      end
      if v[1] > 8 then
        table.remove(self.att_target_lists, k)
      end
    end
  end
end

function M:effect_aborn_magic(npc, target, element)
  if npc == get_come_on_hero() and check_magic(target, 1999050) and (2 == element or 3 == element or 4 == element or 5 == element) then
    self:creat_magic(npc, target, element)
  end
end

function M:on_frame()
  self:creat_magic_loop()
end

return M
