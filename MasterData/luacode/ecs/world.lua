local Entity = require("ecs.entity")
local World = strictclass("World")

function World:Ctor(...)
  self._GlobalEntityID = 0
  self._entitys = {}
  self._systems = {}
  self._events = {
    AddEntity = "AddEntity",
    ModifyEntity = "ModifyEntity",
    RemoveEntity = "RemoveEntity",
    ComponentAdded = "ComponentAdded",
    ComponentWillRemoved = "ComponentWillRemoved"
  }
  self._eventDelegates = {}
end

function World:Destroy()
  local entityIds = {}
  for _, entity in ipairs(self._entitys) do
    table.insert(entityIds, entity._entityId)
  end
  for i, entityId in ipairs(entityIds) do
    self:DeleteEntity(entityId)
  end
  local systemNames = {}
  for systemName, system in pairs(self._systems) do
    table.insert(systemNames, systemName)
  end
  for i, systemName in ipairs(systemNames) do
    if self._systems[systemName] then
      self._systems[systemName]:Destroy()
      self._systems[systemName] = nil
    end
  end
end

function World:NewEntity(components)
  self._GlobalEntityID = self._GlobalEntityID + 1
  local newEntity = Entity.Create(self, self._GlobalEntityID)
  local hasEntity = false
  for i, e in ipairs(self._entitys) do
    if e._entityId == newEntity._entityId then
      self._entitys[i] = newEntity
      hasEntity = true
      break
    end
  end
  if not hasEntity then
    table.insert(self._entitys, newEntity)
  end
  self:FireEvent(self._events.AddEntity, newEntity)
  if components then
    for i, component in ipairs(components) do
      newEntity:AddComponent(component)
    end
  end
  return newEntity
end

function World:DeleteEntity(entityId)
  local entity, index
  for i, e in ipairs(self._entitys) do
    if e._entityId == entityId then
      entity = e
      index = i
      break
    end
  end
  if entity then
    entity:Destroy()
    table.remove(self._entitys, index)
    self:FireEvent(self._events.RemoveEntity, entity)
  end
end

function World:GetEntity(entityId)
  for i, e in ipairs(self._entitys) do
    if e._entityId == entityId then
      return e
    end
  end
end

function World:AddSystem(System)
  if not self._systems[System.__cname] then
    self._systems[System.__cname] = System.Create(self)
  end
  return self._systems[System.__cname]
end

function World:GetSystem(System)
  return self._systems[System.__cname]
end

function World:RemoveSystem(System)
  if self._systems[System.__cname] then
    self._systems[System.__cname]:Destroy()
    self._systems[System.__cname] = nil
  end
end

function World:AddEventListener(observer, event, delegate)
  if not (observer and event) or not delegate then
    LogError("World", "Invaild argument in World.AddEventListener")
    return
  end
  local record = {}
  record.observer = observer
  record.delegate = delegate
  record.event = event
  if not self._eventDelegates[event] then
    self._eventDelegates[event] = {}
  end
  table.insert(self._eventDelegates[event], record)
end

function World:RemoveEventListener(observer, event)
  if not observer then
    LogError("World", "Invaild argument in World.RemoveEventListener")
    return
  end
  local newEventDelegates = {}
  for sEvent, recordTable in pairs(self._eventDelegates) do
    for index, record in ipairs(recordTable) do
      local match = false
      if observer == record.observer and (event == nil or event == sEvent) then
        match = true
      end
      if not match then
        if not newEventDelegates[event] then
          newEventDelegates[event] = {}
        end
        table.insert(newEventDelegates[event], record)
      end
    end
  end
  self._eventDelegates = newEventDelegates
end

function World:FireEvent(event, ...)
  if not event then
    LogError("World", "Invaild argument in World.FireEvent")
    return
  end
  if not self._eventDelegates[event] then
    return
  end
  local notificationList = {}
  for index, record in ipairs(self._eventDelegates[event]) do
    table.insert(notificationList, record)
  end
  for index, record in ipairs(notificationList) do
    record.delegate(record.observer, ...)
  end
end

return World
