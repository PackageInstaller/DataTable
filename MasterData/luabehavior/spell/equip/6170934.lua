local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:on_start()
  local level = get_ability_level(30020) or 1
  cast_magic(self.npc, self.npc, 61709341, level)
end

function M:on_fate_book_battle_start()
  rogueMgr:add_water_control_magic(self.npc)
end

function M:on_npc_born(npc)
  rogueMgr:born_add_water_control(self.npc, npc)
end

function M:_init(npc)
  rogueMgr.element_add_water = true
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170934)
  if 0 == num then
    rogueMgr.element_add_water = false
  end
end

return M
