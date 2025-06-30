-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/composed/triggeroperator.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerOperatorBase = class("TriggerOperatorBase")
TriggerOperatorBase.Ctor = function(self, id)
  -- function num : 0_0
  self._id = id
  self._tasks = {}
end

TriggerOperatorBase.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in pairs(self._tasks) do
    if v:GetType() == "operator" then
      v:Destroy()
    else
      ;
      (TriggerManager.RemoveTrigger)(v:GetType(), v:GetID())
    end
  end
  self._tasks = {}
end

TriggerOperatorBase.GetID = function(self)
  -- function num : 0_2
  return self._id
end

TriggerOperatorBase.GetType = function(self)
  -- function num : 0_3
  return "operator"
end

TriggerOperatorBase.Check = function(self)
  -- function num : 0_4
  return false
end

TriggerOperatorBase.AddTask = function(self, value)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in pairs(self._tasks) do
    if v:GetType() ~= "operator" and v:GetType() == value:GetType() and v:GetID() == value:GetID() then
      return 
    end
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._tasks)[#self._tasks + 1] = value
end

TriggerOperatorBase.IsActive = function(self)
  -- function num : 0_6
  return self:Check()
end

TriggerOperatorBase.Activate = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._active = true
  for _,v in pairs(self._tasks) do
    if v:GetType() == "operator" then
      v:Activate()
    else
      ;
      (TriggerManager.AddTrigger)(v:GetType(), v)
    end
  end
end

TriggerOperatorBase.Reset = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for _,v in pairs(self._tasks) do
    if v:GetType() == "operator" then
      v:Reset()
    else
      v:SetState(0)
    end
  end
end

return TriggerOperatorBase

