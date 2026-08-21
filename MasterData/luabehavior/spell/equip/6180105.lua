local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:on_fate_book_battle_start()
  self.RecoverTime = -30
  cast_magic(self.npc, self.npc, 618010501, 1)
  cast_magic(self.npc, self.npc, 618010502, 1)
end

function M:_init(npc)
end

function M:RampageEnd()
  abort_magic_by_id(self.npc, 618010402)
end

function M:on_start()
  self.RecoverTime = -30
  cast_magic(self.npc, self.npc, 618010501, 1)
  cast_magic(self.npc, self.npc, 618010502, 1)
  listen_attr_change_mq(self.npc, 2, self.on_jingli_change, self)
end

function M:on_remove()
  unlisten_attr_change_mq(self.npc, 2, self)
  abort_magic_by_id(self.npc, 618010501)
  abort_magic_by_id(self.npc, 618010502)
end

function M:on_jingli_change(npc, attr_tpe, change_value)
  self.current_energy = get_npc_attr(self.npc, 2)
  if self.current_energy < 100 then
    local curTime = get_npc_time(self.npc)
    if curTime > self.RecoverTime + 30 then
      self.RecoverTime = curTime
      cast_magic(self.npc, self.npc, 618010503, 1)
    end
  end
end

return M
