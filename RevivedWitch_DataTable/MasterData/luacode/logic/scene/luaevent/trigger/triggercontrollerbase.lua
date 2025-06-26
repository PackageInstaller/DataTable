-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/triggercontrollerbase.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = class("TriggerControllerBase")
TriggerControllerBase.Ctor = function(self)
  -- function num : 0_0
  self._triggers = {}
  self._adding = {}
  self._removing = {}
  self._checking = false
end

TriggerControllerBase.Destroy = function(self)
  -- function num : 0_1
  self._triggers = {}
end

TriggerControllerBase.OnSceneChange = function(self)
  -- function num : 0_2
end

local check_table = function(remove, tbl, pred, ...)
  -- function num : 0_3 , upvalues : _ENV
  for _,trigger in pairs(tbl) do
    if not remove[trigger:GetID()] and (not pred or pred(trigger, ...)) then
      trigger:Check(...)
    end
  end
end

TriggerControllerBase.CheckImpl = function(self, pred, ...)
  -- function num : 0_4 , upvalues : check_table, _ENV
  self._checking = true
  check_table(self._removing, self._triggers, pred, ...)
  for i,v in ipairs(self._adding) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    if not (self._removing)[v:GetID()] then
      (self._triggers)[v:GetID()] = v
    end
  end
  self._adding = {}
  self._removing = {}
  self._checking = false
end

TriggerControllerBase.CreateTrigger = function(self, eventid, ...)
  -- function num : 0_5 , upvalues : _ENV
  local id = (TriggerManager.GenID)()
  local trigger = self:CreateTriggerInstance(id, eventid, ...)
  if self.OnTriggerCreate then
    self:OnTriggerCreate(trigger)
  end
  return trigger
end

TriggerControllerBase.AddTrigger = function(self, trigger)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if not self._checking then
    (self._triggers)[trigger:GetID()] = trigger
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._adding)[#self._adding + 1] = trigger
  end
  if self.OnTriggerAdd then
    self:OnTriggerAdd(trigger)
  end
end

TriggerControllerBase.RemoveTrigger = function(self, id)
  -- function num : 0_7
  local t = (self._triggers)[id]
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if not self._checking then
    (self._triggers)[id] = nil
  else
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._removing)[id] = true
  end
  do return t ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TriggerControllerBase.GetTrigger = function(self, id)
  -- function num : 0_8 , upvalues : _ENV
  do return ((self._removing)[id] or not (self._triggers)[id]) and (table.first)(self._adding, function(k, v)
    -- function num : 0_8_0 , upvalues : id
    do return v == id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return TriggerControllerBase

