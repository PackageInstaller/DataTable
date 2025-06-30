-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/composed/triggeror.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerOperatorBase = require("logic.scene.luaevent.trigger.composed.triggeroperator")
local TriggerOperatorOr = class("TriggerOr", TriggerOperatorBase)
TriggerOperatorOr.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TriggerOperatorOr
  ((TriggerOperatorOr.super).Ctor)(self, ...)
end

TriggerOperatorOr.Check = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if not self._active then
    return false
  end
  for _,v in pairs(self._tasks) do
    if v:GetType() == "operator" and v:Check() then
      return true
    end
    if v:GetState() then
      return true
    end
  end
  return false
end

return TriggerOperatorOr

