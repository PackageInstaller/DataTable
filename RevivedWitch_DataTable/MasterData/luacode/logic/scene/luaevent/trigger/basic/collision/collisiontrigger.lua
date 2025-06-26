-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/collision/collisiontrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local CollisionTrigger = class("CollisionTrigger", TriggerBase)
CollisionTrigger.Ctor = function(self, triggertype, id, eventid, colliderID)
  -- function num : 0_0 , upvalues : CollisionTrigger
  ((CollisionTrigger.super).Ctor)(self, triggertype, id, eventid)
  self._colliderID = colliderID
end

CollisionTrigger.OnCheck = function(self, id)
  -- function num : 0_1
  do return id == self._colliderID end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return CollisionTrigger

