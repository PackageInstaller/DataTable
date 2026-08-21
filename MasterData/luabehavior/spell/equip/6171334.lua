local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local vec3 = require("base.vec3")

function M:_init(npc)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  print("skact")
  if act:isUlt() then
    print("ult")
    if act:isQte() then
      print("ultqte")
      cast_magic(self.npc, self.npc, rogueMgr.relay, 1)
      cast_magic(self.npc, self.npc, rogueMgr.relay, 1)
    end
  end
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 6171331)
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

return M
