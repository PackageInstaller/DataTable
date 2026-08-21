local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")
local buffCastTime = 0

function M:_init(npc)
end

function M:on_start()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  cast_magic(self.npc, self.npc, 7000021601, 1)
  cast_magic(self.npc, self.npc, 7000021602, 1)
  tool.insert(role, "onRampageStart", self.RampageStart)
  tool.insert(role, "onRampageEnd", self.RampageEnd)
end

function M:on_remove()
  local role = self.npc:get_behavior()
  if not role then
    return
  end
  tool.remove(role, "onRampageStart", self.RampageStart)
  tool.remove(role, "onRampageEnd", self.RampageEnd)
  abort_magic_by_id(self.npc, 7000021601)
  abort_magic_by_id(self.npc, 7000021602)
  abort_magic_by_id(self.npc, 7000021603)
  abort_magic_by_id(self.npc, 7000021604)
end

function M:RampageStart()
  cast_magic(self.npc, self.npc, 7000021603, 1)
  cast_magic(self.npc, self.npc, 7000021604, 1)
end

function M:RampageEnd()
  abort_magic_by_id(self.npc, 7000021603)
  abort_magic_by_id(self.npc, 7000021604)
end

return M
