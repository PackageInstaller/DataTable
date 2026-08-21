local M = Util.create_class()
local ability = 30001
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
  cast_magic(self.npc, self.npc, 61702011, level)
end

return M
