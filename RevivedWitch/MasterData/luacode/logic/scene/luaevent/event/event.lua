-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/event/event.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Event = class("Event")
Event.Ctor = function(self, id, repeate)
  -- function num : 0_0
  self._id = id
  self._repeate = repeate
  self._triggers = {}
  self._effects = {}
end

Event.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for type,triggers in pairs(self._triggers) do
    for _,trigger in pairs(triggers) do
      if type == "composed" then
        trigger:Destroy()
      else
        ;
        (TriggerManager.RemoveTrigger)(type, trigger:GetID())
      end
    end
  end
  self._triggers = {}
  for _,v in pairs(self._effects) do
    v:Destroy()
  end
end

Event.GetID = function(self)
  -- function num : 0_2
  return self._id
end

Event.SetConfigID = function(self, id)
  -- function num : 0_3 , upvalues : _ENV
  if id ~= self._cfgid then
    self._cfg = ((BeanManager.GetTableByName)("event.ceventconfig")):GetRecorder(id)
  end
  self._cfgid = id
end

Event.GetConfigID = function(self)
  -- function num : 0_4
  return self._cfgid
end

Event.IsRepeateEvent = function(self)
  -- function num : 0_5
  return self._repeate
end

Event.GetConfigType = function(self)
  -- function num : 0_6
  return (self._cfg).eventType
end

Event.AddTrigger = function(self, type, trigger)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if not (self._triggers)[type] then
    (self._triggers)[type] = {}
    for _,v in pairs((self._triggers)[type]) do
      if v:GetID() == trigger:GetID() then
        LogError("event", "add existing trigger")
        return false
      end
    end
    ;
    (table.insert)((self._triggers)[type], trigger)
    return true
  end
end

Event.Activate = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for type,triggers in pairs(self._triggers) do
    if type == "composed" then
      for _,trigger in pairs(triggers) do
        trigger:Activate()
      end
    else
      do
        for _,trigger in pairs(triggers) do
          (TriggerManager.AddTrigger)(type, trigger)
        end
        do
          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

local remove_if = function(tbl, pred)
  -- function num : 0_9 , upvalues : _ENV
  for i,v in ipairs(tbl) do
    if pred(v) then
      (table.remove)(tbl, i)
      return true
    end
  end
  return false
end

Event.RemoveTrigger = function(self, type, triggerid)
  -- function num : 0_10 , upvalues : remove_if, _ENV
  local pred = function(arg)
    -- function num : 0_10_0 , upvalues : triggerid
    do return arg:GetID() == triggerid end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  if (self._triggers)[type] then
    return remove_if((self._triggers)[type], pred)
  else
    for _,v in pairs(self._triggers) do
      if remove_if(v, pred) then
        return true
      end
    end
    return false
  end
end

Event.Reset = function(self)
  -- function num : 0_11 , upvalues : _ENV
  for type,triggers in pairs(self._triggers) do
    if type == "composed" then
      for _,trigger in pairs(triggers) do
        trigger:Reset()
      end
    else
      do
        for _,trigger in pairs(triggers) do
          trigger:SetState(0)
        end
        do
          -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

Event.GetTriggers = function(self)
  -- function num : 0_12
  return self._triggers
end

Event.AddEffect = function(self, effect)
  -- function num : 0_13 , upvalues : _ENV
  (table.insert)(self._effects, effect)
end

Event.AddAlternativeEffect = function(self, effect)
  -- function num : 0_14 , upvalues : _ENV
  if not self._alternatives then
    self._alternatives = {}
    ;
    (table.insert)(self._alternatives, effect)
  end
end

Event.Fire = function(self, args)
  -- function num : 0_15 , upvalues : _ENV
  for _,v in ipairs(self._effects) do
    v:Run(args)
  end
end

Event.FireAlternative = function(self, args)
  -- function num : 0_16 , upvalues : _ENV
  if not self._alternatives then
    for _,v in ipairs(self._effects) do
      v:Run(args)
    end
  end
end

Event.IsTriggerFired = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local any = false
  for type,v in pairs(self._triggers) do
    any = true
    if type == "composed" then
      for _,trigger in pairs(v) do
        if not trigger:Check() then
          return false
        end
      end
    else
      do
        for _,trigger in pairs(v) do
          if not trigger:GetState() then
            return false
          end
        end
        do
          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return any
end

Event.Dump = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local str = "event " .. self._id .. " with trigger "
  for t,v in pairs(self._triggers) do
    for _,vv in pairs(v) do
      str = str .. vv:GetID() .. ":(" .. t .. ", " .. vv:GetEventID() .. ")" .. "@" .. tostring(vv) .. ", "
    end
  end
end

Event.GetMinimapPosition = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self._cfgid then
    local pos = (string.split)((self._cfg).coordinate, ",")
    return {x = tonumber(pos[1]), y = tonumber(pos[2])}
  end
end

Event.GetMinimapIcon = function(self)
  -- function num : 0_20
  if self._cfgid then
    return (self._cfg).imageId
  end
end

Event.ShowInMinimap = function(self)
  -- function num : 0_21
  if (self._cfg).isShowMinimapIcon ~= 1 then
    do return not self._cfgid end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return Event

