-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/rolestatus/rolestatustrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local RoleStatusTrigger = class("RoleStatusTrigger", TriggerBase)
RoleStatusTrigger.Ctor = function(self, triggertype, id, eventid, list)
  -- function num : 0_0 , upvalues : RoleStatusTrigger
  ((RoleStatusTrigger.super).Ctor)(self, triggertype, id, eventid)
  self._list = list
  self._value = (self._list).value
end

RoleStatusTrigger.OnCheck = function(self, value)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Unhandled construct in 'MakeBoolean' P1

  if type(value) == "number" and value == self._value then
    return true
  end
  if type(value) == "table" then
    for _,v in pairs(value) do
      if self._value == v then
        return true
      end
    end
  end
  do
    return false
  end
end

RoleStatusTrigger.GetTriList = function(self)
  -- function num : 0_2
  return self._list
end

return RoleStatusTrigger

