-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/triggerbase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = class("TriggerBase")
TriggerBase.Ctor = function(self, type, id, eventid)
  -- function num : 0_0
  self._active = false
  self._type = type
  self._id = id
  self._eventID = eventid
end

TriggerBase.IsActive = function(self)
  -- function num : 0_1
  return self._active
end

TriggerBase.GetID = function(self)
  -- function num : 0_2
  return self._id
end

TriggerBase.GetEventID = function(self)
  -- function num : 0_3
  return self._eventID
end

TriggerBase.GetType = function(self)
  -- function num : 0_4
  return self._type
end

TriggerBase.SetState = function(self, state)
  -- function num : 0_5
  self._active = state
end

TriggerBase.GetState = function(self)
  -- function num : 0_6
  return self._active
end

TriggerBase.Check = function(self, ...)
  -- function num : 0_7 , upvalues : _ENV
  local prev_state = self._active
  self:SetState(self:OnCheck(...))
  if self._active ~= prev_state then
    (TriggerManager.OnTriggerStateChange)(self)
  end
end

TriggerBase.OnCheck = function(self, ...)
  -- function num : 0_8
end

return TriggerBase

