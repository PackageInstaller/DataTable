-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/ecs/world.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Entity = require("ecs.entity")
local World = strictclass("World")
World.Ctor = function(self, ...)
  -- function num : 0_0
  self._GlobalEntityID = 0
  self._entitys = {}
  self._systems = {}
  self._events = {AddEntity = "AddEntity", ModifyEntity = "ModifyEntity", RemoveEntity = "RemoveEntity", ComponentAdded = "ComponentAdded", ComponentWillRemoved = "ComponentWillRemoved"}
  self._eventDelegates = {}
end

World.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local entityIds = {}
  for _,entity in ipairs(self._entitys) do
    (table.insert)(entityIds, entity._entityId)
  end
  for i,entityId in ipairs(entityIds) do
    self:DeleteEntity(entityId)
  end
  local systemNames = {}
  for systemName,system in pairs(self._systems) do
    (table.insert)(systemNames, systemName)
  end
  for i,systemName in ipairs(systemNames) do
    if (self._systems)[systemName] then
      ((self._systems)[systemName]):Destroy()
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self._systems)[systemName] = nil
    end
  end
end

World.NewEntity = function(self, components)
  -- function num : 0_2 , upvalues : Entity, _ENV
  self._GlobalEntityID = self._GlobalEntityID + 1
  local newEntity = (Entity.Create)(self, self._GlobalEntityID)
  local hasEntity = false
  for i,e in ipairs(self._entitys) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R9 in 'UnsetPending'

    if e._entityId == newEntity._entityId then
      (self._entitys)[i] = newEntity
      hasEntity = true
      break
    end
  end
  do
    if not hasEntity then
      (table.insert)(self._entitys, newEntity)
    end
    self:FireEvent((self._events).AddEntity, newEntity)
    if components then
      for i,component in ipairs(components) do
        newEntity:AddComponent(component)
      end
    end
    do
      return newEntity
    end
  end
end

World.DeleteEntity = function(self, entityId)
  -- function num : 0_3 , upvalues : _ENV
  local entity, index = nil, nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == entityId then
      entity = e
      index = i
      break
    end
  end
  do
    if entity then
      entity:Destroy()
      ;
      (table.remove)(self._entitys, index)
      self:FireEvent((self._events).RemoveEntity, entity)
    end
  end
end

World.GetEntity = function(self, entityId)
  -- function num : 0_4 , upvalues : _ENV
  for i,e in ipairs(self._entitys) do
    if e._entityId == entityId then
      return e
    end
  end
end

World.AddSystem = function(self, System)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._systems)[System.__cname] then
    (self._systems)[System.__cname] = (System.Create)(self)
  end
  return (self._systems)[System.__cname]
end

World.GetSystem = function(self, System)
  -- function num : 0_6
  return (self._systems)[System.__cname]
end

World.RemoveSystem = function(self, System)
  -- function num : 0_7
  if (self._systems)[System.__cname] then
    ((self._systems)[System.__cname]):Destroy()
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._systems)[System.__cname] = nil
  end
end

World.AddEventListener = function(self, observer, event, delegate)
  -- function num : 0_8 , upvalues : _ENV
  if not observer or not event or not delegate then
    LogError("World", "Invaild argument in World.AddEventListener")
    return 
  end
  local record = {}
  record.observer = observer
  record.delegate = delegate
  record.event = event
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  if not (self._eventDelegates)[event] then
    (self._eventDelegates)[event] = {}
  end
  ;
  (table.insert)((self._eventDelegates)[event], record)
end

World.RemoveEventListener = function(self, observer, event)
  -- function num : 0_9 , upvalues : _ENV
  if not observer then
    LogError("World", "Invaild argument in World.RemoveEventListener")
    return 
  end
  local newEventDelegates = {}
  for sEvent,recordTable in pairs(self._eventDelegates) do
    for index,record in ipairs(recordTable) do
      local match = false
      if observer == record.observer and (event == nil or event == sEvent) then
        match = true
      end
      if not match then
        if not newEventDelegates[event] then
          newEventDelegates[event] = {}
        end
        ;
        (table.insert)(newEventDelegates[event], record)
      end
    end
  end
  self._eventDelegates = newEventDelegates
end

World.FireEvent = function(self, event, ...)
  -- function num : 0_10 , upvalues : _ENV
  if not event then
    LogError("World", "Invaild argument in World.FireEvent")
    return 
  end
  if not (self._eventDelegates)[event] then
    return 
  end
  local notificationList = {}
  for index,record in ipairs((self._eventDelegates)[event]) do
    (table.insert)(notificationList, record)
  end
  for index,record in ipairs(notificationList) do
    (record.delegate)(record.observer, ...)
  end
end

return World

