local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if get_npc_count_by_res_id(6170894) < 1 then
    local hero = get_come_on_hero()
    local pos = {}
    pos = get_npc_pos(hero)
    add_npc2(1, 6170894, pos.x, pos.z, pos.x, pos.z, 2, 1)
  end
end

return M
