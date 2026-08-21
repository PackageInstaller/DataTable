local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:on_fate_book_battle_start()
  cast_magic(self.npc, self.npc, 618010401, 1)
end

function M:_init(npc)
  cast_magic(self.npc, self.npc, 618010401, 1)
end

function M:Rampage()
  cast_magic(self.npc, self.npc, 618010402, 1)
end

function M:RampageEnd()
  abort_magic_by_id(self.npc, 618010402)
end

function M:on_start()
  local role = self.npc:get_behavior()
  if role then
    tool.insert(role, "onRampageStart", self.Rampage)
    tool.insert(role, "onRampageEnd", self.RampageEnd)
  end
end

function M:on_remove()
  abort_magic_by_id(self.npc, 618010401)
  abort_magic_by_id(self.npc, 618010402)
  local role = self.npc:get_behavior()
  if role then
    tool.remove(role, "onRampageStart", self.Rampage)
    tool.remove(role, "onRampageEnd", self.RampageEnd)
  end
end

return M
