local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if 1 == element and get_npc_count_by_res_id(6170892) < rogueMgr.paotai_limit then
    local pos = {}
    pos = get_npc_pos(npc)
    add_npc2(1, 6170892, pos.x, pos.z, pos.x, pos.z, 2, 1)
  end
end

function M:on_start()
  rogueMgr.add_paotai_magic = true
end

function M:on_remove()
  local bool, num = tool:checkMagicToTeam(6170812)
  if 0 == num then
    rogueMgr.add_paotai_magic = false
  end
end

return M
