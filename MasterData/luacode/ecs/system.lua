local System = strictclass("System")

function System:Ctor(world)
  self._world = world
  self._requiredComponents = {}
  self._entitys = {}
  world:AddEventListener(self, world._events.ComponentAdded, self.OnEntityComponentAdded)
  world:AddEventListener(self, world._events.ComponentWillRemoved, self.OnEntityComponentWillRemoved)
  world:AddEventListener(self, world._events.RemoveEntity, self.OnEntityRemoved)
end

function System:Destroy()
  self._world:RemoveEventListener(self, self._world._events.ComponentAdded)
  self._world:RemoveEventListener(self, self._world._events.ComponentWillRemoved)
  self._world:RemoveEventListener(self, self._world._events.RemoveEntity)
end

function System:OnEntityComponentAdded(entity, addedComponent)
  if self:HasRequiredComponents(entity) then
    local hasEntity = false
    for i, e in ipairs(self._entitys) do
      if e._entityId == entity._entityId then
        hasEntity = true
        break
      end
    end
    if not hasEntity then
      table.insert(self._entitys, entity)
      self:OnEntityAdded(entity)
    end
  end
end

function System:OnEntityComponentWillRemoved(entity, willRemovedComponent)
  local removed = false
  for _, component in ipairs(self._requiredComponents) do
    if component.__cname == willRemovedComponent.__cname then
      removed = true
      break
    end
  end
  if removed then
    self:OnEntityRemoved(entity)
  end
end

function System:OnEntityAdded(entity)
end

function System:OnEntityRemoved(entity)
  local hasEntity = false
  local index
  for i, e in ipairs(self._entitys) do
    if e._entityId == entity._entityId then
      hasEntity = true
      index = i
      break
    end
  end
  if hasEntity then
    table.remove(self._entitys, index)
  end
end

function System:HasRequiredComponents(entity)
  for _, component in ipairs(self._requiredComponents) do
    if not entity:GetComponent(component) then
      return false
    end
  end
  return true
end

return System
