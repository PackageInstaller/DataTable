local M = Util.create_class()
local ability = 30002
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
  cast_magic(self.npc, self.npc, 61702021, level)
end

function M:on_room_change(npc)
  cast_magic(self.npc, self.npc, 61702021, level)
end

return M
