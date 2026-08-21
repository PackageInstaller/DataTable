local M = Util.create_class()

function M:_init()
  self.count = 0
end

function M:on_floor_finished(npc1, npc2, npc3, floor)
  self.count = self.count + 1
  if nil ~= npc1 then
    cast_magic(npc1, npc1, 60720801, 1)
  end
  if nil ~= npc2 then
    cast_magic(npc2, npc2, 60720801, 1)
  end
  if nil ~= npc3 then
    cast_magic(npc3, npc3, 60720801, 1)
  end
end

return M
