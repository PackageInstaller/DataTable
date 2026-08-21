local M = Util.create_class()
local target_list = {}
local team_hero_list = {}
local time = 0
local interval_time = 0
local ability = 60007
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_element_aborn_start(npc, element)
  if self.npc == get_come_on_hero() then
    cast_magic(self.npc, self.npc, 61705071, level)
  end
end

return M
