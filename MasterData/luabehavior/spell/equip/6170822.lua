local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local ultMgr = import("character.base.base_ultManager")

function M:_init(npc)
end

function M.add_device(ultMgr, isInit)
  if isInit then
    return
  end
  if get_npc_count_by_res_id(6170893) < 1 then
    local pos = {}
    pos = get_npc_pos(get_come_on_hero())
    add_npc2(1, 6170893, pos.x, pos.z, pos.x, pos.z, 2, 1)
  end
end

function M:on_start()
  tool.insert(ultMgr, "closeLink", self.add_device)
end

function M:on_remove()
  tool.remove(ultMgr, "closeLink", self.add_device)
end

return M
