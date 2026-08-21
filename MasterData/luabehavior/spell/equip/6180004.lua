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
  abort_magic_by_id(self.npc, 618000401)
  abort_magic_by_id(self.npc, 618000402)
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  local role = self.npc:get_behavior()
  if npc ~= self.npc then
    return
  end
  if is_showup then
    if role:isRampage() then
      cast_magic(self.npc, self.npc, 618000402)
    end
    cast_magic(npc, npc, 618000401)
  end
  if not is_showup then
    abort_magic_by_id(npc, 618000401)
  end
end

function M:RampageStart()
  if self.npc == get_come_on_hero() then
    cast_magic(self.npc, self.npc, 618000402)
  end
end

function M:RampageEnd()
  abort_magic_by_id(self.npc, 618000402)
end

return M
