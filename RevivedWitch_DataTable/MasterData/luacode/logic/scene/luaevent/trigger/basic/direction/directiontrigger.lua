-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/direction/directiontrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local DirectionTrigger = class("DirectionTrigger", TriggerBase)
DirectionTrigger.Ctor = function(self, type, id, eventid, ...)
  -- function num : 0_0 , upvalues : DirectionTrigger, _ENV
  ((DirectionTrigger.super).Ctor)(self, type, id, eventid)
  self._direction = {}
  local params = {...}
  if #params == 1 then
    for _,v in pairs(params[1]) do
      (table.insert)(self._direction, v)
    end
  end
end

DirectionTrigger.OnCheck = function(self, direction)
  -- function num : 0_1 , upvalues : _ENV
  if #self._direction == 0 then
    return true
  end
  for _,v in ipairs(self._direction) do
    if direction == v then
      return true
    end
  end
  return false
end

return DirectionTrigger

