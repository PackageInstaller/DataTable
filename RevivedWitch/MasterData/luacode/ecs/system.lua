-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/ecs/system.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local System = strictclass("System")
System.Ctor = function(self, world)
  -- function num : 0_0
  self._world = world
  self._requiredComponents = {}
  self._entitys = {}
  world:AddEventListener(self, (world._events).ComponentAdded, self.OnEntityComponentAdded)
  world:AddEventListener(self, (world._events).ComponentWillRemoved, self.OnEntityComponentWillRemoved)
  world:AddEventListener(self, (world._events).RemoveEntity, self.OnEntityRemoved)
end

System.Destroy = function(self)
  -- function num : 0_1
  (self._world):RemoveEventListener(self, ((self._world)._events).ComponentAdded)
  ;
  (self._world):RemoveEventListener(self, ((self._world)._events).ComponentWillRemoved)
  ;
  (self._world):RemoveEventListener(self, ((self._world)._events).RemoveEntity)
end

System.OnEntityComponentAdded = function(self, entity, addedComponent)
  -- function num : 0_2 , upvalues : _ENV
  if self:HasRequiredComponents(entity) then
    local hasEntity = false
    for i,e in ipairs(self._entitys) do
      if e._entityId == entity._entityId then
        hasEntity = true
        break
      end
    end
    do
      if not hasEntity then
        (table.insert)(self._entitys, entity)
        self:OnEntityAdded(entity)
      end
    end
  end
end

System.OnEntityComponentWillRemoved = function(self, entity, willRemovedComponent)
  -- function num : 0_3 , upvalues : _ENV
  local removed = false
  for _,component in ipairs(self._requiredComponents) do
    if component.__cname == willRemovedComponent.__cname then
      removed = true
      break
    end
  end
  do
    if removed then
      self:OnEntityRemoved(entity)
    end
  end
end

System.OnEntityAdded = function(self, entity)
  -- function num : 0_4
end

System.OnEntityRemoved = function(self, entity)
  -- function num : 0_5 , upvalues : _ENV
  local hasEntity = false
  local index = nil
  for i,e in ipairs(self._entitys) do
    if e._entityId == entity._entityId then
      hasEntity = true
      index = i
      break
    end
  end
  do
    if hasEntity then
      (table.remove)(self._entitys, index)
    end
  end
end

System.HasRequiredComponents = function(self, entity)
  -- function num : 0_6 , upvalues : _ENV
  for _,component in ipairs(self._requiredComponents) do
    if not entity:GetComponent(component) then
      return false
    end
  end
  return true
end

return System

