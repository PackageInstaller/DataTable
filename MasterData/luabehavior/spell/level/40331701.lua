local M = Util.create_class()
local bornNum = 0
local bornMagic = true

function M:_init()
end

function M:on_npc_born(npc)
  if get_come_on_hero() == self.npc then
    local kind = get_role_kind(npc)
    bornNum = bornNum + 1
    if bornNum >= 10 then
      bornMagic = true
    end
    if bornMagic and get_come_on_hero() == self.npc and 2 == kind and math.random(1, 5) > 2 then
      cast_magic(npc, npc, 40331702, 1)
      bornNum = 0
      bornMagic = false
    end
  end
end

return M
