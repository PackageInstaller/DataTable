local M = Util.create_class()
local target_list = {}
local team_hero_list = {}
local time = 0
local interval_time = 0
local ability = 60008
local level = 1
local magic_list = {
  1999990,
  1999991,
  1999992,
  1999993,
  1999994
}

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_element_aborn_start(npc, element)
  if self.npc == get_come_on_hero() then
    for k, v in pairs(magic_list) do
      if check_magic(npc, v) then
        cast_magic(self.npc, npc, 61705081, level)
        return
      end
    end
  end
end

return M
