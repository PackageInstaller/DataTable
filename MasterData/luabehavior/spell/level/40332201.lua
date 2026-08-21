local M = Util.create_class()
local tool = import("common.tool")

function M:_init()
end

function M:on_born_behavior()
  local unit = self.npc:get_behavior()
  if not unit then
    return
  end
  
  local function red_skill_counter_fragile(unit, attackerNpc, victimNpc)
    cast_magic(attackerNpc, attackerNpc, 4033220101, 1)
    cast_magic(attackerNpc, victimNpc, 4033220101, 1)
  end
  
  tool.insert(unit, "on_red_skill_countered", red_skill_counter_fragile)
end

return M
