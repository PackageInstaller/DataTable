-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/composed/triggernot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerOperatorBase = require("logic.scene.luaevent.trigger.composed.triggeroperator")
local TriggerOperatorNot = class("TriggerNot", TriggerOperatorBase)
TriggerOperatorNot.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TriggerOperatorNot
  ((TriggerOperatorNot.super).Ctor)(self, ...)
  self._task = nil
end

TriggerOperatorNot.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if (self._task):GetType() == "operator" then
    (self._task):Destroy()
  else
    ;
    (TriggerManager.RemoveTrigger)((self._task):GetType(), (self._task):GetID())
  end
end

TriggerOperatorNot.SetTask = function(self, task)
  -- function num : 0_2
  self._task = task
end

TriggerOperatorNot.Check = function(self)
  -- function num : 0_3
  if not self._active then
    return false
  end
  if (self._task):GetType() == "operator" then
    return not (self._task):Check()
  else
    return not (self._task):GetState()
  end
end

TriggerOperatorNot.Activate = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._active = true
  ;
  (TriggerManager.AddTrigger)((self._task):GetType(), self._task)
end

TriggerOperatorNot.Reset = function(self)
  -- function num : 0_5
  if (self._task):GetType() == "operator" then
    (self._task):Reset()
  else
    ;
    (self._task):SetState(0)
  end
end

return TriggerOperatorNot

