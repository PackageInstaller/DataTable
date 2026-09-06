local Entity = class("Entity")

function Entity:Ctor(world, entityId)
  self._world = world
  self._entityId = entityId
  self._components = {}
end

function Entity:AddComponent(ComponentClass, ...)
  if not self._components[ComponentClass.__cname] then
    self._components[ComponentClass.__cname] = ComponentClass.Create(self, ...)
    self._world:FireEvent(self._world._events.ComponentAdded, self, self._components[ComponentClass.__cname])
  end
  return self._components[ComponentClass.__cname]
end

function Entity:GetComponent(ComponentClass)
  return self._components[ComponentClass.__cname]
end

function Entity:GetComponents(...)
  local ComponentClasses = table.pack(...)
  local components = {}
  for i = 1, ComponentClasses.n do
    components[i] = self._components[ComponentClasses[i].__cname]
  end
  return table.unpack(components, 1, ComponentClasses.n)
end

function Entity:RemoveComponent(ComponentClass)
  if self._components[ComponentClass.__cname] then
    self._world:FireEvent(self._world._events.ComponentWillRemoved, self, self._components[ComponentClass.__cname])
    self._components[ComponentClass.__cname] = nil
  end
end

function Entity:Destroy()
  local deleteComponents = {}
  for componentName, _ in pairs(self._components) do
    table.insert(deleteComponents, componentName)
  end
  for _, componentName in ipairs(deleteComponents) do
    if self._components[componentName] then
      self._world:FireEvent(self._world._events.ComponentWillRemoved, self, self._components[componentName])
      self._components[componentName] = nil
    end
  end
end

return Entity
