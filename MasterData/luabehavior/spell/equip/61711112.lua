local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local tool = import("common.tool")

function M:on_start()
  self.init_time = get_npc_time(self.npc)
  self.cd = 0
end

function M:on_frame()
  local bool, num = tool:checkMagicToTeam(rogueMgr.shengguang)
  if num > 0 and get_npc_time(self.npc) > self.init_time + self.cd then
    cast_missile3(get_come_on_hero(), get_come_on_hero(), nil, nil, 61711910405)
    self.init_time = get_npc_time(self.npc)
    self.cd = 0.5
  end
end

function M:on_magic_end(npc, target, magic_id, magic_kind, magic_type, magic_type)
  if magic_id == rogueMgr.shengguang then
    abort_magic_by_id(self.npc, rogueMgr.shengguang_logic)
  end
end

function M:_init(npc)
end

return M
