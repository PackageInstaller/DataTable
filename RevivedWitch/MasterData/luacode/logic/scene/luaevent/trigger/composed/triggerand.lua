-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/composed/triggerand.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerOperatorBase = require("logic.scene.luaevent.trigger.composed.triggeroperator")
local TriggerOperatorAnd = class("TriggerAnd", TriggerOperatorBase)
TriggerOperatorAnd.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TriggerOperatorAnd
  ((TriggerOperatorAnd.super).Ctor)(self, ...)
end

TriggerOperatorAnd.Check = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if not self._active then
    return false
  end
  for _,v in pairs(self._tasks) do
    if v:GetType() == "operator" and not v:Check() then
      return false
    end
    if not v:GetState() then
      return false
    end
  end
  return true
end

return TriggerOperatorAnd

