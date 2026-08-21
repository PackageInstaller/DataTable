local M = Util.create_class()
local tool = import("common.tool")
local is_niubi = false

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if self.npc == get_come_on_hero() then
    local level = get_ability_level(30023) or 1
    cast_magic(self.npc, npc, 61709371, level)
  end
end

function M:_init(npc)
end

return M
